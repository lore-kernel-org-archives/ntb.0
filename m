Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id sf5si1640641pac.1.2016.03.17.15.20.11
        for <linux-ntb@googlegroups.com>;
        Thu, 17 Mar 2016 15:20:11 -0700 (PDT)
Subject: [PATCH 2/2] NTB: Fix incorrect clean up routine in ntb_perf
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 17 Mar 2016 15:20:02 -0700
Message-ID: <20160317222002.155072.90692.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160317221956.155072.40712.stgit@djiang5-desk3.ch.intel.com>
References: <20160317221956.155072.40712.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/ntb/test/ntb_perf.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 23e2311..7444cfa 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -605,8 +605,10 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 						       (void *)pctx,
 						       node, "ntb_perf %d", i);
 			if (IS_ERR(pctx->thread))  {
+				pctx->thread = NULL;
 				perf->run = false;
 				for (i = 0; i < MAX_THREADS; i++) {
+					pctx = &perf->pthr_ctx[i];
 					if (pctx->thread) {
 						kthread_stop(pctx->thread);
 						pctx->thread = NULL;

