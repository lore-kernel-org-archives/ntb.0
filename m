Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com. [2a00:1450:4010:c07::232])
        by gmr-mx.google.com with ESMTPS id s29si316190eds.0.2017.12.03.11.17.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 11:17:51 -0800 (PST)
Received: by mail-lf0-x232.google.com with SMTP id a12so16808839lfe.4
        for <linux-ntb@googlegroups.com>; Sun, 03 Dec 2017 11:17:51 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 02/15] NTB: Set dma mask and dma coherent mask to NTB devices
Date: Sun,  3 Dec 2017 22:17:23 +0300
Message-Id: <20171203191736.3399-3-fancer.lancer@gmail.com>
In-Reply-To: <20171203191736.3399-1-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The dma_mask and dma_coherent_mask fields of the NTB struct device
weren't initialized in hardware drivers. In fact it should be done
instead of PCIe interface usage, since NTB clients are supposed to
use NTB API only and left unaware of real hardware implementation.
In addition to that ntb_device_register() method shouldn't clear
the passed ntb_dev structure, since it dma_mask is initialized
by hardware drivers.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c     | 4 ++++
 drivers/ntb/hw/idt/ntb_hw_idt.c     | 8 +++++++-
 drivers/ntb/hw/intel/ntb_hw_intel.c | 4 ++++
 drivers/ntb/ntb.c                   | 1 -
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index f0788aae05c9..3cfa46876239 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1020,6 +1020,10 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
+	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
+					  dma_get_mask(&pdev->dev));
+	if (rc)
+		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fb87c0f0d97..d87dbd4bc82c 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2426,7 +2426,7 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	int ret;
 
-	/* Initialize the bit mask of DMA */
+	/* Initialize the bit mask of PCI/NTB DMA */
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (ret != 0) {
 		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
@@ -2447,6 +2447,12 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 		dev_warn(&pdev->dev,
 			"Cannot set consistent DMA highmem bit mask\n");
 	}
+	ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
+					   dma_get_mask(&pdev->dev));
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
+		return ret;
+	}
 
 	/*
 	 * Enable the device advanced error reporting. It's not critical to
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 4de074a86073..ea6c82f8655f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -2586,6 +2586,10 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
+	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
+					  dma_get_mask(&pdev->dev));
+	if (rc)
+		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 03b80d89b980..79e50a5f8902 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -112,7 +112,6 @@ int ntb_register_device(struct ntb_dev *ntb)
 
 	init_completion(&ntb->released);
 
-	memset(&ntb->dev, 0, sizeof(ntb->dev));
 	ntb->dev.bus = &ntb_bus;
 	ntb->dev.parent = &ntb->pdev->dev;
 	ntb->dev.release = ntb_dev_release;
-- 
2.12.0

