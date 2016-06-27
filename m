Return-Path: <dave.jiang@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id i135si2967833pfe.0.2016.06.27.16.10.38
        for <linux-ntb@googlegroups.com>;
        Mon, 27 Jun 2016 16:10:38 -0700 (PDT)
Subject: [PATCH 5/5] ntb: add DMA error handling for RX DMA
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 27 Jun 2016 16:10:01 -0700
Message-ID: <146706900184.188649.15761649041053225719.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
References: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Adding support on the rx DMA path to allow recovery of errors when DMA
responds with error status and abort all the subsequent ops.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |   99 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 25 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 55a5ae0..435b206 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -106,13 +106,13 @@ struct ntb_queue_entry {
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
@@ -227,6 +227,7 @@ struct ntb_transport_ctx {
 enum {
 	DESC_DONE_FLAG = BIT(0),
 	LINK_DOWN_FLAG = BIT(1),
+	DESC_ABORT_FLAG = BIT(2),
 };
 
 struct ntb_payload_header {
@@ -265,6 +266,9 @@ static struct ntb_client ntb_transport_client;
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 			       struct ntb_queue_entry *entry);
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
+static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
+static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
+
 
 static int ntb_transport_bus_match(struct device *dev,
 				   struct device_driver *drv)
@@ -1204,14 +1208,18 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 	while (!list_empty(&qp->rx_post_q)) {
 		entry = list_first_entry(&qp->rx_post_q,
 					 struct ntb_queue_entry, entry);
-		if (!(entry->flags & DESC_DONE_FLAG))
+		if (entry->flags & DESC_ABORT_FLAG)
+			len = 0;
+		else if (!(entry->flags & DESC_DONE_FLAG))
 			break;
+		else
+			len = entry->len;
+
 
 		entry->rx_hdr->flags = 0;
-		iowrite32(entry->index, &qp->rx_info->entry);
+		iowrite32(entry->rx_index, &qp->rx_info->entry);
 
 		cb_data = entry->cb_data;
-		len = entry->len;
 
 		list_move_tail(&entry->entry, &qp->rx_free_q);
 
@@ -1229,8 +1237,27 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 static void ntb_rx_copy_callback(void *data)
 {
 	struct ntb_queue_entry *entry = data;
+	struct dma_async_tx_descriptor *txd;
+	unsigned int flags = DESC_DONE_FLAG;
 
-	entry->flags |= DESC_DONE_FLAG;
+	txd = entry->txd;
+
+	/* we need to check DMA results if we are using DMA */
+	if (txd) {
+		switch (txd->result) {
+		case ERR_DMA_READ:
+		case ERR_DMA_WRITE:
+			entry->errors++;
+		case ERR_DMA_ABORT:
+			flags = DESC_ABORT_FLAG;
+			break;
+		case ERR_DMA_NONE:
+		default:
+			break;
+		}
+	}
+
+	entry->flags |= flags;
 
 	ntb_complete_rxc(entry->qp);
 }
@@ -1248,9 +1275,8 @@ static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset)
 	ntb_rx_copy_callback(entry);
 }
 
-static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
+static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 {
-	struct dma_async_tx_descriptor *txd;
 	struct ntb_transport_qp *qp = entry->qp;
 	struct dma_chan *chan = qp->rx_dma_chan;
 	struct dma_device *device;
@@ -1261,13 +1287,6 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
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
@@ -1295,26 +1314,27 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	unmap->from_cnt = 1;
 
 	for (retries = 0; retries < DMA_RETRIES; retries++) {
-		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
-						     unmap->addr[0], len,
-						     DMA_PREP_INTERRUPT);
-		if (txd)
+		entry->txd = device->device_prep_dma_memcpy(chan,
+							    unmap->addr[1],
+							    unmap->addr[0], len,
+							    DMA_PREP_INTERRUPT);
+		if (entry->txd)
 			break;
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(DMA_OUT_RESOURCE_TO);
 	}
 
-	if (!txd) {
+	if (!entry->txd) {
 		qp->dma_rx_prep_err++;
 		goto err_get_unmap;
 	}
 
-	txd->callback = ntb_rx_copy_callback;
-	txd->callback_param = entry;
-	dma_set_unmap(txd, unmap);
+	entry->txd->callback = ntb_rx_copy_callback;
+	entry->txd->callback_param = entry;
+	dma_set_unmap(entry->txd, unmap);
 
-	cookie = dmaengine_submit(txd);
+	cookie = dmaengine_submit(entry->txd);
 	if (dma_submit_error(cookie))
 		goto err_set_unmap;
 
@@ -1324,13 +1344,38 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 
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
@@ -1376,7 +1421,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	}
 
 	entry->rx_hdr = hdr;
-	entry->index = qp->rx_index;
+	entry->rx_index = qp->rx_index;
 
 	if (hdr->len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
@@ -1949,6 +1994,10 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->buf = data;
 	entry->len = len;
 	entry->flags = 0;
+	entry->retries = 0;
+	entry->errors = 0;
+	entry->rx_index = 0;
+	entry->txd = NULL;
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 

