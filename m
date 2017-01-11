Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w2si896215pfg.0.2017.01.10.16.33.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:33:47 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 10 Jan 2017 17:33:36 -0700
Message-Id: <1484094819-16084-2-git-send-email-logang@deltatee.com>
In-Reply-To: <1484094819-16084-1-git-send-email-logang@deltatee.com>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v2 1/4] ntb_hw_amd: Style fixes: open code macros that just obfuscate code
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

As per a comments in [1] by Greg Kroah-Hartman, the ndev_* macros should
be cleaned up. This makes it more clear what's actually going on when
reading the code.

[1] http://www.spinics.net/lists/linux-pci/msg56904.html

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 59 ++++++++++++++++++++++-------------------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  3 ---
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 019a158..0135fcf 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -98,10 +98,10 @@ static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 		return bar;
 
 	if (base)
-		*base = pci_resource_start(ndev->ntb.pdev, bar);
+		*base = pci_resource_start(ntb->pdev, bar);
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar);
+		*size = pci_resource_len(ntb->pdev, bar);
 
 	if (align)
 		*align = SZ_4K;
@@ -126,7 +126,7 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ndev->ntb.pdev, bar);
+	mw_size = pci_resource_len(ntb->pdev, bar);
 
 	/* make sure the range fits in the usable mw size */
 	if (size > mw_size)
@@ -135,7 +135,7 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	mmio = ndev->self_mmio;
 	peer_mmio = ndev->peer_mmio;
 
-	base_addr = pci_resource_start(ndev->ntb.pdev, bar);
+	base_addr = pci_resource_start(ntb->pdev, bar);
 
 	if (bar != 1) {
 		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 2);
@@ -225,7 +225,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
 		if (width)
 			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
 
-		dev_dbg(ndev_dev(ndev), "link is up.\n");
+		dev_dbg(&ntb->pdev->dev, "link is up.\n");
 
 		ret = 1;
 	} else {
@@ -234,7 +234,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
 		if (width)
 			*width = NTB_WIDTH_NONE;
 
-		dev_dbg(ndev_dev(ndev), "link is down.\n");
+		dev_dbg(&ntb->pdev->dev, "link is down.\n");
 	}
 
 	return ret;
