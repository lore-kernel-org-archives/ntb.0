Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id n20si797435qtl.1.2021.11.26.17.23.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:23:59 -0800 (PST)
Message-ID: <20211126232735.429897588@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 19/32] powerpc/mpic_u3msi: Use msi_for_each-desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:23:58 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/mpic_u3msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -104,17 +104,12 @@ static void u3msi_teardown_msi_irqs(stru
 	struct msi_desc *entry;
 	irq_hw_number_t hwirq;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 	}
-
-	return;
 }
 
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -136,7 +131,7 @@ static int u3msi_setup_msi_irqs(struct p
 		return -ENXIO;
 	}
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");

