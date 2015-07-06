Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id d142si1980934ywe.7.2015.07.06.08.31.26
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:26 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 07/12] NTB: Add PCI Device IDs for Broadwell Xeon
Date: Mon,  6 Jul 2015 11:30:30 -0400
Message-Id: <64d354e486b605c0e990b45f561345af22a507ca.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Adding PCI Device IDs for B2B (back to back), RP (root port, primary),
and TB (transparent bridge, secondary) devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 15 +++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 87751cfd6f4f..c2bc56b67e63 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -190,14 +190,17 @@ static inline int pdev_is_xeon(struct pci_dev *pdev)
 	case PCI_DEVICE_ID_INTEL_NTB_SS_SNB:
 	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
 	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_BDX:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_JSF:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_SNB:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_IVT:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_BDX:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_JSF:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_SNB:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_BDX:
 		return 1;
 	}
 	return 0;
@@ -1843,6 +1846,9 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_BDX:
 		ndev->hwerr_flags |= NTB_HWERR_SDOORBELL_LOCKUP;
 		break;
 	}
@@ -1857,6 +1863,9 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_BDX:
 		ndev->hwerr_flags |= NTB_HWERR_SB01BASE_LOCKUP;
 		break;
 	}
@@ -1878,6 +1887,9 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_BDX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_BDX:
 		ndev->hwerr_flags |= NTB_HWERR_B2BDOORBELL_BIT14;
 		break;
 	}
@@ -2234,14 +2246,17 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_HSX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_BDX)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_JSF)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_SNB)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_IVT)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_HSX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_BDX)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_JSF)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_SNB)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_IVT)},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_HSX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_BDX)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 7ddaf387b679..ea0612f797df 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -67,6 +67,9 @@
 #define PCI_DEVICE_ID_INTEL_NTB_PS_HSX	0x2F0E
 #define PCI_DEVICE_ID_INTEL_NTB_SS_HSX	0x2F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD	0x0C4E
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_BDX	0x6F0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_BDX	0x6F0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_BDX	0x6F0F
 
 /* Intel Xeon hardware */
 
-- 
2.4.0.rc0.43.gcf8a8c6

