Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id c11si2811035pfc.2.2016.06.27.16.09.59
        for <linux-ntb@googlegroups.com>;
        Mon, 27 Jun 2016 16:09:59 -0700 (PDT)
Subject: [PATCH 1/5] dmaengine: Adding error handling flag
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 27 Jun 2016 16:09:39 -0700
Message-ID: <146706897936.188649.9714053337305649647.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
References: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Adding error flag for the call back descriptor to notify upper layer that
an error has occurred with this particular DMA op.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/linux/dmaengine.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

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

