Return-Path: <asierra@xes-inc.com>
Received: from mail.xes-mad.com (xes-mad.com. [162.248.234.2])
        by gmr-mx.google.com with ESMTP id n124-v6si1109115itb.0.2018.10.12.13.20.18
        for <linux-ntb@googlegroups.com>;
        Fri, 12 Oct 2018 13:20:18 -0700 (PDT)
From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 2/2] ntb_netdev: Simplify remove with client private data
Date: Fri, 12 Oct 2018 15:20:18 -0500
Message-Id: <1539375618-6782-3-git-send-email-asierra@xes-inc.com>
In-Reply-To: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

Replace the elaborate private structure global linked-list used in
ntb_netdev_probe() and ntb_netdev_remove() by using the new private
data stashing mechanism available to NTB transport client devices.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/net/ntb_netdev.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index b12023b..1e76f7c 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -71,7 +71,6 @@ static unsigned int tx_start = 10;
 static unsigned int tx_stop = 5;
 
 struct ntb_netdev {
-	struct list_head list;
 	struct pci_dev *pdev;
 	struct net_device *ndev;
 	struct ntb_transport_qp *qp;
@@ -81,8 +80,6 @@ struct ntb_netdev {
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
-static LIST_HEAD(dev_list);
-
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
 	struct net_device *ndev = data;
@@ -452,7 +449,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (rc)
 		goto err1;
 
-	list_add(&dev->list, &dev_list);
+	ntb_transport_client_set_pdata(client_dev, ndev);
 	dev_info(&pdev->dev, "%s created\n", ndev->name);
 	return 0;
 
@@ -465,27 +462,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 static void ntb_netdev_remove(struct device *client_dev)
 {
-	struct ntb_dev *ntb;
-	struct net_device *ndev;
-	struct pci_dev *pdev;
-	struct ntb_netdev *dev;
-	bool found = false;
-
-	ntb = dev_ntb(client_dev->parent);
-	pdev = ntb->pdev;
-
-	list_for_each_entry(dev, &dev_list, list) {
-		if (dev->pdev == pdev) {
-			found = true;
-			break;
-		}
-	}
-	if (!found)
-		return;
-
-	list_del(&dev->list);
-
-	ndev = dev->ndev;
+	struct net_device *ndev = ntb_transport_client_get_pdata(client_dev);
+	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
 	ntb_transport_free_queue(dev->qp);
-- 
2.7.4

