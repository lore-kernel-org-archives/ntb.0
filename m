Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id fj7si391492wib.3.2015.07.13.10.07.38
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:38 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 09/14] NTB: Add flow control to the ntb_netdev
Date: Mon, 13 Jul 2015 08:07:17 -0400
Message-Id: <015b0d41a835e9dcaea9f18ff3c6aa822cb49c64.1436788771.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788771.git.Allen.Hubbe@emc.com>
References: <cover.1436788771.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Right now if we push the NTB really hard, we start dropping packets due
to not able to process the packets fast enough. We need to st:qop the
upper layer from flooding us when that happens.

A timer is necessary in order to restart the queue once the resource has
been processed on the receive side. Due to the way NTB is setup, the
resources on the tx side are tied to the processing of the rx side and
there's no async way to know when the rx side has released those
resources.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ntb_netdev.c      | 77 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c   | 18 +++++++++-
 include/linux/ntb_transport.h |  1 +
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index d8757bf9ad75..a9acf7156855 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -61,11 +61,21 @@ MODULE_VERSION(NTB_NETDEV_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
+/* Time in usecs for tx resource reaper */
+static unsigned int tx_time = 1;
+
+/* Number of descriptors to free before resuming tx */
+static unsigned int tx_start = 10;
+
+/* Number of descriptors still available before stop upper layer tx */
+static unsigned int tx_stop = 5;
+
 struct ntb_netdev {
 	struct list_head list;
 	struct pci_dev *pdev;
 	struct net_device *ndev;
 	struct ntb_transport_qp *qp;
+	struct timer_list tx_timer;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -136,11 +146,42 @@ enqueue_again:
 	}
 }
 
+static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
+				      struct ntb_transport_qp *qp, int size)
+{
+	struct ntb_netdev *dev = netdev_priv(netdev);
+
+	netif_stop_queue(netdev);
+	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
+	 * since the queue was last started.
+	 */
+	smp_mb();
+
+	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
+		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+		return -EBUSY;
+	}
+
+	netif_start_queue(netdev);
+	return 0;
+}
+
+static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
+				    struct ntb_transport_qp *qp, int size)
+{
+	if (netif_queue_stopped(ndev) ||
+	    (ntb_transport_tx_free_entry(qp) >= size))
+		return 0;
+
+	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+}
+
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
 	struct sk_buff *skb;
+	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -155,6 +196,15 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 	dev_kfree_skb(skb);
+
+	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+		/* Make sure anybody stopping the queue after this sees the new
+		 * value of ntb_transport_tx_free_entry()
+		 */
+		smp_mb();
+		if (netif_queue_stopped(ndev))
+			netif_wake_queue(ndev);
+	}
 }
 
 static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
@@ -163,10 +213,15 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	int rc;
 
+	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+
 	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
+	/* check for next submit */
+	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+
 	return NETDEV_TX_OK;
 
 err:
@@ -175,6 +230,23 @@ err:
 	return NETDEV_TX_BUSY;
 }
 
+static void ntb_netdev_tx_timer(unsigned long data)
+{
+	struct net_device *ndev = (struct net_device *)data;
+	struct ntb_netdev *dev = netdev_priv(ndev);
+
+	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
+		mod_timer(&dev->tx_timer, jiffies + msecs_to_jiffies(tx_time));
+	} else {
+		/* Make sure anybody stopping the queue after this sees the new
+		 * value of ntb_transport_tx_free_entry()
+		 */
+		smp_mb();
+		if (netif_queue_stopped(ndev))
+			netif_wake_queue(ndev);
+	}
+}
+
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
@@ -197,8 +269,11 @@ static int ntb_netdev_open(struct net_device *ndev)
 		}
 	}
 
+	setup_timer(&dev->tx_timer, ntb_netdev_tx_timer, (unsigned long)ndev);
+
 	netif_carrier_off(ndev);
 	ntb_transport_link_up(dev->qp);
+	netif_start_queue(ndev);
 
 	return 0;
 
@@ -219,6 +294,8 @@ static int ntb_netdev_close(struct net_device *ndev)
 	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
 		dev_kfree_skb(skb);
 
+	del_timer_sync(&dev->tx_timer);
+
 	return 0;
 }
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3363a8968f9d..8c9d50d50e92 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -494,6 +494,12 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 			       "tx_index - \t%u\n", qp->tx_index);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "qp->remote_rx_info->entry - \t%u\n",
+			       qp->remote_rx_info->entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "free tx - \t%u\n",
+			       ntb_transport_tx_free_entry(qp));
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "\nQP Link %s\n",
@@ -535,6 +541,7 @@ static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
 	}
 	entry = list_first_entry(list, struct ntb_queue_entry, entry);
 	list_del(&entry->entry);
+
 out:
 	spin_unlock_irqrestore(lock, flags);
 
@@ -1843,7 +1850,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;
-		return -ENOMEM;
+		return -EBUSY;
 	}
 
 	entry->cb_data = cb;
@@ -1969,6 +1976,15 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
+unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+}
+EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
+
 static void ntb_transport_doorbell_callback(void *data, int vector)
 {
 	struct ntb_transport_ctx *nt = data;
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 2862861366a5..7243eb98a722 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -83,3 +83,4 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
 void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
+unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp);
-- 
2.5.0.rc1

