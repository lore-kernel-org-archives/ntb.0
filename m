Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id q3si1194777ilu.0.2021.11.26.17.23.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:23:35 -0800 (PST)
Message-ID: <20211126232734.472421030@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: 
 [patch 03/32] genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:23:33 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Usage sites which do allocations of the MSI descriptors before invoking
msi_domain_alloc_irqs() require to lock the MSI decriptors accross the
operation.

Provide entry points which can be called with the MSI mutex held and lock
the mutex in the existing entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 ++
 kernel/irq/msi.c    |   74 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 16 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -413,9 +413,12 @@ struct irq_domain *msi_create_irq_domain
 					 struct irq_domain *parent);
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec);
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -691,10 +691,8 @@ int __msi_domain_alloc_irqs(struct irq_d
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
-		if (virq < 0) {
-			ret = msi_handle_pci_fail(domain, desc, allocated);
-			goto cleanup;
-		}
+		if (virq < 0)
+			return msi_handle_pci_fail(domain, desc, allocated);
 
 		for (i = 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
@@ -728,7 +726,7 @@ int __msi_domain_alloc_irqs(struct irq_d
 		}
 		ret = irq_domain_activate_irq(irq_data, can_reserve);
 		if (ret)
-			goto cleanup;
+			return ret;
 	}
 
 skip_activate:
@@ -743,38 +741,63 @@ int __msi_domain_alloc_irqs(struct irq_d
 		}
 	}
 	return 0;
-
-cleanup:
-	msi_domain_free_irqs(domain, dev);
-	return ret;
 }
 
 /**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation/free.
+ *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	int ret;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
 		return 0;
 
 	ret = msi_device_populate_sysfs(dev);
 	if (ret)
-		msi_domain_free_irqs(domain, dev);
+		goto cleanup;
+	return 0;
+
+cleanup:
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * @domain:	The domain to allocate from
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
+{
+	int ret;
+
+	msi_lock_descs(dev);
+	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	msi_unlock_descs(dev);
 	return ret;
 }
 
@@ -804,22 +827,41 @@ void __msi_domain_free_irqs(struct irq_d
 }
 
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	if (info->flags & MSI_FLAG_DEV_SYSFS)
 		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
 }
 
 /**
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_unlock_descs(dev);
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *

