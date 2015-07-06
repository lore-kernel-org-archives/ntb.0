Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id bk2si998680wib.1.2015.07.06.08.31.16
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:17 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 05/12] NTB: Fix oops in debugfs when transport is half-up
Date: Mon,  6 Jul 2015 11:30:28 -0400
Message-Id: <d22aba26baf68a4cf037da29fe952701cba4e67c.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
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
index 7e2de6764b9f..73bb58bbcaec 100644
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
2.4.0.rc0.43.gcf8a8c6

