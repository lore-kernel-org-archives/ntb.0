Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id ph3si166962pac.1.2016.04.07.11.01.00
        for <linux-ntb@googlegroups.com>;
        Thu, 07 Apr 2016 11:01:00 -0700 (PDT)
Subject: [PATCH v2] NTB: allocate number transport entries depending on size
 of ring size
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 07 Apr 2016 11:00:48 -0700
Message-ID: <20160407180048.208535.61268.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/ntb/ntb_transport.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2ef9d913..a943bb1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -597,9 +597,13 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	struct ntb_transport_mw *mw;
+	struct ntb_dev *ndev = nt->ndev;
+	struct ntb_queue_entry *entry;
 	unsigned int rx_size, num_qps_mw;
 	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
+	unsigned int rx_entries = 0;
+	int node;
 
 	mw_count = nt->mw_count;
 	qp_count = nt->qp_count;
@@ -626,6 +630,25 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
 
+	/*
+	 * Checking to see if we have more entries than the default.
+	 * We should add additional entries if that is the case so we
+	 * can be in sync with the transport frames.
+	 */
+	if (qp->rx_max_entry > NTB_QP_DEF_NUM_ENTRIES)
+		rx_entries = qp->rx_max_entry - NTB_QP_DEF_NUM_ENTRIES;
+
+	node = dev_to_node(&ndev->dev);
+	for (i = 0; i < rx_entries; i++) {
+		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->qp = qp;
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
+			     &qp->rx_free_q);
+	}
+
 	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
 
 	/* setup the hdr offsets with 0's */
@@ -1723,7 +1746,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->rx_free_q);
 	}
 
-	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
+	for (i = 0; i < qp->tx_max_entry; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
 		if (!entry)
 			goto err2;

