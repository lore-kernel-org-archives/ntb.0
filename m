Return-Path: <kishon@ti.com>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com. [198.47.23.248])
        by gmr-mx.google.com with ESMTPS id e17si788820pjp.3.2020.05.14.08.01.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:01:51 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 14/19] PCI: cadence: Implement ->msi_map_irq() ops
Date: Thu, 14 May 2020 20:29:22 +0530
Message-ID: <20200514145927.17555-15-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

Implement ->msi_map_irq() ops in order to map physical address to
MSI address and return MSI data.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 50 +++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  7 ++-
 include/linux/pci-epc.h                       |  2 +-
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e6588a0cd705..74d36fb9ea5d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -380,6 +380,54 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
+static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
+				    phys_addr_t addr, u8 interrupt_num,
+				    u32 entry_size, u32 *msi_data)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	struct cdns_pcie *pcie = &ep->pcie;
+	u16 flags, mme, data, data_mask;
+	u8 msi_count;
+	u64 pci_addr;
+	int ret;
+	int i;
+
+	/* Check whether the MSI feature has been enabled by the PCI host. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	if (!(flags & PCI_MSI_FLAGS_ENABLE))
+		return -EINVAL;
+
+	/* Get the number of enabled MSIs */
+	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+	msi_count = 1 << mme;
+	if (!interrupt_num || interrupt_num > msi_count)
+		return -EINVAL;
+
+	/* Compute the data value to be written. */
+	data_mask = msi_count - 1;
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
+	data = data & ~data_mask;
+
+	/* Get the PCI address where to write the data into. */
+	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
+	pci_addr <<= 32;
+	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
+	pci_addr &= GENMASK_ULL(63, 2);
+
+	for (i = 0; i < interrupt_num; i++) {
+		ret = cdns_pcie_ep_map_addr(epc, fn, addr, pci_addr,
+					    entry_size);
+		if (ret)
+			return ret;
+		addr = addr + entry_size;
+	}
+
+	*msi_data = data;
+
+	return 0;
+}
+
 static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
 				      u16 interrupt_num)
 {
@@ -480,6 +528,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
+	.align = 256,
 };
 
 static const struct pci_epc_features*
@@ -499,6 +548,7 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.set_msix	= cdns_pcie_ep_set_msix,
 	.get_msix	= cdns_pcie_ep_get_msix,
 	.raise_irq	= cdns_pcie_ep_raise_irq,
+	.map_msi_irq	= cdns_pcie_ep_map_msi_irq,
 	.start		= cdns_pcie_ep_start,
 	.get_features	= cdns_pcie_ep_get_features,
 };
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3f481a12d43d..ab5da996953e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -319,7 +319,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  *                         MSI data
  * @epc: the EPC device which has the MSI capability
  * @func_no: the physical endpoint function number in the EPC device
- * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: the physical address of the outbound region
  * @interrupt_num: the MSI interrupt number
  * @entry_size: Size of Outbound address region for each interrupt
@@ -333,7 +332,7 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  * physical address (in outbound region) of the other interface to ring
  * doorbell.
  */
-int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr, u8 interrupt_num, u32 entry_size,
 			u32 *msi_data)
 {
@@ -346,8 +345,8 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return -EINVAL;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->map_msi_irq(epc, func_no, vfunc_no, phys_addr,
-				    interrupt_num, entry_size, msi_data);
+	ret = epc->ops->map_msi_irq(epc, func_no, phys_addr, interrupt_num,
+				    entry_size, msi_data);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 59cd4c967329..bb00f107c0dc 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -78,7 +78,7 @@ struct pci_epc_ops {
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
-	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no,
 			       phys_addr_t phys_addr, u8 interrupt_num,
 			       u32 entry_size, u32 *msi_data);
 	int	(*start)(struct pci_epc *epc);
-- 
2.17.1

