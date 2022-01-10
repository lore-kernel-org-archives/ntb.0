Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id f31si340699lfv.11.2022.01.10.10.12.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:12:47 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] genirq/msi: Populate sysfs entry only once
In-Reply-To: <20211206210749.224917330@linutronix.de>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de>
Date: Mon, 10 Jan 2022 19:12:45 +0100
Message-ID: <87leznqx2a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The MSI entries for multi-MSI are populated en bloc for the MSI descriptor,
but the current code invokes the population inside the per interrupt loop
which triggers a warning in the sysfs code and causes the interrupt
allocation to fail.

Move it outside of the loop so it works correctly for single and multi-MSI.

Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -887,12 +887,11 @@ int __msi_domain_alloc_irqs(struct irq_d
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
-
-			if (info->flags & MSI_FLAG_DEV_SYSFS) {
-				ret = msi_sysfs_populate_desc(dev, desc);
-				if (ret)
-					return ret;
-			}
+		}
+		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			ret = msi_sysfs_populate_desc(dev, desc);
+			if (ret)
+				return ret;
 		}
 		allocated++;
 	}
