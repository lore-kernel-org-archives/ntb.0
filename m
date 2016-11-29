Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id f71si335427wmf.2.2016.11.29.09.16.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:15 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id o141so13357507lff.1
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:15 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 19/22] NTB PingPong: Alter driver to work with two-ports NTB API
Date: Tue, 29 Nov 2016 20:16:14 +0300
Message-Id: <1480439777-1080-20-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

PingPong driver doesn't do much, but it uses Scratchpads, which can be
unsupported by most of IDT hardware. So I restricted the usage of the
driver with hardware, which supports Scratchpads up until the IDT driver
is ported to the NTB API. When it's done I'll alter the pingpong driver to
support message registers as well.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/test/ntb_pingpong.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 4358611..90d3281 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -90,6 +90,9 @@ static unsigned long db_init = 0x7;
 module_param(db_init, ulong, 0644);
 MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
 
+/* Only two-ports NTB devices are supported */
+#define PIDX		0
+
 struct pp_ctx {
 	struct ntb_dev			*ntb;
 	u64				db_bits;
@@ -135,7 +138,7 @@ static void pp_ping(unsigned long ctx)
 			"Ping bits %#llx read %#x write %#x\n",
 			db_bits, spad_rd, spad_wr);
 
-		ntb_peer_spad_write(pp->ntb, 0, spad_wr);
+		ntb_peer_spad_write(pp->ntb, PIDX, 0, spad_wr);
 		ntb_peer_db_set(pp->ntb, db_bits);
 		ntb_db_clear_mask(pp->ntb, db_mask);
 
@@ -222,6 +225,12 @@ static int pp_probe(struct ntb_client *client,
 		}
 	}
 
+	if (ntb_spad_count(ntb) < 1) {
+		dev_dbg(&ntb->dev, "no enough scratchpads\n");
+		rc = -EINVAL;
+		goto err_pp;
+	}
+
 	if (ntb_spad_is_unsafe(ntb)) {
 		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
 		if (!unsafe) {
-- 
2.6.6

