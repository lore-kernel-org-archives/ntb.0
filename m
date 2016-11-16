Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id n18si8341959pfb.2.2016.11.16.13.03.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2016 13:03:39 -0800 (PST)
Subject: [PATCH v3] ntb: Adding Skylake Xeon NTB support
From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 16 Nov 2016 14:03:38 -0700
Message-ID: <147933021880.124938.13946656717891227718.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The Skylake Xeon NTB hardware has made some changes to the register name,
offset, and the way doorbells work. Adding driver support for the new
hardware.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |  660 +++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |   48 +++
 2 files changed, 703 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 7310a26..d2ce280 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -86,7 +86,12 @@ static const struct intel_ntb_xlat_reg xeon_pri_xlat;
 static const struct intel_ntb_xlat_reg xeon_sec_xlat;
 static struct intel_b2b_addr xeon_b2b_usd_addr;
 static struct intel_b2b_addr xeon_b2b_dsd_addr;
+static const struct intel_ntb_reg skx_reg;
+static const struct intel_ntb_alt_reg skx_pri_reg;
+static const struct intel_ntb_alt_reg skx_b2b_reg;
+static const struct intel_ntb_xlat_reg skx_sec_xlat;
 static const struct ntb_dev_ops intel_ntb_ops;
+static const struct ntb_dev_ops intel_ntb3_ops;
 
 static const struct file_operations intel_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
@@ -145,6 +150,9 @@ module_param_named(xeon_b2b_dsd_bar5_addr32,
 MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
 		 "XEON B2B DSD split-BAR 5 32-bit address");
 
+static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
+static int xeon_init_isr(struct intel_ntb_dev *ndev);
+
 #ifndef ioread64
 #ifdef readq
 #define ioread64 readq
@@ -206,6 +214,14 @@ static inline int pdev_is_xeon(struct pci_dev *pdev)
 	return 0;
 }
 
+static inline int pdev_is_skx_xeon(struct pci_dev *pdev)
+{
+	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_SKX)
+		return 1;
+
+	return 0;
+}
+
 static inline void ndev_reset_unsafe_flags(struct intel_ntb_dev *ndev)
 {
 	ndev->unsafe_flags = 0;
@@ -390,6 +406,9 @@ static irqreturn_t ndev_interrupt(struct intel_ntb_dev *ndev, int vec)
 
 	vec_mask = ndev_vec_mask(ndev, vec);
 
+	if ((ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD) && (vec == 31))
+		vec_mask |= ndev->db_link_mask;
+
 	dev_dbg(ndev_dev(ndev), "vec %d vec_mask %llx\n", vec, vec_mask);
 
 	ndev->last_ts = jiffies;
@@ -409,6 +428,9 @@ static irqreturn_t ndev_vec_isr(int irq, void *dev)
 {
 	struct intel_ntb_vec *nvec = dev;
 
+	dev_dbg(ndev_dev(nvec->ndev), "irq: %d  nvec->num: %d\n",
+		irq, nvec->num);
+
 	return ndev_interrupt(nvec->ndev, nvec->num);
 }
 
@@ -465,7 +487,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 			goto err_msix_request;
 	}
 
-	dev_dbg(ndev_dev(ndev), "Using msix interrupts\n");
+	dev_dbg(ndev_dev(ndev), "Using %d msix interrupts\n", msix_count);
 	ndev->db_vec_count = msix_count;
 	ndev->db_vec_shift = msix_shift;
 	return 0;
@@ -547,8 +569,171 @@ static void ndev_deinit_isr(struct intel_ntb_dev *ndev)
 	}
 }
 
