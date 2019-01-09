Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id k12si921283iop.5.2019.01.09.11.22.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 11:22:51 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed,  9 Jan 2019 12:22:27 -0700
Message-Id: <20190109192233.5752-3-logang@deltatee.com>
In-Reply-To: <20190109192233.5752-1-logang@deltatee.com>
References: <20190109192233.5752-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v3 2/8] NTB: Revert the change to use the NTB device dev for DMA allocations
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Commit 417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
devices") started using the NTB device for DMA allocations which was
turns out was wrong. If the IOMMU is enabled, such alloctanions will
always fail with messages such as:

  DMAR: Allocating domain for 0000:02:00.1 failed

This is because the IOMMU has not setup the device for such use.

Change the tools back to using the PCI device for allocations seeing
it doesn't make sense to add an IOMMU group for the non-physical NTB
device. Also remove the code that sets the DMA mask as it no longer
makes sense to do this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c    | 6 ------
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 4 ----
 drivers/ntb/ntb.c                  | 1 -
 drivers/ntb/test/ntb_perf.c        | 7 +++----
 drivers/ntb/test/ntb_tool.c        | 6 +++---
 6 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index efb214fc545a..16c10dfe0919 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 1dede87dd54f..30c29183f515 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2667,12 +2667,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 		dev_warn(&pdev->dev,
 			"Cannot set consistent DMA highmem bit mask\n");
 	}
-	ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					   dma_get_mask(&pdev->dev));
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
-		return ret;
-	}
 
 	/*
 	 * Enable the device advanced error reporting. It's not critical to
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f708da..9128b32a562f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1770,10 +1770,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2581ab724c34..dc82be2dcf47 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -315,4 +315,3 @@ static void __exit ntb_driver_exit(void)
 	bus_unregister(&ntb_bus);
 }
 module_exit(ntb_driver_exit);
-
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0d1f19..9174085ddc13 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -588,8 +588,8 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+			peer->inbuf_size, &peer->inbuf_xlat, GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
@@ -1512,4 +1512,3 @@ static void __exit perf_exit(void)
 	destroy_workqueue(perf_wq);
 }
 module_exit(perf_exit);
-
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index ec5cf095cdb9..311d6ab8d016 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -590,7 +590,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	inmw->size = min_t(resource_size_t, req_size, size);
 	inmw->size = round_up(inmw->size, addr_align);
 	inmw->size = round_up(inmw->size, size_align);
-	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+	inmw->mm_base = dma_alloc_coherent(&tc->ntb->pdev->dev, inmw->size,
 					   &inmw->dma_base, GFP_KERNEL);
 	if (!inmw->mm_base)
 		return -ENOMEM;
@@ -612,7 +612,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	return 0;
 
 err_free_dma:
-	dma_free_coherent(&tc->ntb->dev, inmw->size, inmw->mm_base,
+	dma_free_coherent(&tc->ntb->pdev->dev, inmw->size, inmw->mm_base,
 			  inmw->dma_base);
 	inmw->mm_base = NULL;
 	inmw->dma_base = 0;
@@ -629,7 +629,7 @@ static void tool_free_mw(struct tool_ctx *tc, int pidx, int widx)
 
 	if (inmw->mm_base != NULL) {
 		ntb_mw_clear_trans(tc->ntb, pidx, widx);
-		dma_free_coherent(&tc->ntb->dev, inmw->size,
+		dma_free_coherent(&tc->ntb->pdev->dev, inmw->size,
 				  inmw->mm_base, inmw->dma_base);
 	}
 
-- 
2.19.0

