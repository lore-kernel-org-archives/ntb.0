Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id un17si5116371pab.0.2016.06.20.12.15.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 12:15:27 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 20 Jun 2016 13:15:07 -0600
Message-Id: <14c2895ca4c7430162543ffc229c2131f57153f7.1466449562.git.logang@deltatee.com>
In-Reply-To: <cover.1466449562.git.logang@deltatee.com>
References: <cover.1466449562.git.logang@deltatee.com>
In-Reply-To: <cover.1466449562.git.logang@deltatee.com>
References: <cover.1466449562.git.logang@deltatee.com>
Subject: [PATCH v5 04/10] ntb_perf: Wait for link before running test
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Instead of returning immediately with an error when the link is
down, wait for the link to come up (or the user sends a SIGINT).

This is to make scripting ntb_perf easier.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 05a8705..f0784e5 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -135,6 +135,7 @@ struct perf_ctx {
 	bool			link_is_up;
 	struct work_struct	link_cleanup;
 	struct delayed_work	link_work;
+	wait_queue_head_t	link_wq;
 	struct dentry		*debugfs_node_dir;
 	struct dentry		*debugfs_run;
 	struct dentry		*debugfs_threads;
@@ -533,6 +534,7 @@ static void perf_link_work(struct work_struct *work)
 		goto out1;
 
 	perf->link_is_up = true;
+	wake_up(&perf->link_wq);
 
 	return;
 
@@ -653,7 +655,7 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 	int node, i;
 	DECLARE_WAIT_QUEUE_HEAD(wq);
 
-	if (!perf->link_is_up)
+	if (wait_event_interruptible(perf->link_wq, perf->link_is_up))
 		return -ENOLINK;
 
 	if (perf->perf_threads == 0)
@@ -783,6 +785,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	mutex_init(&perf->run_mutex);
 	spin_lock_init(&perf->db_lock);
 	perf_setup_mw(ntb, perf);
+	init_waitqueue_head(&perf->link_wq);
 	INIT_DELAYED_WORK(&perf->link_work, perf_link_work);
 	INIT_WORK(&perf->link_cleanup, perf_link_cleanup);
 
-- 
2.1.4

