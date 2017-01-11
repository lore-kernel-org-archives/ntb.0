Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z62si876721pfz.1.2017.01.10.16.33.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:33:46 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 10 Jan 2017 17:33:38 -0700
Message-Id: <1484094819-16084-4-git-send-email-logang@deltatee.com>
In-Reply-To: <1484094819-16084-1-git-send-email-logang@deltatee.com>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v2 3/4] ntb_hw_amd: Print kernel messages with the ntb device not the pci one
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Now that macros are open it's pretty clear that these should print
using the NTB struct device not the PCI one.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 0135fcf..69b8c64 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -225,7 +225,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
 		if (width)
 			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
 
-		dev_dbg(&ntb->pdev->dev, "link is up.\n");
+		dev_dbg(&ntb->dev, "link is up.\n");
 
 		ret = 1;
 	} else {
@@ -234,7 +234,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
 		if (width)
 			*width = NTB_WIDTH_NONE;
 
-		dev_dbg(&ntb->pdev->dev, "link is down.\n");
+		dev_dbg(&ntb->dev, "link is down.\n");
 	}
 
 	return ret;
@@ -254,7 +254,7 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
-	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
+	dev_dbg(&ntb->dev, "Enabling Link.\n");
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
@@ -275,7 +275,7 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
-	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
+	dev_dbg(&ntb->dev, "Enabling Link.\n");
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
@@ -466,19 +466,18 @@ static void amd_ack_smu(struct amd_ntb_dev *ndev, u32 bit)
 static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 {
 	void __iomem *mmio = ndev->self_mmio;
-	struct device *dev = &ndev->ntb.pdev->dev;
 	u32 status;
 
 	status = readl(mmio + AMD_INTSTAT_OFFSET);
 	if (!(status & AMD_EVENT_INTMASK))
 		return;
 
-	dev_dbg(dev, "status = 0x%x and vec = %d\n", status, vec);
+	dev_dbg(&ndev->ntb.dev, "status = 0x%x and vec = %d\n", status, vec);
 
 	status &= AMD_EVENT_INTMASK;
 	switch (status) {
 	case AMD_PEER_FLUSH_EVENT:
-		dev_info(dev, "Flush is done.\n");
+		dev_info(&ndev->ntb.dev, "Flush is done.\n");
 		break;
 	case AMD_PEER_RESET_EVENT:
 		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
@@ -504,7 +503,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		status = readl(mmio + AMD_PMESTAT_OFFSET);
 		/* check if this is WAKEUP event */
 		if (status & 0x1)
-			dev_info(dev, "Wakeup is done.\n");
+			dev_info(&ndev->ntb.dev, "Wakeup is done.\n");
 
 		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
 
@@ -513,14 +512,14 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 				      AMD_LINK_HB_TIMEOUT);
 		break;
 	default:
-		dev_info(dev, "event status = 0x%x.\n", status);
+		dev_info(&ndev->ntb.dev, "event status = 0x%x.\n", status);
 		break;
 	}
 }
 
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 {
-	dev_dbg(&ndev->ntb.pdev->dev, "vec %d\n", vec);
+	dev_dbg(&ndev->ntb.dev, "vec %d\n", vec);
 
 	if (vec > (AMD_DB_CNT - 1) || (ndev->msix_vec_count == 1))
 		amd_handle_event(ndev, vec);
@@ -814,7 +813,7 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	reg &= NTB_LIN_STA_ACTIVE_BIT;
 
-	dev_dbg(&ndev->ntb.pdev->dev, "%s: reg_val = 0x%x.\n", __func__, reg);
+	dev_dbg(&ndev->ntb.dev, "%s: reg_val = 0x%x.\n", __func__, reg);
 
 	if (reg == ndev->cntl_sta)
 		return 0;
@@ -1052,7 +1051,7 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
 	if (rc)
 		goto err_register;
 
-	dev_info(&pdev->dev, "NTB device registered.\n");
+	dev_info(&ndev->ntb.dev, "NTB device registered.\n");
 
 	return 0;
 
-- 
2.1.4

