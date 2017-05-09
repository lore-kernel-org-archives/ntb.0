Return-Path: <Gary.Hook@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on0059.outbound.protection.outlook.com. [104.47.36.59])
        by gmr-mx.google.com with ESMTPS id k16si16509pfg.5.2017.05.09.07.33.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 07:33:30 -0700 (PDT)
Subject: [PATCH V3 1/3] ntb: Add a module option to control affinity of DMA
 channels
From: Gary R Hook <gary.hook@amd.com>
Date: Tue, 9 May 2017 09:33:17 -0500
Message-ID: <20170509143317.12995.76566.stgit@taos.amd.com>
In-Reply-To: <20170509142856.12995.96207.stgit@taos.amd.com>
References: <20170509142856.12995.96207.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The DMA channel(s)/memory used to transfer data to an NTB device
may not be required to be on the same node as the device. Add a
module parameter that allows any candidate channel (aside from
node assocation) and allocated memory to be used.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/ntb/test/ntb_perf.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 42756a98a728..0ec9f56f6999 100644
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
@@ -345,6 +349,10 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 
 static bool perf_dma_filter_fn(struct dma_chan *chan, void *node)
 {
+	/* Is the channel required to be on the same node as the device? */
+	if (!on_node)
+		return true;
+
 	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
 }
 
@@ -362,7 +370,7 @@ static int ntb_perf_thread(void *data)
 
 	pr_debug("kthread %s starting...\n", current->comm);
 
-	node = dev_to_node(&pdev->dev);
+	node = on_node ? dev_to_node(&pdev->dev) : NUMA_NO_NODE;
 
 	if (use_dma && !pctx->dma_chan) {
 		dma_cap_mask_t dma_mask;
@@ -682,7 +690,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
 		pr_info("Fix run_order to %u\n", run_order);
 	}
 
-	node = dev_to_node(&perf->ntb->pdev->dev);
+	node = on_node ? dev_to_node(&perf->ntb->pdev->dev)
+		       : NUMA_NO_NODE;
 	atomic_set(&perf->tdone, 0);
 
 	/* launch kernel thread */
@@ -779,8 +788,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
 		dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
 
-	node = dev_to_node(&pdev->dev);
-
+	node = on_node ? dev_to_node(&pdev->dev) : NUMA_NO_NODE;
 	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
 	if (!perf) {
 		rc = -ENOMEM;

