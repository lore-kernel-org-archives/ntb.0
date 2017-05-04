Return-Path: <Gary.Hook@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01on0066.outbound.protection.outlook.com. [104.47.32.66])
        by gmr-mx.google.com with ESMTPS id m67si22849pfm.0.2017.05.04.09.37.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 09:37:22 -0700 (PDT)
Subject: [PATCH] ntb: Add more debugfs support for ntb_perf testing options
From: Gary R Hook <gary.hook@amd.com>
Date: Thu, 4 May 2017 11:37:17 -0500
Message-ID: <20170504163717.9687.61665.stgit@taos.amd.com>
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
 drivers/ntb/test/ntb_perf.c |   48 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 42756a98a728..425c2a1b36e7 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -101,6 +101,10 @@
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Using DMA engine to measure performance");
 
+static bool on_node = true; /* default to 1 */
+module_param(on_node, bool, 0644);
+MODULE_PARM_DESC(on_node, "Run threads only on NTB device node (default: true)");
+
 struct perf_mw {
 	phys_addr_t	phys_addr;
 	resource_size_t	phys_size;
@@ -139,6 +143,10 @@ struct perf_ctx {
 	struct dentry		*debugfs_node_dir;
 	struct dentry		*debugfs_run;
 	struct dentry		*debugfs_threads;
+	struct dentry		*debugfs_seg_order;
+	struct dentry		*debugfs_run_order;
+	struct dentry		*debugfs_use_dma;
+	struct dentry		*debugfs_on_node;
 	u8			perf_threads;
 	/* mutex ensures only one set of threads run at once */
 	struct mutex		run_mutex;
@@ -345,6 +353,10 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 
 static bool perf_dma_filter_fn(struct dma_chan *chan, void *node)
 {
+	/* Is the channel required to be on the same node as the device? */
+	if (!on_node)
+		return true;
+
 	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
 }
 
@@ -682,7 +694,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 		pr_info("Fix run_order to %u\n", run_order);
 	}
 
-	node = dev_to_node(&perf->ntb->pdev->dev);
+	node = on_node ? dev_to_node(&perf->ntb->pdev->dev)
+		       : NUMA_NO_NODE;
 	atomic_set(&perf->tdone, 0);
 
 	/* launch kernel thread */
@@ -743,18 +756,42 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 	if (!perf->debugfs_node_dir)
 		return -ENODEV;
 
-	perf->debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
+	perf->debugfs_run = debugfs_create_file("run", 0600,
 						perf->debugfs_node_dir, perf,
 						&ntb_perf_debugfs_run);
 	if (!perf->debugfs_run)
 		return -ENODEV;
 
-	perf->debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
+	perf->debugfs_threads = debugfs_create_u8("threads", 0600,
 						  perf->debugfs_node_dir,
 						  &perf->perf_threads);
 	if (!perf->debugfs_threads)
 		return -ENODEV;
 
+	perf->debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
+						  perf->debugfs_node_dir,
+						  &seg_order);
+	if (!perf->debugfs_seg_order)
+		return -ENODEV;
+
+	perf->debugfs_run_order = debugfs_create_u32("run_order", 0600,
+						  perf->debugfs_node_dir,
+						  &run_order);
+	if (!perf->debugfs_run_order)
+		return -ENODEV;
+
+	perf->debugfs_use_dma = debugfs_create_u32("use_dma", 0600,
+						  perf->debugfs_node_dir,
+						  &use_dma);
+	if (!perf->debugfs_use_dma)
+		return -ENODEV;
+
+	perf->debugfs_on_node = debugfs_create_bool("on_node", 0600,
+						  perf->debugfs_node_dir,
+						  &on_node);
+	if (!perf->debugfs_on_node)
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -781,7 +818,10 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 
 	node = dev_to_node(&pdev->dev);
 
-	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
+	if (on_node)
+		perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
+	else
+		perf = kzalloc(sizeof(*perf), GFP_KERNEL);
 	if (!perf) {
 		rc = -ENOMEM;
 		goto err_perf;

