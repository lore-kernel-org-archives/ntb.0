Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id d8si65966pjv.1.2019.09.26.04.31.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:31:20 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 10/21] PCI: endpoint: Make pci_epf_driver ops optional
Date: Thu, 26 Sep 2019 16:59:22 +0530
Message-ID: <20190926112933.8922-11-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

pci_epf_driver had two ops for bind and unbind which will be invoked
when an endpoint controller is bound to an endpoint function (using
configfs). Now that endpoint core has support to define an endpoint
function using device tree alone, the bind and unbind ops can be
optional. Make pci_epf_driver ops optional here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index c74c7cc6d8bd..67015c66d09f 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -446,11 +446,9 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 {
 	int ret;
 
-	if (!driver->ops)
-		return -EINVAL;
-
-	if (!driver->ops->bind || !driver->ops->unbind)
-		return -EINVAL;
+	if (!driver->ops || !driver->ops->bind || !driver->ops->unbind)
+		pr_debug("%s: Supports only pci_epf device created using DT\n",
+			 driver->driver.name);
 
 	driver->driver.bus = &pci_epf_bus_type;
 	driver->driver.owner = owner;
-- 
2.17.1

