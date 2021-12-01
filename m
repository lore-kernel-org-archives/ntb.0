Return-Path: <jgg@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com. [40.107.94.54])
        by gmr-mx.google.com with ESMTPS id bg19si129128oib.5.2021.12.01.10.14.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:14:09 -0800 (PST)
Date: Wed, 1 Dec 2021 14:14:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211201181406.GM4670@nvidia.com>
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2548byw.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 01, 2021 at 06:35:35PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
> > On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
> >> Looking at the device slices as subdevices with their own struct device
> >> makes a lot of sense from the conceptual level.
> >
> > Except IMS is not just for subdevices, it should be usable for any
> > driver in any case as a general interrupt mechiansm, as you alluded to
> > below about ethernet queues. ntb seems to be the current example of
> > this need..
> 
> But NTB is operating through an abstraction layer and is not a direct
> PCIe device driver.

I'm not sure exactly how NTB seems to be split between switchtec and
the ntb code, but since the ntbd code seems to be doing MMIO touches,
it feels like part of a PCIe driver?

> > IDXD is not so much making device "slices", but virtualizing and
> > sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
> > described and the VFIO driver is simply allocating queues from a PCI
> > device for specific usages and assigning them interrupts.
> 
> Right.
> 
> But what is the representation for that resulting device? Some VFIO
> specific homebrewn muck or something which is based on struct device?

Why is there a device? A queue is a queue, not a device.

If the task is to make some struct device (eg mdev, or cdev, or
whatever) then queues may be allocated to do this, but the queue is
logically a resource handed out by the PCIe driver and there should
not be a requirement to have an external struct device just to create
a queue.

> Right now with VF passthrough, I can see the interrupts which are
> associated to the device.
> 
> How is that going to be with something which is just made up? Does that
> expose it's own msi properties then somewhere hidden in the VFIO layer?

For sysfs, I think all interrupts should be on the PCI directory.

> > There is already a char dev interface that equally allocates queues
> > from the same IDXD device, why shouldn't it be able to access IMS
> > interrupt pools too?
> 
> Why wouldn't it be able to do so?

The only 'struct device' there is a cdev and I really don't think
cdevs should have interrupts. It is a bit hacky as a in-kernel thing
and downright wrong as a sysfs ABI.

> The VFIO driver does not own the irq chip ever. The irq chip is of
> course part of the underlying infrastructure. I never asked for that.

That isn't quite what I ment.. I ment the PCIe driver cannot create
the domain or make use of the irq_chip until the VFIO layer comes
along and provides the struct device. To me this is backwards
layering, the interrupts come from the PCIe layer and should exist
independently from VFIO.

>      When it allocates a slice for whatever usage then it also
>      allocates the IMS interrupts (though the VFIO people want to
>      have only one and do the allocations later on demand).
> 
>      That allocation cannot be part of the PCI/MSIx interrupt
>      domain as we already agreed on.

Yes, it is just an open question of where the new irq_domain need to
reside

>     1) Storage
> 
>        A) Having "subdevices" solves the storage problem nicely and
>           makes everything just fall in place. Even for a purely
>           physical multiqueue device one can argue that each queue is a
>           "subdevice" of the physical device. The fact that we lump them
>           all together today is not an argument against that.

I don't like the idea that queue is a device, that is trying to force
a struct device centric world onto a queue which doesn't really want
it..
 
>        B) Requires extra storage in the PCIe device and extra storage
>           per subdevice, queue to keep track of the interrupts which
>           are associated to it.

Yes

>     2) Exposure of VFIO interrupts via sysfs
> 
>        A) Just works

I would say this is flawed, in sysfs I expect all the interrupts for
the PCIe device to be in the PCIe sysfs, not strewn over subsystem
owned sub-directories.

For instance, today in mlx5, when a subdevice allocates a queue for a
slice (which is modeled as an aux device) the queue's assigned MSI-X
interrupt shows up on the PCIe sysfs, not the aux.

It should be uniform, if I assign a queue a legacy INT, MSI or an IMS
it should show in sysfs in the same way. Leaking this kernel
implementation detail as sysfs ABI does not seem good.

>     3) On demand expansion of the vectors for VFIO
> 
>        A) Just works because the device has an irqdomain assigned.
> 
>        B) Requires extra indirections to do that

Yes.
 
>     4) PASID
> 
>        While an Intel IDXD specific issue, it want's to be solved
>        without any nasty hacks.
> 
>        A) Having a "subdevice" allows to associate the PASID with the
>           underlying struct device which makes IOMMU integration trivial
> 
>        B) Needs some other custom hackery to get that solved

Yes

> > Any possibility that the 'IMS' xarray could be outside the struct
> > device?
> 
> We could, but we really want to keep things tied to devices which is the
> right thing to do.

I see the sysfs issue makes this a poor idea as well, as where would
the sysfs live if there was no struct device?

I'm inclined to think either of your ideas with the xarray are good
directions, primarily because it keeps HW data out of non-HW struct
devices and maintains a consistent sysfs representation for all the
different interrupt allocation methods.

Regards,
Jason
