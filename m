Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tp10si5087414pac.2.2016.06.16.13.17.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 13:17:30 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Jun 2016 14:17:05 -0600
Message-Id: <c55b9ce2f0ecdd0b60d028ffea1206e26d140493.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
Subject: [PATCH v4 02/10] ntb_perf: Improve thread handling to increase robustness
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This commit accomplishes a few things:

1) Properly prevent multiple sets of threads from running at once using
a mutex. Lots of race issues existed with the thread_cleanup.

2) The mutex allows us to ensure that threads are finished before
tearing down the device or module.

3) Don't use kthread_stop when the threads can exit by themselves, as
this is counter-indicated by the kthread_create documentation. Threads
now wait for kthread_stop to occur.

4) Writing to the run file now blocks until the threads are complete.
The test can then be safely interrupted by a SIGINT.

Also, while I was at it:

5) debugfs_run_write shouldn't return 0 in the early check cases as this
could cause debugfs_run_write to loop undesirably.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c | 124 +++++++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 48 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 5008ccf..db4dc61 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -58,6 +58,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/ntb.h>
+#include <linux/mutex.h>
 
 #define DRIVER_NAME		"ntb_perf"
 #define DRIVER_DESCRIPTION	"PCIe NTB Performance Measurement Tool"
@@ -121,6 +122,7 @@ struct pthr_ctx {
 	int			dma_prep_err;
 	int			src_idx;
 	void			*srcs[MAX_SRCS];
+	wait_queue_head_t       *wq;
 };
 
 struct perf_ctx {
@@ -134,9 +136,11 @@ struct perf_ctx {
 	struct dentry		*debugfs_run;
 	struct dentry		*debugfs_threads;
 	u8			perf_threads;
-	bool			run;
+	/* mutex ensures only one set of threads run at once */
+	struct mutex		run_mutex;
 	struct pthr_ctx		pthr_ctx[MAX_THREADS];
 	atomic_t		tsync;
+	atomic_t                tdone;
 };
 
 enum {
@@ -295,12 +299,18 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
+
+		if (unlikely(kthread_should_stop()))
+			break;
 	}
 
 	if (use_dma) {
 		pr_info("%s: All DMA descriptors submitted\n", current->comm);
-		while (atomic_read(&pctx->dma_sync) != 0)
+		while (atomic_read(&pctx->dma_sync) != 0) {
+			if (kthread_should_stop())
+				break;
 			msleep(20);
+		}
 	}
 
 	kstop = ktime_get();
@@ -393,7 +403,10 @@ static int ntb_perf_thread(void *data)
 		pctx->srcs[i] = NULL;
 	}
 
-	return 0;
+	atomic_inc(&perf->tdone);
+	wake_up(pctx->wq);
+	rc = 0;
+	goto done;
 
 err:
 	for (i = 0; i < MAX_SRCS; i++) {
@@ -406,6 +419,16 @@ err:
 		pctx->dma_chan = NULL;
 	}
 
+done:
+	/* Wait until we are told to stop */
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
 	return rc;
 }
 
@@ -553,6 +576,7 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
 	struct perf_ctx *perf = filp->private_data;
 	char *buf;
 	ssize_t ret, out_offset;
+	int running;
 
 	if (!perf)
 		return 0;