@@ -254,7 +254,7 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
-	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
+	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
@@ -275,7 +275,7 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
-	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
+	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
@@ -466,18 +466,19 @@ static void amd_ack_smu(struct amd_ntb_dev *ndev, u32 bit)
 static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 {
 	void __iomem *mmio = ndev->self_mmio;
+	struct device *dev = &ndev->ntb.pdev->dev;
 	u32 status;
 
 	status = readl(mmio + AMD_INTSTAT_OFFSET);
 	if (!(status & AMD_EVENT_INTMASK))
 		return;
 
-	dev_dbg(ndev_dev(ndev), "status = 0x%x and vec = %d\n", status, vec);
+	dev_dbg(dev, "status = 0x%x and vec = %d\n", status, vec);
 
 	status &= AMD_EVENT_INTMASK;
 	switch (status) {
 	case AMD_PEER_FLUSH_EVENT:
-		dev_info(ndev_dev(ndev), "Flush is done.\n");
+		dev_info(dev, "Flush is done.\n");
 		break;
 	case AMD_PEER_RESET_EVENT:
 		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
@@ -503,7 +504,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		status = readl(mmio + AMD_PMESTAT_OFFSET);
 		/* check if this is WAKEUP event */
 		if (status & 0x1)
-			dev_info(ndev_dev(ndev), "Wakeup is done.\n");
+			dev_info(dev, "Wakeup is done.\n");
 
 		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
 
@@ -512,14 +513,14 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 				      AMD_LINK_HB_TIMEOUT);
 		break;
 	default:
-		dev_info(ndev_dev(ndev), "event status = 0x%x.\n", status);
+		dev_info(dev, "event status = 0x%x.\n", status);
 		break;
 	}
 }
 
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 {
-	dev_dbg(ndev_dev(ndev), "vec %d\n", vec);
+	dev_dbg(&ndev->ntb.pdev->dev, "vec %d\n", vec);
 
 	if (vec > (AMD_DB_CNT - 1) || (ndev->msix_vec_count == 1))
 		amd_handle_event(ndev, vec);
@@ -541,7 +542,7 @@ static irqreturn_t ndev_irq_isr(int irq, void *dev)
 {
 	struct amd_ntb_dev *ndev = dev;
 
-	return ndev_interrupt(ndev, irq - ndev_pdev(ndev)->irq);
+	return ndev_interrupt(ndev, irq - ndev->ntb.pdev->irq);
 }
 
 static int ndev_init_isr(struct amd_ntb_dev *ndev,
@@ -550,7 +551,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 	struct pci_dev *pdev;
 	int rc, i, msix_count, node;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	node = dev_to_node(&pdev->dev);
 
@@ -592,7 +593,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 			goto err_msix_request;
 	}
 
-	dev_dbg(ndev_dev(ndev), "Using msix interrupts\n");
+	dev_dbg(&pdev->dev, "Using msix interrupts\n");
 	ndev->db_count = msix_min;
 	ndev->msix_vec_count = msix_max;
 	return 0;
@@ -619,7 +620,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 	if (rc)
 		goto err_msi_request;
 
-	dev_dbg(ndev_dev(ndev), "Using msi interrupts\n");
+	dev_dbg(&pdev->dev, "Using msi interrupts\n");
 	ndev->db_count = 1;
 	ndev->msix_vec_count = 1;
 	return 0;
@@ -636,7 +637,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 	if (rc)
 		goto err_intx_request;
 
-	dev_dbg(ndev_dev(ndev), "Using intx interrupts\n");
+	dev_dbg(&pdev->dev, "Using intx interrupts\n");
 	ndev->db_count = 1;
 	ndev->msix_vec_count = 1;
 	return 0;
@@ -651,7 +652,7 @@ static void ndev_deinit_isr(struct amd_ntb_dev *ndev)
 	void __iomem *mmio = ndev->self_mmio;
 	int i;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	/* Mask all doorbell interrupts */
 	ndev->db_mask = ndev->db_valid_mask;
@@ -777,7 +778,8 @@ static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
 		ndev->debugfs_info = NULL;
 	} else {
 		ndev->debugfs_dir =
-			debugfs_create_dir(ndev_name(ndev), debugfs_dir);
+			debugfs_create_dir(pci_name(ndev->ntb.pdev),
+					   debugfs_dir);
 		if (!ndev->debugfs_dir)
 			ndev->debugfs_info = NULL;
 		else
@@ -812,7 +814,7 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	reg &= NTB_LIN_STA_ACTIVE_BIT;
 
-	dev_dbg(ndev_dev(ndev), "%s: reg_val = 0x%x.\n", __func__, reg);
+	dev_dbg(&ndev->ntb.pdev->dev, "%s: reg_val = 0x%x.\n", __func__, reg);
 
 	if (reg == ndev->cntl_sta)
 		return 0;
@@ -894,7 +896,8 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 
 		break;
 	default:
-		dev_err(ndev_dev(ndev), "AMD NTB does not support B2B mode.\n");
+		dev_err(&ndev->ntb.pdev->dev,
+			"AMD NTB does not support B2B mode.\n");
 		return -EINVAL;
 	}
 
@@ -923,10 +926,10 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 	struct pci_dev *pdev;
 	int rc = 0;
 
-	pdev = ndev_pdev(ndev);
+	pdev = ndev->ntb.pdev;
 
 	ndev->ntb.topo = amd_get_topo(ndev);
-	dev_dbg(ndev_dev(ndev), "AMD NTB topo is %s\n",
+	dev_dbg(&pdev->dev, "AMD NTB topo is %s\n",
 		ntb_topo_string(ndev->ntb.topo));
 
 	rc = amd_init_ntb(ndev);
@@ -935,7 +938,7 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 
 	rc = amd_init_isr(ndev);
 	if (rc) {
-		dev_err(ndev_dev(ndev), "fail to init isr.\n");
+		dev_err(&pdev->dev, "fail to init isr.\n");
 		return rc;
 	}
 
@@ -973,7 +976,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
-		dev_warn(ndev_dev(ndev), "Cannot DMA highmem\n");
+		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
 	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
@@ -981,7 +984,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
-		dev_warn(ndev_dev(ndev), "Cannot DMA consistent highmem\n");
+		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
@@ -1004,7 +1007,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 
 static void amd_ntb_deinit_pci(struct amd_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = ndev_pdev(ndev);
+	struct pci_dev *pdev = ndev->ntb.pdev;
 
 	pci_iounmap(pdev, ndev->self_mmio);
 
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 13d73ed..8f3617a 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -211,9 +211,6 @@ struct amd_ntb_dev {
 	struct dentry *debugfs_info;
 };
 
-#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
-#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
-#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
 #define ntb_ndev(__ntb) container_of(__ntb, struct amd_ntb_dev, ntb)
 #define hb_ndev(__work) container_of(__work, struct amd_ntb_dev, hb_timer.work)
 
-- 
2.1.4

