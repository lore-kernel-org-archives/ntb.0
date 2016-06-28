Return-Path: <dave.jiang@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id c11si124338pfc.2.2016.06.28.16.15.31
        for <linux-ntb@googlegroups.com>;
        Tue, 28 Jun 2016 16:15:31 -0700 (PDT)
Subject: [PATCH v3 1/5] dmaengine: Adding error handling flag
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 28 Jun 2016 16:15:11 -0700
Message-ID: <146715571138.208762.7964180099092112652.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
References: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc.com, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

Adding error flag for the call back descriptor to notify upper layer that
an error has occurred with this particular DMA op.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 0 files changed

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0174337..6524881 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -453,6 +453,20 @@ struct dmaengine_unmap_data {
 };
 
 /**
+ * enum err_result_flags - result of DMA operations
+ * @ERR_DMA_NONE - no errors
+ * @ERR_DMA_READ - DMA read error
+ * @ERR_DMA_WRITE - DMA write error
+ * @ERR_DMA_ABORT - Operation aborted
+ */
+enum err_result_flags {
+	ERR_DMA_NONE = 0,
+	ERR_DMA_READ,
+	ERR_DMA_WRITE,
+	ERR_DMA_ABORT,
+};
+
+/**
  * struct dma_async_tx_descriptor - async transaction descriptor
  * ---dma generic offload fields---
  * @cookie: tracking cookie for this transaction, set to -EBUSY if
@@ -480,6 +494,7 @@ struct dma_async_tx_descriptor {
 	dma_async_tx_callback callback;
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
+	enum err_result_flags result;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;

