Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w4-v6si594362ioa.4.2018.06.08.17.08.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 17:08:27 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:15 -0600
Message-Id: <20180609000819.13883-6-logang@deltatee.com>
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
Subject: [PATCH 5/8] NTB: perf: Don't require one more memory window than number of peers
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

ntb_perf should not require more than one memory window per peer. This
was probably an off-by-one error.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0d1f19..fe27412ffe91 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -655,7 +655,7 @@ static int perf_init_service(struct perf_ctx *perf)
 {
 	u64 mask;
 
-	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
+	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
 		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
 		return -EINVAL;
 	}
-- 
2.11.0

