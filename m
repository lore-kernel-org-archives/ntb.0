Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b36si141861uah.3.2017.11.29.09.55.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:52 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:26 -0700
Message-Id: <20171129175530.31032-4-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 3/7] ntb_hw_switchtec: Create helper function to setup reserved LUT MWs
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This is a prep patch in order to support the crosslink feature which
will require the driver to use another reserved LUT window. To
simplify this we move the code which sets up the reserved LUT window
into a helper function which will be used by the crosslink
initialization.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 72 ++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 51fec6497164..b18e938312e1 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -847,6 +847,46 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	return 0;
 }
 
+static int config_rsvd_lut_win(struct switchtec_ntb *sndev,
+			       struct ntb_ctrl_regs __iomem *ctl,
+			       int lut_idx, int partition,
+			       dma_addr_t addr)
+{
+	int peer_bar = sndev->peer_direct_mw_to_bar[0];
+	u32 ctl_val;
+	int rc;
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
+				   NTB_CTRL_PART_STATUS_LOCKED);
+	if (rc)
+		return rc;
+
+	ctl_val = ioread32(&ctl->bar_entry[peer_bar].ctl);
+	ctl_val &= 0xFF;
+	ctl_val |= NTB_CTRL_BAR_LUT_WIN_EN;
+	ctl_val |= ilog2(LUT_SIZE) << 8;
+	ctl_val |= (sndev->nr_lut_mw - 1) << 14;
+	iowrite32(ctl_val, &ctl->bar_entry[peer_bar].ctl);
+
+	iowrite64((NTB_CTRL_LUT_EN | (partition << 1) | addr),
+		  &ctl->lut_entry[lut_idx]);
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				   NTB_CTRL_PART_STATUS_NORMAL);
+	if (rc) {
+		u32 bar_error, lut_error;
+
+		bar_error = ioread32(&ctl->bar_error);
+		lut_error = ioread32(&ctl->lut_error);
+		dev_err(&sndev->stdev->dev,
+			"Error setting up reserved lut window: %08x / %08x\n",
+			bar_error, lut_error);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int map_bars(int *map, struct ntb_ctrl_regs __iomem *ctrl)
 {
 	int i;
@@ -1004,10 +1044,7 @@ static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
 
 static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 {
-	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
 	int self_bar = sndev->direct_mw_to_bar[0];
-	int peer_bar = sndev->peer_direct_mw_to_bar[0];
-	u32 ctl_val;
 	int rc;
 
 	sndev->nr_rsvd_luts++;
@@ -1023,35 +1060,12 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 
 	switchtec_ntb_init_shared(sndev);
 
-	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
-				   NTB_CTRL_PART_STATUS_LOCKED);
+	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
+				 sndev->self_partition,
+				 sndev->self_shared_dma);
 	if (rc)
 		goto unalloc_and_exit;
 
-	ctl_val = ioread32(&ctl->bar_entry[peer_bar].ctl);
-	ctl_val &= 0xFF;
-	ctl_val |= NTB_CTRL_BAR_LUT_WIN_EN;
-	ctl_val |= ilog2(LUT_SIZE) << 8;
-	ctl_val |= (sndev->nr_lut_mw - 1) << 14;
-	iowrite32(ctl_val, &ctl->bar_entry[peer_bar].ctl);
-
-	iowrite64((NTB_CTRL_LUT_EN | (sndev->self_partition << 1) |
-		   sndev->self_shared_dma),
-		  &ctl->lut_entry[0]);
-
-	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
-				   NTB_CTRL_PART_STATUS_NORMAL);
-	if (rc) {
-		u32 bar_error, lut_error;
-
-		bar_error = ioread32(&ctl->bar_error);
-		lut_error = ioread32(&ctl->lut_error);
-		dev_err(&sndev->stdev->dev,
-			"Error setting up shared MW: %08x / %08x\n",
-			bar_error, lut_error);
-		goto unalloc_and_exit;
-	}
-
 	sndev->peer_shared = pci_iomap(sndev->stdev->pdev, self_bar, LUT_SIZE);
 	if (!sndev->peer_shared) {
 		rc = -ENOMEM;
-- 
2.11.0

