Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8E7F
	for <ntb@lists.linux.dev>; Mon,  1 Aug 2022 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659387257; x=1690923257;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Z7gJrHDqSzglqLoy9sqodU7yUGXg780X6nOs1tkiBI=;
  b=WtlWib0iH/sy1KGLcO/x6ckt3MmEjYskmZ3tbiRXkQtrtsclf9Dyg7W+
   ruPpSpCz7Pm9tyY7t6WGy4lpDeYAZa+x6XrGu7HYAbOGftS4AKQT8fvbY
   Ta3FR3Cy1OA4mZxbfKYduu+lO0dOE8pAMzbGlSH7GhGu9W/Qf+7DEBCZZ
   sA4EslFVG/ZHNPZhgby0x4BV0ASm5xaxQPq9b7nEoHjxHqSkjyMzSA/Db
   IltNSwV4CD1oKC66QHhg30awn68ggyx/Y/K41wWefa9M0XNdUxB6vugq4
   VeumeIjb7X8fM0JBoGCdwZ+WsRPjIN/F5u5PfkKIHDUyJfo/J3NgpUoeH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269016081"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="269016081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:44:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661312353"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:44:50 -0700
Subject: [PATCH v2] ntb: intel: add GNR support for Intel PCIe gen5 NTB
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us
Cc: allenbh@gmail.com, ntb@lists.linux.dev
Date: Mon, 01 Aug 2022 13:44:50 -0700
Message-ID: 
 <165938663353.3660206.14823522095818743981.stgit@djiang5-desk3.ch.intel.com>
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

v2:
- Add debugfs check for GNR generation. Otherwise it fails on GNR.

 drivers/ntb/hw/intel/ntb_hw_gen1.c  |    6 ++++--
 drivers/ntb/hw/intel/ntb_hw_gen4.c  |    2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h |    9 +++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index e5f14e20a9ff..bb928d7b4301 100644
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
@@ -2047,6 +2047,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
 
 	/* GEN4 */
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
+	/* SPR has same dev id has ICX but different revision id */
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
index b233d1c6ba2d..380ec0d8e0d9 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -70,6 +70,8 @@
 #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX	0x6F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX	0x201C
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX	0x347e
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_SPR	0x347e
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_GNR	0x0db4
 
 /* Ntb control and link status */
 #define NTB_CTL_CFG_LOCK		BIT(0)
@@ -225,7 +227,14 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
 {
 	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)
 		return 1;
+	return 0;
+}
 
+static inline int pdev_is_gen5(struct pci_dev *pdev)
+{
+	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)
+		return 1;
 	return 0;
 }
+
 #endif


