Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id fk4si584253pbc.2.2015.09.17.13.43.01
        for <linux-ntb@googlegroups.com>;
        Thu, 17 Sep 2015 13:43:01 -0700 (PDT)
Subject: [PATCH v2] NTB: Fix issue where we may be accessing NULL ptr
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 17 Sep 2015 13:27:04 -0700
Message-ID: <20150917202704.72985.32052.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

smatch detected an issue in the function ntb_transport_max_size() where
we could be dereferencing a dma channel pointer when it is NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6e3ee90..3903dfc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1996,23 +1996,24 @@ EXPORT_SYMBOL_GPL(ntb_transport_qp_num);
  */
 unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 {
-	unsigned int max;
+	unsigned int max_size;
 	unsigned int copy_align;
+	struct dma_chan *rx_chan, *tx_chan;
 
 	if (!qp)
 		return 0;
 
-	if (!qp->tx_dma_chan && !qp->rx_dma_chan)
-		return qp->tx_max_frame - sizeof(struct ntb_payload_header);
+	rx_chan = qp->rx_dma_chan;
+	tx_chan = qp->tx_dma_chan;
 
-	copy_align = max(qp->tx_dma_chan->device->copy_align,
-			 qp->rx_dma_chan->device->copy_align);
+	copy_align = max(rx_chan ? rx_chan->device->copy_align : 0,
+			 tx_chan ? tx_chan->device->copy_align : 0);
 
 	/* If DMA engine usage is possible, try to find the max size for that */
-	max = qp->tx_max_frame - sizeof(struct ntb_payload_header);
-	max -= max % (1 << copy_align);
+	max_size = qp->tx_max_frame - sizeof(struct ntb_payload_header);
+	max_size = round_down(max_size, 1 << copy_align);
 
-	return max;
+	return max_size;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 

