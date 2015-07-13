Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id fj7si391502wib.3.2015.07.13.10.07.42
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:43 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 4/7] NTB: Fix oops in debugfs when transport is half-up
Date: Mon, 13 Jul 2015 08:07:11 -0400
Message-Id: <99736d1cff7857b7a2a44dca81d9d6ec2a5a0c6c.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

When the remote side is not up, we do not have all the context for the
transport, and that causes NULL ptr access. Have the debugfs reads check
to see if transport is up before we make access.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 25e973ff64cf..a049f96fab8d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -439,13 +439,17 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	char *buf;
 	ssize_t ret, out_offset, out_count;
 
+	qp = filp->private_data;
+
+	if (!qp || !qp->link_is_up)
+		return 0;
+
 	out_count = 1000;
 
 	buf = kmalloc(out_count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	qp = filp->private_data;
 	out_offset = 0;
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "NTB QP stats\n");
-- 
2.5.0.rc1

