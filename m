Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com. [40.107.93.43])
        by gmr-mx.google.com with ESMTPS id 198si780256qkh.7.2020.03.10.13.55.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:55:24 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 1/5] ntb_perf: refactor code for CPU and DMA transfers
Date: Tue, 10 Mar 2020 15:54:50 -0500
Message-Id: <1583873694-19151-2-git-send-email-sanju.mehta@amd.com>
In-Reply-To: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Arindam Nath <arindam.nath@amd.com>

This patch creates separate function to handle CPU
and DMA transfers. Since CPU transfers use memcopy
and DMA transfers use dmaengine APIs, these changes
not only allow logical separation between the two,
but also allows someone to clearly see the difference
in the way the two are handled.

In the case of DMA, we DMA from system memory to the
memory window(MW) of NTB, which is a MMIO region, we
should not use dma_map_page() for mapping MW. The
correct way to map a MMIO region is to use
dma_map_resource(), so the code is modified
accordingly.

dma_map_resource() expects physical address of the
region to be mapped for DMA, we add a new field,
outbuf_phys_addr, to struct perf_peer, and also
another field, outbuf_dma_addr, to store the
corresponding mapped address returned by the API.

Since the MW is contiguous, rather than mapping
chunk-by-chunk, we map the entire MW before the
actual DMA transfer happens. Then for each chunk,
we simply pass offset into the mapped region and
DMA to that region. Then later, we unmap the MW
during perf_clear_test().

The above means that now we need to have different
function parameters to deal with in the case of
CPU and DMA transfers. In the case of CPU transfers,
we simply need the CPU virtual addresses for memcopy,
but in the case of DMA, we need dma_addr_t, which
will be different from CPU physical address depending
on whether IOMMU is enabled or not. Thus we now
have two separate functions, perf_copy_chunk_cpu(),
and perf_copy_chunk_dma() to take care of above
consideration.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 141 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 105 insertions(+), 36 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..6d16628 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -149,6 +149,8 @@ struct perf_peer {
 	u64 outbuf_xlat;
 	resource_size_t outbuf_size;
 	void __iomem *outbuf;
+	phys_addr_t outbuf_phys_addr;
+	dma_addr_t outbuf_dma_addr;
 
 	/* Inbound MW params */
 	dma_addr_t inbuf_xlat;
@@ -775,26 +777,24 @@ static void perf_dma_copy_callback(void *data)
 	wake_up(&pthr->dma_wait);
 }
 
-static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+static int perf_copy_chunk_cpu(struct perf_thread *pthr,
+			       void __iomem *dst, void *src, size_t len)
+{
+	memcpy_toio(dst, src, len);
+
+	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
+}
+
+static int perf_copy_chunk_dma(struct perf_thread *pthr,
+			       dma_addr_t dst, void *src, size_t len)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
 	struct device *dma_dev;
 	int try = 0, ret = 0;
 
-	if (!use_dma) {
-		memcpy_toio(dst, src, len);
-		goto ret_check_tsync;
-	}
-
 	dma_dev = pthr->dma_chan->device->dev;
-
-	if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
-				 offset_in_page(dst), len))
-		return -EIO;
-
-	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
 	if (!unmap)
 		return -ENOMEM;
 
@@ -807,17 +807,12 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
-		offset_in_page(dst), len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
-		ret = -EIO;
-		goto err_free_resource;
-	}
-	unmap->from_cnt = 1;
-
 	do {
-		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, unmap->addr[1],
-			unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, dst,
+					       unmap->addr[0], len,
+					       DMA_PREP_INTERRUPT |
+					       DMA_CTRL_ACK);
+
 		if (!tx)
 			msleep(DMA_MDELAY);
 	} while (!tx && (try++ < DMA_TRIES));
@@ -833,22 +828,16 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 
 	ret = dma_submit_error(dmaengine_submit(tx));
 	if (ret) {
-		dmaengine_unmap_put(unmap);
 		goto err_free_resource;
 	}
 
-	dmaengine_unmap_put(unmap);
-
 	atomic_inc(&pthr->dma_sync);
 	dma_async_issue_pending(pthr->dma_chan);
 
-ret_check_tsync:
-	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
-
 err_free_resource:
 	dmaengine_unmap_put(unmap);
 
-	return ret;
+	return likely(atomic_read(&pthr->perf->tsync) > 0) ? ret : -EINTR;
 }
 
 static bool perf_dma_filter(struct dma_chan *chan, void *data)
