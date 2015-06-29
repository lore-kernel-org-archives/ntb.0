Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id gt9si413777wib.2.2015.06.29.07.50.32
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 07:50:33 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 5/9] NTB: Fix oops in debugfs when transport is half-up
Date: Mon, 29 Jun 2015 10:50:01 -0400
Message-Id: <dc46fafa9893ffa92dad1a95fda17627dfff8c8a.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
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
index 30d8b52421ec..1764bb2fd265 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -438,13 +438,17 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
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

