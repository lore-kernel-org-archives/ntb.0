Return-Path: <jgg@nvidia.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com. [40.107.237.87])
        by gmr-mx.google.com with ESMTPS id k10si2048099qko.0.2021.12.01.05.00.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 05:00:26 -0800 (PST)
Date: Wed, 1 Dec 2021 09:00:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211201130023.GH4670@nvidia.com>
References: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtlkaauo.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:

> Looking at the device slices as subdevices with their own struct device
> makes a lot of sense from the conceptual level.

Except IMS is not just for subdevices, it should be usable for any
driver in any case as a general interrupt mechiansm, as you alluded to
below about ethernet queues. ntb seems to be the current example of
this need..

If it works properly on the physical PCI dev there is no reason to try
to also make it work on the mdev and add complixity in iommu land.

> Though I fear there is also a use case for MSI-X and IMS tied to the
> same device. That network card you are talking about might end up using
> MSI-X for a control block and then IMS for the actual network queues
> when it is used as physical function device as a whole, but that's
> conceptually a different case.

Is it? Why?

IDXD is not so much making device "slices", but virtualizing and
sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
described and the VFIO driver is simply allocating queues from a PCI
device for specific usages and assigning them interrupts.

There is already a char dev interface that equally allocates queues
from the same IDXD device, why shouldn't it be able to access IMS
interrupt pools too?

IMHO a well designed IDXD driver should put all the PCI MMIO, queue
mangement, interrupts, etc in the PCI driver layer, and the VFIO
driver layer should only deal with the MMIO trapping and VFIO
interfacing.

From this view it is conceptually wrong to have the VFIO driver
directly talking to MMIO registers in the PCI device or owning the
irq_chip. It would be very odd for the PCI driver to allocate
interrupts from some random external struct device when it is creating
queues on the PCI device.

> > Another view is the msi_domain_alloc_irqs() flows should have their
> > own xarrays..
> 
> Yes, I was thinking about that as well. The trivial way would be:
> 
>     struct xarray     store[MSI_MAX_STORES];
> 
> and then have a store index for each allocation domain. With the
> proposed encapsulation of the xarray handling that's definitely
> feasible. Whether that buys much is a different question. Let me think
> about it some more.

Any possibility that the 'IMS' xarray could be outside the struct
device?

Thanks,
Jason
