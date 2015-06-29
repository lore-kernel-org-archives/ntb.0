Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id eo3si411905wib.0.2015.06.29.07.50.32
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 07:50:32 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 4/9] NTB: ntb_netdev not covering all receive errors
Date: Mon, 29 Jun 2015 10:50:00 -0400
Message-Id: <b102ae0f0209cfcd03f90b554857ce76d054ce5a.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Dave Jiang <mailto>, dave.jiang@intel.com, 
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <mailto:dave.jiang@intel.com>

ntb_netdev is allowing the link to come up even when -ENOMEM is returned
from ntb_transport_rx_enqueue.  Fix to cover all possible errors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 7a0aeac00c24..4d4d4f19049d 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -257,7 +257,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 
 		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
 					      ndev->mtu + ETH_HLEN);
-		if (rc == -EINVAL) {
+		if (rc) {
 			dev_kfree_skb(skb);
 			goto err;
 		}
-- 
2.4.0.rc0.43.gcf8a8c6

