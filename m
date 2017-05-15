Return-Path: <Gary.Hook@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01on0043.outbound.protection.outlook.com. [104.47.32.43])
        by gmr-mx.google.com with ESMTPS id p67si1722005pfk.2.2017.05.15.08.33.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 08:33:38 -0700 (PDT)
Subject: [PATCH] ntb: Add error path/handling to Debug FS entry creation
From: Gary R Hook <gary.hook@amd.com>
Date: Mon, 15 May 2017 10:33:27 -0500
Message-ID: <20170515153327.4400.83250.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

If a failure occurs when creating Debug FS entries, unroll all of
the work that's been done.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/ntb/test/ntb_perf.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 6fdddf86269e..759f772fa00c 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -745,6 +745,7 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 	if (!debugfs_initialized())
 		return -ENODEV;
 
+	/* Assumpion: only one NTB device in the system */
 	if (!perf_debugfs_dir) {
 		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 		if (!perf_debugfs_dir)
@@ -754,45 +755,50 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 	debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
 					      perf_debugfs_dir);
 	if (!debugfs_node_dir)
-		return -ENODEV;
+		goto err;
 
 	debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
 					  debugfs_node_dir, perf,
 					  &ntb_perf_debugfs_run);
 	if (!debugfs_run)
-		return -ENODEV;
+		goto err;
 
 	debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
 					    debugfs_node_dir,
 					    &perf->perf_threads);
 	if (!debugfs_threads)
-		return -ENODEV;
+		goto err;
 
 	debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
 					       debugfs_node_dir,
 					       &seg_order);
 	if (!debugfs_seg_order)
-		return -ENODEV;
+		goto err;
 
 	debugfs_run_order = debugfs_create_u32("run_order", 0600,
 					       debugfs_node_dir,
 					       &run_order);
 	if (!debugfs_run_order)
-		return -ENODEV;
+		goto err;
 
 	debugfs_use_dma = debugfs_create_bool("use_dma", 0600,
 					       debugfs_node_dir,
 					       &use_dma);
 	if (!debugfs_use_dma)
-		return -ENODEV;
+		goto err;
 
 	debugfs_on_node = debugfs_create_bool("on_node", 0600,
 					      debugfs_node_dir,
 					      &on_node);
 	if (!debugfs_on_node)
-		return -ENODEV;
+		goto err;
 
 	return 0;
+
+err:
+	debugfs_remove_recursive(perf_debugfs_dir);
+	perf_debugfs_dir = NULL;
+	return -ENODEV;
 }
 
 static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)

