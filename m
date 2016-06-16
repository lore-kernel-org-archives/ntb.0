Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c11si3162893pfc.2.2016.06.16.13.17.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 13:17:30 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Jun 2016 14:17:08 -0600
Message-Id: <8850af3a6354d8ca2159a707d87c6b54845ca0d5.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
In-Reply-To: <cover.1466098407.git.logang@deltatee.com>
References: <cover.1466098407.git.logang@deltatee.com>
Subject: [PATCH v4 05/10] ntb_tool: BUG: Ensure the buffer size is large enough to return all spads
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

On hardware with 32 scratchpad registers the spad field in ntb tool
could chop off the end. The maximum buffer size is increased from
256 to 15 times the number or scratchpads.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/test/ntb_tool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 4c01057..cba31fd 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -368,7 +368,14 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 	if (!spad_read_fn)
 		return -EINVAL;
 
-	buf_size = min_t(size_t, size, 0x100);
+	spad_count = ntb_spad_count(tc->ntb);
+
+	/*
+	 * We multiply the number of spads by 15 to get the buffer size
+	 * this is from 3 for the %d, 10 for the largest hex value
+	 * (0x00000000) and 2 for the tab and line feed.
+	 */
+	buf_size = min_t(size_t, size, spad_count * 15);
 
 	buf = kmalloc(buf_size, GFP_KERNEL);
 	if (!buf)
@@ -376,7 +383,6 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 
 	pos = 0;
 
-	spad_count = ntb_spad_count(tc->ntb);
 	for (i = 0; i < spad_count; ++i) {
 		pos += scnprintf(buf + pos, buf_size - pos, "%d\t%#x\n",
 				 i, spad_read_fn(tc->ntb, i));
-- 
2.1.4

