Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id 62si62193pfx.1.2016.06.28.14.33.00
        for <linux-ntb@googlegroups.com>;
        Tue, 28 Jun 2016 14:33:00 -0700 (PDT)
Subject: [PATCH v2 1/5] dmaengine: Adding error handling flag
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 28 Jun 2016 14:32:36 -0700
Message-ID: <146714955631.164165.9667998483372316270.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146714937102.164165.14635157606697707937.stgit@djiang5-desk3.ch.intel.com>
References: <146714937102.164165.14635157606697707937.stgit@djiang5-desk3.ch.intel.com>
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

