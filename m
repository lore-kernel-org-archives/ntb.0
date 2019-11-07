Return-Path: <linjiasen@hygon.cn>
Received: from spam1.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id i1si60159pfr.2.2019.11.06.19.40.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:40:39 -0800 (PST)
From: Jiasen Lin <linjiasen@hygon.cn>
Subject: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
Date: Wed, 6 Nov 2019 19:38:33 -0800
Message-ID: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc: allenbh@gmail.com, dave.jiang@intel.com, linjiasen@hygon.cn
List-ID: <linux-ntb.googlegroups.com>

peer->outbuf is a virtual address which is get by ioremap, it can not
be converted to a physical address by virt_to_page and page_to_phys.
This conversion will result in DMA error, because the destination address
which is converted by page_to_phys is invalid.

We Save the physical address in perf_setup_peer_mw, it is MMIO address
of NTB BARx. Then fill the destination address of DMA descriptor with
this physical address to guarantee that the address of memory write
requests fall in memory window of NBT BARx.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..1c2fd1a 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -149,6 +149,7 @@ struct perf_peer {
 	u64 outbuf_xlat;
 	resource_size_t outbuf_size;
 	void __iomem *outbuf;
+	phys_addr_t out_phys_addr;
 
 	/* Inbound MW params */
 	dma_addr_t inbuf_xlat;
@@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
 }
 
 static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+			   void __iomem *dst, void *src, size_t len,
+			   phys_addr_t dst_phys_addr)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
@@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
-		offset_in_page(dst), len, DMA_FROM_DEVICE);
+	unmap->addr[1] = dst_phys_addr;
 	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
 		ret = -EIO;
 		goto err_free_resource;
@@ -901,6 +902,8 @@ static int perf_run_test(struct perf_thread *pthr)
 	u64 total_size, chunk_size;
 	void *flt_src;
 	int ret = 0;
+	phys_addr_t flt_phys_addr;
+	phys_addr_t bnd_phys_addr;
 
 	total_size = 1ULL << total_order;
 	chunk_size = 1ULL << chunk_order;
@@ -909,12 +912,15 @@ static int perf_run_test(struct perf_thread *pthr)
 	flt_src = pthr->src;
 	bnd_dst = peer->outbuf + peer->outbuf_size;
 	flt_dst = peer->outbuf;
+	bnd_phys_addr = peer->out_phys_addr + peer->outbuf_size;
+	flt_phys_addr = peer->out_phys_addr;
 
 	pthr->duration = ktime_get();
 
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
+				flt_phys_addr);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -925,8 +931,15 @@ static int perf_run_test(struct perf_thread *pthr)
 
 		flt_dst += chunk_size;
 		flt_src += chunk_size;
-		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
+		flt_phys_addr += chunk_size;
+
+		if (flt_dst >= bnd_dst ||
+		    flt_dst < peer->outbuf ||
+		    flt_phys_addr >= bnd_phys_addr ||
+		    flt_phys_addr < peer->out_phys_addr) {
+
 			flt_dst = peer->outbuf;
+			flt_phys_addr = peer->out_phys_addr;
 			flt_src = pthr->src;
 		}
 
@@ -1195,6 +1208,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
+			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+
+		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
@@ -1388,6 +1404,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (!peer->outbuf)
 		return -ENOMEM;
 
+	peer->out_phys_addr = phys_addr;
+
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
 		dev_warn(&peer->perf->ntb->dev,
-- 
2.7.4

