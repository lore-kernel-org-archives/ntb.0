Return-Path: <tremyfr@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com. [2a00:1450:400c:c0c::241])
        by gmr-mx.google.com with ESMTPS id f7si15482wmg.3.2017.03.09.14.10.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 14:10:20 -0800 (PST)
Received: by mail-wr0-x241.google.com with SMTP id u48so9571287wrc.1
        for <linux-ntb@googlegroups.com>; Thu, 09 Mar 2017 14:10:20 -0800 (PST)
Return-Path: <tremyfr@gmail.com>
From: Philippe Reynes <tremyfr@gmail.com>
Subject: [PATCH] net: net_netdev: use new api ethtool_{get|set}_link_ksettings
Date: Thu,  9 Mar 2017 23:10:13 +0100
Message-Id: <1489097413-4202-1-git-send-email-tremyfr@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, davem@davemloft.net
Cc: linux-ntb@googlegroups.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Reynes <tremyfr@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The ethtool api {get|set}_settings is deprecated.
We move this driver to new api {get|set}_link_ksettings.

As I don't have the hardware, I'd be very pleased if
someone may test this patch.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/net/ntb_netdev.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 36877ba..4daf3d0 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -372,18 +372,19 @@ static void ntb_get_drvinfo(struct net_device *ndev,
 	strlcpy(info->bus_info, pci_name(dev->pdev), sizeof(info->bus_info));
 }
 
-static int ntb_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int ntb_get_link_ksettings(struct net_device *dev,
+				  struct ethtool_link_ksettings *cmd)
 {
-	cmd->supported = SUPPORTED_Backplane;
-	cmd->advertising = ADVERTISED_Backplane;
-	ethtool_cmd_speed_set(cmd, SPEED_UNKNOWN);
-	cmd->duplex = DUPLEX_FULL;
-	cmd->port = PORT_OTHER;
-	cmd->phy_address = 0;
-	cmd->transceiver = XCVR_DUMMY1;
-	cmd->autoneg = AUTONEG_ENABLE;
-	cmd->maxtxpkt = 0;
-	cmd->maxrxpkt = 0;
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Backplane);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, Backplane);
+
+	cmd->base.speed = SPEED_UNKNOWN;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_OTHER;
+	cmd->base.phy_address = 0;
+	cmd->base.autoneg = AUTONEG_ENABLE;
 
 	return 0;
 }
@@ -391,7 +392,7 @@ static int ntb_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 static const struct ethtool_ops ntb_ethtool_ops = {
 	.get_drvinfo = ntb_get_drvinfo,
 	.get_link = ethtool_op_get_link,
-	.get_settings = ntb_get_settings,
+	.get_link_ksettings = ntb_get_link_ksettings,
 };
 
 static const struct ntb_queue_handlers ntb_netdev_handlers = {
-- 
1.7.4.4

