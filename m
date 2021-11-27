Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id k1si738936ybp.1.2021.11.26.17.23.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:23:52 -0800 (PST)
Message-ID: <20211126232735.130164978@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 14/32] s390/pci: Rework MSI descriptor walk
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:23:50 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/pci/pci_irq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *
 
 	/* Request MSI interrupts */
 	hwirq = bit;
-	for_each_pci_msi_entry(msi, pdev) {
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
@@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_d
 		return;
 
 	/* Release MSI interrupts */
-	for_each_pci_msi_entry(msi, pdev) {
-		if (!msi->irq)
-			continue;
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;

