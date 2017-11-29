Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id m22si150281uab.4.2017.11.29.09.55.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:54 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:29 -0700
Message-Id: <20171129175530.31032-7-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 6/7] ntb_hw_switchtec: Add initialization code for crosslink
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Crosslink is a feature of the Switchtec switches that is similar to
the B2B mode of other NTB devices. It allows a system to be designed
that is perfectly symmetric with two identical switches that link
two hosts together.

In order for the system to be symmetric, there is an empty host-less
partition between the two switches which the host must enumerate and
assign BAR addresses to. The firmware in the switch manages this
specially so that the BAR addresses on both sides of the empty
partition will be identical despite being in the same partition with
the same address space.

The driver determines whether crosslink is enabled by a flag set in
the NTB partition info registers which are set by the switch's
configuration file.

When crosslink is enabled, a reserved LUT window is setup to point to
the peer's switch's NTB registers and the local MWs are set to forward
to the host-less partition's BARs. (Yes, this hurts my brain too.)
Once this is setup, largely the same NTB infrastructure is used to
communicate between the two hosts.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 202 ++++++++++++++++++++++++++++++++-
 include/linux/ntb.h                    |  15 ++-
 2 files changed, 206 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 4adc32fe035a..17db0f50bb22 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -95,6 +95,8 @@ struct switchtec_ntb {
 	struct ntb_ctrl_regs __iomem *mmio_peer_ctrl;
 	struct ntb_dbmsg_regs __iomem *mmio_self_dbmsg;
 
+	void __iomem *mmio_xlink_win;
+
 	struct shared_mw *self_shared;
 	struct shared_mw __iomem *peer_shared;
 	dma_addr_t self_shared_dma;
@@ -465,6 +467,13 @@ static void switchtec_ntb_set_link_speed(struct switchtec_ntb *sndev)
 	sndev->link_width = min(self_width, peer_width);
 }
 