-static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
-				 size_t count, loff_t *offp)
+static ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
+				      size_t count, loff_t *offp)
+{
+	struct intel_ntb_dev *ndev;
+	void __iomem *mmio;
+	char *buf;
+	size_t buf_size;
+	ssize_t ret, off;
+	union { u64 v64; u32 v32; u16 v16; } u;
+
+	ndev = filp->private_data;
+	mmio = ndev->self_mmio;
+
+	buf_size = min(count, 0x800ul);
+
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	off = 0;
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "NTB Device Information:\n");
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "Connection Topology -\t%s\n",
+			 ntb_topo_string(ndev->ntb.topo));
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "NTB CTL -\t\t%#06x\n", ndev->ntb_ctl);
+	off += scnprintf(buf + off, buf_size - off,
+			 "LNK STA -\t\t%#06x\n", ndev->lnk_sta);
+
+	if (!ndev->reg->link_is_up(ndev))
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Status -\t\tDown\n");
+	else {
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Status -\t\tUp\n");
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Speed -\t\tPCI-E Gen %u\n",
+				 NTB_LNK_STA_SPEED(ndev->lnk_sta));
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Width -\t\tx%u\n",
+				 NTB_LNK_STA_WIDTH(ndev->lnk_sta));
+	}
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "Memory Window Count -\t%u\n", ndev->mw_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Scratchpad Count -\t%u\n", ndev->spad_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Count -\t%u\n", ndev->db_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Vector Count -\t%u\n", ndev->db_vec_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Vector Shift -\t%u\n", ndev->db_vec_shift);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Valid Mask -\t%#llx\n", ndev->db_valid_mask);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Link Mask -\t%#llx\n", ndev->db_link_mask);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Mask Cached -\t%#llx\n", ndev->db_mask);
+
+	u.v64 = ndev_db_read(ndev, mmio + ndev->self_reg->db_mask);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Mask -\t\t%#llx\n", u.v64);
+
+	u.v64 = ndev_db_read(ndev, mmio + ndev->self_reg->db_bell);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Bell -\t\t%#llx\n", u.v64);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "\nNTB Incoming XLAT:\n");
+
+	u.v64 = ioread64(mmio + SKX_IMBAR1XBASE_OFFSET);
+	off += scnprintf(buf + off, buf_size - off,
+			 "IMBAR1XBASE -\t\t%#018llx\n", u.v64);
+
+	u.v64 = ioread64(mmio + SKX_IMBAR2XBASE_OFFSET);
+	off += scnprintf(buf + off, buf_size - off,
+			 "IMBAR2XBASE -\t\t%#018llx\n", u.v64);
+
+	u.v64 = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
+	off += scnprintf(buf + off, buf_size - off,
+			 "IMBAR1XLMT -\t\t\t%#018llx\n", u.v64);
+
+	u.v64 = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
+	off += scnprintf(buf + off, buf_size - off,
+			 "IMBAR2XLMT -\t\t\t%#018llx\n", u.v64);
+
+	if (ntb_topo_is_b2b(ndev->ntb.topo)) {
+		off += scnprintf(buf + off, buf_size - off,
+				 "\nNTB Outgoing B2B XLAT:\n");
+
+		u.v64 = ioread64(mmio + SKX_EMBAR1XBASE_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR1XBASE -\t\t%#018llx\n", u.v64);
+
+		u.v64 = ioread64(mmio + SKX_EMBAR2XBASE_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR2XBASE -\t\t%#018llx\n", u.v64);
+
+		u.v64 = ioread64(mmio + SKX_EMBAR1XLMT_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR1XLMT -\t\t%#018llx\n", u.v64);
+
+		u.v64 = ioread64(mmio + SKX_EMBAR2XLMT_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR2XLMT -\t\t%#018llx\n", u.v64);
+
+		off += scnprintf(buf + off, buf_size - off,
+				 "\nNTB Secondary BAR:\n");
+
+		u.v64 = ioread64(mmio + SKX_EMBAR0_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR0 -\t\t%#018llx\n", u.v64);
+
+		u.v64 = ioread64(mmio + SKX_EMBAR1_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR1 -\t\t%#018llx\n", u.v64);
+
+		u.v64 = ioread64(mmio + SKX_EMBAR2_OFFSET);
+		off += scnprintf(buf + off, buf_size - off,
+				 "EMBAR2 -\t\t%#018llx\n", u.v64);
+	}
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "\nNTB Statistics:\n");
+
+	u.v16 = ioread16(mmio + SKX_USMEMMISS_OFFSET);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Upstream Memory Miss -\t%u\n", u.v16);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "\nNTB Hardware Errors:\n");
+
+	if (!pci_read_config_word(ndev->ntb.pdev,
+				  SKX_DEVSTS_OFFSET, &u.v16))
+		off += scnprintf(buf + off, buf_size - off,
+				 "DEVSTS -\t\t%#06x\n", u.v16);
+
+	if (!pci_read_config_word(ndev->ntb.pdev,
+				  SKX_LINK_STATUS_OFFSET, &u.v16))
+		off += scnprintf(buf + off, buf_size - off,
+				 "LNKSTS -\t\t%#06x\n", u.v16);
+
+	if (!pci_read_config_dword(ndev->ntb.pdev,
+				   SKX_UNCERRSTS_OFFSET, &u.v32))
+		off += scnprintf(buf + off, buf_size - off,
+				 "UNCERRSTS -\t\t%#06x\n", u.v32);
+
+	if (!pci_read_config_dword(ndev->ntb.pdev,
+				   SKX_CORERRSTS_OFFSET, &u.v32))
+		off += scnprintf(buf + off, buf_size - off,
+				 "CORERRSTS -\t\t%#06x\n", u.v32);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
+				     size_t count, loff_t *offp)
 {
 	struct intel_ntb_dev *ndev;
 	struct pci_dev *pdev;
@@ -813,6 +998,20 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	return ret;
 }
 
+static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
+				 size_t count, loff_t *offp)
+{
+	struct intel_ntb_dev *ndev = filp->private_data;
+
+	if (pdev_is_xeon(ndev->ntb.pdev) ||
+	    pdev_is_atom(ndev->ntb.pdev))
+		return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
+	else if (pdev_is_skx_xeon(ndev->ntb.pdev))
+		return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
+
+	return -ENXIO;
+}
+
 static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 {
 	if (!debugfs_dir) {
@@ -1428,6 +1627,383 @@ static void atom_deinit_dev(struct intel_ntb_dev *ndev)
 	atom_deinit_isr(ndev);
 }
 
+/* Skylake Xeon NTB */
+
+static u64 skx_db_ioread(void __iomem *mmio)
+{
+	return ioread64(mmio);
+}
+
+static void skx_db_iowrite(u64 bits, void __iomem *mmio)
+{
+	iowrite64(bits, mmio);
+}
+
+static int skx_init_isr(struct intel_ntb_dev *ndev)
+{
+	int i;
+
+	/*
+	 * The MSIX vectors and the interrupt status bits are not lined up
+	 * on Skylake. By default the link status bit is bit 32, however it
+	 * is by default MSIX vector0. We need to fixup to line them up.
+	 * The vectors at reset is 1-32,0. We need to reprogram to 0-32.
+	 */
+
+	for (i = 0; i < SKX_DB_MSIX_VECTOR_COUNT; i++)
+		iowrite8(i, ndev->self_mmio + SKX_INTVEC_OFFSET + i);
+
+	/* move link status down one as workaround */
+	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD) {
+		iowrite8(SKX_DB_MSIX_VECTOR_COUNT - 2,
+			 ndev->self_mmio + SKX_INTVEC_OFFSET +
+			 (SKX_DB_MSIX_VECTOR_COUNT - 1));
+	}
+
+	return ndev_init_isr(ndev, SKX_DB_MSIX_VECTOR_COUNT,
+			     SKX_DB_MSIX_VECTOR_COUNT,
+			     SKX_DB_MSIX_VECTOR_SHIFT,
+			     SKX_DB_TOTAL_SHIFT);
+}
+
+static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
+			    const struct intel_b2b_addr *addr,
+			    const struct intel_b2b_addr *peer_addr)
+{
+	struct pci_dev *pdev;
+	void __iomem *mmio;
+	resource_size_t bar_size;
+	phys_addr_t bar_addr;
+	int b2b_bar;
+	u8 bar_sz;
+
+	pdev = ndev_pdev(ndev);
+	mmio = ndev->self_mmio;
+
+	if (ndev->b2b_idx == UINT_MAX) {
+		dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
+		b2b_bar = 0;
+		ndev->b2b_off = 0;
+	} else {
+		b2b_bar = ndev_mw_to_bar(ndev, ndev->b2b_idx);
+		if (b2b_bar < 0)
+			return -EIO;
+
+		dev_dbg(ndev_dev(ndev), "using b2b mw bar %d\n", b2b_bar);
+
+		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
+
+		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
+
+		if (b2b_mw_share && ((bar_size >> 1) >= XEON_B2B_MIN_SIZE)) {
+			dev_dbg(ndev_dev(ndev),
+				"b2b using first half of bar\n");
+			ndev->b2b_off = bar_size >> 1;
+		} else if (bar_size >= XEON_B2B_MIN_SIZE) {
+			dev_dbg(ndev_dev(ndev),
+				"b2b using whole bar\n");
+			ndev->b2b_off = 0;
+			--ndev->mw_count;
+		} else {
+			dev_dbg(ndev_dev(ndev),
+				"b2b bar size is too small\n");
+			return -EIO;
+		}
+	}
+
+	/*
+	 * Reset the secondary bar sizes to match the primary bar sizes,
+	 * except disable or halve the size of the b2b secondary bar.
+	 */
+	pci_read_config_byte(pdev, SKX_IMBAR1SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "IMBAR1SZ %#x\n", bar_sz);
+	if (b2b_bar == 1) {
+		if (ndev->b2b_off)
+			bar_sz -= 1;
+		else
+			bar_sz = 0;
+	}
+
+	pci_write_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, bar_sz);
+	pci_read_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "EMBAR1SZ %#x\n", bar_sz);
+
+	pci_read_config_byte(pdev, SKX_IMBAR2SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "IMBAR2SZ %#x\n", bar_sz);
+	if (b2b_bar == 2) {
+		if (ndev->b2b_off)
+			bar_sz -= 1;
+		else
+			bar_sz = 0;
+	}
+
+	pci_write_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, bar_sz);
+	pci_read_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "EMBAR2SZ %#x\n", bar_sz);
+
+	/* SBAR01 hit by first part of the b2b bar */
+	if (b2b_bar == 0)
+		bar_addr = addr->bar0_addr;
+	else if (b2b_bar == 1)
+		bar_addr = addr->bar2_addr64;
+	else if (b2b_bar == 2)
+		bar_addr = addr->bar4_addr64;
+	else
+		return -EIO;
+
+	/* setup incoming bar limits == base addrs (zero length windows) */
+	bar_addr = addr->bar2_addr64 + (b2b_bar == 1 ? ndev->b2b_off : 0);
+	iowrite64(bar_addr, mmio + SKX_IMBAR1XLMT_OFFSET);
+	bar_addr = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
+	dev_dbg(ndev_dev(ndev), "IMBAR1XLMT %#018llx\n", bar_addr);
+
+	bar_addr = addr->bar4_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
+	iowrite64(bar_addr, mmio + SKX_IMBAR2XLMT_OFFSET);
+	bar_addr = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
+	dev_dbg(ndev_dev(ndev), "IMBAR2XLMT %#018llx\n", bar_addr);
+
+	/* zero incoming translation addrs */
+	iowrite64(0, mmio + SKX_IMBAR1XBASE_OFFSET);
+	iowrite64(0, mmio + SKX_IMBAR2XBASE_OFFSET);
+
+	ndev->peer_mmio = ndev->self_mmio;
+
+	return 0;
+}
+
+static int skx_init_ntb(struct intel_ntb_dev *ndev)
+{
+	int rc;
+
+
+	ndev->mw_count = XEON_MW_COUNT;
+	ndev->spad_count = SKX_SPAD_COUNT;
+	ndev->db_count = SKX_DB_COUNT;
+	ndev->db_link_mask = SKX_DB_LINK_BIT;
+
+	/* DB fixup for using 31 right now */
+	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
+		ndev->db_link_mask |= BIT_ULL(31);
+
+	switch (ndev->ntb.topo) {
+	case NTB_TOPO_B2B_USD:
+	case NTB_TOPO_B2B_DSD:
+		ndev->self_reg = &skx_pri_reg;
+		ndev->peer_reg = &skx_b2b_reg;
+		ndev->xlat_reg = &skx_sec_xlat;
+
+		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
+			rc = skx_setup_b2b_mw(ndev,
+					      &xeon_b2b_dsd_addr,
+					      &xeon_b2b_usd_addr);
+		} else {
+			rc = skx_setup_b2b_mw(ndev,
+					      &xeon_b2b_usd_addr,
+					      &xeon_b2b_dsd_addr);
+		}
+
+		if (rc)
+			return rc;
+
+		/* Enable Bus Master and Memory Space on the secondary side */
+		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
+			  ndev->self_mmio + SKX_SPCICMD_OFFSET);
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+
+	ndev->reg->db_iowrite(ndev->db_valid_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_mask);
+
+	return 0;
+}
+
+static int skx_init_dev(struct intel_ntb_dev *ndev)
+{
+	struct pci_dev *pdev;
+	u8 ppd;
+	int rc;
+
+	pdev = ndev_pdev(ndev);
+
+	ndev->reg = &skx_reg;
+
+	rc = pci_read_config_byte(pdev, XEON_PPD_OFFSET, &ppd);
+	if (rc)
+		return -EIO;
+
+	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
+	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
+		ntb_topo_string(ndev->ntb.topo));
+	if (ndev->ntb.topo == NTB_TOPO_NONE)
+		return -EINVAL;
+
+	if (pdev_is_skx_xeon(pdev))
+		ndev->hwerr_flags |= NTB_HWERR_MSIX_VECTOR32_BAD;
+
+	rc = skx_init_ntb(ndev);
+	if (rc)
+		return rc;
+
+	return skx_init_isr(ndev);
+}
+
+static int intel_ntb3_link_enable(struct ntb_dev *ntb,
+				  enum ntb_speed max_speed,
+				  enum ntb_width max_width)
+{
+	struct intel_ntb_dev *ndev;
+	u32 ntb_ctl;
+
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
+
+	dev_dbg(ndev_dev(ndev),
+		"Enabling link with max_speed %d max_width %d\n",
+		max_speed, max_width);
+
+	if (max_speed != NTB_SPEED_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
+	if (max_width != NTB_WIDTH_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
+
+	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
+	ntb_ctl |= NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP;
+	ntb_ctl |= NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP;
+	iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
+
+	return 0;
+}
+static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
+				   dma_addr_t addr, resource_size_t size)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	unsigned long xlat_reg, limit_reg;
+	resource_size_t bar_size, mw_size;
+	void __iomem *mmio;
+	u64 base, limit, reg_val;
+	int bar;
+
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	bar_size = pci_resource_len(ndev->ntb.pdev, bar);
+
+	if (idx == ndev->b2b_idx)
+		mw_size = bar_size - ndev->b2b_off;
+	else
+		mw_size = bar_size;
+
+	/* hardware requires that addr is aligned to bar size */
+	if (addr & (bar_size - 1))
+		return -EINVAL;
+
+	/* make sure the range fits in the usable mw size */
+	if (size > mw_size)
+		return -EINVAL;
+
+	mmio = ndev->self_mmio;
+	xlat_reg = ndev->xlat_reg->bar2_xlat + (idx * 0x10);
+	limit_reg = ndev->xlat_reg->bar2_limit + (idx * 0x10);
+	base = pci_resource_start(ndev->ntb.pdev, bar);
+
+	/* Set the limit if supported, if size is not mw_size */
+	if (limit_reg && size != mw_size)
+		limit = base + size;
+	else
+		limit = base + mw_size;
+
+	/* set and verify setting the translation address */
+	iowrite64(addr, mmio + xlat_reg);
+	reg_val = ioread64(mmio + xlat_reg);
+	if (reg_val != addr) {
+		iowrite64(0, mmio + xlat_reg);
+		return -EIO;
+	}
+
+	dev_dbg(ndev_dev(ndev), "BAR %d IMBARXBASE: %#Lx\n", bar, reg_val);
+
+	/* set and verify setting the limit */
+	iowrite64(limit, mmio + limit_reg);
+	reg_val = ioread64(mmio + limit_reg);
+	if (reg_val != limit) {
+		iowrite64(base, mmio + limit_reg);
+		iowrite64(0, mmio + xlat_reg);
+		return -EIO;
+	}
+
+	dev_dbg(ndev_dev(ndev), "BAR %d IMBARXLMT: %#Lx\n", bar, reg_val);
+
+	/* setup the EP */
+	limit_reg = ndev->xlat_reg->bar2_limit + (idx * 0x10) + 0x4000;
+	base = ioread64(mmio + SKX_EMBAR1_OFFSET + (8 * idx));
+	base &= ~0xf;
+
+	if (limit_reg && size != mw_size)
+		limit = base + size;
+	else
+		limit = base + mw_size;
+
+	/* set and verify setting the limit */
+	iowrite64(limit, mmio + limit_reg);
+	reg_val = ioread64(mmio + limit_reg);
+	if (reg_val != limit) {
+		iowrite64(base, mmio + limit_reg);
+		iowrite64(0, mmio + xlat_reg);
+		return -EIO;
+	}
+
+	dev_dbg(ndev_dev(ndev), "BAR %d EMBARXLMT: %#Lx\n", bar, reg_val);
+
+	return 0;
+}
+
+static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	int bit;
+
+	if (db_bits & ~ndev->db_valid_mask)
+		return -EINVAL;
+
+	while (db_bits) {
+		bit = __ffs(db_bits);
+		iowrite32(1, ndev->peer_mmio +
+				ndev->peer_reg->db_bell + (bit * 4));
+		db_bits &= db_bits - 1;
+	}
+
+	return 0;
+}
+
+static u64 intel_ntb3_db_read(struct ntb_dev *ntb)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+
+	return ndev_db_read(ndev,
+			    ndev->self_mmio +
+			    ndev->self_reg->db_clear);
+}
+
+static int intel_ntb3_db_clear(struct ntb_dev *ntb, u64 db_bits)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+
+	return ndev_db_write(ndev, db_bits,
+			     ndev->self_mmio +
+			     ndev->self_reg->db_clear);
+}
+
 /* XEON */
 
 static u64 xeon_db_ioread(void __iomem *mmio)
