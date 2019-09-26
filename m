Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id i13si147653uan.1.2019.09.26.04.31.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:31:24 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 11/21] PCI: endpoint: Add helper API to populate header with values from DT
Date: Thu, 26 Sep 2019 16:59:23 +0530
Message-ID: <20190926112933.8922-12-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Add helper API pci_epc_of_parse_header() to populate header with
values from device tree. These values will be written to the
configuration space header in the endpoint controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 49bdff217777..98acadbfc934 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -31,6 +31,29 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
 	return *epc == match_data;
 }
 
+/**
+ * pci_epc_of_parse_header() - parse the device tree to get PCI config space
+ *                             header
+ * @node: The device tree node (of endpoint function) which has the PCI config
+ *        space header values
+ * @header: standard configuration space header fields that has to be populated
+ *
+ * Invoke to populate *header* with the PCI configuration space values populated
+ * in device tree.
+ */
+void pci_epc_of_parse_header(struct device_node *node,
+			     struct pci_epf_header *header)
+{
+	of_property_read_u16(node, "vendor-id", &header->vendorid);
+	of_property_read_u16(node, "device-id", &header->deviceid);
+	of_property_read_u8(node, "baseclass-code", &header->baseclass_code);
+	of_property_read_u8(node, "subclass-code", &header->subclass_code);
+	of_property_read_u16(node, "subsys-vendor-id",
+			     &header->subsys_vendor_id);
+	of_property_read_u16(node, "subsys-id", &header->subsys_id);
+}
+EXPORT_SYMBOL_GPL(pci_epc_of_parse_header);
+
 /**
  * pci_epc_put() - release the PCI endpoint controller
  * @epc: epc returned by pci_epc_get()
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 993b1a55a239..18fff589a881 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -196,6 +196,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+void pci_epc_of_parse_header(struct device_node *node,
+			     struct pci_epf_header *header);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
 unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
-- 
2.17.1

