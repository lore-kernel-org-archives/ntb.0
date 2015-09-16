Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id uv4si2935937pac.0.2015.09.16.10.43.41
        for <linux-ntb@googlegroups.com>;
        Wed, 16 Sep 2015 10:43:41 -0700 (PDT)
Subject: [PATCH] NTB: Fix issue where we may be accessing NULL ptr
From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 16 Sep 2015 10:43:10 -0700
Message-ID: <20150916174310.143612.54775.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

smatch detected an issue in the function ntb_transport_max_size() where
we could be dereferencing a dma channel pointer when it is NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6e3ee90..cd0ee3d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2005,8 +2005,13 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 	if (!qp->tx_dma_chan && !qp->rx_dma_chan)
 		return qp->tx_max_frame - sizeof(struct ntb_payload_header);
 
-	copy_align = max(qp->tx_dma_chan->device->copy_align,
-			 qp->rx_dma_chan->device->copy_align);
+	if (!qp->tx_dma_chan)
+		copy_align = qp->rx_dma_chan->device->copy_align;
+	else if (!qp->rx_dma_chan)
+		copy_align = qp->tx_dma_chan->device->copy_align;
+	else
+		copy_align = max(qp->tx_dma_chan->device->copy_align,
+				 qp->rx_dma_chan->device->copy_align);
 
 	/* If DMA engine usage is possible, try to find the max size for that */
 	max = qp->tx_max_frame - sizeof(struct ntb_payload_header);

