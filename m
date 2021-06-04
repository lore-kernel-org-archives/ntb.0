Return-Path: <yang.lee@linux.alibaba.com>
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com. [115.124.30.56])
        by gmr-mx.google.com with ESMTPS id f3si436080pjs.3.2021.06.04.03.21.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:21:20 -0700 (PDT)
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH 1/2] NTB: perf: Fix an error code in perf_setup_inbuf()
Date: Fri,  4 Jun 2021 18:20:50 +0800
Message-Id: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
List-ID: <linux-ntb.googlegroups.com>

When the function IS_ALIGNED() returns false, the value of ret is 0.
So, we set ret to -ENOMEM to indicate this error.

Clean up smatch warning:
drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/test/ntb_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 89df135..c20b375 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -598,6 +598,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 		return -ENOMEM;
 	}
 	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {
+		ret = -ENOMEM;
 		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
 		goto err_free_inbuf;
 	}
-- 
1.8.3.1

