Return-Path: <kishon@ti.com>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com. [198.47.23.249])
        by gmr-mx.google.com with ESMTPS id m186si69147pga.4.2019.09.26.04.30.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:30:47 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 02/21] dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Device
Date: Thu, 26 Sep 2019 16:59:14 +0530
Message-ID: <20190926112933.8922-3-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Add device tree bindings for PCI endpoint function device. The
nodes for PCI endpoint function device should be attached to
PCI endpoint function bus.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/endpoint/pci-epf.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt

diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
new file mode 100644
index 000000000000..f006395fd526
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
@@ -0,0 +1,28 @@
+PCI Endpoint Function Device
+
+This describes the generic bindings to be used when a device has to be
+exposed to the remote host over PCIe. The device could be an actual
+peripheral in the platform or a virtual device created by the software.
+
+epcs : phandle to the endpoint controller device
+epc-names : the names of the endpoint controller device corresponding
+	    to the EPCs present in the *epcs* phandle
+vendor-id: used to identify device manufacturer
+device-id: used to identify a particular device
+baseclass-code: used to classify the type of function the device performs
+subclass-code: used to identify more specifically the function of the device
+subsys-vendor-id: used to identify vendor of the add-in card or subsystem
+subsys-id: used to specify an id that is specific to a vendor
+
+Example:
+Following is an example of NTB device exposed to the remote host.
+
+ntb {
+	compatible = "pci-epf-ntb";
+	epcs = <&pcie0_ep>, <&pcie1_ep>;
+	epc-names = "primary", "secondary";
+	vendor-id = /bits/ 16 <0x104c>;
+	device-id = /bits/ 16 <0xb00d>;
+	num-mws = <4>;
+	mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
+};
-- 
2.17.1

