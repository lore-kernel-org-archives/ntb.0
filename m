Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id s14si296525ybc.2.2020.05.14.08.00.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:00:15 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/19] PCI: endpoint: Add API to create EPF device from device tree
Date: Thu, 14 May 2020 20:29:12 +0530
Message-ID: <20200514145927.17555-5-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

Add API to create EPF device from device tree and the device managed
interface corresponding to it. This is added in order to define
an endpoint function completely from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 68 +++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 74 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 244e00f48c5c..cb6c7b886325 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -280,6 +280,73 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_of_create() - create a new PCI EPF device from device tree node
+ * @node: the device node of the PCI EPF device.
+ *
+ * Invoke to create a new PCI EPF device by providing a device tree node
+ * with compatible property.
+ */
+struct pci_epf *pci_epf_of_create(struct device_node *node)
+{
+	struct pci_epf *epf;
+	const char *compat;
+	int ret;
+
+	of_node_get(node);
+
+	ret = of_property_read_string(node, "compatible", &compat);
+	if (ret) {
+		of_node_put(node);
+		return ERR_PTR(ret);
+	}
+
+	epf = pci_epf_create(compat);
+	if (!IS_ERR(epf))
+		epf->node = node;
+
+	return epf;
+}
+EXPORT_SYMBOL_GPL(pci_epf_of_create);
+
+static void devm_epf_release(struct device *dev, void *res)
+{
+	struct pci_epf *epf = *(struct pci_epf **)res;
+
+	pci_epf_destroy(epf);
+}
+
+/**
+ * devm_pci_epf_of_create() - create a new PCI EPF device from device tree node
+ * @dev: device that is creating the new EPF
+ * @node: the device node of the PCI EPF device.
+ *
+ * Invoke to create a new PCI EPF device by providing a device tree node with
+ * compatible property. While at that, it also associates the device with the
+ * EPF using devres. On driver detach, release function is invoked on the devres
+ * data, where devres data is freed.
+ */
+struct pci_epf *devm_pci_epf_of_create(struct device *dev,
+				       struct device_node *node)
+{
+	struct pci_epf **ptr, *epf;
+
+	ptr = devres_alloc(devm_epf_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	epf = pci_epf_of_create(node);
+	if (!IS_ERR(epf)) {
+		*ptr = epf;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return epf;
+}
+EXPORT_SYMBOL_GPL(devm_pci_epf_of_create);
+
 const struct pci_epf_device_id *
 pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
 {
@@ -300,6 +367,7 @@ static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
 
+	of_node_put(epf->node);
 	kfree(epf->name);
 	kfree(epf);
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6644ff3b0702..8fb77ab1968f 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -108,6 +109,7 @@ struct pci_epf_bar {
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
+ * @node: the device tree node of the PCI EPF device
  * @name: the name of the PCI EPF device
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
@@ -121,6 +123,7 @@ struct pci_epf_bar {
  */
 struct pci_epf {
 	struct device		dev;
+	struct device_node	*node;
 	const char		*name;
 	struct pci_epf_header	*header;
 	struct pci_epf_bar	bar[6];
@@ -167,6 +170,9 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 const struct pci_epf_device_id *
 pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf);
 struct pci_epf *pci_epf_create(const char *name);
+struct pci_epf *pci_epf_of_create(struct device_node *node);
+struct pci_epf *devm_pci_epf_of_create(struct device *dev,
+				       struct device_node *node);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
-- 
2.17.1

