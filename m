Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTP id i136si563350pfe.1.2016.07.20.13.14.34
        for <linux-ntb@googlegroups.com>;
        Wed, 20 Jul 2016 13:14:35 -0700 (PDT)
Subject: [PATCH v4 40/41] ntb: add DMA error handling for RX DMA
From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 20 Jul 2016 13:14:13 -0700
Message-ID: <146904565314.11972.6867332019581304256.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146904507864.11972.10146989448811282060.stgit@djiang5-desk3.ch.intel.com>
References: <146904507864.11972.10146989448811282060.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, lars@metafoo.de
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, laurent.pinchart@ideasonboard.com, Jon Mason <jdmason@kudzu.us>, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

Adding support on the rx DMA path to allow recovery of errors when
DMA responds with error status and abort all the subsequent ops.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com
---
 drivers/ntb/ntb_transport.c |   83 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 01da764..d825712 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -105,13 +105,13 @@ struct ntb_queue_entry {
 	int retries;
 	int errors;
 	unsigned int tx_index;
+	unsigned int rx_index;
 
 	struct ntb_transport_qp *qp;
 	union {
 		struct ntb_payload_header __iomem *tx_hdr;
 		struct ntb_payload_header *rx_hdr;
 	};
-	unsigned int index;
 };
 
 struct ntb_rx_info {
@@ -264,6 +264,9 @@ static struct ntb_client ntb_transport_client;
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 			       struct ntb_queue_entry *entry);
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
+static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
+static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
+
 
 static int ntb_transport_bus_match(struct device *dev,
 				   struct device_driver *drv)
@@ -1207,7 +1210,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 			break;
 
 		entry->rx_hdr->flags = 0;
-		iowrite32(entry->index, &qp->rx_info->entry);
+		iowrite32(entry->rx_index, &qp->rx_info->entry);
 
 		cb_data = entry->cb_data;
 		len = entry->len;
@@ -1225,10 +1228,36 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 	spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
 }
 
-static void ntb_rx_copy_callback(void *data)
+static void ntb_rx_copy_callback(void *data,
+				 const struct dmaengine_result *res)
 {
 	struct ntb_queue_entry *entry = data;
 
+	/* we need to check DMA results if we are using DMA */
+	if (res) {
+		enum dmaengine_tx_result dma_err = res->result;
+
+		switch (dma_err) {
+		case DMA_TRANS_READ_FAILED:
+		case DMA_TRANS_WRITE_FAILED:
+			entry->errors++;
+		case DMA_TRANS_ABORTED:
+		{
+			struct ntb_transport_qp *qp = entry->qp;
+			void *offset = qp->rx_buff + qp->rx_max_frame *
+					qp->rx_index;
+
+			ntb_memcpy_rx(entry, offset);
+			qp->rx_memcpy++;
+			return;
+		}
+
+		case DMA_TRANS_NOERROR:
+		default:
+			break;
+		}
+	}
+
 	entry->flags |= DESC_DONE_FLAG;
 
 	ntb_complete_rxc(entry->qp);
@@ -1244,10 +1273,10 @@ static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset)
 	/* Ensure that the data is fully copied out before clearing the flag */
 	wmb();
 
-	ntb_rx_copy_callback(entry);
+	ntb_rx_copy_callback(entry, NULL);
 }
 
-static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
+static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 {
 	struct dma_async_tx_descriptor *txd;
 	struct ntb_transport_qp *qp = entry->qp;
@@ -1260,13 +1289,6 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	int retries = 0;
 
 	len = entry->len;
-
-	if (!chan)
-		goto err;
-
-	if (len < copy_bytes)
-		goto err;
-
 	device = chan->device;
 	pay_off = (size_t)offset & ~PAGE_MASK;
 	buff_off = (size_t)buf & ~PAGE_MASK;
@@ -1294,7 +1316,8 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	unmap->from_cnt = 1;
 
 	for (retries = 0; retries < DMA_RETRIES; retries++) {
-		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
+		txd = device->device_prep_dma_memcpy(chan,
+						     unmap->addr[1],
 						     unmap->addr[0], len,
 						     DMA_PREP_INTERRUPT);
 		if (txd)
@@ -1309,7 +1332,7 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 		goto err_get_unmap;
 	}
 
-	txd->callback = ntb_rx_copy_callback;
+	txd->callback_result = ntb_rx_copy_callback;
 	txd->callback_param = entry;
 	dma_set_unmap(txd, unmap);
 
@@ -1323,13 +1346,38 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 
 	qp->rx_async++;
 
-	return;
+	return 0;
 
 err_set_unmap:
 	dmaengine_unmap_put(unmap);
 err_get_unmap:
 	dmaengine_unmap_put(unmap);
 err:
+	return -ENXIO;
+}
+
+static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
+{
+	struct ntb_transport_qp *qp = entry->qp;
+	struct dma_chan *chan = qp->rx_dma_chan;
+	int res;
+
+	if (!chan)
+		goto err;
+
+	if (entry->len < copy_bytes)
+		goto err;
+
+	res = ntb_async_rx_submit(entry, offset);
+	if (res < 0)
+		goto err;
+
+	if (!entry->retries)
+		qp->rx_async++;
+
+	return;
+
+err:
 	ntb_memcpy_rx(entry, offset);
 	qp->rx_memcpy++;
 }
@@ -1375,7 +1423,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	}
 
 	entry->rx_hdr = hdr;
-	entry->index = qp->rx_index;
+	entry->rx_index = qp->rx_index;
 
 	if (hdr->len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
@@ -1951,6 +1999,9 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->buf = data;
 	entry->len = len;
 	entry->flags = 0;
+	entry->retries = 0;
+	entry->errors = 0;
+	entry->rx_index = 0;
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 

