Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id d201si4679008pfd.2.2016.08.08.02.48.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 02:48:09 -0700 (PDT)
Received: by mail-pa0-x244.google.com with SMTP id hh10so23779950pac.1
        for <linux-ntb@googlegroups.com>; Mon, 08 Aug 2016 02:48:09 -0700 (PDT)
Return-Path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ntb_pingpong: Fix db_init parameter description
Date: Mon,  8 Aug 2016 09:48:00 +0000
Message-Id: <1470649680-29533-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Logan Gunthorpe <logang@deltatee.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Fix 'db_init' parameter description.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/ntb/test/ntb_pingpong.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 7d31179..4358611 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to peer");
 
 static unsigned long db_init = 0x7;
 module_param(db_init, ulong, 0644);
-MODULE_PARM_DESC(delay_ms, "Initial doorbell bits to ring on the peer");
+MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
 
 struct pp_ctx {
 	struct ntb_dev			*ntb;



