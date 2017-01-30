Return-Path: <dave.jiang@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id f7si3073970pfk.5.2017.01.30.13.21.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 13:21:18 -0800 (PST)
Subject: [PATCH] ntb: ntb_perf missing dmaengine_unmap_put
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 30 Jan 2017 14:21:17 -0700
Message-ID: <148581127718.58806.1803127910265426156.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

In the normal I/O execution path, ntb_perf is missing a call to
dmaengine_unmap_put() after submission. That causes us to leak
unmap objects.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e75d4fd..434e1d4 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -265,6 +265,8 @@ static ssize_t perf_copy(struct pthr_ctx *pctx, char __iomem *dst,
 	if (dma_submit_error(cookie))
 		goto err_set_unmap;
 
+	dmaengine_unmap_put(unmap);
+
 	atomic_inc(&pctx->dma_sync);
 	dma_async_issue_pending(chan);
 

