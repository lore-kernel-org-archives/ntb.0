Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y7si120467iof.5.2019.02.13.09.55.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:55:07 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 13 Feb 2019 10:54:45 -0700
Message-Id: <20190213175454.7506-4-logang@deltatee.com>
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 03/12] iommu/vt-d: Add helper to set an IRTE to verify only the bus number
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>, David Woodhouse <dwmw2@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-ID: <linux-ntb.googlegroups.com>

The current code uses set_irte_sid() with SVT_VERIFY_BUS and PCI_DEVID
to set the SID value. However, this is very confusing because, with
SVT_VERIFY_BUS, the SID value is not a PCI devfn address, but the start
and end bus numbers to match against.

According to the Intel Virtualization Technology for Directed I/O
Architecture Specification, Rev. 3.0, page 9-36:

  The most significant 8-bits of the SID field contains the Startbus#,
  and the least significant 8-bits of the SID field contains the Endbus#.
  Interrupt requests that reference this IRTE must have a requester-id
  whose bus# (most significant 8-bits of requester-id) has a value equal
  to or within the Startbus# to Endbus# range.

So to make this more clear, introduce a new set_irte_verify_bus() that
explicitly takes a start bus and end bus so that we can stop abusing
the PCI_DEVID macro.

This helper function will be called a second time in an subsequent patch.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel_irq_remapping.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 24d45b07f425..5a55bef8e379 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -294,6 +294,18 @@ static void set_irte_sid(struct irte *irte, unsigned int svt,
 	irte->sid = sid;
 }
 
+/*
+ * Set an IRTE to match only the bus number. Interrupt requests that reference
+ * this IRTE must have a requester-id whose bus number is between or equal
+ * to the start_bus and end_bus arguments.
+ */
+static void set_irte_verify_bus(struct irte *irte, unsigned int start_bus,
+				unsigned int end_bus)
+{
+	set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
+		     (start_bus << 8) | end_bus);
+}
+
 static int set_ioapic_sid(struct irte *irte, int apic)
 {
 	int i;
@@ -391,9 +403,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	 * original device.
 	 */
 	if (PCI_BUS_NUM(data.alias) != data.pdev->bus->number)
-		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
-			     PCI_DEVID(PCI_BUS_NUM(data.alias),
-				       dev->bus->number));
+		set_irte_verify_bus(irte, PCI_BUS_NUM(data.alias),
+				    dev->bus->number);
 	else if (data.pdev->bus->number != dev->bus->number)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
-- 
2.19.0