@@ -2120,6 +2696,24 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		if (rc)
 			goto err_init_dev;
 
+	} else if (pdev_is_skx_xeon(pdev)) {
+		ndev = kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
+		if (!ndev) {
+			rc = -ENOMEM;
+			goto err_ndev;
+		}
+
+		ndev_init_struct(ndev, pdev);
+		ndev->ntb.ops = &intel_ntb3_ops;
+
+		rc = intel_ntb_init_pci(ndev, pdev);
+		if (rc)
+			goto err_init_pci;
+
+		rc = skx_init_dev(ndev);
+		if (rc)
+			goto err_init_dev;
+
 	} else {
 		rc = -EINVAL;
 		goto err_ndev;
@@ -2143,7 +2737,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 	ndev_deinit_debugfs(ndev);
 	if (pdev_is_atom(pdev))
 		atom_deinit_dev(ndev);
-	else if (pdev_is_xeon(pdev))
+	else if (pdev_is_xeon(pdev) || pdev_is_skx_xeon(pdev))
 		xeon_deinit_dev(ndev);
 err_init_dev:
 	intel_ntb_deinit_pci(ndev);
@@ -2161,7 +2755,7 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
 	ndev_deinit_debugfs(ndev);
 	if (pdev_is_atom(pdev))
 		atom_deinit_dev(ndev);
-	else if (pdev_is_xeon(pdev))
+	else if (pdev_is_xeon(pdev) || pdev_is_skx_xeon(pdev))
 		xeon_deinit_dev(ndev);
 	intel_ntb_deinit_pci(ndev);
 	kfree(ndev);
@@ -2257,6 +2851,36 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
 	.bar5_addr32		= XEON_B2B_BAR5_ADDR32,
 };
 
