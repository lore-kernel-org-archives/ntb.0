Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id c78si63409qkb.7.2019.09.26.04.31.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:31:48 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 16/21] PCI: endpoint: Fix missing mutex_unlock in error case
Date: Thu, 26 Sep 2019 16:59:28 +0530
Message-ID: <20190926112933.8922-17-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

There is a missing mutex_unlock() in pci_epc_add_epf() in one of the
error scenarios. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 797e5d323998..33c745546a42 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -686,6 +686,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 {
 	struct list_head *list;
 	u32 func_no = 0;
+	int ret = 0;
 
 	if (epf->is_vf)
 		return -EINVAL;
@@ -705,8 +706,10 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	mutex_lock(&epc->lock);
 	func_no = find_first_zero_bit(&epc->function_num_map,
 				      BITS_PER_LONG);
-	if (func_no >= BITS_PER_LONG)
-		return -EINVAL;
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	set_bit(func_no, &epc->function_num_map);
 	if (type == PRIMARY_INTERFACE) {
@@ -720,9 +723,11 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	}
 
 	list_add_tail(list, &epc->pci_epf);
+
+err:
 	mutex_unlock(&epc->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
-- 
2.17.1

