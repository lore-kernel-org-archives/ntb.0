Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id d20si264519oti.1.2020.11.11.07.37.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:37:55 -0800 (PST)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v8 12/18] PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
Date: Wed, 11 Nov 2020 21:05:53 +0530
Message-ID: <20201111153559.19050-13-kishon@ti.com>
In-Reply-To: <20201111153559.19050-1-kishon@ti.com>
References: <20201111153559.19050-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The number of functions supported by the endpoint controller is
configured in LM_EP_FUNC_CFG based on func_no member of struct pci_epf.
Now that an endpoint function can be associated with two endpoint
controllers (primary and secondary), just using func_no will
not suffice as that will take into account only if the endpoint
controller is associated with the primary interface of endpoint
function. Instead use epc->function_num_map which will already have the
configured functions information (irrespective of whether the endpoint
controller is associated with primary or secondary interface).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1fe6b8baca97..4e4eb30cd1a2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -506,18 +506,13 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
-	struct pci_epf *epf;
-	u32 cfg;
 	int ret;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cfg = BIT(0);
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		cfg |= BIT(epf->func_no);
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
-- 
2.17.1

