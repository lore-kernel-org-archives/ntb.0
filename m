Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id n6si745386otj.5.2021.11.26.17.23.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:23:41 -0800 (PST)
Message-ID: <20211126232734.708730446@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:23:39 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 +++
 kernel/irq/msi.c    |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -156,6 +156,7 @@ enum msi_desc_filter {
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
  * @properties:		MSI properties which are interesting to drivers
+ * @num_descs:		The number of allocated MSI descriptors for the device
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
@@ -166,6 +167,7 @@ enum msi_desc_filter {
 struct msi_device_data {
 	raw_spinlock_t			lock;
 	unsigned long			properties;
+	unsigned int			num_descs;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
@@ -208,6 +210,7 @@ static inline unsigned int msi_get_virq(
 
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
+unsigned int msi_device_num_descs(struct device *dev);
 
 struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
 struct msi_desc *msi_next_desc(struct device *dev);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -82,6 +82,7 @@ int msi_add_msi_desc(struct device *dev,
 	desc->pci = init_desc->pci;
 
 	list_add_tail(&desc->list, &dev->msi.data->list);
+	dev->msi.data->num_descs++;
 	return 0;
 }
 
@@ -109,6 +110,7 @@ int msi_add_simple_msi_descs(struct devi
 		list_add_tail(&desc->list, &list);
 	}
 	list_splice_tail(&list, &dev->msi.data->list);
+	dev->msi.data->num_descs += ndesc;
 	return 0;
 
 fail:
@@ -142,6 +144,7 @@ void msi_free_msi_descs_range(struct dev
 			continue;
 		list_del(&desc->list);
 		free_msi_entry(desc);
+		dev->msi.data->num_descs--;
 	}
 }
 
@@ -157,6 +160,21 @@ bool msi_device_has_property(struct devi
 	return !!(dev->msi.data->properties & prop);
 }
 
+/**
+ * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
+ * @dev:	The device to read from
+ *
+ * Note: This is a lockless snapshot of msi_device_data::num_descs
+ *
+ * Returns the number of MSI descriptors which are allocated for @dev
+ */
+unsigned int msi_device_num_descs(struct device *dev)
+{
+	if (dev->msi.data)
+		return dev->msi.data->num_descs;
+	return 0;
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;

