Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id c6si102997pls.5.2019.09.26.04.31.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:31:41 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 15/21] PCI: endpoint: Remove unused pci_epf_match_device()
Date: Thu, 26 Sep 2019 16:59:27 +0530
Message-ID: <20190926112933.8922-16-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Remove unused pci_epf_match_device() function added in pci-epf-core.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 16 ----------------
 include/linux/pci-epf.h             |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 388966faf17a..9fa4d8d4d829 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -619,22 +619,6 @@ struct pci_epf *devm_pci_epf_of_create(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_epf_of_create);
 
-const struct pci_epf_device_id *
-pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
-{
-	if (!id || !epf)
-		return NULL;
-
-	while (*id->name) {
-		if (strcmp(epf->name, id->name) == 0)
-			return id;
-		id++;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(pci_epf_match_device);
-
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index b5075119f3ad..80505106c770 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -189,8 +189,6 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
-const struct pci_epf_device_id *
-pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf);
 struct pci_epf *pci_epf_create(const char *name);
 struct pci_epf *pci_epf_of_create(struct device_node *node);
 struct pci_epf *devm_pci_epf_of_create(struct device *dev,
-- 
2.17.1

