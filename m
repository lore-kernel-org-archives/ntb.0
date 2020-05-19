Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id n23si93087qtv.0.2020.05.19.16.37.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 16:37:12 -0700 (PDT)
Subject: [PATCH] ntb: intel: add revision lockdown for Icelake NTB driver
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 19 May 2020 16:37:11 -0700
Message-ID: <158993143119.41853.10657616792966099233.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allenbh@gmail.com
List-ID: <linux-ntb.googlegroups.com>

Add PCI device revision during probe to ensure that the driver only runs
on intended CPU steppings for Icelake.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen4.c |    6 ++++++
 drivers/ntb/hw/intel/ntb_hw_gen4.h |   13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index ed6574d8fcc6..dcbd6d3cf7ae 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -221,6 +221,12 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
 	u16 lnkctl;
 	int rc;
 
+	if (!pdev_is_ICX(pdev)) {
+		dev_warn(&pdev->dev,
+			 "Incorrect device revision: %d.\n", pdev->revision);
+		return -ENODEV;
+	}
+
 	ndev->reg = &gen4_reg;
 
 	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
index 10f3ddf2ad30..c2ff5ed86d7d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
@@ -46,6 +46,10 @@
 
 #include "ntb_hw_intel.h"
 
+/* Supported PCI device revision range for ICX */
+#define PCI_DEVICE_REVISION_ICX_MIN	0x2
+#define PCI_DEVICE_REVISION_ICX_MAX	0x7
+
 /* Intel Gen4 NTB hardware */
 /* PCIe config space */
 #define GEN4_IMBAR23SZ_OFFSET		0x00c4
@@ -125,4 +129,13 @@ ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
 
 extern const struct ntb_dev_ops intel_ntb4_ops;
 
+static inline int pdev_is_ICX(struct pci_dev *pdev)
+{
+	if (pdev_is_gen4(pdev) &&
+	    pdev->revision >= PCI_DEVICE_REVISION_ICX_MIN &&
+	    pdev->revision <= PCI_DEVICE_REVISION_ICX_MAX)
+		return 1;
+	return 0;
+}
+
 #endif

