Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id fj7si391509wib.3.2015.07.13.10.07.44
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:44 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 13/14] NTB: Remove dma_sync_wait from ntb_async_rx
Date: Mon, 13 Jul 2015 08:07:21 -0400
Message-Id: <1bad979125757d55c2b6c4d25204b954473e747d.1436788771.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788771.git.Allen.Hubbe@emc.com>
References: <cover.1436788771.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

The dma_sync_wait can hurt the performance of workloads mixed with both
large and small frames.  Large frames will be copied using the dma
engine.  Small frames will be copied by the cpu.  The dma_sync_wait
prevents the cpu and dma engine copying in parallel.

In the period where the cpu is copying, the dma engine is stopped.  The
dma engine is not doing any useful work to copy large frames during that
time, and the additional time to restart the dma engine for the next
large frame.  This will decrease the throughput for the portion of a
workload with large frames.

In the period where the dma engine is copying, the cpu is held up
waiting for dma to complete.  The small frames processing will be
delayed until the dma is complete.  The RX frames are completed
in-order, and the processing of small frames takes very little time, so
dma_sync_wait may have an insignificant impact on the respose time of
frames.  The more significant impact is to the system, because the delay
in dma_sync_wait is implemented as busy non-blocking wait.  This can
prevent the delayed core from doing any useful work, even if it could be
processing work for other drivers, unrelated to transport RX processing.

After applying the earlier patch to fix out-of-order RX acknoledgement,
the dma_sync_wait is no longer necessary.  Remove it, so that cpu memcpy
will proceed immediately for small frames, in parallel with ongoing dma
for large frames.  Do not hold up the cpu from doing work while dma is
in progress.  The prior fix will continue to ensure in-order completion
of the RX frames to the upper layer, and in-order delivery of the RX
acknoledgement.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index c283d1c2cb72..1ddf84ca721a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1233,18 +1233,18 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 		goto err;
 
 	if (len < copy_bytes)
-		goto err_wait;
+		goto err;
 
 	device = chan->device;
 	pay_off = (size_t)offset & ~PAGE_MASK;
 	buff_off = (size_t)buf & ~PAGE_MASK;
 
 	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
-		goto err_wait;
+		goto err;
 
 	unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
 	if (!unmap)
-		goto err_wait;
+		goto err;
 
 	unmap->len = len;
 	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
@@ -1287,12 +1287,6 @@ err_set_unmap:
 	dmaengine_unmap_put(unmap);
 err_get_unmap:
 	dmaengine_unmap_put(unmap);
-err_wait:
-	/* If the callbacks come out of order, the writing of the index to the
-	 * last completed will be out of order.  This may result in the
-	 * receive stalling forever.
-	 */
-	dma_sync_wait(chan, qp->last_cookie);
 err:
 	ntb_memcpy_rx(entry, offset);
 	qp->rx_memcpy++;
-- 
2.5.0.rc1

