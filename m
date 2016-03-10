Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com. [2607:f8b0:400e:c03::22f])
        by gmr-mx.google.com with ESMTPS id y20si435537pfa.2.2016.03.10.04.21.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2016 04:21:25 -0800 (PST)
Received: by mail-pa0-x22f.google.com with SMTP id td3so39391690pab.2
        for <linux-ntb@googlegroups.com>; Thu, 10 Mar 2016 04:21:25 -0800 (PST)
Return-Path: <sudipm.mukherjee@gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ntb: fix possible NULL dereference
Date: Thu, 10 Mar 2016 17:51:11 +0530
Message-Id: <1457612471-26128-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

kmalloc can fail and we should check for NULL before using the pointer
returned by kmalloc.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/ntb/test/ntb_perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index c8a37ba..b21e647 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -541,6 +541,8 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
 		return 0;
 
 	buf = kmalloc(64, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 	out_offset = snprintf(buf, 64, "%d\n", perf->run);
 	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
 	kfree(buf);
-- 
1.9.1

