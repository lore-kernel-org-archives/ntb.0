Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c13si817387otm.1.2019.02.13.09.55.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:55:03 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 13 Feb 2019 10:54:44 -0700
Message-Id: <20190213175454.7506-3-logang@deltatee.com>
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 02/12] NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Presently, when ntb_transport is used with DMA and the IOMMU turned on,
it fails with errors from the IOMMU such as:

  DMAR: DRHD: handling fault status reg 202
  DMAR: [DMA Write] Request device [00:04.0] fault addr
	381fc0340000 [fault reason 05] PTE Write access is not set

This is because ntb_transport does not map the BAR space with the IOMMU.

To fix this, we map the entire MW region for each QP after we assign
the DMA channel. This prevents needing an extra DMA map in the fast
path.

Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3bfdb4562408..526b65afc16a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -144,7 +144,9 @@ struct ntb_transport_qp {
 	struct list_head tx_free_q;
 	spinlock_t ntb_tx_free_q_lock;
 	void __iomem *tx_mw;
-	dma_addr_t tx_mw_phys;
+	phys_addr_t tx_mw_phys;
+	size_t tx_mw_size;
+	dma_addr_t tx_mw_dma_addr;
 	unsigned int tx_index;
 	unsigned int tx_max_entry;
 	unsigned int tx_max_frame;
@@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
 
+	qp->tx_mw_size = tx_size;
 	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
 	if (!qp->tx_mw)
 		return -EINVAL;
@@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	dma_cookie_t cookie;
 
 	device = chan->device;
-	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
+	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
 	buff_off = (size_t)buf & ~PAGE_MASK;
 	dest_off = (size_t)dest & ~PAGE_MASK;
 
@@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		qp->rx_dma_chan = NULL;
 	}
 
+	if (qp->tx_dma_chan) {
+		qp->tx_mw_dma_addr =
+			dma_map_resource(qp->tx_dma_chan->device->dev,
+					 qp->tx_mw_phys, qp->tx_mw_size,
+					 DMA_FROM_DEVICE, 0);
+		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
+				      qp->tx_mw_dma_addr)) {
+			qp->tx_mw_dma_addr = 0;
+			goto err1;
+		}
+	}
+
 	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
 		qp->tx_dma_chan ? "DMA" : "CPU");
 
@@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
+	if (qp->tx_mw_dma_addr)
+		dma_unmap_resource(qp->tx_dma_chan->device->dev,
+				   qp->tx_mw_dma_addr, qp->tx_mw_size,
+				   DMA_FROM_DEVICE, 0);
 	if (qp->tx_dma_chan)
 		dma_release_channel(qp->tx_dma_chan);
 	if (qp->rx_dma_chan)
@@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		 */
 		dma_sync_wait(chan, qp->last_cookie);
 		dmaengine_terminate_all(chan);
+
+		dma_unmap_resource(chan->device->dev,
+				   qp->tx_mw_dma_addr, qp->tx_mw_size,
+				   DMA_FROM_DEVICE, 0);
+
 		dma_release_channel(chan);
 	}
 
-- 
2.19.0

