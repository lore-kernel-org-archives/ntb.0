Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id e20si750052otj.1.2021.11.26.17.24.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 17:24:17 -0800 (PST)
Message-ID: <20211126232736.079074688@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 30/32] genirq/msi: Add abuse prevention comment to msi header
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Nov 2021 02:24:15 +0100 (CET)
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,6 +2,20 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
+/*
+ * This header file contains MSI data structures and functions which are
+ * only relevant for:
+ *	- Interrupt core code
+ *	- PCI/MSI core code
+ *	- MSI interrupt domain implementations
+ *	- IOMMU, low level VFIO, NTB and other justified exceptions
+ *	  dealing with low level MSI details.
+ *
+ * Regular device drivers have no business with any of these functions and
+ * especially storing MSI descriptor pointers in random code is considered
+ * abuse. The only function which is relevant for drivers is msi_get_virq().
+ */
+
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>

