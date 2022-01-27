Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id i16si131809edc.4.2022.01.27.12.31.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 12:31:16 -0800 (PST)
Subject: [PATCH] ntb: intel: fix port config status offset for SPR
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 27 Jan 2022 13:31:12 -0700
Message-ID: 
 <164331547261.135051.8301478137022089685.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: Jerry Dai <jerry.dai@intel.com>, allenbh@gmail.com, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The field offset for port configuration status on SPR has been changed to
bit 14 from ICX where it resides at bit 12. By chance link status detection
continued to work on SPR. This is due to bit 12 being a configuration bit
which is in sync with the status bit. Fix this by checking for a SPR device
and checking correct status bit.

Tested-by: Jerry Dai <jerry.dai@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen4.c |   17 ++++++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen4.h |   16 ++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index fede05151f69..4081fc538ff4 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -168,6 +168,18 @@ static enum ntb_topo gen4_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 	return NTB_TOPO_NONE;
 }
 
+static enum ntb_topo spr_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
+{
+	switch (ppd & SPR_PPD_TOPO_MASK) {
+	case SPR_PPD_TOPO_B2B_USD:
+		return NTB_TOPO_B2B_USD;
+	case SPR_PPD_TOPO_B2B_DSD:
+		return NTB_TOPO_B2B_DSD;
+	}
+
+	return NTB_TOPO_NONE;
+}
+
 int gen4_init_dev(struct intel_ntb_dev *ndev)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
@@ -183,7 +195,10 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
 	}
 
 	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
-	ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
+	if (pdev_is_ICX(pdev))
+		ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
+	else if (pdev_is_SPR(pdev))
+		ndev->ntb.topo = spr_ppd_topo(ndev, ppd1);
 	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd1,
 		ntb_topo_string(ndev->ntb.topo));
 	if (ndev->ntb.topo == NTB_TOPO_NONE)
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
index 3fcd3fdce9ed..f91323eaf5ce 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
@@ -49,10 +49,14 @@
 #define GEN4_PPD_CLEAR_TRN		0x0001
 #define GEN4_PPD_LINKTRN		0x0008
 #define GEN4_PPD_CONN_MASK		0x0300
+#define SPR_PPD_CONN_MASK		0x0700
 #define GEN4_PPD_CONN_B2B		0x0200
 #define GEN4_PPD_DEV_MASK		0x1000
 #define GEN4_PPD_DEV_DSD		0x1000
 #define GEN4_PPD_DEV_USD		0x0000
+#define SPR_PPD_DEV_MASK		0x4000
+#define SPR_PPD_DEV_DSD 		0x4000
+#define SPR_PPD_DEV_USD 		0x0000
 #define GEN4_LINK_CTRL_LINK_DISABLE	0x0010
 
 #define GEN4_SLOTSTS			0xb05a
@@ -62,6 +66,10 @@
 #define GEN4_PPD_TOPO_B2B_USD	(GEN4_PPD_CONN_B2B | GEN4_PPD_DEV_USD)
 #define GEN4_PPD_TOPO_B2B_DSD	(GEN4_PPD_CONN_B2B | GEN4_PPD_DEV_DSD)
 
+#define SPR_PPD_TOPO_MASK	(SPR_PPD_CONN_MASK | SPR_PPD_DEV_MASK)
+#define SPR_PPD_TOPO_B2B_USD	(GEN4_PPD_CONN_B2B | SPR_PPD_DEV_USD)
+#define SPR_PPD_TOPO_B2B_DSD	(GEN4_PPD_CONN_B2B | SPR_PPD_DEV_DSD)
+
 #define GEN4_DB_COUNT			32
 #define GEN4_DB_LINK			32
 #define GEN4_DB_LINK_BIT		BIT_ULL(GEN4_DB_LINK)
@@ -112,4 +120,12 @@ static inline int pdev_is_ICX(struct pci_dev *pdev)
 	return 0;
 }
 
+static inline int pdev_is_SPR(struct pci_dev *pdev)
+{
+	if (pdev_is_gen4(pdev) &&
+	    pdev->revision > PCI_DEVICE_REVISION_ICX_MAX)
+		return 1;
+	return 0;
+}
+
 #endif


