Return-Path: <Gary.Hook@amd.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0065.outbound.protection.outlook.com. [104.47.37.65])
        by gmr-mx.google.com with ESMTPS id c14si84490itc.3.2017.05.09.07.33.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 07:33:37 -0700 (PDT)
Subject: [PATCH V3 2/3] ntb: Remove debug-fs variables from the context
 structure
From: Gary R Hook <gary.hook@amd.com>
Date: Tue, 9 May 2017 09:33:28 -0500
Message-ID: <20170509143328.12995.19706.stgit@taos.amd.com>
In-Reply-To: <20170509142856.12995.96207.stgit@taos.amd.com>
References: <20170509142856.12995.96207.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The Debug FS entries manage themselves; we don't need to hang onto
them in the context structure.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/ntb/test/ntb_perf.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 0ec9f56f6999..60e0dd320aef 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -140,9 +140,6 @@ struct perf_ctx {
 	bool			link_is_up;
 	struct delayed_work	link_work;
 	wait_queue_head_t	link_wq;
-	struct dentry		*debugfs_node_dir;
-	struct dentry		*debugfs_run;
-	struct dentry		*debugfs_threads;
 	u8			perf_threads;
 	/* mutex ensures only one set of threads run at once */
 	struct mutex		run_mutex;
@@ -737,6 +734,9 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 static int perf_debugfs_setup(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
+	struct dentry *debugfs_node_dir;
+	struct dentry *debugfs_run;
+	struct dentry *debugfs_threads;
 
 	if (!debugfs_initialized())
 		return -ENODEV;
@@ -747,21 +747,21 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 			return -ENODEV;
 	}
 
-	perf->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
-						    perf_debugfs_dir);
-	if (!perf->debugfs_node_dir)
+	debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
+					      perf_debugfs_dir);
+	if (!debugfs_node_dir)
 		return -ENODEV;
 
-	perf->debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
-						perf->debugfs_node_dir, perf,
-						&ntb_perf_debugfs_run);
-	if (!perf->debugfs_run)
+	debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
+					  debugfs_node_dir, perf,
+					  &ntb_perf_debugfs_run);
+	if (!debugfs_run)
 		return -ENODEV;
 
-	perf->debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
-						  perf->debugfs_node_dir,
-						  &perf->perf_threads);
-	if (!perf->debugfs_threads)
+	debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
+					    debugfs_node_dir,
+					    &perf->perf_threads);
+	if (!debugfs_threads)
 		return -ENODEV;
 
 	return 0;

