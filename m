Return-Path: <kishon@ti.com>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com. [198.47.23.249])
        by gmr-mx.google.com with ESMTPS id n23si331900qtv.0.2020.05.14.08.00.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:00:11 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/19] PCI: endpoint: Add API to get reference to EPC from device-tree
Date: Thu, 14 May 2020 20:29:11 +0530
Message-ID: <20200514145927.17555-4-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

Add of_pci_epc_get() and of_pci_epc_get_by_name() to get reference
to EPC from device-tree. This is added in preparation to define
an endpoint function device in device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 61 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  3 ++
 2 files changed, 64 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 82ba0dc7f2f5..177a3fc1a0dd 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,66 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * of_pci_epc_get() - get PCI endpoint controller from device node and index
+ * @node: device node which contains the phandle to endpoint controller
+ * @index: index of the endpoint controller in "epcs" property
+ *
+ * Returns the EPC corresponding to the _index_ entry in "epcs" property
+ * present in device node, after getting a refcount  to it or -ENODEV if
+ * there is no such EPC or -EPROBE_DEFER if there is a phandle to the phy,
+ * but the device is not yet loaded.
+ */
+struct pci_epc *of_pci_epc_get(struct device_node *node, int index)
+{
+	struct device_node *epc_node;
+	struct class_dev_iter iter;
+	struct pci_epc *epc;
+	struct device *dev;
+
+	epc_node = of_parse_phandle(node, "epcs", index);
+	if (!epc_node)
+		return ERR_PTR(-ENODEV);
+
+	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		epc = to_pci_epc(dev);
+		if (epc_node != epc->dev.of_node)
+			continue;
+
+		of_node_put(epc_node);
+		class_dev_iter_exit(&iter);
+		get_device(&epc->dev);
+		return epc;
+	}
+
+	of_node_put(epc_node);
+	class_dev_iter_exit(&iter);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(of_pci_epc_get);
+
+/**
+ * of_pci_epc_get_by_name() - get PCI endpoint controller from device node
+ *                            and string
+ * @node: device node which contains the phandle to endpoint controller
+ * @epc_name: name of endpoint controller as present in "epc-names" property
+ *
+ * Returns the EPC corresponding to the epc_name in "epc-names" property
+ * present in device node.
+ */
+struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
+				       const char *epc_name)
+{
+	int index = 0;
+
+	if (epc_name)
+		index = of_property_match_string(node, "epc-names", epc_name);
+
+	return of_pci_epc_get(node, index);
+}
+EXPORT_SYMBOL_GPL(of_pci_epc_get_by_name);
+
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
  * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
@@ -629,6 +689,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
 	epc->dev.parent = dev;
+	epc->dev.of_node = dev->of_node;
 	epc->ops = ops;
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index cc66bec8be90..dd3c2d566c3d 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -211,6 +211,9 @@ int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 int pci_epc_multi_mem_init(struct pci_epc *epc,
 			   struct pci_epc_mem_window *window,
 			   unsigned int num_windows);
+struct pci_epc *of_pci_epc_get(struct device_node *node, int index);
+struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
+				       const char *epc_name);
 void pci_epc_mem_exit(struct pci_epc *epc);
 void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
-- 
2.17.1

