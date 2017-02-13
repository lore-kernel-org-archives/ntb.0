Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com. [216.165.139.218])
        by gmr-mx.google.com with ESMTPS id f73si899019ita.1.2017.02.13.14.46.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 14:46:29 -0800 (PST)
Date: Mon, 13 Feb 2017 16:46:26 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <742181292.969165.1487025986540.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH] ntb_transport: Pick an unused queue
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Thomas Vanselus <tvanselus@xes-inc.com>
List-ID: <linux-ntb.googlegroups.com>

From: Thomas VanSelus <tvanselus@xes-inc.com>

Fix typo causing ntb_transport_create_queue to select the first
queue every time, instead of using the next free queue.

Signed-off-by: Thomas VanSelus <tvanselus@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f81aa4b..95b5540 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1802,7 +1802,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 	node = dev_to_node(&ndev->dev);
 
-	free_queue = ffs(nt->qp_bitmap);
+	free_queue = ffs(nt->qp_bitmap_free);
 	if (!free_queue)
 		goto err;
 
-- 
2.7.4
