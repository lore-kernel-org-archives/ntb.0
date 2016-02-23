Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id ui7si3997473pab.0.2016.02.23.08.12.46
        for <linux-ntb@googlegroups.com>;
        Tue, 23 Feb 2016 08:12:47 -0800 (PST)
Subject: [PATCH] ntb: stop tasklet from spinning forever during shutdown.
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 23 Feb 2016 09:11:36 -0700
Message-ID: <20160223161136.167489.13026.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: alex@pernixdata.com, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

We can leave tasklet spinning forever if we disable the tasklet during
qp shutdown and the tasklets are still being kicked off. This hopefully
should avoid that race condition.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reported-by: Alex Depoutovitch <alex@pernixdata.com>
Tested-by: Alex Depoutovitch <alex@pernixdata.com>
---
 drivers/ntb/ntb_transport.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8da0e6c..06d4e58 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -124,6 +124,7 @@ struct ntb_transport_qp {
 
 	bool client_ready;
 	bool link_is_up;
+	bool active;
 
 	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
 	u64 qp_bit;
@@ -719,6 +720,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
+	qp->active = false;
 
 	qp->tx_index = 0;
 	qp->rx_index = 0;
@@ -926,11 +928,13 @@ static void ntb_qp_link_work(struct work_struct *work)
 	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
+		qp->active = true;
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		tasklet_schedule(&qp->rxc_db_work);
+		if (qp->active)
+			tasklet_schedule(&qp->rxc_db_work);
 	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1411,7 +1415,8 @@ static void ntb_transport_rxc_db(unsigned long data)
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
-		tasklet_schedule(&qp->rxc_db_work);
+		if (qp->active)
+			tasklet_schedule(&qp->rxc_db_work);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1422,7 +1427,8 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		tasklet_schedule(&qp->rxc_db_work);
+		if (qp->active)
+			tasklet_schedule(&qp->rxc_db_work);
 	}
 }
 
@@ -1760,6 +1766,8 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	qp->active = false;
+
 	if (qp->tx_dma_chan) {
 		struct dma_chan *chan = qp->tx_dma_chan;
 		/* Putting the dma_chan to NULL will force any new traffic to be
@@ -1793,7 +1801,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	qp_bit = BIT_ULL(qp->qp_num);
 
 	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_disable(&qp->rxc_db_work);
+	tasklet_kill(&qp->rxc_db_work);
 
 	cancel_delayed_work_sync(&qp->link_work);
 
@@ -1886,7 +1894,8 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
-	tasklet_schedule(&qp->rxc_db_work);
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
 
 	return 0;
 }
@@ -2069,7 +2078,8 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		tasklet_schedule(&qp->rxc_db_work);
+		if (qp->active)
+			tasklet_schedule(&qp->rxc_db_work);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}

