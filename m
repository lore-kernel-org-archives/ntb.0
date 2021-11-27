Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id mq9si1768827pjb.3.2021.11.26.17.24.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:24:11 -0800 (PST)
Message-ID: <20211126232735.849307742@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 26/32] platform-msi: Simplify platform device MSI code
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:24:09 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The allocation code is overly complex. It tries to have the MSI index space
packed, which is not working when an interrupt is freed. There is no
requirement for this. The only requirement is that the MSI index is unique.

Move the MSI descriptor allocation into msi_domain_populate_irqs() and use
the Linux interrupt number as MSI index which fulfils the unique
requirement.

This requires to lock the MSI descriptors which makes the lock order
reverse to the regular MSI alloc/free functions vs. the domain
mutex. Assign a seperate lockdep class for these MSI device domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |   88 +++++++++-----------------------------------
 kernel/irq/msi.c            |   46 +++++++++++------------
 2 files changed, 40 insertions(+), 94 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -246,6 +246,8 @@ void *platform_msi_get_host_data(struct
 	return data->host_data;
 }
 
+static struct lock_class_key platform_device_msi_lock_class;
+
 /**
  * __platform_msi_create_device_domain - Create a platform-msi device domain
  *
@@ -278,6 +280,13 @@ struct irq_domain *
 	if (err)
 		return NULL;
 
+	/*
+	 * Use a separate lock class for the MSI descriptor mutex on
+	 * platform MSI device domains because the descriptor mutex nests
+	 * into the domain mutex. See alloc/free below.
+	 */
+	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
+
 	data = dev->msi.data->platform_data;
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
@@ -300,75 +309,23 @@ struct irq_domain *
 	return NULL;
 }
 
-static void platform_msi_free_descs(struct device *dev, int base, int nvec)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->msi_index >= base &&
-		    desc->msi_index < (base + nvec)) {
-			list_del(&desc->list);
-			free_msi_entry(desc);
-		}
-	}
-}
-
-static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec)
-{
-	struct msi_desc *desc;
-	int i, base = 0;
-
-	if (!list_empty(dev_to_msi_list(dev))) {
-		desc = list_last_entry(dev_to_msi_list(dev),
-				       struct msi_desc, list);
-		base = desc->msi_index + 1;
-	}
-
-	for (i = 0; i < nvec; i++) {
-		desc = alloc_msi_entry(dev, 1, NULL);
-		if (!desc)
-			break;
-
-		desc->msi_index = base + i;
-		desc->irq = virq + i;
-
-		list_add_tail(&desc->list, dev_to_msi_list(dev));
-	}
-
-	if (i != nvec) {
-		/* Clean up the mess */
-		platform_msi_free_descs(dev, base, nvec);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 /**
  * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
  *				     device domain
  *
  * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the free operation
- * @nvec:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to free from @virq
  */
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nvec)
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
-	struct msi_desc *desc, *tmp;
 
-	for_each_msi_entry_safe(desc, tmp, data->dev) {
-		if (WARN_ON(!desc->irq || desc->nvec_used != 1))
-			return;
-		if (!(desc->irq >= virq && desc->irq < (virq + nvec)))
-			continue;
-
-		irq_domain_free_irqs_common(domain, desc->irq, 1);
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
+	msi_lock_descs(data->dev);
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, nr_irqs);
+	msi_unlock_descs(data->dev);
 }
 
 /**
@@ -377,7 +334,7 @@ void platform_msi_device_domain_free(str
  *
  * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the allocate operation
- * @nr_irqs:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to allocate from @virq
  *
  * Return 0 on success, or an error code on failure. Must be called
  * with irq_domain_mutex held (which can only be done as part of a
@@ -387,16 +344,7 @@ int platform_msi_device_domain_alloc(str
 				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
-	int err;
-
-	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs);
-	if (err)
-		return err;
-
-	err = msi_domain_populate_irqs(domain->parent, data->dev,
-				       virq, nr_irqs, &data->arg);
-	if (err)
-		platform_msi_device_domain_free(domain, virq, nr_irqs);
+	struct device *dev = data->dev;
 
-	return err;
+	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->arg);
 }
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -775,43 +775,41 @@ int msi_domain_prepare_irqs(struct irq_d
 }
 
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *arg)
+			     int virq_base, int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
-	int ret = 0;
+	int ret, virq;
 
-	for_each_msi_entry(desc, dev) {
-		/* Don't even try the multi-MSI brain damage. */
-		if (WARN_ON(!desc->irq || desc->nvec_used != 1)) {
-			ret = -EINVAL;
-			break;
+	msi_lock_descs(dev);
+	for (virq = virq_base; virq < virq_base + nvec; virq++) {
+		desc = alloc_msi_entry(dev, 1, NULL);
+		if (!desc) {
+			ret = -ENOMEM;
+			goto fail;
 		}
 
-		if (!(desc->irq >= virq && desc->irq < (virq + nvec)))
-			continue;
+		desc->msi_index = virq;
+		desc->irq = virq;
+		list_add_tail(&desc->list, &dev->msi.data->list);
+		dev->msi.data->num_descs++;
 
 		ops->set_desc(arg, desc);
-		/* Assumes the domain mutex is held! */
-		ret = irq_domain_alloc_irqs_hierarchy(domain, desc->irq, 1,
-						      arg);
+		ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 		if (ret)
-			break;
+			goto fail;
 
-		irq_set_msi_desc_off(desc->irq, 0, desc);
-	}
-
-	if (ret) {
-		/* Mop up the damage */
-		for_each_msi_entry(desc, dev) {
-			if (!(desc->irq >= virq && desc->irq < (virq + nvec)))
-				continue;
-
-			irq_domain_free_irqs_common(domain, desc->irq, 1);
-		}
+		irq_set_msi_desc(virq, desc);
 	}
+	msi_unlock_descs(dev);
+	return 0;
 
+fail:
+	for (--virq; virq >= virq_base; virq--)
+		irq_domain_free_irqs_common(domain, virq, 1);
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, nvec);
+	msi_unlock_descs(dev);
 	return ret;
 }
 

