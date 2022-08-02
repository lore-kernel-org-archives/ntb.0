Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE187F
	for <ntb@lists.linux.dev>; Tue,  2 Aug 2022 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659474615; x=1691010615;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pX3/no6an43VailDZwaCLCbv/wCmUW77ATE5S6ZX960=;
  b=YAaBg7mIkhKOEAxceH0z3woUxmFc8+gefH+M8GnXFHNt2SFkudqia6g4
   7SVgcVQC/g3HwpgOTu+OkALaK3gNOH1CU/NAzlEfYPbI3521QPM/TNitr
   H1dUjgdVmuAap9Zm6sexUXi0m6AUfCq1f5u3zsz62ZmgOS3QeDEjIv/9J
   a2oxuKJoySJjUeQQ+xJrsKx5lt1dNKTNdmCH4vltlK/E4SEZs9Ihc3vOj
   u6hXFf7yDgluBp9IMkQdCuj3J5hWcpZfzSeqk8dvnj5+Y8Ovup29tt334
   /DUjvlzWtaq9sh+qbgQ6UsmEfncjG3EnVi9Uerd3X9SEDowMIQy4Z6CEN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287080416"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="287080416"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:10:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="661796461"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:10:13 -0700
Subject: [PATCH v3] ntb: intel: add GNR support for Intel PCIe gen5 NTB
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us
Cc: allenbh@gmail.com, ntb@lists.linux.dev
Date: Tue, 02 Aug 2022 14:10:13 -0700
Message-ID: 
 <165947448457.3727412.2993602211644885680.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add Intel Granite Rapids NTB PCI device ID and related enabling.
Expectation is same hardware interface as Saphire Rapids Xeon platforms.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
- Remove SPR related bits to avoid confusion (Allen)
- Simplify pdev_is_gen5() function (Allen)

v2:
- Add debugfs check for GNR generation. Otherwise it fails on GNR.

 drivers/ntb/hw/intel/ntb_hw_gen1.c  |   12 ++++++++----
 drivers/ntb/hw/intel/ntb_hw_gen4.c  |    2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h |    7 +++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index e5f14e20a9ff..84772013812b 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -763,7 +763,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 		return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
 	else if (pdev_is_gen3(ndev->ntb.pdev))
 		return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
-	else if (pdev_is_gen4(ndev->ntb.pdev))
+	else if (pdev_is_gen4(ndev->ntb.pdev) || pdev_is_gen5(ndev->ntb.pdev))
 		return ndev_ntb4_debugfs_read(filp, ubuf, count, offp);
 
 	return -ENXIO;
@@ -1874,7 +1874,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		rc = gen3_init_dev(ndev);
 		if (rc)
 			goto err_init_dev;
-	} else if (pdev_is_gen4(pdev)) {
+	} else if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev)) {
 		ndev->ntb.ops = &intel_ntb4_ops;
 		rc = intel_ntb_init_pci(ndev, pdev);
 		if (rc)
@@ -1904,7 +1904,8 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 
 err_register:
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) || pdev_is_gen4(pdev))
+	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
+	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
 		xeon_deinit_dev(ndev);
 err_init_dev:
 	intel_ntb_deinit_pci(ndev);
@@ -1920,7 +1921,8 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
 
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) || pdev_is_gen4(pdev))
+	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
+	    pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
 		xeon_deinit_dev(ndev);
 	intel_ntb_deinit_pci(ndev);
 	kfree(ndev);
@@ -2047,6 +2049,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
 
 	/* GEN4 */
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
+	/* GEN5 PCIe */
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index 4081fc538ff4..22cac7975b3c 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -197,7 +197,7 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
 	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
 	if (pdev_is_ICX(pdev))
 		ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
-	else if (pdev_is_SPR(pdev))
+	else if (pdev_is_SPR(pdev) || pdev_is_gen5(pdev))
 		ndev->ntb.topo = spr_ppd_topo(ndev, ppd1);
 	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd1,
 		ntb_topo_string(ndev->ntb.topo));
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index b233d1c6ba2d..da4d5fe55bab 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -70,6 +70,7 @@
 #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX	0x6F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX	0x201C
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX	0x347e
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_GNR	0x0db4
 
 /* Ntb control and link status */
 #define NTB_CTL_CFG_LOCK		BIT(0)
@@ -228,4 +229,10 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
 
 	return 0;
 }
+
+static inline int pdev_is_gen5(struct pci_dev *pdev)
+{
+	return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR;
+}
+
 #endif


