Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id d18si761866lfg.3.2021.12.06.14.51.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:51:17 -0800 (PST)
Message-ID: <20211206210748.089085131@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 09/31] PCI/MSI: Let core code free MSI descriptors
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  6 Dec 2021 23:51:16 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Set the domain info flag which tells the core code to free the MSI
descriptors from msi_domain_free_irqs() and add an explicit call to the
core function into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    3 ++-
 drivers/pci/msi/legacy.c    |    1 +
 drivers/pci/msi/msi.c       |   14 --------------
 3 files changed, 3 insertions(+), 15 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -171,7 +171,8 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
+		       MSI_FLAG_FREE_MSI_DESCS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -80,4 +80,5 @@ void pci_msi_legacy_teardown_msi_irqs(st
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -224,22 +224,8 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 
 static void free_msi_irqs(struct pci_dev *dev)
 {
-	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
-	struct msi_desc *entry, *tmp;
-	int i;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i = 0; i < entry->nvec_used; i++)
-				BUG_ON(irq_has_action(entry->irq + i));
-
 	pci_msi_teardown_msi_irqs(dev);
 
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		list_del(&entry->list);
-		free_msi_entry(entry);
-	}
-
 	if (dev->msix_base) {
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;

