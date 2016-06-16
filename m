Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si4842690pfx.1.2016.06.16.13.17.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 13:17:31 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Jun 2016 14:17:13 -0600
Message-Id: <53d495a5f97211289302ddb60d8508edeaab20ed.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
Subject: [PATCH v4 10/10] ntb_perf: clear link_is_up flag when the link goes down.
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When the link goes down, the link_is_up flag did not return to
false. This could have caused some subtle corner case bugs
when the link goes up and down quickly.

Once that was fixed, there was found to be a race if the link was
brought down then immediately up. The link_cleanup work would
occasionally be scheduled after the next link up event. This would
cancel the link_work that was supposed to occur and leave ntb_perf
in an unusable state.

To fix this we get rid of the link_cleanup work and put the actions
directly in the link_down event.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index f0784e5..6a50f20 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -133,7 +133,6 @@ struct perf_ctx {
 	spinlock_t		db_lock;
 	struct perf_mw		mw;
 	bool			link_is_up;
-	struct work_struct	link_cleanup;
 	struct delayed_work	link_work;
 	wait_queue_head_t	link_wq;
 	struct dentry		*debugfs_node_dir;
@@ -158,10 +157,16 @@ static void perf_link_event(void *ctx)
 {
 	struct perf_ctx *perf = ctx;
 
-	if (ntb_link_is_up(perf->ntb, NULL, NULL) == 1)
+	if (ntb_link_is_up(perf->ntb, NULL, NULL) == 1) {
 		schedule_delayed_work(&perf->link_work, 2*HZ);
-	else
-		schedule_work(&perf->link_cleanup);
+	} else {
+		dev_dbg(&perf->ntb->pdev->dev, "link down\n");
+
+		if (!perf->link_is_up)
+			cancel_delayed_work_sync(&perf->link_work);
+
+		perf->link_is_up = false;
+	}
 }
 
 static void perf_db_event(void *ctx, int vec)
@@ -547,18 +552,6 @@ out:
 				      msecs_to_jiffies(PERF_LINK_DOWN_TIMEOUT));
 }
 
-static void perf_link_cleanup(struct work_struct *work)
-{
-	struct perf_ctx *perf = container_of(work,
-					     struct perf_ctx,
-					     link_cleanup);
-
-	dev_dbg(&perf->ntb->pdev->dev, "%s called\n", __func__);
-
-	if (!perf->link_is_up)
-		cancel_delayed_work_sync(&perf->link_work);
-}
-
 static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
 {
 	struct perf_mw *mw;
@@ -787,7 +780,6 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	perf_setup_mw(ntb, perf);
 	init_waitqueue_head(&perf->link_wq);
 	INIT_DELAYED_WORK(&perf->link_work, perf_link_work);
-	INIT_WORK(&perf->link_cleanup, perf_link_cleanup);
 
 	rc = ntb_set_ctx(ntb, perf, &perf_ops);
 	if (rc)
@@ -807,7 +799,6 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 
 err_ctx:
 	cancel_delayed_work_sync(&perf->link_work);
-	cancel_work_sync(&perf->link_cleanup);
 	kfree(perf);
 err_perf:
 	return rc;
@@ -823,7 +814,6 @@ static void perf_remove(struct ntb_client *client, struct ntb_dev *ntb)
 	mutex_lock(&perf->run_mutex);
 
 	cancel_delayed_work_sync(&perf->link_work);
-	cancel_work_sync(&perf->link_cleanup);
 
 	ntb_clear_ctx(ntb);
 	ntb_link_disable(ntb);
-- 
2.1.4

