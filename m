Return-Path: <Gary.Hook@amd.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-co1nam03on0075.outbound.protection.outlook.com. [104.47.40.75])
        by gmr-mx.google.com with ESMTPS id r66si106225pfb.7.2017.05.04.13.21.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 13:21:41 -0700 (PDT)
Subject: [PATCH V2 3/3] ntb: Add more debugfs support for ntb_perf testing
 options
From: Gary R Hook <gary.hook@amd.com>
Date: Thu, 4 May 2017 15:21:35 -0500
Message-ID: <20170504202135.10113.49796.stgit@taos.amd.com>
In-Reply-To: <20170504201544.10113.13551.stgit@taos.amd.com>
References: <20170504201544.10113.13551.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The ntb_perf tool uses module parameters to control the
characteristics of its test.  Enable the changing of these
options through debugfs, and eliminating the need to unload
and reload the module to make changes and run additional tests.

Add a new module parameter that forces the DMA channel
selection onto the same node as the NTB device (default: true).

 - seg_order: Size of the NTB memory window; power of 2.
 - run_order: Size of the data buffer; power of 2.
 - use_dma:   Use DMA or memcpy? Default: 0.
 - on_node:   Only use DMA channel(s) on the NTB node. Default: true.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/ntb/test/ntb_perf.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 70085d5d553f..d13b837e8396 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -737,6 +737,10 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 	struct dentry *debugfs_node_dir;
 	struct dentry *debugfs_run;
 	struct dentry *debugfs_threads;
+	struct dentry *debugfs_seg_order;
+	struct dentry *debugfs_run_order;
+	struct dentry *debugfs_use_dma;
+	struct dentry *debugfs_on_node;
 
 	if (!debugfs_initialized())
 		return -ENODEV;
@@ -764,6 +768,30 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 	if (!debugfs_threads)
 		return -ENODEV;
 
+	debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
+					       debugfs_node_dir,
+					       &seg_order);
+	if (!debugfs_seg_order)
+		return -ENODEV;
+
+	debugfs_run_order = debugfs_create_u32("run_order", 0600,
+					       debugfs_node_dir,
+					       &run_order);
+	if (!debugfs_run_order)
+		return -ENODEV;
+
+	debugfs_use_dma = debugfs_create_bool("use_dma", 0600,
+					       debugfs_node_dir,
+					       &use_dma);
+	if (!debugfs_use_dma)
+		return -ENODEV;
+
+	debugfs_on_node = debugfs_create_bool("on_node", 0600,
+					      debugfs_node_dir,
+					      &on_node);
+	if (!debugfs_on_node)
+		return -ENODEV;
+
 	return 0;
 }
 

