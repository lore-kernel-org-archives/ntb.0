Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id sf5si2471230pac.1.2016.03.18.16.39.56
        for <linux-ntb@googlegroups.com>;
        Fri, 18 Mar 2016 16:39:56 -0700 (PDT)
Subject: [PATCH v2 2/2] NTB: Fix incorrect clean up routine in ntb_perf
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 18 Mar 2016 16:39:47 -0700
Message-ID: <20160318233946.4985.43257.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160318233941.4985.90146.stgit@djiang5-desk3.ch.intel.com>
References: <20160318233941.4985.90146.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

The clean up routine when we failed to allocate kthread is not cleaning
up all the threads, only the same one over and over again.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 245a34c..842ecca 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -548,6 +548,21 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
 	return ret;
 }
 
+static void threads_cleanup(struct perf_ctx *perf)
+{
+	struct pthr_ctx *pctx;
+	int i;
+
+	perf->run = false;
+	for (i = 0; i < MAX_THREADS; i++) {
+		pctx = &perf->pthr_ctx[i];
+		if (pctx->thread) {
+			kthread_stop(pctx->thread);
+			pctx->thread = NULL;
+		}
+	}
+}
+
 static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 				 size_t count, loff_t *offp)
 {
@@ -563,17 +578,9 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 	if (atomic_read(&perf->tsync) == 0)
 		perf->run = false;
 
-	if (perf->run) {
-		/* lets stop the threads */
-		perf->run = false;
-		for (i = 0; i < MAX_THREADS; i++) {
-			if (perf->pthr_ctx[i].thread) {
-				kthread_stop(perf->pthr_ctx[i].thread);
-				perf->pthr_ctx[i].thread = NULL;
-			} else
-				break;
-		}
-	} else {
+	if (perf->run)
+		threads_cleanup(perf);
+	else {
 		perf->run = true;
 
 		if (perf->perf_threads > MAX_THREADS) {
@@ -605,13 +612,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 						       (void *)pctx,
 						       node, "ntb_perf %d", i);
 			if (IS_ERR(pctx->thread)) {
-				perf->run = false;
-				for (i = 0; i < MAX_THREADS; i++) {
-					if (pctx->thread) {
-						kthread_stop(pctx->thread);
-						pctx->thread = NULL;
-					}
-				}
+				pctx->thread = NULL;
+				goto err;
 			} else
 				wake_up_process(pctx->thread);
 
@@ -622,6 +624,10 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 	}
 
 	return count;
+
+err:
+	threads_cleanup(perf);
+	return -ENXIO;
 }
 
 static const struct file_operations ntb_perf_debugfs_run = {

