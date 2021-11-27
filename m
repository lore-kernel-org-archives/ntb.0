Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id bg19si1168877oib.5.2021.11.26.17.24.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:24:14 -0800 (PST)
Message-ID: <20211126232735.966439698@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 28/32] genirq/msi: Convert to new functions
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:24:12 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Use the new iterator functions and add locking where required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -354,6 +354,7 @@ struct msi_desc *msi_next_desc(struct de
 int __msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
+	int ret = -ENOENT;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -361,11 +362,12 @@ int __msi_get_virq(struct device *dev, u
 
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
-	for_each_msi_entry(desc, dev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc_from(desc, dev, MSI_DESC_ASSOCIATED, index) {
 		/* PCI-MSI has only one descriptor for multiple interrupts. */
 		if (pcimsi) {
-			if (desc->irq && index < desc->nvec_used)
-				return desc->irq + index;
+			if (index < desc->nvec_used)
+				ret = desc->irq + index;
 			break;
 		}
 
@@ -373,10 +375,13 @@ int __msi_get_virq(struct device *dev, u
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (desc->msi_index == index)
-			return desc->irq;
+		if (desc->msi_index == index) {
+			ret = desc->irq;
+			break;
+		}
 	}
-	return -ENOENT;
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__msi_get_virq);
 
@@ -407,7 +412,7 @@ static const struct attribute_group **ms
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_msi_entry(entry, dev)
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return NULL;
@@ -417,7 +422,7 @@ static const struct attribute_group **ms
 	if (!msi_attrs)
 		return ERR_PTR(-ENOMEM);
 
-	for_each_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -838,7 +843,7 @@ static bool msi_check_reservation_mode(s
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
-	desc = first_msi_entry(dev);
+	desc = msi_first_desc(dev);
 	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
 }
 

