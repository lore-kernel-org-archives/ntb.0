Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o85si841850pfj.2.2017.01.10.16.33.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:33:50 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 10 Jan 2017 17:33:39 -0700
Message-Id: <1484094819-16084-5-git-send-email-logang@deltatee.com>
In-Reply-To: <1484094819-16084-1-git-send-email-logang@deltatee.com>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v2 4/4] ntb_hw_intel: Print kernel messages with the ntb device not the pci one
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Now that macros are open it's pretty clear that these should print
using the NTB struct device not the PCI one.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 132 +++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 6456f54..001c82d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -270,12 +270,12 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
 
 	if (db_addr) {
 		*db_addr = reg_addr + reg;
-		dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx\n", *db_addr);
+		dev_dbg(&ndev->ntb.dev, "Peer db addr %llx\n", *db_addr);
 	}
 
 	if (db_size) {
 		*db_size = ndev->reg->db_size;
-		dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n", *db_size);
+		dev_dbg(&ndev->ntb.dev, "Peer db size %llx\n", *db_size);
 	}
 
 	return 0;
@@ -368,8 +368,7 @@ static inline int ndev_spad_addr(struct intel_ntb_dev *ndev, int idx,
 
 	if (spad_addr) {
 		*spad_addr = reg_addr + reg + (idx << 2);
-		dev_dbg(&ndev->ntb.pdev->dev, "Peer spad addr %llx\n",
-			*spad_addr);
+		dev_dbg(&ndev->ntb.dev, "Peer spad addr %llx\n", *spad_addr);
 	}
 
 	return 0;
@@ -410,7 +409,7 @@ static irqreturn_t ndev_interrupt(struct intel_ntb_dev *ndev, int vec)
 	if ((ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD) && (vec == 31))
 		vec_mask |= ndev->db_link_mask;
 
-	dev_dbg(&ndev->ntb.pdev->dev, "vec %d vec_mask %llx\n", vec, vec_mask);
+	dev_dbg(&ndev->ntb.dev, "vec %d vec_mask %llx\n", vec, vec_mask);
 
 	ndev->last_ts = jiffies;
 
@@ -429,7 +428,7 @@ static irqreturn_t ndev_vec_isr(int irq, void *dev)
 {
 	struct intel_ntb_vec *nvec = dev;
 
-	dev_dbg(&nvec->ndev->ntb.pdev->dev, "irq: %d  nvec->num: %d\n",
+	dev_dbg(&nvec->ndev->ntb.dev, "irq: %d  nvec->num: %d\n",
 		irq, nvec->num);
 
 	return ndev_interrupt(nvec->ndev, nvec->num);
@@ -534,7 +533,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 	if (rc)
 		goto err_intx_request;
 
-	dev_dbg(&pdev->dev, "Using intx interrupts\n");
+	dev_dbg(&ndev->ntb.dev, "Using intx interrupts\n");
 	ndev->db_vec_count = 1;
 	ndev->db_vec_shift = total_shift;
 	return 0;
@@ -1208,13 +1207,12 @@ static int intel_ntb_link_enable(struct ntb_dev *ntb,
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
 
-	dev_dbg(&ntb->pdev->dev,
-		"Enabling link with max_speed %d max_width %d\n",
+	dev_dbg(&ntb->dev, "Enabling link with max_speed %d max_width %d\n",
 		max_speed, max_width);
 	if (max_speed != NTB_SPEED_AUTO)
-		dev_dbg(&ntb->pdev->dev, "ignoring max_speed %d\n", max_speed);
+		dev_dbg(&ntb->dev, "ignoring max_speed %d\n", max_speed);
 	if (max_width != NTB_WIDTH_AUTO)
-		dev_dbg(&ntb->pdev->dev, "ignoring max_width %d\n", max_width);
+		dev_dbg(&ntb->dev, "ignoring max_width %d\n", max_width);
 
 	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
 	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
@@ -1237,7 +1235,7 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
 
-	dev_dbg(&ntb->pdev->dev, "Disabling link\n");
+	dev_dbg(&ntb->dev, "Disabling link\n");
 
 	/* Bring NTB link down */
 	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
@@ -1444,33 +1442,30 @@ static int atom_link_is_err(struct intel_ntb_dev *ndev)
 
 static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 {
-	struct device *dev = &ndev->ntb.pdev->dev;
-
 	switch (ppd & ATOM_PPD_TOPO_MASK) {
 	case ATOM_PPD_TOPO_B2B_USD:
-		dev_dbg(dev, "PPD %d B2B USD\n", ppd);
+		dev_dbg(&ndev->ntb.dev, "PPD %d B2B USD\n", ppd);
 		return NTB_TOPO_B2B_USD;
 
 	case ATOM_PPD_TOPO_B2B_DSD:
-		dev_dbg(dev, "PPD %d B2B DSD\n", ppd);
+		dev_dbg(&ndev->ntb.dev, "PPD %d B2B DSD\n", ppd);
 		return NTB_TOPO_B2B_DSD;
 
 	case ATOM_PPD_TOPO_PRI_USD:
 	case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
 	case ATOM_PPD_TOPO_SEC_USD:
 	case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
-		dev_dbg(dev, "PPD %d non B2B disabled\n", ppd);
+		dev_dbg(&ndev->ntb.dev, "PPD %d non B2B disabled\n", ppd);
 		return NTB_TOPO_NONE;
 	}
 
-	dev_dbg(dev, "PPD %d invalid\n", ppd);
+	dev_dbg(&ndev->ntb.dev, "PPD %d invalid\n", ppd);
 	return NTB_TOPO_NONE;
 }
 
 static void atom_link_hb(struct work_struct *work)
 {
 	struct intel_ntb_dev *ndev = hb_ndev(work);
-	struct device *dev = &ndev->ntb.pdev->dev;
 	unsigned long poll_ts;
 	void __iomem *mmio;
 	u32 status32;
@@ -1508,30 +1503,30 @@ static void atom_link_hb(struct work_struct *work)
 
 	/* Clear AER Errors, write to clear */
 	status32 = ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
-	dev_dbg(dev, "ERRCORSTS = %x\n", status32);
+	dev_dbg(&ndev->ntb.dev, "ERRCORSTS = %x\n", status32);
 	status32 &= PCI_ERR_COR_REP_ROLL;
 	iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
 
 	/* Clear unexpected electrical idle event in LTSSM, write to clear */
 	status32 = ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
-	dev_dbg(dev, "LTSSMERRSTS0 = %x\n", status32);
+	dev_dbg(&ndev->ntb.dev, "LTSSMERRSTS0 = %x\n", status32);
 	status32 |= ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
 	iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
 
 	/* Clear DeSkew Buffer error, write to clear */
 	status32 = ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
-	dev_dbg(dev, "DESKEWSTS = %x\n", status32);
+	dev_dbg(&ndev->ntb.dev, "DESKEWSTS = %x\n", status32);
 	status32 |= ATOM_DESKEWSTS_DBERR;
 	iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
 
 	status32 = ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
-	dev_dbg(dev, "IBSTERRRCRVSTS0 = %x\n", status32);
+	dev_dbg(&ndev->ntb.dev, "IBSTERRRCRVSTS0 = %x\n", status32);
 	status32 &= ATOM_IBIST_ERR_OFLOW;
 	iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
 
 	/* Releases the NTB state machine to allow the link to retrain */
 	status32 = ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
-	dev_dbg(dev, "LTSSMSTATEJMP = %x\n", status32);
+	dev_dbg(&ndev->ntb.dev, "LTSSMSTATEJMP = %x\n", status32);
 	status32 &= ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
 	iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
 
@@ -1718,7 +1713,7 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 * except disable or halve the size of the b2b secondary bar.
 	 */
 	pci_read_config_byte(pdev, SKX_IMBAR1SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "IMBAR1SZ %#x\n", bar_sz);
+	dev_dbg(&ndev->ntb.dev, "IMBAR1SZ %#x\n", bar_sz);
 	if (b2b_bar == 1) {
 		if (ndev->b2b_off)
 			bar_sz -= 1;
@@ -1865,14 +1860,13 @@ static int intel_ntb3_link_enable(struct ntb_dev *ntb,
 
 	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-	dev_dbg(&ntb->pdev->dev,
-		"Enabling link with max_speed %d max_width %d\n",
+	dev_dbg(&ntb->dev, "Enabling link with max_speed %d max_width %d\n",
 		max_speed, max_width);
 
 	if (max_speed != NTB_SPEED_AUTO)
-		dev_dbg(&ntb->pdev->dev, "ignoring max_speed %d\n", max_speed);
+		dev_dbg(&ntb->dev, "ignoring max_speed %d\n", max_speed);
 	if (max_width != NTB_WIDTH_AUTO)
-		dev_dbg(&ntb->pdev->dev, "ignoring max_width %d\n", max_width);
+		dev_dbg(&ntb->dev, "ignoring max_width %d\n", max_width);
 
 	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
 	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
@@ -1933,7 +1927,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
 		return -EIO;
 	}
 
-	dev_dbg(&ntb->pdev->dev, "BAR %d IMBARXBASE: %#Lx\n", bar, reg_val);
+	dev_dbg(&ntb->dev, "BAR %d IMBARXBASE: %#Lx\n", bar, reg_val);
 
 	/* set and verify setting the limit */
 	iowrite64(limit, mmio + limit_reg);
@@ -1944,7 +1938,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
 		return -EIO;
 	}
 
-	dev_dbg(&ntb->pdev->dev, "BAR %d IMBARXLMT: %#Lx\n", bar, reg_val);
+	dev_dbg(&ntb->dev, "BAR %d IMBARXLMT: %#Lx\n", bar, reg_val);
 
 	/* setup the EP */
 	limit_reg = ndev->xlat_reg->bar2_limit + (idx * 0x10) + 0x4000;
@@ -1965,7 +1959,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
 		return -EIO;
 	}
 
-	dev_dbg(&ntb->pdev->dev, "BAR %d EMBARXLMT: %#Lx\n", bar, reg_val);
+	dev_dbg(&ntb->dev, "BAR %d EMBARXLMT: %#Lx\n", bar, reg_val);
 
 	return 0;
 }
@@ -2072,7 +2066,7 @@ static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
 static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
 {
 	if (ppd & XEON_PPD_SPLIT_BAR_MASK) {
-		dev_dbg(&ndev->ntb.pdev->dev, "PPD %d split bar\n", ppd);
+		dev_dbg(&ndev->ntb.dev, "PPD %d split bar\n", ppd);
 		return 1;
 	}
 	return 0;
@@ -2106,7 +2100,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	mmio = ndev->self_mmio;
 
 	if (ndev->b2b_idx == UINT_MAX) {
-		dev_dbg(&pdev->dev, "not using b2b mw\n");
+		dev_dbg(&ndev->ntb.dev, "not using b2b mw\n");
 		b2b_bar = 0;
 		ndev->b2b_off = 0;
 	} else {
@@ -2114,21 +2108,21 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		if (b2b_bar < 0)
 			return -EIO;
 
-		dev_dbg(&pdev->dev, "using b2b mw bar %d\n", b2b_bar);
+		dev_dbg(&ndev->ntb.dev, "using b2b mw bar %d\n", b2b_bar);
 
 		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
 
-		dev_dbg(&pdev->dev, "b2b bar size %#llx\n", bar_size);
+		dev_dbg(&ndev->ntb.dev, "b2b bar size %#llx\n", bar_size);
 
 		if (b2b_mw_share && XEON_B2B_MIN_SIZE <= bar_size >> 1) {
-			dev_dbg(&pdev->dev, "b2b using first half of bar\n");
+			dev_dbg(&ndev->ntb.dev, "b2b using first half of bar\n");
 			ndev->b2b_off = bar_size >> 1;
 		} else if (XEON_B2B_MIN_SIZE <= bar_size) {
-			dev_dbg(&pdev->dev, "b2b using whole bar\n");
+			dev_dbg(&ndev->ntb.dev, "b2b using whole bar\n");
 			ndev->b2b_off = 0;
 			--ndev->mw_count;
 		} else {
-			dev_dbg(&pdev->dev, "b2b bar size is too small\n");
+			dev_dbg(&ndev->ntb.dev, "b2b bar size is too small\n");
 			return -EIO;
 		}
 	}
@@ -2140,7 +2134,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 * offsets are not in a consistent order (bar5sz comes after ppd, odd).
 	 */
 	pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "PBAR23SZ %#x\n", bar_sz);
+	dev_dbg(&ndev->ntb.dev, "PBAR23SZ %#x\n", bar_sz);
 	if (b2b_bar == 2) {
 		if (ndev->b2b_off)
 			bar_sz -= 1;
@@ -2149,11 +2143,11 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	}
 	pci_write_config_byte(pdev, XEON_SBAR23SZ_OFFSET, bar_sz);
 	pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "SBAR23SZ %#x\n", bar_sz);
+	dev_dbg(&ndev->ntb.dev, "SBAR23SZ %#x\n", bar_sz);
 
 	if (!ndev->bar4_split) {
 		pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "PBAR45SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "PBAR45SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -2162,10 +2156,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR45SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "SBAR45SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "SBAR45SZ %#x\n", bar_sz);
 	} else {
 		pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "PBAR4SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "PBAR4SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -2174,10 +2168,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR4SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "SBAR4SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "SBAR4SZ %#x\n", bar_sz);
 
 		pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "PBAR5SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "PBAR5SZ %#x\n", bar_sz);
 		if (b2b_bar == 5) {
 			if (ndev->b2b_off)
 				bar_sz -= 1;
@@ -2186,7 +2180,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		}
 		pci_write_config_byte(pdev, XEON_SBAR5SZ_OFFSET, bar_sz);
 		pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET, &bar_sz);
-		dev_dbg(&pdev->dev, "SBAR5SZ %#x\n", bar_sz);
+		dev_dbg(&ndev->ntb.dev, "SBAR5SZ %#x\n", bar_sz);
 	}
 
 	/* SBAR01 hit by first part of the b2b bar */
@@ -2203,7 +2197,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	else
 		return -EIO;
 
-	dev_dbg(&pdev->dev, "SBAR01 %#018llx\n", bar_addr);
+	dev_dbg(&ndev->ntb.dev, "SBAR01 %#018llx\n", bar_addr);
 	iowrite64(bar_addr, mmio + XEON_SBAR0BASE_OFFSET);
 
 	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
@@ -2214,26 +2208,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
 	iowrite64(bar_addr, mmio + XEON_SBAR23BASE_OFFSET);
 	bar_addr = ioread64(mmio + XEON_SBAR23BASE_OFFSET);
-	dev_dbg(&pdev->dev, "SBAR23 %#018llx\n", bar_addr);
+	dev_dbg(&ndev->ntb.dev, "SBAR23 %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite64(bar_addr, mmio + XEON_SBAR45BASE_OFFSET);
 		bar_addr = ioread64(mmio + XEON_SBAR45BASE_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR45 %#018llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR45 %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR4BASE_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR4BASE_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR4 %#010llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR4 %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR5BASE_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR5BASE_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR5 %#010llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR5 %#010llx\n", bar_addr);
 	}
 
 	/* setup incoming bar limits == base addrs (zero length windows) */
@@ -2241,26 +2235,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
 	iowrite64(bar_addr, mmio + XEON_SBAR23LMT_OFFSET);
 	bar_addr = ioread64(mmio + XEON_SBAR23LMT_OFFSET);
-	dev_dbg(&pdev->dev, "SBAR23LMT %#018llx\n", bar_addr);
+	dev_dbg(&ndev->ntb.dev, "SBAR23LMT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite64(bar_addr, mmio + XEON_SBAR45LMT_OFFSET);
 		bar_addr = ioread64(mmio + XEON_SBAR45LMT_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR45LMT %#018llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR45LMT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR4LMT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR4LMT_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR4LMT %#010llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR4LMT %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
 		iowrite32(bar_addr, mmio + XEON_SBAR5LMT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_SBAR5LMT_OFFSET);
-		dev_dbg(&pdev->dev, "SBAR5LMT %#05llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "SBAR5LMT %#05llx\n", bar_addr);
 	}
 
 	/* zero incoming translation addrs */
@@ -2286,23 +2280,23 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	bar_addr = peer_addr->bar2_addr64;
 	iowrite64(bar_addr, mmio + XEON_PBAR23XLAT_OFFSET);
 	bar_addr = ioread64(mmio + XEON_PBAR23XLAT_OFFSET);
-	dev_dbg(&pdev->dev, "PBAR23XLAT %#018llx\n", bar_addr);
+	dev_dbg(&ndev->ntb.dev, "PBAR23XLAT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = peer_addr->bar4_addr64;
 		iowrite64(bar_addr, mmio + XEON_PBAR45XLAT_OFFSET);
 		bar_addr = ioread64(mmio + XEON_PBAR45XLAT_OFFSET);
-		dev_dbg(&pdev->dev, "PBAR45XLAT %#018llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "PBAR45XLAT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = peer_addr->bar4_addr32;
 		iowrite32(bar_addr, mmio + XEON_PBAR4XLAT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_PBAR4XLAT_OFFSET);
-		dev_dbg(&pdev->dev, "PBAR4XLAT %#010llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "PBAR4XLAT %#010llx\n", bar_addr);
 
 		bar_addr = peer_addr->bar5_addr32;
 		iowrite32(bar_addr, mmio + XEON_PBAR5XLAT_OFFSET);
 		bar_addr = ioread32(mmio + XEON_PBAR5XLAT_OFFSET);
-		dev_dbg(&pdev->dev, "PBAR5XLAT %#010llx\n", bar_addr);
+		dev_dbg(&ndev->ntb.dev, "PBAR5XLAT %#010llx\n", bar_addr);
 	}
 
 	/* set the translation offset for b2b registers */
@@ -2320,7 +2314,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		return -EIO;
 
 	/* B2B_XLAT_OFFSET is 64bit, but can only take 32bit writes */
-	dev_dbg(&pdev->dev, "B2BXLAT %#018llx\n", bar_addr);
+	dev_dbg(&ndev->ntb.dev, "B2BXLAT %#018llx\n", bar_addr);
 	iowrite32(bar_addr, mmio + XEON_B2B_XLAT_OFFSETL);
 	iowrite32(bar_addr >> 32, mmio + XEON_B2B_XLAT_OFFSETU);
 
@@ -2339,7 +2333,6 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 
 static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 {
-	struct device *dev = &ndev->ntb.pdev->dev;
 	int rc;
 	u32 ntb_ctl;
 
@@ -2355,7 +2348,8 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 	switch (ndev->ntb.topo) {
 	case NTB_TOPO_PRI:
 		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(dev, "NTB Primary config disabled\n");
+			dev_err(&ndev->ntb.dev,
+				"NTB Primary config disabled\n");
 			return -EINVAL;
 		}
 
@@ -2373,7 +2367,8 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 
 	case NTB_TOPO_SEC:
 		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(dev, "NTB Secondary config disabled\n");
+			dev_err(&ndev->ntb.dev,
+				"NTB Secondary config disabled\n");
 			return -EINVAL;
 		}
 		/* use half the spads for the peer */
@@ -2398,17 +2393,18 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 				ndev->b2b_idx = b2b_mw_idx;
 
 			if (ndev->b2b_idx >= ndev->mw_count) {
-				dev_dbg(dev,
+				dev_dbg(&ndev->ntb.dev,
 					"b2b_mw_idx %d invalid for mw_count %u\n",
 					b2b_mw_idx, ndev->mw_count);
 				return -EINVAL;
 			}
 
-			dev_dbg(dev, "setting up b2b mw idx %d means %d\n",
+			dev_dbg(&ndev->ntb.dev,
+				"setting up b2b mw idx %d means %d\n",
 				b2b_mw_idx, ndev->b2b_idx);
 
 		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
-			dev_warn(dev, "Reduce doorbell count by 1\n");
+			dev_warn(&ndev->ntb.dev, "Reduce doorbell count by 1\n");
 			ndev->db_count -= 1;
 		}
 
@@ -2728,7 +2724,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 	if (rc)
 		goto err_register;
 
-	dev_info(&pdev->dev, "NTB device registered.\n");
+	dev_info(&ndev->ntb.dev, "NTB device registered.\n");
 
 	return 0;
 
-- 
2.1.4

