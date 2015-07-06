Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id b76si1065559ywe.1.2015.07.06.08.31.21
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:22 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 11/12] NTB: Use unique DMA channels for TX and RX
Date: Mon,  6 Jul 2015 11:30:34 -0400
Message-Id: <c57962af5fea4f35c74c241afeb76dd081548961.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Allocate two DMA channels, one for TX operation and one for RX
operation, instead of having one DMA channel for everything. This
provides slightly better performance, and also will make error handling
cleaner later on.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 77 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index dd4e3ab824aa..fbddeab13b4c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -119,7 +119,8 @@ struct ntb_transport_qp {
 	struct ntb_transport_ctx *transport;
 	struct ntb_dev *ndev;
 	void *cb_data;
-	struct dma_chan *dma_chan;
+	struct dma_chan *tx_dma_chan;
+	struct dma_chan *rx_dma_chan;
 
 	bool client_ready;
 	bool link_is_up;
@@ -504,7 +505,11 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "\n");
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "Using DMA - \t%s\n", use_dma ? "Yes" : "No");
+			       "Using TX DMA - \t%s\n",
+			       qp->tx_dma_chan ? "Yes" : "No");
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "Using RX DMA - \t%s\n",
+			       qp->rx_dma_chan ? "Yes" : "No");
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "QP Link - \t%s\n",
 			       qp->link_is_up ? "Up" : "Down");
@@ -1217,7 +1222,7 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 {
 	struct dma_async_tx_descriptor *txd;
 	struct ntb_transport_qp *qp = entry->qp;
-	struct dma_chan *chan = qp->dma_chan;
+	struct dma_chan *chan = qp->rx_dma_chan;
 	struct dma_device *device;
 	size_t pay_off, buff_off, len;
 	struct dmaengine_unmap_data *unmap;
@@ -1378,8 +1383,8 @@ static void ntb_transport_rxc_db(unsigned long data)
 			break;
 	}
 
-	if (i && qp->dma_chan)
-		dma_async_issue_pending(qp->dma_chan);
+	if (i && qp->rx_dma_chan)
+		dma_async_issue_pending(qp->rx_dma_chan);
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
@@ -1446,7 +1451,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 {
 	struct ntb_payload_header __iomem *hdr;
 	struct dma_async_tx_descriptor *txd;
-	struct dma_chan *chan = qp->dma_chan;
+	struct dma_chan *chan = qp->tx_dma_chan;
 	struct dma_device *device;
 	size_t dest_off, buff_off;
 	struct dmaengine_unmap_data *unmap;
@@ -1639,14 +1644,27 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
 	if (use_dma) {
-		qp->dma_chan = dma_request_channel(dma_mask, ntb_dma_filter_fn,
-						   (void *)(unsigned long)node);
-		if (!qp->dma_chan)
-			dev_info(&pdev->dev, "Unable to allocate DMA channel\n");
+		qp->tx_dma_chan =
+			dma_request_channel(dma_mask, ntb_dma_filter_fn,
+					    (void *)(unsigned long)node);
+		if (!qp->tx_dma_chan)
+			dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
+
+		qp->rx_dma_chan =
+			dma_request_channel(dma_mask, ntb_dma_filter_fn,
+					    (void *)(unsigned long)node);
+		if (!qp->rx_dma_chan)
+			dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
 	} else {
-		qp->dma_chan = NULL;
+		qp->tx_dma_chan = NULL;
+		qp->rx_dma_chan = NULL;
 	}
-	dev_dbg(&pdev->dev, "Using %s memcpy\n", qp->dma_chan ? "DMA" : "CPU");
+
+	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
+		qp->tx_dma_chan ? "DMA" : "CPU");
+
+	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
+		qp->rx_dma_chan ? "DMA" : "CPU");
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
@@ -1681,8 +1699,10 @@ err2:
 err1:
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
-	if (qp->dma_chan)
-		dma_release_channel(qp->dma_chan);
+	if (qp->tx_dma_chan)
+		dma_release_channel(qp->tx_dma_chan);
+	if (qp->rx_dma_chan)
+		dma_release_channel(qp->rx_dma_chan);
 	nt->qp_bitmap_free |= qp_bit;
 err:
 	return NULL;
@@ -1707,12 +1727,27 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
-	if (qp->dma_chan) {
-		struct dma_chan *chan = qp->dma_chan;
+	if (qp->tx_dma_chan) {
+		struct dma_chan *chan = qp->tx_dma_chan;
+		/* Putting the dma_chan to NULL will force any new traffic to be
+		 * processed by the CPU instead of the DAM engine
+		 */
+		qp->tx_dma_chan = NULL;
+
+		/* Try to be nice and wait for any queued DMA engine
+		 * transactions to process before smashing it with a rock
+		 */
+		dma_sync_wait(chan, qp->last_cookie);
+		dmaengine_terminate_all(chan);
+		dma_release_channel(chan);
+	}
+
+	if (qp->rx_dma_chan) {
+		struct dma_chan *chan = qp->rx_dma_chan;
 		/* Putting the dma_chan to NULL will force any new traffic to be
 		 * processed by the CPU instead of the DAM engine
 		 */
-		qp->dma_chan = NULL;
+		qp->rx_dma_chan = NULL;
 
 		/* Try to be nice and wait for any queued DMA engine
 		 * transactions to process before smashing it with a rock
@@ -1960,16 +1995,20 @@ EXPORT_SYMBOL_GPL(ntb_transport_qp_num);
 unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 {
 	unsigned int max;
+	unsigned int copy_align;
 
 	if (!qp)
 		return 0;
 
-	if (!qp->dma_chan)
+	if (!qp->tx_dma_chan && !qp->rx_dma_chan)
 		return qp->tx_max_frame - sizeof(struct ntb_payload_header);
 
+	copy_align = max(qp->tx_dma_chan->device->copy_align,
+			 qp->rx_dma_chan->device->copy_align);
+
 	/* If DMA engine usage is possible, try to find the max size for that */
 	max = qp->tx_max_frame - sizeof(struct ntb_payload_header);
-	max -= max % (1 << qp->dma_chan->device->copy_align);
+	max -= max % (1 << copy_align);
 
 	return max;
 }
-- 
2.4.0.rc0.43.gcf8a8c6

