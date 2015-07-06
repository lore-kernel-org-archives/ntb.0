Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id c123si546041ywb.3.2015.07.06.08.31.17
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:17 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 04/12] NTB: ntb_netdev not covering all receive errors
Date: Mon,  6 Jul 2015 11:30:27 -0400
Message-Id: <e71ab00f6f36d0986e57e0757ce139200d93107a.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
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
index 84d094df1a63..e7072e544567 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -266,7 +266,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 
 		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
 					      ndev->mtu + ETH_HLEN);
-		if (rc == -EINVAL) {
+		if (rc) {
 			dev_kfree_skb(skb);
 			goto err;
 		}
-- 
2.4.0.rc0.43.gcf8a8c6

