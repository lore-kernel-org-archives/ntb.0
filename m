Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id a23si2301517edd.1.2018.01.22.01.39.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 01:39:00 -0800 (PST)
From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] NTB: ntb_tool: fix memory leak on 'buf' on error exit path
Date: Mon, 22 Jan 2018 09:38:57 +0000
Message-Id: <20180122093857.2174-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Colin Ian King <colin.king@canonical.com>

Currently there is a memory leak on buf when the call to ntb_mw_get_align
fails.  Add an exit err label and jump to this so that kfree on buf frees
the memory.

Detected by CoverityScan, CID#1464286 ("Resource leak")

Fixes: d637628ce00c ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ntb/test/ntb_tool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 920fc9b161b0..d592c0ffbd19 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -659,7 +659,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 	ret = ntb_mw_get_align(inmw->tc->ntb, inmw->pidx, inmw->widx,
 			       &addr_align, &size_align, &size_max);
 	if (ret)
-		return ret;
+		goto err;
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Inbound MW     \t%d\n",
@@ -694,6 +694,8 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 			 &size_max);
 
 	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
+
+err:
 	kfree(buf);
 
 	return ret;
-- 
2.15.1

