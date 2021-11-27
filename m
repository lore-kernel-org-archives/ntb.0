Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id f21si740661pfc.3.2021.11.26.17.23.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:23:38 -0800 (PST)
Message-ID: <20211126232734.590073487@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: 
 [patch 05/32] genirq/msi: Provide msi_alloc_msi_desc() and a simple allocator
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:23:36 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Provide msi_alloc_msi_desc() which takes a template MSI descriptor for
initializing a newly allocated descriptor. This allows to simplify various
usage sites of alloc_msi_entry() and moves the storage handling into the
core code.

For simple cases where only a linear vector space is required provide
msi_add_simple_msi_descs() which just allocates a linear range of MSI
descriptors and fills msi_desc::msi_index accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 +
 kernel/irq/msi.c    |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -302,6 +302,8 @@ static inline void pci_write_msi_msg(uns
 }
 #endif /* CONFIG_PCI_MSI */
 
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity);
 void free_msi_entry(struct msi_desc *entry);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -61,6 +61,65 @@ void free_msi_entry(struct msi_desc *ent
 }
 
 /**
+ * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	struct msi_desc *desc;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	desc = alloc_msi_entry(dev, init_desc->nvec_used, init_desc->affinity);
+	if (!desc)
+		return -ENOMEM;
+
+	/* Copy the MSI index and type specific data to the new descriptor. */
+	desc->msi_index = init_desc->msi_index;
+	desc->pci = init_desc->pci;
+
+	list_add_tail(&desc->list, &dev->msi.data->list);
+	return 0;
+}
+
+/**
+ * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @index:	Index for the first MSI descriptor
+ * @ndesc:	Number of descriptors to allocate
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
+{
+	struct msi_desc *desc, *tmp;
+	LIST_HEAD(list);
+	unsigned int i;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	for (i = 0; i < ndesc; i++) {
+		desc = alloc_msi_entry(dev, 1, NULL);
+		if (!desc)
+			goto fail;
+		desc->msi_index = index + i;
+		list_add_tail(&desc->list, &list);
+	}
+	list_splice_tail(&list, &dev->msi.data->list);
+	return 0;
+
+fail:
+	list_for_each_entry_safe(desc, tmp, &list, list) {
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+	return -ENOMEM;
+}
+
+/**
  * msi_device_has_property - Check whether a device has a specific MSI property
  * @dev:	Pointer to the device which is queried
  * @prop:	Property to check for

