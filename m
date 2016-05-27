Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id ci4si4665639pad.1.2016.05.27.13.39.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 May 2016 13:39:56 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 27 May 2016 14:38:31 -0600
Message-Id: <1464381511-18491-1-git-send-email-logang@deltatee.com>
Subject: [PATCH] ntb_tool: Fix infinite loop bug when writing spad/peer_spad file
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

If you tried to write two spads in one line, as per the example:

root@peer# echo '0 0x01010101 1 0x7f7f7f7f' > $DBG_DIR/peer_spad

then the CPU would freeze in an infinite loop.

This wasn't immediately obvious but 'pos' was not incrementing the
buffer, so after reading the second pair of values, 'pos' would once
again be 3 and it would re-read the second pair of values ad infinitum.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_tool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 6f5dc6c..209ef7c 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -268,7 +268,7 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
 {
 	int spad_idx;
 	u32 spad_val;
-	char *buf;
+	char *buf, *buf_ptr;
 	int pos, n;
 	ssize_t rc;
 
@@ -288,14 +288,15 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
 	}
 
 	buf[size] = 0;
-
-	n = sscanf(buf, "%d %i%n", &spad_idx, &spad_val, &pos);
+	buf_ptr = buf;
+	n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
 	while (n == 2) {
+		buf_ptr += pos;
 		rc = spad_write_fn(tc->ntb, spad_idx, spad_val);
 		if (rc)
 			break;
 
-		n = sscanf(buf + pos, "%d %i%n", &spad_idx, &spad_val, &pos);
+		n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
 	}
 
 	if (n < 0)
-- 
2.1.4

