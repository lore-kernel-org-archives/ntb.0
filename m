Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 189si1587179pfw.2.2016.06.10.15.55.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 15:55:28 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 10 Jun 2016 16:54:08 -0600
Message-Id: <d9488f2c946644c2b1258a78929d3543747283ec.1465598632.git.logang@deltatee.com>
In-Reply-To: <cover.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com>
In-Reply-To: <cover.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com>
Subject: [PATCH 5/8] ntb_tool: BUG: Ensure the buffer size is large enough to return all spads
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

On hardware with 32 scratchpad registers the spad field in ntb tool
could chop off the end. The maximum buffer size is increased from
256 to 15 times the number or scratchpads.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_tool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 4c01057..954e1d5 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -368,7 +368,9 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 	if (!spad_read_fn)
 		return -EINVAL;
 
-	buf_size = min_t(size_t, size, 0x100);
+	spad_count = ntb_spad_count(tc->ntb);
+
+	buf_size = min_t(size_t, size, spad_count * 15);
 
 	buf = kmalloc(buf_size, GFP_KERNEL);
 	if (!buf)
@@ -376,7 +378,6 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 
 	pos = 0;
 
-	spad_count = ntb_spad_count(tc->ntb);
 	for (i = 0; i < spad_count; ++i) {
 		pos += scnprintf(buf + pos, buf_size - pos, "%d\t%#x\n",
 				 i, spad_read_fn(tc->ntb, i));
-- 
2.1.4

