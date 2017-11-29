Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c5si722380iti.3.2017.11.29.09.55.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:57 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:28 -0700
Message-Id: <20171129175530.31032-6-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 5/7] ntb_hw_switchtec: Expand PFF CSR registers
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

The PFF CSR registers actual mirrors the PCI configuration space
for all the ports in the switch. Previously, this was not needed by
the driver but will be used by the crosslink code to enumerate the
bus in an host-less centre partition.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/switchtec.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index d4a7c18b42cf..6d325a7a0c19 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -292,7 +292,20 @@ enum {
 struct pff_csr_regs {
 	u16 vendor_id;
 	u16 device_id;
-	u32 pci_cfg_header[15];
+	u16 pcicmd;
+	u16 pcists;
+	u32 pci_class;
+	u32 pci_opts;
+	union {
+		u32 pci_bar[6];
+		u64 pci_bar64[3];
+	};
+	u32 pci_cardbus;
+	u32 pci_subsystem_id;
+	u32 pci_expansion_rom;
+	u32 pci_cap_ptr;
+	u32 reserved1;
+	u32 pci_irq;
 	u32 pci_cap_region[48];
 	u32 pcie_cap_region[448];
 	u32 indirect_gas_window[128];
-- 
2.11.0

