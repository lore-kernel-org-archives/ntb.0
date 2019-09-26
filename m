Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id x2si81709pfq.3.2019.09.26.04.31.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:31:04 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 06/21] PCI: endpoint: Add API to create EPF device from device tree
Date: Thu, 26 Sep 2019 16:59:18 +0530
Message-ID: <20190926112933.8922-7-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
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
index 16feff8cad50..c74c7cc6d8bd 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -529,6 +529,73 @@ struct pci_epf *pci_epf_create(const char *name)
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
@@ -549,6 +616,7 @@ static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
 
+	of_node_put(epf->node);
 	kfree(epf->name);
 	kfree(epf);
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 02090eb41563..7e997fb656fb 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -101,6 +102,7 @@ struct pci_epf_bar {
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
+ * @node: the device tree node of the PCI EPF device
  * @name: the name of the PCI EPF device
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
@@ -125,6 +127,7 @@ struct pci_epf_bar {
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

