Return-Path: <kishon@ti.com>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com. [198.47.23.249])
        by gmr-mx.google.com with ESMTPS id o6si267528ilo.4.2020.05.14.08.01.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:01:16 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 13/19] PCI: endpoint: Add pci_epc_ops to map MSI irq
Date: Thu, 14 May 2020 20:29:21 +0530
Message-ID: <20200514145927.17555-14-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

Add pci_epc_ops to map physical address to MSI address and return MSI
data. The physical address is an address in the outbound region. This is
required to implement doorbell functionality of NTB (non transparent
bridge) wherein EPC on either side of the interface (primary and
secondary) can directly write to the physical address (in outbound
region) of the other interface to ring doorbell using MSI.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 40 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  7 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bd8f372c506f..3f481a12d43d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -314,6 +314,46 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
 
+/**
+ * pci_epc_map_msi_irq() - Map physical address to MSI address and return
+ *                         MSI data
+ * @epc: the EPC device which has the MSI capability
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @phys_addr: the physical address of the outbound region
+ * @interrupt_num: the MSI interrupt number
+ * @entry_size: Size of Outbound address region for each interrupt
+ * @msi_data: the data that should be written in order to raise MSI interrupt
+ *            with interrupt number as 'interrupt num'
+ *
+ * Invoke to map physical address to MSI address and return MSI data. The
+ * physical address should be an address in the outbound region. This is
+ * required to implement doorbell functionality of NTB wherein EPC on either
+ * side of the interface (primary and secondary) can directly write to the
+ * physical address (in outbound region) of the other interface to ring
+ * doorbell.
+ */
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			phys_addr_t phys_addr, u8 interrupt_num, u32 entry_size,
+			u32 *msi_data)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc))
+		return -EINVAL;
+
+	if (!epc->ops->map_msi_irq)
+		return -EINVAL;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->map_msi_irq(epc, func_no, vfunc_no, phys_addr,
+				    interrupt_num, entry_size, msi_data);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_map_msi_irq);
+
 /**
  * pci_epc_get_msi() - get the number of MSI interrupt numbers allocated
  * @epc: the EPC device to which MSI interrupts was requested
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index e7614dda4e0e..59cd4c967329 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -55,6 +55,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
  *	     from the MSI-X capability register
  * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
+ * @map_msi_irq: ops to map physical address to MSI address and return MSI data
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @owner: the module owner containing the ops
@@ -77,6 +78,9 @@ struct pci_epc_ops {
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
+	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       phys_addr_t phys_addr, u8 interrupt_num,
+			       u32 entry_size, u32 *msi_data);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
@@ -216,6 +220,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 		     enum pci_barno, u32 offset);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no,
+			phys_addr_t phys_addr, u8 interrupt_num,
+			u32 entry_size, u32 *msi_data);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
-- 
2.17.1

