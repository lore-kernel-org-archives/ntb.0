Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t79si1112308qke.0.2019.02.13.09.55.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:55:12 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 13 Feb 2019 10:54:43 -0700
Message-Id: <20190213175454.7506-2-logang@deltatee.com>
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 01/12] iommu/vt-d: Implement dma_[un]map_resource()
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-ntb.googlegroups.com>

Currently the Intel IOMMU uses the default dma_[un]map_resource()
implementations does nothing and simply returns the physical address
unmodified.

However, this doesn't create the IOVA entries necessary for addresses
mapped this way to work when the IOMMU is enabled. Thus, when the
IOMMU is enabled, drivers relying on dma_map_resource() will trigger
DMAR errors. We see this when running ntb_transport with the IOMMU
enabled, DMA, and switchtec hardware.

The implementation for intel_map_resource() is nearly identical to
intel_map_page(), we just have to re-create __intel_map_single().
dma_unmap_resource() uses intel_unmap_page() directly as the
functions are identical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..ad737e16575b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3649,11 +3649,9 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size, int dir,
-				   u64 dma_mask)
+static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
+				     size_t size, int dir, u64 dma_mask)
 {
-	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
@@ -3715,7 +3713,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	return __intel_map_page(dev, page, offset, size, dir, *dev->dma_mask);
+	return __intel_map_single(dev, page_to_phys(page) + offset, size,
+				  dir, *dev->dma_mask);
+}
+
+static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3806,8 +3812,9 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	memset(page_address(page), 0, size);
 
-	*dma_handle = __intel_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL,
-				       dev->coherent_dma_mask);
+	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
+					 DMA_BIDIRECTIONAL,
+					 dev->coherent_dma_mask);
 	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
@@ -3924,6 +3931,8 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+	.map_resource = intel_map_resource,
+	.unmap_resource = intel_unmap_page,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.19.0

