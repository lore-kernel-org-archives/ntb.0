Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h203si393339vkh.0.2019.01.31.10.57.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:57:24 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 31 Jan 2019 11:56:48 -0700
Message-Id: <20190131185656.17972-2-logang@deltatee.com>
In-Reply-To: <20190131185656.17972-1-logang@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for aliased devices
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-ntb.googlegroups.com>

When a device has multiple aliases that all are from the same bus,
we program the IRTE to accept requests from any matching device on the
bus.

This is so NTB devices which can have requests from multiple bus-devfns
can pass MSI interrupts through across the bridge.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/iommu/intel_irq_remapping.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 24d45b07f425..8d3107a6b2b4 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -356,6 +356,8 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 struct set_msi_sid_data {
 	struct pci_dev *pdev;
 	u16 alias;
+	int count;
+	int busmatch_count;
 };
 
 static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
@@ -364,6 +366,10 @@ static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
 
 	data->pdev = pdev;
 	data->alias = alias;
+	data->count++;
+
+	if (PCI_BUS_NUM(alias) == pdev->bus->number)
+		data->busmatch_count++;
 
 	return 0;
 }
@@ -375,6 +381,8 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	if (!irte || !dev)
 		return -1;
 
+	data.count = 0;
+	data.busmatch_count = 0;
 	pci_for_each_dma_alias(dev, set_msi_sid_cb, &data);
 
 	/*
@@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
 			     PCI_DEVID(PCI_BUS_NUM(data.alias),
 				       dev->bus->number));
+	else if (data.count >= 2 && data.busmatch_count == data.count)
+		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
+			     PCI_DEVID(dev->bus->number,
+				       dev->bus->number));
 	else if (data.pdev->bus->number != dev->bus->number)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
-- 
2.19.0