@@ -560,7 +584,9 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
 	buf = kmalloc(64, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	out_offset = snprintf(buf, 64, "%d\n", perf->run);
+
+	running = mutex_is_locked(&perf->run_mutex);
+	out_offset = snprintf(buf, 64, "%d\n", running);
 	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
 	kfree(buf);
 
@@ -572,7 +598,6 @@ static void threads_cleanup(struct perf_ctx *perf)
 	struct pthr_ctx *pctx;
 	int i;
 
-	perf->run = false;
 	for (i = 0; i < MAX_THREADS; i++) {
 		pctx = &perf->pthr_ctx[i];
 		if (pctx->thread) {
@@ -587,65 +612,66 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 {
 	struct perf_ctx *perf = filp->private_data;
 	int node, i;
+	DECLARE_WAIT_QUEUE_HEAD(wq);
 
 	if (!perf->link_is_up)
-		return 0;
+		return -ENOLINK;
 
 	if (perf->perf_threads == 0)
-		return 0;
+		return -EINVAL;
 
-	if (atomic_read(&perf->tsync) == 0)
-		perf->run = false;
+	if (!mutex_trylock(&perf->run_mutex))
+		return -EBUSY;
 
-	if (perf->run)
-		threads_cleanup(perf);
-	else {
-		perf->run = true;
+	if (perf->perf_threads > MAX_THREADS) {
+		perf->perf_threads = MAX_THREADS;
+		pr_info("Reset total threads to: %u\n", MAX_THREADS);
+	}
 
-		if (perf->perf_threads > MAX_THREADS) {
-			perf->perf_threads = MAX_THREADS;
-			pr_info("Reset total threads to: %u\n", MAX_THREADS);
-		}
+	/* no greater than 1M */
+	if (seg_order > MAX_SEG_ORDER) {
+		seg_order = MAX_SEG_ORDER;
+		pr_info("Fix seg_order to %u\n", seg_order);
+	}
 
-		/* no greater than 1M */
-		if (seg_order > MAX_SEG_ORDER) {
-			seg_order = MAX_SEG_ORDER;
-			pr_info("Fix seg_order to %u\n", seg_order);
-		}
+	if (run_order < seg_order) {
+		run_order = seg_order;
+		pr_info("Fix run_order to %u\n", run_order);
+	}
 
-		if (run_order < seg_order) {
-			run_order = seg_order;
-			pr_info("Fix run_order to %u\n", run_order);
-		}
+	node = dev_to_node(&perf->ntb->pdev->dev);
+	atomic_set(&perf->tdone, 0);
 
-		node = dev_to_node(&perf->ntb->pdev->dev);
-		/* launch kernel thread */
-		for (i = 0; i < perf->perf_threads; i++) {
-			struct pthr_ctx *pctx;
-
-			pctx = &perf->pthr_ctx[i];
-			atomic_set(&pctx->dma_sync, 0);
-			pctx->perf = perf;
-			pctx->thread =
-				kthread_create_on_node(ntb_perf_thread,
-						       (void *)pctx,
-						       node, "ntb_perf %d", i);
-			if (IS_ERR(pctx->thread)) {
-				pctx->thread = NULL;
-				goto err;
-			} else
-				wake_up_process(pctx->thread);
-
-			if (perf->run == false)
-				return -ENXIO;
-		}
+	/* launch kernel thread */
+	for (i = 0; i < perf->perf_threads; i++) {
+		struct pthr_ctx *pctx;
 
+		pctx = &perf->pthr_ctx[i];
+		atomic_set(&pctx->dma_sync, 0);
+		pctx->perf = perf;
+		pctx->wq = &wq;
+		pctx->thread =
+			kthread_create_on_node(ntb_perf_thread,
+					       (void *)pctx,
+					       node, "ntb_perf %d", i);
+		if (IS_ERR(pctx->thread)) {
+			pctx->thread = NULL;
+			goto err;
+		} else {
+			wake_up_process(pctx->thread);
+		}
 	}
 
+	wait_event_interruptible(wq,
+		atomic_read(&perf->tdone) == perf->perf_threads);
+
+	threads_cleanup(perf);
+	mutex_unlock(&perf->run_mutex);
 	return count;
 
 err:
 	threads_cleanup(perf);
+	mutex_unlock(&perf->run_mutex);
 	return -ENXIO;
 }
 
@@ -713,7 +739,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	perf->ntb = ntb;
 	perf->perf_threads = 1;
 	atomic_set(&perf->tsync, 0);
-	perf->run = false;
+	mutex_init(&perf->run_mutex);
 	spin_lock_init(&perf->db_lock);
 	perf_setup_mw(ntb, perf);
 	INIT_DELAYED_WORK(&perf->link_work, perf_link_work);
@@ -748,6 +774,8 @@ static void perf_remove(struct ntb_client *client, struct ntb_dev *ntb)
 
 	dev_dbg(&perf->ntb->dev, "%s called\n", __func__);
 
+	mutex_lock(&perf->run_mutex);
+
 	cancel_delayed_work_sync(&perf->link_work);
 	cancel_work_sync(&perf->link_cleanup);
 
-- 
2.1.4

