Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id x10si176961ejy.0.2021.06.09.04.21.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:21:29 -0700 (PDT)
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ntb: ntb_pingpong: remove redundant initialization of variables msg_data and spad_data
Date: Wed,  9 Jun 2021 12:21:28 +0100
Message-Id: <20210609112128.184667-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Colin Ian King <colin.king@canonical.com>

The variables msg_data and spad_data are being initialized with values
that are never read, they are being updated later on. The initializations
are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ntb/test/ntb_pingpong.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 2164e8492772..8aeca7914050 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -187,7 +187,7 @@ static void pp_ping(struct pp_ctx *pp)
 
 static void pp_pong(struct pp_ctx *pp)
 {
-	u32 msg_data = -1, spad_data = -1;
+	u32 msg_data, spad_data;
 	int pidx = 0;
 
 	/* Read pong data */
-- 
2.31.1

