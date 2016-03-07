Return-Path: <dave.jiang@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id ff2si3516541pad.2.2016.03.07.14.57.33
        for <linux-ntb@googlegroups.com>;
        Mon, 07 Mar 2016 14:57:33 -0800 (PST)
Subject: [PATCH] ntb: add missing setup of translation window
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 07 Mar 2016 15:57:25 -0700
Message-ID: <20160307225725.91265.76601.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, john.kading@gd-ms.com
List-ID: <linux-ntb.googlegroups.com>

The perf tool is missing the setup of translation window. Adding call to
setup the translation window for backed memory.

Signed-off-by: John Kading <john.kading@gd-ms.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index af06286..454c374 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -424,6 +424,7 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
 {
 	struct perf_mw *mw = &perf->mw;
 	size_t xlat_size, buf_size;
+	int rc;
 
 	if (!size)
 		return -EINVAL;
@@ -447,6 +448,13 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
 		mw->buf_size = 0;
 	}
 
+	rc = ntb_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
+	if (rc) {
+		dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
+		perf_free_mw(perf);
+		return -EIO;
+	}
+
 	return 0;
 }
 

