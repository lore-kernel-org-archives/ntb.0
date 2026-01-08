Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24652DAFA2
	for <ntb@lists.linux.dev>; Thu,  8 Jan 2026 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907262; cv=none; b=aDO8gl2/X4/RN+/TZmaRjlDYCq/9eTDg5LtdI6WREMgImVzMVxru/3kBEngW655l5FsXRh4DxoI3scmnN/TaEuZiDXhJa2fxdgoqhMfK3WKrCUKmH2g7xUgEc4ohUBnxR0oZSD/AO67VwY308PJR8NK31R1b9Wsq/xZioUz/I5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907262; c=relaxed/simple;
	bh=oS1W5FfApAoOEq4KUHI3/VayJzhcrU/X9O9/lpZD6Fo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q7jmdT87mHdnP9IhUDTbL4h6e9pIJ3C/mAHdtHMVje6GkueO6y2kTlWJ93haMIe8A4k2fOCnaPbL8aVORVuVrWfKk8MlBgpntcDi/EI5YjMDZdFRwppmMCv0BvlZIm1qYThYxZ0ZCRYqxj/AtKiXyhEJSHn/7ehrJtxuf+1SDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490AEC116C6;
	Thu,  8 Jan 2026 21:21:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: ntb@lists.linux.dev,
	jdmason@kudzu.us
Subject: [PATCH] ntb: intel: Add Intel Gen6 NTB support for DiamondRapids
Date: Thu,  8 Jan 2026 14:21:01 -0700
Message-ID: <20260108212101.902595-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DiamondRapids NTB support by adding the DID and adjust the changed
PPD0 offset.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c  | 14 ++++++++++----
 drivers/ntb/hw/intel/ntb_hw_gen4.c  | 22 +++++++++++++++++-----
 drivers/ntb/hw/intel/ntb_hw_gen4.h  |  2 ++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  6 ++++++
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..944d10b48ae4 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -763,7 +763,8 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 		return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
 	else if (pdev_is_gen3(ndev->ntb.pdev))
 		return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
-	else if (pdev_is_gen4(ndev->ntb.pdev) || pdev_is_gen5(ndev->ntb.pdev))
+	else if (pdev_is_gen4(ndev->ntb.pdev) || pdev_is_gen5(ndev->ntb.pdev) ||
+		 pdev_is_gen6(ndev->ntb.pdev))
 		return ndev_ntb4_debugfs_read(filp, ubuf, count, offp);
 
 	return -ENXIO;
@@ -1872,7 +1873,8 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		rc = gen3_init_dev(ndev);
 		if (rc)
 			goto err_init_dev;
-	} else if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev)) {
+	} else if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev) ||
+		   pdev_is_gen6(pdev)) {
 		ndev->ntb.ops = &intel_ntb4_ops;
 		rc = intel_ntb_init_pci(ndev, pdev);
 		if (rc)
@@ -1903,7 +1905,8 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 err_register:
 	ndev_deinit_debugfs(ndev);
 	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
-	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
+	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev) ||
+	    pdev_is_gen6(pdev))
 		xeon_deinit_dev(ndev);
 err_init_dev:
 	intel_ntb_deinit_pci(ndev);
@@ -1920,7 +1923,8 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
 	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
-	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
+	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev) ||
+	    pdev_is_gen6(pdev))
 		xeon_deinit_dev(ndev);
 	intel_ntb_deinit_pci(ndev);
 	kfree(ndev);
@@ -2049,6 +2053,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
 	/* GEN5 PCIe */
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},
+	/* GEN6 PCIe */
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_DMR)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index 22cac7975b3c..a221a978a9d5 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -46,6 +46,16 @@ static const struct intel_ntb_alt_reg gen4_b2b_reg = {
 	.spad			= GEN4_EM_SPAD_OFFSET,
 };
 
+static u64 get_ppd0(struct pci_dev *pdev)
+{
+	if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
+		return GEN4_PPD0_OFFSET;
+	else if (pdev_is_gen6(pdev))
+		return GEN6_PPD0_OFFSET;
+
+	return ULLONG_MAX;
+}
+
 static int gen4_poll_link(struct intel_ntb_dev *ndev)
 {
 	u16 reg_val;
@@ -183,7 +193,7 @@ static enum ntb_topo spr_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 int gen4_init_dev(struct intel_ntb_dev *ndev)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
-	u32 ppd1/*, ppd0*/;
+	u32 ppd1;
 	u16 lnkctl;
 	int rc;
 
@@ -197,7 +207,7 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
 	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
 	if (pdev_is_ICX(pdev))
 		ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
-	else if (pdev_is_SPR(pdev) || pdev_is_gen5(pdev))
+	else if (pdev_is_SPR(pdev) || pdev_is_gen5(pdev) || pdev_is_gen6(pdev))
 		ndev->ntb.topo = spr_ppd_topo(ndev, ppd1);
 	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd1,
 		ntb_topo_string(ndev->ntb.topo));
@@ -432,10 +442,12 @@ static int intel_ntb4_link_enable(struct ntb_dev *ntb,
 		enum ntb_speed max_speed, enum ntb_width max_width)
 {
 	struct intel_ntb_dev *ndev;
+	struct pci_dev *pdev;
 	u32 ntb_ctl, ppd0;
 	u16 lnkctl;
 
 	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
+	pdev = ntb->pdev;
 
 	dev_dbg(&ntb->pdev->dev,
 			"Enabling link with max_speed %d max_width %d\n",
@@ -476,12 +488,12 @@ static int intel_ntb4_link_enable(struct ntb_dev *ntb,
 	iowrite16(lnkctl, ndev->self_mmio + GEN4_LINK_CTRL_OFFSET);
 
 	/* start link training in PPD0 */
-	ppd0 = ioread32(ndev->self_mmio + GEN4_PPD0_OFFSET);
+	ppd0 = ioread32(ndev->self_mmio + get_ppd0(pdev));
 	ppd0 |= GEN4_PPD_LINKTRN;
-	iowrite32(ppd0, ndev->self_mmio + GEN4_PPD0_OFFSET);
+	iowrite32(ppd0, ndev->self_mmio + get_ppd0(pdev));
 
 	/* make sure link training has started */
-	ppd0 = ioread32(ndev->self_mmio + GEN4_PPD0_OFFSET);
+	ppd0 = ioread32(ndev->self_mmio + get_ppd0(pdev));
 	if (!(ppd0 & GEN4_PPD_LINKTRN)) {
 		dev_warn(&ntb->pdev->dev, "Link is not training\n");
 		return -ENXIO;
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
index f91323eaf5ce..1ba8203d6352 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
@@ -103,6 +103,8 @@
 #define NTB_LTR_IDLE_LATSCALE		0x0800  /* 1us scale */
 #define NTB_LTR_IDLE_REQMNT		0x8000  /* snoop req enable */
 
+#define GEN6_PPD0_OFFSET		0xf0d4
+
 ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
 				      size_t count, loff_t *offp);
 int gen4_init_dev(struct intel_ntb_dev *ndev);
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index da4d5fe55bab..0a3a3677f82a 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX	0x201C
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX	0x347e
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_GNR	0x0db4
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_DMR	0x7868
 
 /* Ntb control and link status */
 #define NTB_CTL_CFG_LOCK		BIT(0)
@@ -235,4 +236,9 @@ static inline int pdev_is_gen5(struct pci_dev *pdev)
 	return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR;
 }
 
+static inline int pdev_is_gen6(struct pci_dev *pdev)
+{
+	return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_DMR;
+}
+
 #endif

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.52.0

