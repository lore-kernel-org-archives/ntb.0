Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id e17si788439pjp.3.2020.05.14.08.01.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:01:16 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/19] PCI: endpoint: Make pci_epf_driver ops optional
Date: Thu, 14 May 2020 20:29:18 +0530
Message-ID: <20200514145927.17555-11-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
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
index f9ba2e8d4a99..f463eedcc3ad 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -201,11 +201,9 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
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

