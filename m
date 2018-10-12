Return-Path: <asierra@xes-inc.com>
Received: from mail.xes-mad.com (xes-mad.com. [162.248.234.2])
        by gmr-mx.google.com with ESMTP id c188-v6si169830ite.0.2018.10.12.13.20.18
        for <linux-ntb@googlegroups.com>;
        Fri, 12 Oct 2018 13:20:18 -0700 (PDT)
From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 1/2] NTB: transport: Support client device private data
Date: Fri, 12 Oct 2018 15:20:17 -0500
Message-Id: <1539375618-6782-2-git-send-email-asierra@xes-inc.com>
In-Reply-To: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

Support NTB transport client device drivers stashing a reference to
their private device representation within the transport client device
for trivial lookup. This capability is provided by most other busses
(PCI, platform, VME, etc.).

This patch introduces two new exported functions:

  void ntb_transport_client_set_pdata(struct device *dev, void *pdata);
  void *ntb_transport_client_get_pdata(struct device *dev);

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/ntb/ntb_transport.c   | 19 +++++++++++++++++++
 include/linux/ntb_transport.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9398959..812efd4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -202,6 +202,9 @@ struct ntb_transport_client_dev {
 	struct list_head entry;
 	struct ntb_transport_ctx *nt;
 	struct device dev;
+
+	/* client private data */
+	void *private_data;
 };
 
 struct ntb_transport_ctx {
@@ -410,6 +413,22 @@ int ntb_transport_register_client_dev(char *device_name)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_register_client_dev);
 
+void ntb_transport_client_set_pdata(struct device *dev, void *pdata)
+{
+	struct ntb_transport_client_dev *client_dev = dev_client_dev(dev);
+
+	client_dev->private_data = pdata;
+}
+EXPORT_SYMBOL_GPL(ntb_transport_client_set_pdata);
+
+void *ntb_transport_client_get_pdata(struct device *dev)
+{
+	struct ntb_transport_client_dev *client_dev = dev_client_dev(dev);
+
+	return client_dev->private_data;
+}
+EXPORT_SYMBOL_GPL(ntb_transport_client_get_pdata);
+
 /**
  * ntb_transport_register_client - Register NTB client driver
  * @drv: NTB client driver to be registered
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb9..16c2a73 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -60,6 +60,8 @@ int ntb_transport_register_client(struct ntb_transport_client *drvr);
 void ntb_transport_unregister_client(struct ntb_transport_client *drvr);
 int ntb_transport_register_client_dev(char *device_name);
 void ntb_transport_unregister_client_dev(char *device_name);
+void ntb_transport_client_set_pdata(struct device *dev, void *pdata);
+void *ntb_transport_client_get_pdata(struct device *dev);
 
 struct ntb_queue_handlers {
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-- 
2.7.4

