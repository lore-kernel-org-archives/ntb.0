Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id un17si2737335pab.0.2016.06.16.13.17.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 13:17:31 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Jun 2016 14:17:06 -0600
Message-Id: <282288d244df4a832d20820fb2f3f74e24e40875.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
Subject: [PATCH v4 03/10] ntb_perf: Return results by reading the run file
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Instead of having to watch logs, allow the results to be retrieved
by reading back the run file. This file will return "running" when
the test is running and nothing if no tests have been run yet.
It returns 1 line per thread, and will display an error message if the
corresponding thread returns an error.

With the above change, the pr_info calls that returned the results are
then changed to pr_debug calls.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c | 67 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index db4dc61..05a8705 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -123,6 +123,9 @@ struct pthr_ctx {
 	int			src_idx;
 	void			*srcs[MAX_SRCS];
 	wait_queue_head_t       *wq;
+	int			status;
+	u64			copied;
+	u64			diff_us;
 };
 
 struct perf_ctx {
@@ -305,7 +308,7 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 	}
 
 	if (use_dma) {
-		pr_info("%s: All DMA descriptors submitted\n", current->comm);
+		pr_debug("%s: All DMA descriptors submitted\n", current->comm);
 		while (atomic_read(&pctx->dma_sync) != 0) {
 			if (kthread_should_stop())
 				break;
@@ -317,13 +320,16 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 	kdiff = ktime_sub(kstop, kstart);
 	diff_us = ktime_to_us(kdiff);
 
-	pr_info("%s: copied %llu bytes\n", current->comm, copied);
+	pr_debug("%s: copied %llu bytes\n", current->comm, copied);
 
-	pr_info("%s: lasted %llu usecs\n", current->comm, diff_us);
+	pr_debug("%s: lasted %llu usecs\n", current->comm, diff_us);
 
 	perf = div64_u64(copied, diff_us);
 
-	pr_info("%s: MBytes/s: %llu\n", current->comm, perf);
+	pr_debug("%s: MBytes/s: %llu\n", current->comm, perf);
+
+	pctx->copied = copied;
+	pctx->diff_us = diff_us;
 
 	return 0;
 }
@@ -345,7 +351,7 @@ static int ntb_perf_thread(void *data)
 	int rc, node, i;
 	struct dma_chan *dma_chan = NULL;
 
-	pr_info("kthread %s starting...\n", current->comm);
+	pr_debug("kthread %s starting...\n", current->comm);
 
 	node = dev_to_node(&pdev->dev);
 
@@ -575,19 +581,44 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
 {
 	struct perf_ctx *perf = filp->private_data;
 	char *buf;
-	ssize_t ret, out_offset;
-	int running;
+	ssize_t ret, out_off = 0;
+	struct pthr_ctx *pctx;
+	int i;
+	u64 rate;
 
 	if (!perf)
 		return 0;
 
-	buf = kmalloc(64, GFP_KERNEL);
+	buf = kmalloc(1024, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	running = mutex_is_locked(&perf->run_mutex);
-	out_offset = snprintf(buf, 64, "%d\n", running);
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
+	if (mutex_is_locked(&perf->run_mutex)) {
+		out_off = snprintf(buf, 64, "running\n");
+		goto read_from_buf;
+	}
+
+	for (i = 0; i < MAX_THREADS; i++) {
+		pctx = &perf->pthr_ctx[i];
+
+		if (pctx->status == -ENODATA)
+			break;
+
+		if (pctx->status) {
+			out_off += snprintf(buf + out_off, 1024 - out_off,
+					    "%d: error %d\n", i,
+					    pctx->status);
+			continue;
+		}
+
+		rate = div64_u64(pctx->copied, pctx->diff_us);
+		out_off += snprintf(buf + out_off, 1024 - out_off,
+			"%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
+			i, pctx->copied, pctx->diff_us, rate);
+	}
+
+read_from_buf:
+	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_off);
 	kfree(buf);
 
 	return ret;
@@ -601,12 +632,20 @@ static void threads_cleanup(struct perf_ctx *perf)
 	for (i = 0; i < MAX_THREADS; i++) {
 		pctx = &perf->pthr_ctx[i];
 		if (pctx->thread) {
-			kthread_stop(pctx->thread);
+			pctx->status = kthread_stop(pctx->thread);
 			pctx->thread = NULL;
 		}
 	}
 }
 
+static void perf_clear_thread_status(struct perf_ctx *perf)
+{
+	int i;
+
+	for (i = 0; i < MAX_THREADS; i++)
+		perf->pthr_ctx[i].status = -ENODATA;
+}
+
 static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 				 size_t count, loff_t *offp)
 {
@@ -623,6 +662,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 	if (!mutex_trylock(&perf->run_mutex))
 		return -EBUSY;
 
+	perf_clear_thread_status(perf);
+
 	if (perf->perf_threads > MAX_THREADS) {
 		perf->perf_threads = MAX_THREADS;
 		pr_info("Reset total threads to: %u\n", MAX_THREADS);
@@ -757,6 +798,8 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (rc)
 		goto err_ctx;
 
+	perf_clear_thread_status(perf);
+
 	return 0;
 
 err_ctx:
-- 
2.1.4

