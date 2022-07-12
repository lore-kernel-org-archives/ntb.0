Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD01FC1
	for <ntb@lists.linux.dev>; Tue, 12 Jul 2022 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657659014; x=1689195014;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SBwXeJH3xGoxbvtKtt7pg4h8aVwptQI1KB1LnMGR270=;
  b=SXwW24X8s1Ks88yP3SA6YyN1KwRrPpucuB2dWPr/7NCAXaVno3ZZ/Km8
   8dm2U9sUAJN/EHAn+Kd3x0N37/FCOf1Buk4/AWWl0Oi9QZZqTWIj2iyFQ
   E2EqSWcQUu9P61Ka9tfvvOv6xWcYCACjfDyYiDAPwh2XVuZhmrRgq3gu3
   F1k0x33P/Hg5R0lyLYDaLAACGClT9qHCxGmUnk6ImdWMXHIjjDSOPOexr
   CHTkbaDtRz8ua2tIBPYpdHPN21hn8wEBQbGJH+NTJNaihMmk2cT50UwEz
   8JqHqIbc7Xw+u2A/sflb0zn7OcgY+NnC6uao919VvQo4+rGfX65t1uOmG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265452266"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265452266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="570345665"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:50:06 -0700
Subject: [PATCH] ntb: intel: add GNR support for Intel PCIe gen5 NTB
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us
Cc: allenbh@gmail.com, ntb@lists.linux.dev
Date: Tue, 12 Jul 2022 13:50:06 -0700
Message-ID: 
 <165765900595.1786187.5476611141315542956.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/ntb/hw/intel/ntb_hw_gen1.c  |    4 +++-
 drivers/ntb/hw/intel/ntb_hw_gen4.c  |    2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h |    9 +++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index e5f14e20a9ff..72e2027a71c4 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
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


