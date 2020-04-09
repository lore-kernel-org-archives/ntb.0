Return-Path: <linjiasen@hygon.cn>
Received: from spam2.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id v1si38117oia.0.2020.04.09.00.14.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 00:14:13 -0700 (PDT)
From: Jiasen Lin <linjiasen@hygon.cn>
Subject: [PATCH] NTB: Fix static check warning in perf_clear_test
Date: Thu, 9 Apr 2020 00:11:24 -0700
Message-ID: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, dan.carpenter@oracle.com
Cc: allenbh@gmail.com, dave.jiang@intel.com, zhangpanyong@hygon.cn, linjiasen@hygon.cn
List-ID: <linux-ntb.googlegroups.com>

As pthr->dma_chan can't be NULL in this context, so there is
no need to check pthr->dma_chan.

Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 972f6d9..f73b126 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1010,8 +1010,8 @@ static void perf_clear_test(struct perf_thread *pthr)
 				   pthr->perf->test_peer->dma_dst_addr,
 				   pthr->perf->test_peer->outbuf_size,
 				   DMA_FROM_DEVICE, 0);
-	if (pthr->dma_chan)
-		dma_release_channel(pthr->dma_chan);
+
+	dma_release_channel(pthr->dma_chan);
 
 no_dma_notify:
 	atomic_dec(&perf->tsync);
-- 
2.7.4