+static const struct intel_ntb_reg skx_reg = {
+	.poll_link		= xeon_poll_link,
+	.link_is_up		= xeon_link_is_up,
+	.db_ioread		= skx_db_ioread,
+	.db_iowrite		= skx_db_iowrite,
+	.db_size		= sizeof(u64),
+	.ntb_ctl		= SKX_NTBCNTL_OFFSET,
+	.mw_bar			= {2, 4},
+};
+
+static const struct intel_ntb_alt_reg skx_pri_reg = {
+	.db_bell		= SKX_EM_DOORBELL_OFFSET,
+	.db_clear		= SKX_IM_INT_STATUS_OFFSET,
+	.db_mask		= SKX_IM_INT_DISABLE_OFFSET,
+	.spad			= SKX_IM_SPAD_OFFSET,
+};
+
+static const struct intel_ntb_alt_reg skx_b2b_reg = {
+	.db_bell		= SKX_IM_DOORBELL_OFFSET,
+	.db_clear		= SKX_EM_INT_STATUS_OFFSET,
+	.db_mask		= SKX_EM_INT_DISABLE_OFFSET,
+	.spad			= SKX_B2B_SPAD_OFFSET,
+};
+
+static const struct intel_ntb_xlat_reg skx_sec_xlat = {
+/*	.bar0_base		= SKX_EMBAR0_OFFSET, */
+	.bar2_limit		= SKX_IMBAR1XLMT_OFFSET,
+	.bar2_xlat		= SKX_IMBAR1XBASE_OFFSET,
+};
+
 /* operations for primary side of local ntb */
 static const struct ntb_dev_ops intel_ntb_ops = {
 	.mw_count		= intel_ntb_mw_count,
@@ -2284,6 +2908,31 @@ static const struct ntb_dev_ops intel_ntb_ops = {
 	.peer_spad_write	= intel_ntb_peer_spad_write,
 };
 
+static const struct ntb_dev_ops intel_ntb3_ops = {
+	.mw_count		= intel_ntb_mw_count,
+	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_set_trans		= intel_ntb3_mw_set_trans,
+	.link_is_up		= intel_ntb_link_is_up,
+	.link_enable		= intel_ntb3_link_enable,
+	.link_disable		= intel_ntb_link_disable,
+	.db_valid_mask		= intel_ntb_db_valid_mask,
+	.db_vector_count	= intel_ntb_db_vector_count,
+	.db_vector_mask		= intel_ntb_db_vector_mask,
+	.db_read		= intel_ntb3_db_read,
+	.db_clear		= intel_ntb3_db_clear,
+	.db_set_mask		= intel_ntb_db_set_mask,
+	.db_clear_mask		= intel_ntb_db_clear_mask,
+	.peer_db_addr		= intel_ntb_peer_db_addr,
+	.peer_db_set		= intel_ntb3_peer_db_set,
+	.spad_is_unsafe		= intel_ntb_spad_is_unsafe,
+	.spad_count		= intel_ntb_spad_count,
+	.spad_read		= intel_ntb_spad_read,
+	.spad_write		= intel_ntb_spad_write,
+	.peer_spad_addr		= intel_ntb_peer_spad_addr,
+	.peer_spad_read		= intel_ntb_peer_spad_read,
+	.peer_spad_write	= intel_ntb_peer_spad_write,
+};
+
 static const struct file_operations intel_ntb_debugfs_info = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
@@ -2307,6 +2956,7 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_IVT)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_HSX)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_BDX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SKX)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 3ec149c..6e8c182 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -70,6 +70,7 @@
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_BDX	0x6F0D
 #define PCI_DEVICE_ID_INTEL_NTB_PS_BDX	0x6F0E
 #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX	0x6F0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX	0x201C
 
 /* Intel Xeon hardware */
 
