Return-Path: <yang.lee@linux.alibaba.com>
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com. [115.124.30.130])
        by gmr-mx.google.com with ESMTPS id x24si1321644qkx.3.2021.06.07.01.40.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:40:46 -0700 (PDT)
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] NTB: perf: Fix an error code in perf_setup_inbuf()
Date: Mon,  7 Jun 2021 16:40:36 +0800
Message-Id: <1623055236-97905-1-git-send-email-yang.lee@linux.alibaba.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
List-ID: <linux-ntb.googlegroups.com>

When the function IS_ALIGNED() returns false, the value of ret is 0.
So, we set ret to -EINVAL to indicate this error.

Clean up smatch warning:
drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Change in v2:
--According to Serge's suggestion, set ret to -EINVAL.
https://lore.kernel.org/lkml/20210605180554.ql4rhpukj57ujkxw@mobilestation/

 drivers/ntb/test/ntb_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 89df135..65e1e5c 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -598,6 +598,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 		return -ENOMEM;
 	}
 	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {
+		ret = -EINVAL;
 		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
 		goto err_free_inbuf;
 	}
-- 
1.8.3.1

