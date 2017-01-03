Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o85si9450414pfj.2.2017.01.02.17.31.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2017 17:31:17 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  2 Jan 2017 18:30:36 -0700
Message-Id: <1483407036-20697-3-git-send-email-logang@deltatee.com>
In-Reply-To: <1483407036-20697-1-git-send-email-logang@deltatee.com>
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 2/2] ntb_hw_intel: Style fixes: open code macros that just obfuscate code
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

As per a comments in [1] by Greg Kroah-Hartman, the ndev_* macros should
be cleaned up. This makes it more clear what's actually going on when
reading the code.

[1] http://www.spinics.net/lists/linux-pci/msg56904.html

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 145 ++++++++++++++++++------------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
 2 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 7310a26..3c8ef1d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -254,12 +254,12 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
 
 	if (db_addr) {
 		*db_addr = reg_addr + reg;
-		dev_dbg(ndev_dev(ndev), "Peer db addr %llx\n", *db_addr);
+		dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx\n", *db_addr);
 	}
 
 	if (db_size) {
 		*db_size = ndev->reg->db_size;
-		dev_dbg(ndev_dev(ndev), "Peer db size %llx\n", *db_size);
+		dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n", *db_size);
 	}
 
 	return 0;
@@ -352,7 +352,8 @@ static inline int ndev_spad_addr(struct intel_ntb_dev *ndev, int idx,
 
 	if (spad_addr) {
 		*spad_addr = reg_addr + reg + (idx << 2);
-		dev_dbg(ndev_dev(ndev), "Peer spad addr %llx\n", *spad_addr);
+		dev_dbg(&ndev->ntb.pdev->dev, "Peer spad addr %llx\n",
+			*spad_addr);
 	}
 
 	return 0;
@@ -390,7 +391,7 @@ static irqreturn_t ndev_interrupt(struct intel_ntb_dev *ndev, int vec)
 
 	vec_mask = ndev_vec_mask(ndev, vec);
 
-	dev_dbg(ndev_dev(ndev), "vec %d vec_mask %llx\n", vec, vec_mask);
+	dev_dbg(&ndev->ntb.pdev->dev, "vec %d vec_mask %llx\n", vec, vec_mask);
 
 	ndev->last_ts = jiffies;
 
@@ -416,7 +417,7 @@ static irqreturn_t ndev_irq_isr(int irq, void *dev)
 {
 	struct intel_ntb_dev *ndev = dev;
 
-	return ndev_interrupt(ndev, irq - ndev_pdev(ndev)->irq);
+	return ndev_interrupt(ndev, irq - ndev->ntb.pdev->irq);
 }
 
 static int ndev_init_isr(struct intel_ntb_dev *ndev,
@@ -426,7 +427,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 	struct pci_dev *pdev;
 	int rc, i, msix_count, node;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	node = dev_to_node(&pdev->dev);
 
@@ -465,7 +466,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 			goto err_msix_request;
 	}
 
-	dev_dbg(ndev_dev(ndev), "Using msix interrupts\n");
+	dev_dbg(&pdev->dev, "Using msix interrupts\n");
 	ndev->db_vec_count = msix_count;
 	ndev->db_vec_shift = msix_shift;
 	return 0;
@@ -493,7 +494,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 	if (rc)
 		goto err_msi_request;
 
-	dev_dbg(ndev_dev(ndev), "Using msi interrupts\n");
+	dev_dbg(&pdev->dev, "Using msi interrupts\n");
 	ndev->db_vec_count = 1;
 	ndev->db_vec_shift = total_shift;
 	return 0;
@@ -511,7 +512,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 	if (rc)
 		goto err_intx_request;
 
-	dev_dbg(ndev_dev(ndev), "Using intx interrupts\n");
+	dev_dbg(&pdev->dev, "Using intx interrupts\n");
 	ndev->db_vec_count = 1;
 	ndev->db_vec_shift = total_shift;
 	return 0;
@@ -525,7 +526,7 @@ static void ndev_deinit_isr(struct intel_ntb_dev *ndev)
 	struct pci_dev *pdev;
 	int i;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	/* Mask all doorbell interrupts */
 	ndev->db_mask = ndev->db_valid_mask;
@@ -559,7 +560,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	union { u64 v64; u32 v32; u16 v16; u8 v8; } u;
 
 	ndev = filp->private_data;
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 	mmio = ndev->self_mmio;
 
 	buf_size = min(count, 0x800ul);
@@ -820,7 +821,8 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 		ndev->debugfs_info = NULL;
 	} else {
 		ndev->debugfs_dir =
-			debugfs_create_dir(ndev_name(ndev), debugfs_dir);
+			debugfs_create_dir(pci_name(ndev->ntb.pdev),
+					   debugfs_dir);
 		if (!ndev->debugfs_dir)
 			ndev->debugfs_info = NULL;
 		else
@@ -1007,13 +1009,13 @@ static int intel_ntb_link_enable(struct ntb_dev *ntb,
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
 
-	dev_dbg(ndev_dev(ndev),
+	dev_dbg(&ntb->pdev->dev,
 		"Enabling link with max_speed %d max_width %d\n",
 		max_speed, max_width);
 	if (max_speed != NTB_SPEED_AUTO)
-		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
+		dev_dbg(&ntb->pdev->dev, "ignoring max_speed %d\n", max_speed);
 	if (max_width != NTB_WIDTH_AUTO)
-		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
+		dev_dbg(&ntb->pdev->dev, "ignoring max_width %d\n", max_width);
 
 	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
 	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
@@ -1036,7 +1038,7 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
 
-	dev_dbg(ndev_dev(ndev), "Disabling link\n");
+	dev_dbg(&ntb->pdev->dev, "Disabling link\n");
 
 	/* Bring NTB link down */
 	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
@@ -1243,30 +1245,33 @@ static int atom_link_is_err(struct intel_ntb_dev *ndev)
 
 static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 {
+	struct device *dev = &ndev->ntb.pdev->dev;
+
 	switch (ppd & ATOM_PPD_TOPO_MASK) {
 	case ATOM_PPD_TOPO_B2B_USD:
-		dev_dbg(ndev_dev(ndev), "PPD %d B2B USD\n", ppd);
+		dev_dbg(dev, "PPD %d B2B USD\n", ppd);
 		return NTB_TOPO_B2B_USD;
 
 	case ATOM_PPD_TOPO_B2B_DSD:
-		dev_dbg(ndev_dev(ndev), "PPD %d B2B DSD\n", ppd);
+		dev_dbg(dev, "PPD %d B2B DSD\n", ppd);
 		return NTB_TOPO_B2B_DSD;
 
 	case ATOM_PPD_TOPO_PRI_USD:
 	case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
 	case ATOM_PPD_TOPO_SEC_USD:
 	case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
-		dev_dbg(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
+		dev_dbg(dev, "PPD %d non B2B disabled\n", ppd);
 		return NTB_TOPO_NONE;
 	}
 
-	dev_dbg(ndev_dev(ndev), "PPD %d invalid\n", ppd);
+	dev_dbg(dev, "PPD %d invalid\n", ppd);
 	return NTB_TOPO_NONE;
 }
 
 static void atom_link_hb(struct work_struct *work)
 {
 	struct intel_ntb_dev *ndev = hb_ndev(work);
+	struct device *dev = &ndev->ntb.pdev->dev;
 	unsigned long poll_ts;
 	void __iomem *mmio;
 	u32 status32;
@@ -1304,30 +1309,30 @@ static void atom_link_hb(struct work_struct *work)
 
 	/* Clear AER Errors, write to clear */
 	status32 = ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
-	dev_dbg(ndev_dev(ndev), "ERRCORSTS = %x\n", status32);
+	dev_dbg(dev, "ERRCORSTS = %x\n", status32);
 	status32 &= PCI_ERR_COR_REP_ROLL;
 	iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
 
 	/* Clear unexpected electrical idle event in LTSSM, write to clear */
 	status32 = ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
-	dev_dbg(ndev_dev(ndev), "LTSSMERRSTS0 = %x\n", status32);
+	dev_dbg(dev, "LTSSMERRSTS0 = %x\n", status32);
 	status32 |= ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
 	iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
 
 	/* Clear DeSkew Buffer error, write to clear */
 	status32 = ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
-	dev_dbg(ndev_dev(ndev), "DESKEWSTS = %x\n", status32);
+	dev_dbg(dev, "DESKEWSTS = %x\n", status32);
 	status32 |= ATOM_DESKEWSTS_DBERR;
 	iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
 
 	status32 = ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
-	dev_dbg(ndev_dev(ndev), "IBSTERRRCRVSTS0 = %x\n", status32);
+	dev_dbg(dev, "IBSTERRRCRVSTS0 = %x\n", status32);
 	status32 &= ATOM_IBIST_ERR_OFLOW;
 	iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
 
 	/* Releases the NTB state machine to allow the link to retrain */
 	status32 = ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
-	dev_dbg(ndev_dev(ndev), "LTSSMSTATEJMP = %x\n", status32);
+	dev_dbg(dev, "LTSSMSTATEJMP = %x\n", status32);
 	status32 &= ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
 	iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
 
@@ -1494,7 +1499,7 @@ static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
 static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
 {
 	if (ppd & XEON_PPD_SPLIT_BAR_MASK) {
-		dev_dbg(ndev_dev(ndev), "PPD %d split bar\n", ppd);
+		dev_dbg(&ndev->ntb.pdev->dev, "PPD %d split bar\n", ppd);
 		return 1;
 	}
 	return 0;
@@ -1524,11 +1529,11 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	int b2b_bar;
 	u8 bar_sz;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 	mmio = ndev->self_mmio;
 
 	if (ndev->b2b_idx == UINT_MAX) {
-		dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
+		dev_dbg(&pdev->dev, "not using b2b mw\n");
 		b2b_bar = 0;
 		ndev->b2b_off = 0;
 	} else {
@@ -1536,24 +1541,21 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		if (b2b_bar < 0)
 			return -EIO;
 
-		dev_dbg(ndev_dev(ndev), "using b2b mw bar %d\n", b2b_bar);
+		dev_dbg(&pdev->dev, "using b2b mw bar %d\n", b2b_bar);
 
 		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
 
-		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
+		dev_dbg(&pdev->dev, "b2b bar size %#llx\n", bar_size);
 
 		if (b2b_mw_share && XEON_B2B_MIN_SIZE <= bar_size >> 1) {
-			dev_dbg(ndev_dev(ndev),
-				"b2b using first half of bar\n");
+			dev_dbg(&pdev->dev, "b2b using first half of bar\n");
 			ndev->b2b_off = bar_size >> 1;
 		} else if (XEON_B2B_MIN_SIZE <= bar_size) {
-			dev_dbg(ndev_dev(ndev),
-				"b2b using whole bar\n");
+			dev_dbg(&pdev->dev, "b2b using whole bar\n");
 			ndev->b2b_off = 0;
 			--ndev->mw_count;
 		} else {
-			dev_dbg(ndev_dev(ndev),
-				"b2b bar size is too small\n");
+			dev_dbg(&pdev->dev, "b2b bar size is too small\n");
 			return -EIO;
 		}
 	}
@@ -1565,7 +1567,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 * offsets are not in a consistent order (bar5sz comes after ppd, odd).
 	 */
 	pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &bar_sz);
-	dev_dbg(ndev_dev(ndev), "PBAR23SZ %#x\n", bar_sz);
+	dev_dbg(&pdev->dev, "PBAR23SZ %#x\n", bar_sz);
 	if (b2b_bar == 2) {
 		if (ndev->b2b_off)
 			bar_sz -= 1;
@@ -1574,11 +1576,11 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	}
 	pci_write_config_byte(pdev, XEON_SBAR23SZ_OFFSET, bar_sz);
 	pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &bar_sz);
-	dev_dbg(ndev_dev(ndev), "SBAR23SZ %#x\n", bar_sz);
+	dev_dbg(&pdev->dev, "SBAR23SZ %#x\n", bar_sz);
 
 	if (!ndev->bar4_split) {
 		pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "PBAR45SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "PBAR45SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -1587,10 +1589,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR45SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "SBAR45SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "SBAR45SZ %#x\n", bar_sz);
 	} else {
 		pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "PBAR4SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "PBAR4SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -1599,10 +1601,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR4SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "SBAR4SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "SBAR4SZ %#x\n", bar_sz);
 
 		pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "PBAR5SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "PBAR5SZ %#x\n", bar_sz);
 		if (b2b_bar == 5) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -1611,7 +1613,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR5SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET, &bar_sz);
-		dev_dbg(ndev_dev(ndev), "SBAR5SZ %#x\n", bar_sz);
+		dev_dbg(&pdev->dev, "SBAR5SZ %#x\n", bar_sz);
 	}
 
 	/* SBAR01 hit by first part of the b2b bar */
@@ -1628,7 +1630,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	else
 		return -EIO;
 
-	dev_dbg(ndev_dev(ndev), "SBAR01 %#018llx\n", bar_addr);
+	dev_dbg(&pdev->dev, "SBAR01 %#018llx\n", bar_addr);
 	iowrite64(bar_addr, mmio + XEON_SBAR0BASE_OFFSET);
 
 	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
@@ -1639,26 +1641,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
 	iowrite64(bar_addr, mmio + XEON_SBAR23BASE_OFFSET);
 	bar_addr = ioread64(mmio + XEON_SBAR23BASE_OFFSET);
-	dev_dbg(ndev_dev(ndev), "SBAR23 %#018llx\n", bar_addr);
+	dev_dbg(&pdev->dev, "SBAR23 %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite64(bar_addr, mmio + XEON_SBAR45BASE_OFFSET);
 		bar_addr = ioread64(mmio + XEON_SBAR45BASE_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR45 %#018llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR45 %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR4BASE_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR4BASE_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR4 %#010llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR4 %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR5BASE_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR5BASE_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR5 %#010llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR5 %#010llx\n", bar_addr);
 	}
 
 	/* setup incoming bar limits == base addrs (zero length windows) */
@@ -1666,26 +1668,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
 	iowrite64(bar_addr, mmio + XEON_SBAR23LMT_OFFSET);
 	bar_addr = ioread64(mmio + XEON_SBAR23LMT_OFFSET);
-	dev_dbg(ndev_dev(ndev), "SBAR23LMT %#018llx\n", bar_addr);
+	dev_dbg(&pdev->dev, "SBAR23LMT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite64(bar_addr, mmio + XEON_SBAR45LMT_OFFSET);
 		bar_addr = ioread64(mmio + XEON_SBAR45LMT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR45LMT %#018llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR45LMT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR4LMT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR4LMT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR4LMT %#010llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR4LMT %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR5LMT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR5LMT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "SBAR5LMT %#05llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "SBAR5LMT %#05llx\n", bar_addr);
 	}
 
 	/* zero incoming translation addrs */
@@ -1711,23 +1713,23 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = peer_addr->bar2_addr64;
 	iowrite64(bar_addr, mmio + XEON_PBAR23XLAT_OFFSET);
 	bar_addr = ioread64(mmio + XEON_PBAR23XLAT_OFFSET);
-	dev_dbg(ndev_dev(ndev), "PBAR23XLAT %#018llx\n", bar_addr);
+	dev_dbg(&pdev->dev, "PBAR23XLAT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = peer_addr->bar4_addr64;
 		iowrite64(bar_addr, mmio + XEON_PBAR45XLAT_OFFSET);
 		bar_addr = ioread64(mmio + XEON_PBAR45XLAT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "PBAR45XLAT %#018llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "PBAR45XLAT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = peer_addr->bar4_addr32;
 		iowrite32(bar_addr, mmio + XEON_PBAR4XLAT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_PBAR4XLAT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "PBAR4XLAT %#010llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "PBAR4XLAT %#010llx\n", bar_addr);
 
 		bar_addr = peer_addr->bar5_addr32;
 		iowrite32(bar_addr, mmio + XEON_PBAR5XLAT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_PBAR5XLAT_OFFSET);
-		dev_dbg(ndev_dev(ndev), "PBAR5XLAT %#010llx\n", bar_addr);
+		dev_dbg(&pdev->dev, "PBAR5XLAT %#010llx\n", bar_addr);
 	}
 
 	/* set the translation offset for b2b registers */
@@ -1745,7 +1747,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		return -EIO;
 
 	/* B2B_XLAT_OFFSET is 64bit, but can only take 32bit writes */
-	dev_dbg(ndev_dev(ndev), "B2BXLAT %#018llx\n", bar_addr);
+	dev_dbg(&pdev->dev, "B2BXLAT %#018llx\n", bar_addr);
 	iowrite32(bar_addr, mmio + XEON_B2B_XLAT_OFFSETL);
 	iowrite32(bar_addr >> 32, mmio + XEON_B2B_XLAT_OFFSETU);
 
@@ -1764,6 +1766,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 
 static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 {
+	struct device *dev = &ndev->ntb.pdev->dev;
 	int rc;
 	u32 ntb_ctl;
 
@@ -1779,7 +1782,7 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 	switch (ndev->ntb.topo) {
 	case NTB_TOPO_PRI:
 		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
+			dev_err(dev, "NTB Primary config disabled\n");
 			return -EINVAL;
 		}
 
@@ -1797,7 +1800,7 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 
 	case NTB_TOPO_SEC:
 		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(ndev_dev(ndev), "NTB Secondary config disabled\n");
+			dev_err(dev, "NTB Secondary config disabled\n");
 			return -EINVAL;
 		}
 		/* use half the spads for the peer */
@@ -1822,18 +1825,17 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 				ndev->b2b_idx = b2b_mw_idx;
 
 			if (ndev->b2b_idx >= ndev->mw_count) {
-				dev_dbg(ndev_dev(ndev),
+				dev_dbg(dev,
 					"b2b_mw_idx %d invalid for mw_count %u\n",
 					b2b_mw_idx, ndev->mw_count);
 				return -EINVAL;
 			}
 
-			dev_dbg(ndev_dev(ndev),
-				"setting up b2b mw idx %d means %d\n",
+			dev_dbg(dev, "setting up b2b mw idx %d means %d\n",
 				b2b_mw_idx, ndev->b2b_idx);
 
 		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
-			dev_warn(ndev_dev(ndev), "Reduce doorbell count by 1\n");
+			dev_warn(dev, "Reduce doorbell count by 1\n");
 			ndev->db_count -= 1;
 		}
 
@@ -1874,7 +1876,7 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 	u8 ppd;
 	int rc, mem;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	switch (pdev->device) {
 	/* There is a Xeon hardware errata related to writes to SDOORBELL or
@@ -1950,14 +1952,14 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 		return -EIO;
 
 	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
-	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
+	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd,
 		ntb_topo_string(ndev->ntb.topo));
 	if (ndev->ntb.topo == NTB_TOPO_NONE)
 		return -EINVAL;
 
 	if (ndev->ntb.topo != NTB_TOPO_SEC) {
 		ndev->bar4_split = xeon_ppd_bar4_split(ndev, ppd);
-		dev_dbg(ndev_dev(ndev), "ppd %#x bar4_split %d\n",
+		dev_dbg(&pdev->dev, "ppd %#x bar4_split %d\n",
 			ppd, ndev->bar4_split);
 	} else {
 		/* This is a way for transparent BAR to figure out if we are
@@ -1967,7 +1969,7 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 		mem = pci_select_bars(pdev, IORESOURCE_MEM);
 		ndev->bar4_split = hweight32(mem) ==
 			HSX_SPLIT_BAR_MW_COUNT + 1;
-		dev_dbg(ndev_dev(ndev), "mem %#x bar4_split %d\n",
+		dev_dbg(&pdev->dev, "mem %#x bar4_split %d\n",
 			mem, ndev->bar4_split);
 	}
 
@@ -2004,7 +2006,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
-		dev_warn(ndev_dev(ndev), "Cannot DMA highmem\n");
+		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
 	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
@@ -2012,7 +2014,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
-		dev_warn(ndev_dev(ndev), "Cannot DMA consistent highmem\n");
+		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
@@ -2038,7 +2040,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 
 static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = ndev_pdev(ndev);
+	struct pci_dev *pdev = ndev->ntb.pdev;
 
 	if (ndev->peer_mmio && ndev->peer_mmio != ndev->self_mmio)
 		pci_iounmap(pdev, ndev->peer_mmio);
@@ -2336,4 +2338,3 @@ static void __exit intel_ntb_pci_driver_exit(void)
 	debugfs_remove_recursive(debugfs_dir);
 }
 module_exit(intel_ntb_pci_driver_exit);
-
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 3ec149c..f0227a4 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -334,9 +334,6 @@ struct intel_ntb_dev {
 	struct dentry			*debugfs_info;
 };
 
-#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
-#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
-#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
 #define ntb_ndev(__ntb) container_of(__ntb, struct intel_ntb_dev, ntb)
 #define hb_ndev(__work) container_of(__work, struct intel_ntb_dev, \
 				     hb_timer.work)
-- 
2.1.4

