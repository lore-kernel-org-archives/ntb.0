Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 16si649540ith.5.2017.06.05.13.01.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 13:01:01 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  5 Jun 2017 14:00:51 -0600
Message-Id: <20170605200053.6912-1-logang@deltatee.com>
Subject: [PATCH] ntb_netdev: set the net_device's parent
To: linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

At present, ntb_netdev devices end up under /sys/devices/virtual/net
completely unconnected to the ntb trees below them. This patch sets the
parent of the net_device (using SET_NETDEV_DEV) to the client_dev
device. This results in a better connected sysfs path for the network
device:

/sys/devices/pci0000:00/0000:00:03.0/0000:03:00.1/0000:03:00.1/ntb_netdev0/net/eth2

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/net/ntb_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 4daf3d0926a8..0250aa9ae2cb 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -418,6 +418,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!ndev)
 		return -ENOMEM;
 
+	SET_NETDEV_DEV(ndev, client_dev);
+
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
-- 
2.11.0