@@ -893,7 +882,7 @@ static int perf_init_test(struct perf_thread *pthr)
 	return 0;
 }
 
-static int perf_run_test(struct perf_thread *pthr)
+static int perf_run_test_cpu(struct perf_thread *pthr)
 {
 	struct perf_peer *peer = pthr->perf->test_peer;
 	struct perf_ctx *perf = pthr->perf;
@@ -914,7 +903,7 @@ static int perf_run_test(struct perf_thread *pthr)
 
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk_cpu(pthr, flt_dst, flt_src, chunk_size);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -937,6 +926,74 @@ static int perf_run_test(struct perf_thread *pthr)
 	return 0;
 }
 
+static int perf_run_test_dma(struct perf_thread *pthr)
+{
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct perf_ctx *perf = pthr->perf;
+	struct device *dma_dev;
+	dma_addr_t flt_dst, bnd_dst;
+	u64 total_size, chunk_size;
+	void *flt_src;
+	int ret = 0;
+
+	total_size = 1ULL << total_order;
+	chunk_size = 1ULL << chunk_order;
+	chunk_size = min_t(u64, peer->outbuf_size, chunk_size);
+
+	/* Map MW for DMA */
+	dma_dev = pthr->dma_chan->device->dev;
+	peer->outbuf_dma_addr = dma_map_resource(dma_dev,
+						 peer->outbuf_phys_addr,
+						 peer->outbuf_size,
+						 DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(dma_dev, peer->outbuf_dma_addr)) {
+		dma_unmap_resource(dma_dev, peer->outbuf_dma_addr,
+				   peer->outbuf_size, DMA_FROM_DEVICE, 0);
+		return -EIO;
+	}
+
+	flt_src = pthr->src;
+	bnd_dst = peer->outbuf_dma_addr + peer->outbuf_size;
+	flt_dst = peer->outbuf_dma_addr;
+
+	pthr->duration = ktime_get();
+	/* Copied field is cleared on test launch stage */
+	while (pthr->copied < total_size) {
+		ret = perf_copy_chunk_dma(pthr, flt_dst, flt_src, chunk_size);
+		if (ret) {
+			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
+				pthr->tidx, ret);
+			return ret;
+		}
+
+		pthr->copied += chunk_size;
+
+		flt_dst += chunk_size;
+		flt_src += chunk_size;
+		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf_dma_addr) {
+			flt_dst = peer->outbuf_dma_addr;
+			flt_src = pthr->src;
+		}
+
+		/* Give up CPU to give a chance for other threads to use it */
+		schedule();
+	}
+
+	return 0;
+}
+
+static int perf_run_test(struct perf_thread *pthr)
+{
+	int ret = 0;
+
+	if (!use_dma)
+		ret = perf_run_test_cpu(pthr);
+	else
+		ret = perf_run_test_dma(pthr);
+
+	return ret;
+}
+
 static int perf_sync_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
@@ -969,6 +1026,8 @@ static int perf_sync_test(struct perf_thread *pthr)
 static void perf_clear_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct device *dma_dev;
 
 	if (!use_dma)
 		goto no_dma_notify;
@@ -978,6 +1037,10 @@ static void perf_clear_test(struct perf_thread *pthr)
 	 * We call it anyway just to be sure of the transfers completion.
 	 */
 	(void)dmaengine_terminate_sync(pthr->dma_chan);
+	/* Un-map MW */
+	dma_dev = pthr->dma_chan->device->dev;
+	dma_unmap_resource(dma_dev, peer->outbuf_dma_addr, peer->outbuf_size,
+			   DMA_FROM_DEVICE, 0);
 
 	dma_release_channel(pthr->dma_chan);
 
@@ -1383,10 +1446,16 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (ret)
 		return ret;
 
-	peer->outbuf = devm_ioremap_wc(&perf->ntb->dev, phys_addr,
-					peer->outbuf_size);
-	if (!peer->outbuf)
-		return -ENOMEM;
+	if (use_dma) {
+		/* For DMA to/from MW */
+		peer->outbuf_phys_addr = phys_addr;
+	} else {
+		/* For CPU read(from)/write(to) MW */
+		peer->outbuf = devm_ioremap_wc(&perf->ntb->dev, phys_addr,
+					       peer->outbuf_size);
+		if (!peer->outbuf)
+			return -ENOMEM;
+	}
 
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
-- 
2.7.4

