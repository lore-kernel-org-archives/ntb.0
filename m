Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id f21si740749pfc.3.2021.11.26.17.24.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:24:05 -0800 (PST)
Message-ID: <20211126232735.608092027@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: 
 [patch 22/32] soc: ti: ti_sci_inta_msi: Rework MSI descriptor allocation
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:24:03 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Protect the allocation properly and use the core allocation and free
mechanism.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/soc/ti/ti_sci_inta_msi.c |   71 +++++++++++++--------------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -51,6 +51,7 @@ struct irq_domain *ti_sci_inta_msi_creat
 	struct irq_domain *domain;
 
 	ti_sci_inta_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -60,50 +61,31 @@ struct irq_domain *ti_sci_inta_msi_creat
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_create_irq_domain);
 
-static void ti_sci_inta_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
 static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 				       struct ti_sci_resource *res)
 {
-	struct msi_desc *msi_desc;
+	struct msi_desc msi_desc;
 	int set, i, count = 0;
 
+	memset(&msi_desc, 0, sizeof(msi_desc));
+
 	for (set = 0; set < res->sets; set++) {
-		for (i = 0; i < res->desc[set].num; i++) {
-			msi_desc = alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->msi_index = res->desc[set].start + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+		for (i = 0; i < res->desc[set].num; i++, count++) {
+			msi_desc.msi_index = res->desc[set].start + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
-		for (i = 0; i < res->desc[set].num_sec; i++) {
-			msi_desc = alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->msi_index = res->desc[set].start_sec + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+
+		for (i = 0; i < res->desc[set].num_sec; i++, count++) {
+			msi_desc.msi_index = res->desc[set].start_sec + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
 	}
-
 	return count;
+fail:
+	msi_free_msi_descs(dev);
+	return -ENOMEM;
 }
 
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
@@ -124,20 +106,18 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 	if (ret)
 		return ret;
 
+	msi_lock_descs(dev);
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <= 0)
-		return nvec;
-
-	ret = msi_domain_alloc_irqs(msi_domain, dev, nvec);
-	if (ret) {
-		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-		goto cleanup;
+	if (nvec <= 0) {
+		ret = nvec;
+		goto unlock;
 	}
 
-	return 0;
-
-cleanup:
-	ti_sci_inta_msi_free_descs(&pdev->dev);
+	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
+unlock:
+	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
@@ -145,6 +125,5 @@ EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
 {
 	msi_domain_free_irqs(dev->msi.domain, dev);
-	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);