@@ -150,6 +151,51 @@
 #define XEON_DB_TOTAL_SHIFT		16
 #define XEON_SPAD_COUNT			16
 
+/* Intel Skylake Xeon hardware */
+#define SKX_IMBAR1SZ_OFFSET		0x00d1
+#define SKX_IMBAR2SZ_OFFSET		0x00d5
+#define SKX_EMBAR1SZ_OFFSET		0x00d3
+#define SKX_EMBAR2SZ_OFFSET		0x00d6
+#define SKX_DEVCTRL_OFFSET		0x0098
+#define SKX_DEVSTS_OFFSET		0x009a
+#define SKX_UNCERRSTS_OFFSET		0x014c
+#define SKX_CORERRSTS_OFFSET		0x0158
+#define SKX_LINK_STATUS_OFFSET		0x01a2
+
+#define SKX_NTBCNTL_OFFSET		0x0000
+#define SKX_IMBAR1XBASE_OFFSET		0x0010		/* SBAR2XLAT */
+#define SKX_IMBAR1XLMT_OFFSET		0x0018		/* SBAR2LMT */
+#define SKX_IMBAR2XBASE_OFFSET		0x0020		/* SBAR4XLAT */
+#define SKX_IMBAR2XLMT_OFFSET		0x0028		/* SBAR4LMT */
+#define SKX_IM_INT_STATUS_OFFSET	0x0040
+#define SKX_IM_INT_DISABLE_OFFSET	0x0048
+#define SKX_IM_SPAD_OFFSET		0x0080		/* SPAD */
+#define SKX_USMEMMISS_OFFSET		0x0070
+#define SKX_INTVEC_OFFSET		0x00d0
+#define SKX_IM_DOORBELL_OFFSET		0x0100		/* SDOORBELL0 */
+#define SKX_B2B_SPAD_OFFSET		0x0180		/* B2B SPAD */
+#define SKX_EMBAR0XBASE_OFFSET		0x4008		/* B2B_XLAT */
+#define SKX_EMBAR1XBASE_OFFSET		0x4010		/* PBAR2XLAT */
+#define SKX_EMBAR1XLMT_OFFSET		0x4018		/* PBAR2LMT */
+#define SKX_EMBAR2XBASE_OFFSET		0x4020		/* PBAR4XLAT */
+#define SKX_EMBAR2XLMT_OFFSET		0x4028		/* PBAR4LMT */
+#define SKX_EM_INT_STATUS_OFFSET	0x4040
+#define SKX_EM_INT_DISABLE_OFFSET	0x4048
+#define SKX_EM_SPAD_OFFSET		0x4080		/* remote SPAD */
+#define SKX_EM_DOORBELL_OFFSET		0x4100		/* PDOORBELL0 */
+#define SKX_SPCICMD_OFFSET		0x4504		/* SPCICMD */
+#define SKX_EMBAR0_OFFSET		0x4510		/* SBAR0BASE */
+#define SKX_EMBAR1_OFFSET		0x4518		/* SBAR23BASE */
+#define SKX_EMBAR2_OFFSET		0x4520		/* SBAR45BASE */
+
+#define SKX_DB_COUNT			32
+#define SKX_DB_LINK			32
+#define SKX_DB_LINK_BIT			BIT_ULL(SKX_DB_LINK)
+#define SKX_DB_MSIX_VECTOR_COUNT	33
+#define SKX_DB_MSIX_VECTOR_SHIFT	1
+#define SKX_DB_TOTAL_SHIFT		33
+#define SKX_SPAD_COUNT			16
+
 /* Intel Atom hardware */
 
 #define ATOM_SBAR2XLAT_OFFSET		0x0008
@@ -240,6 +286,7 @@
 #define NTB_HWERR_SDOORBELL_LOCKUP	BIT_ULL(0)
 #define NTB_HWERR_SB01BASE_LOCKUP	BIT_ULL(1)
 #define NTB_HWERR_B2BDOORBELL_BIT14	BIT_ULL(2)
+#define NTB_HWERR_MSIX_VECTOR32_BAD	BIT_ULL(3)
 
 /* flags to indicate unsafe api */
 #define NTB_UNSAFE_DB			BIT_ULL(0)
@@ -263,6 +310,7 @@ struct intel_ntb_reg {
 struct intel_ntb_alt_reg {
 	unsigned long			db_bell;
 	unsigned long			db_mask;
+	unsigned long			db_clear;
 	unsigned long			spad;
 };
 

