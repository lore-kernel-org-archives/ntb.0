Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id sf5si2471188pac.1.2016.03.18.16.39.51
        for <linux-ntb@googlegroups.com>;
        Fri, 18 Mar 2016 16:39:51 -0700 (PDT)
Subject: [PATCH v2 1/2] NTB: Fix incorrect return check in ntb_perf
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 18 Mar 2016 16:39:41 -0700
Message-ID: <20160318233941.4985.90146.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

kthread_create_no_node() returns error pointers, never NULL. Fix check so
it handles error correctly.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index c8a37ba..245a34c 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -604,9 +604,7 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 				kthread_create_on_node(ntb_perf_thread,
 						       (void *)pctx,
 						       node, "ntb_perf %d", i);
-			if (pctx->thread)
-				wake_up_process(pctx->thread);
-			else {
+			if (IS_ERR(pctx->thread)) {
 				perf->run = false;
 				for (i = 0; i < MAX_THREADS; i++) {
 					if (pctx->thread) {
@@ -614,7 +612,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 						pctx->thread = NULL;
 					}
 				}
-			}
+			} else
+				wake_up_process(pctx->thread);
 
 			if (perf->run == false)
 				return -ENXIO;