+static int crosslink_is_enabled(struct switchtec_ntb *sndev)
+{
+	struct ntb_info_regs __iomem *inf = sndev->mmio_ntb;
+
+	return ioread8(&inf->ntp_info[sndev->peer_partition].xlink_enabled);
+}
+
 enum {
 	LINK_MESSAGE = 0,
 	MSG_LINK_UP = 1,
@@ -849,8 +858,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 
 static int config_rsvd_lut_win(struct switchtec_ntb *sndev,
 			       struct ntb_ctrl_regs __iomem *ctl,
-			       int lut_idx, int partition,
-			       dma_addr_t addr)
+			       int lut_idx, int partition, u64 addr)
 {
 	int peer_bar = sndev->peer_direct_mw_to_bar[0];
 	u32 ctl_val;
@@ -936,6 +944,182 @@ static int config_req_id_table(struct switchtec_ntb *sndev,
 	return 0;
 }
 
+static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
+			       u64 *mw_addrs, int mw_count)
+{
+	int rc, i;
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_self_ctrl;
+	u64 addr;
+	size_t size, offset;
+	int bar;
+	int xlate_pos;
+	u32 ctl_val;
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
+				   NTB_CTRL_PART_STATUS_LOCKED);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < sndev->nr_lut_mw; i++) {
+		if (i == ntb_lut_idx)
+			continue;
+
+		addr = mw_addrs[0] + LUT_SIZE * i;
+
+		iowrite64((NTB_CTRL_LUT_EN | (sndev->peer_partition << 1) |
+			   addr),
+			  &ctl->lut_entry[i]);
+	}
+
+	sndev->nr_direct_mw = min_t(int, sndev->nr_direct_mw, mw_count);
+
+	for (i = 0; i < sndev->nr_direct_mw; i++) {
+		bar = sndev->direct_mw_to_bar[i];
+		offset = (i == 0) ? LUT_SIZE * sndev->nr_lut_mw : 0;
+		addr = mw_addrs[i] + offset;
+		size = pci_resource_len(sndev->ntb.pdev, bar) - offset;
+		xlate_pos = ilog2(size);
+
+		if (offset && size > offset)
+			size = offset;
+
+		ctl_val = ioread32(&ctl->bar_entry[bar].ctl);
+		ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
+
+		iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
+		iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+		iowrite64(sndev->peer_partition | addr,
+			  &ctl->bar_entry[bar].xlate_addr);
+	}
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				   NTB_CTRL_PART_STATUS_NORMAL);
+	if (rc) {
+		u32 bar_error, lut_error;
+
+		bar_error = ioread32(&ctl->bar_error);
+		lut_error = ioread32(&ctl->lut_error);
+		dev_err(&sndev->stdev->dev,
+			"Error setting up cross link windows: %08x / %08x\n",
+			bar_error, lut_error);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int crosslink_setup_req_ids(struct switchtec_ntb *sndev,
+	struct ntb_ctrl_regs __iomem *mmio_ctrl)
+{
+	int req_ids[16];
+	int i;
+	u32 proxy_id;
+
+	for (i = 0; i < ARRAY_SIZE(req_ids); i++) {
+		proxy_id = ioread32(&sndev->mmio_self_ctrl->req_id_table[i]);
+
+		if (!(proxy_id & NTB_CTRL_REQ_ID_EN))
+			break;
+
+		req_ids[i] = ((proxy_id >> 1) & 0xFF);
+	}
+
+	return config_req_id_table(sndev, mmio_ctrl, req_ids, i);
+}
+
+/*
+ * In crosslink configuration there is a virtual partition in the
+ * middle of the two switches. The BARs in this partition have to be
+ * enumerated and assigned addresses.
+ */
+static int crosslink_enum_partition(struct switchtec_ntb *sndev,
+				    u64 *bar_addrs)
+{
+	struct part_cfg_regs __iomem *part_cfg =
+		&sndev->stdev->mmio_part_cfg_all[sndev->peer_partition];
+	u32 pff = ioread32(&part_cfg->vep_pff_inst_id);
+	struct pff_csr_regs __iomem *mmio_pff =
+		&sndev->stdev->mmio_pff_csr[pff];
+	const u64 bar_space = 0x1000000000LL;
+	u64 bar_addr;
+	int bar_cnt = 0;
+	int i;
+
+	iowrite16(0x6, &mmio_pff->pcicmd);
+
+	for (i = 0; i < ARRAY_SIZE(mmio_pff->pci_bar64); i++) {
+		iowrite64(bar_space * i, &mmio_pff->pci_bar64[i]);
+		bar_addr = ioread64(&mmio_pff->pci_bar64[i]);
+		bar_addr &= ~0xf;
+
+		dev_dbg(&sndev->stdev->dev,
+			"Crosslink BAR%d addr: %llx\n",
+			i, bar_addr);
+
+		if (bar_addr != bar_space * i)
+			continue;
+
+		bar_addrs[bar_cnt++] = bar_addr;
+	}
+
+	return bar_cnt;
+}
+
+static int switchtec_ntb_init_crosslink(struct switchtec_ntb *sndev)
+{
+	int rc;
+	int bar = sndev->direct_mw_to_bar[0];
+	const int ntb_lut_idx = 1;
+	u64 bar_addrs[6];
+	u64 addr;
+	int bar_cnt;
+
+	if (!crosslink_is_enabled(sndev))
+		return 0;
+
+	dev_info(&sndev->stdev->dev, "Using crosslink configuration\n");
+	sndev->ntb.topo = NTB_TOPO_CROSSLINK;
+
+	bar_cnt = crosslink_enum_partition(sndev, bar_addrs);
+	if (bar_cnt < sndev->nr_direct_mw + 1) {
+		dev_err(&sndev->stdev->dev,
+			"Error enumerating crosslink partition\n");
+		return -EINVAL;
+	}
+
+	addr = bar_addrs[0];
+	rc = config_rsvd_lut_win(sndev, sndev->mmio_self_ctrl, ntb_lut_idx,
+				 sndev->peer_partition, addr);
+	if (rc)
+		return rc;
+
+	rc = crosslink_setup_mws(sndev, ntb_lut_idx, &bar_addrs[1],
+				 bar_cnt - 1);
+	if (rc)
+		return rc;
+
+	rc = crosslink_setup_req_ids(sndev, sndev->mmio_peer_ctrl);
+	if (rc)
+		return rc;
+
+	sndev->mmio_xlink_win = pci_iomap_range(sndev->stdev->pdev, bar,
+						LUT_SIZE, LUT_SIZE);
+	if (!sndev->mmio_xlink_win) {
+		rc = -ENOMEM;
+		return rc;
+	}
+
+	sndev->nr_rsvd_luts++;
+
+	return 0;
+}
+
+static void switchtec_ntb_deinit_crosslink(struct switchtec_ntb *sndev)
+{
+	if (sndev->mmio_xlink_win)
+		pci_iounmap(sndev->stdev->pdev, sndev->mmio_xlink_win);
+}
+
 static int map_bars(int *map, struct ntb_ctrl_regs __iomem *ctrl)
 {
 	int i;
@@ -1222,17 +1406,22 @@ static int switchtec_ntb_add(struct device *dev,
 		goto free_and_exit;
 
 	switchtec_ntb_init_mw(sndev);
-	switchtec_ntb_init_db(sndev);
-	switchtec_ntb_init_msgs(sndev);
 
 	rc = switchtec_ntb_init_req_id_table(sndev);
 	if (rc)
 		goto free_and_exit;
 
-	rc = switchtec_ntb_init_shared_mw(sndev);
+	rc = switchtec_ntb_init_crosslink(sndev);
 	if (rc)
 		goto free_and_exit;
 
+	switchtec_ntb_init_db(sndev);
+	switchtec_ntb_init_msgs(sndev);
+
+	rc = switchtec_ntb_init_shared_mw(sndev);
+	if (rc)
+		goto deinit_crosslink;
+
 	rc = switchtec_ntb_init_db_msg_irq(sndev);
 	if (rc)
 		goto deinit_shared_and_exit;
@@ -1251,6 +1440,8 @@ static int switchtec_ntb_add(struct device *dev,
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 deinit_shared_and_exit:
 	switchtec_ntb_deinit_shared_mw(sndev);
+deinit_crosslink:
+	switchtec_ntb_deinit_crosslink(sndev);
 free_and_exit:
 	kfree(sndev);
 	dev_err(dev, "failed to register ntb device: %d\n", rc);
@@ -1271,6 +1462,7 @@ void switchtec_ntb_remove(struct device *dev,
 	ntb_unregister_device(&sndev->ntb);
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
+	switchtec_ntb_deinit_crosslink(sndev);
 	kfree(sndev);
 	dev_info(dev, "ntb device unregistered\n");
 }
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index c308964777eb..ea3be7275a5e 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -71,6 +71,7 @@ struct pci_dev;
  * @NTB_TOPO_B2B_USD:	On primary side of local ntb upstream of remote ntb.
  * @NTB_TOPO_B2B_DSD:	On primary side of local ntb downstream of remote ntb.
  * @NTB_TOPO_SWITCH:	Connected via a switch which supports ntb.
+ * @NTB_TOPO_CROSSLINK: Connected via two symmetric switchecs
  */
 enum ntb_topo {
 	NTB_TOPO_NONE = -1,
@@ -79,6 +80,7 @@ enum ntb_topo {
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
 	NTB_TOPO_SWITCH,
+	NTB_TOPO_CROSSLINK,
 };
 
 static inline int ntb_topo_is_b2b(enum ntb_topo topo)
@@ -94,12 +96,13 @@ static inline int ntb_topo_is_b2b(enum ntb_topo topo)
 static inline char *ntb_topo_string(enum ntb_topo topo)
 {
 	switch (topo) {
-	case NTB_TOPO_NONE:	return "NTB_TOPO_NONE";
-	case NTB_TOPO_PRI:	return "NTB_TOPO_PRI";
-	case NTB_TOPO_SEC:	return "NTB_TOPO_SEC";
-	case NTB_TOPO_B2B_USD:	return "NTB_TOPO_B2B_USD";
-	case NTB_TOPO_B2B_DSD:	return "NTB_TOPO_B2B_DSD";
-	case NTB_TOPO_SWITCH:	return "NTB_TOPO_SWITCH";
+	case NTB_TOPO_NONE:		return "NTB_TOPO_NONE";
+	case NTB_TOPO_PRI:		return "NTB_TOPO_PRI";
+	case NTB_TOPO_SEC:		return "NTB_TOPO_SEC";
+	case NTB_TOPO_B2B_USD:		return "NTB_TOPO_B2B_USD";
+	case NTB_TOPO_B2B_DSD:		return "NTB_TOPO_B2B_DSD";
+	case NTB_TOPO_SWITCH:		return "NTB_TOPO_SWITCH";
+	case NTB_TOPO_CROSSLINK:	return "NTB_TOPO_CROSSLINK";
 	}
 	return "NTB_TOPO_INVALID";
 }
-- 
2.11.0

