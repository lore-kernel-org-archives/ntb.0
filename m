Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id tu5si252854pab.2.2016.04.08.10.49.19
        for <linux-ntb@googlegroups.com>;
        Fri, 08 Apr 2016 10:49:19 -0700 (PDT)
Subject: [PATCH v3] NTB: allocate number transport entries depending on size
 of ring size
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 08 Apr 2016 10:49:06 -0700
Message-ID: <146013774604.52030.5227558679570366112.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Currently we only allocate a fixed default number of descriptors for the tx
and rx side. We should dynamically resize it to the number of descriptors
resides in the transport rings. We should know the number of transmit
descriptors at initializaiton. We will allocate the default number of
descriptors for receive side and allocate additional ones when we know the
actual max entries for receive.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2ef9d913..6db8c85 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -153,6 +153,7 @@ struct ntb_transport_qp {
 	unsigned int rx_index;
 	unsigned int rx_max_entry;
 	unsigned int rx_max_frame;
+	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
 	struct tasklet_struct rxc_db_work;
 
@@ -480,7 +481,9 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "rx_index - \t%u\n", qp->rx_index);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "rx_max_entry - \t%u\n\n", qp->rx_max_entry);
+			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "tx_bytes - \t%llu\n", qp->tx_bytes);
@@ -597,9 +600,12 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	struct ntb_transport_mw *mw;
+	struct ntb_dev *ndev = nt->ndev;
+	struct ntb_queue_entry *entry;
 	unsigned int rx_size, num_qps_mw;
 	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
+	int node;
 
 	mw_count = nt->mw_count;
 	qp_count = nt->qp_count;
@@ -626,6 +632,23 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
 
+	/*
+	 * Checking to see if we have more entries than the default.
+	 * We should add additional entries if that is the case so we
+	 * can be in sync with the transport frames.
+	 */
+	node = dev_to_node(&ndev->dev);
+	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
+		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->qp = qp;
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
+			     &qp->rx_free_q);
+		qp->rx_alloc_entry++;
+	}
+
 	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
 
 	/* setup the hdr offsets with 0's */
@@ -1722,8 +1745,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
 			     &qp->rx_free_q);
 	}
+	qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
 
-	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
+	for (i = 0; i < qp->tx_max_entry; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
 		if (!entry)
 			goto err2;
@@ -1744,6 +1768,7 @@ err2:
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 err1:
+	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
 	if (qp->tx_dma_chan)

