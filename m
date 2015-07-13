Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id v8si336961wiw.1.2015.07.13.10.07.34
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:34 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 3/7] NTB: ntb_netdev not covering all receive errors
Date: Mon, 13 Jul 2015 08:07:10 -0400
Message-Id: <7133e6e0174d24bd29cb75c513a1adac5f6ad899.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

ntb_netdev is allowing the link to come up even when -ENOMEM is returned
from ntb_transport_rx_enqueue.  Fix to cover all possible errors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 5f1ee7c05f68..d8757bf9ad75 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -191,7 +191,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 
 		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
 					      ndev->mtu + ETH_HLEN);
-		if (rc == -EINVAL) {
+		if (rc) {
 			dev_kfree_skb(skb);
 			goto err;
 		}
-- 
2.5.0.rc1

