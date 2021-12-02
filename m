Return-Path: <jgg@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com. [40.107.94.81])
        by gmr-mx.google.com with ESMTPS id i18si550630qtx.0.2021.12.02.05.55.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 05:55:06 -0800 (PST)
Date: Thu, 2 Dec 2021 09:55:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211202135502.GP4670@nvidia.com>
References: <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1av7u3d.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 02, 2021 at 01:01:42AM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> > On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> > Which in turn is consistent all over the place and does not require any
> > special case for anything. Neither for interrupts nor for anything else.
> 
> that said, feel free to tell me that I'm getting it all wrong.
> 
> The reason I'm harping on this is that we are creating ABIs on several
> ends and we all know that getting that wrong is a major pain.

I don't really like coupling the method to fetch IRQs with needing
special struct devices. Struct devices have a sysfs presence and it is
not always appropriate to create sysfs stuff just to allocate some
IRQs.

A queue is simply not a device, it doesn't make any sense. A queue is
more like a socket().

That said, we often have enough struct devices floating about to make
this work. Between netdev/ib_device/aux device/mdev we can use them to
do this.

I think it is conceptual nonsense to attach an IMS IRQ domain to a
netdev or a cdev, but it will solve this problem.

However, I would really prefer that there be no uAPI here. 

I looked at the msi_irqs/ stuff and could not find a user. Debian code
search found nothing, Greg redid the entire uAPI in 2013
(1c51b50c2995), so I think it is just dead. (maybe delete it?)

So lets not create any sysfs for IMS with the msi_irqs/ dir.  We can
revise the in-kenel mechanism someday if it turns out to be a problem.

As to your question:

> So again, why would we want to make software managed subdevices look
> exactly the opposite way like hardware/firmware managed subdevices?

That isn't my thinking at all.

Something like mlx5 has a hw/fw managed VF and there is an RPC call
from driver to device to 'create a queue'. The device has no hard
division inside along a VF, the device simply checks resource limits
and security properties and returns one of the >>10k queues. Again
think more like socket() than a hard partitioning.

It is the same as I suggest for IDXD & VFIO where the PCIe IDXD layer
takes the place of hw/fw and has a 'create a queue' API call for the
VFIO layer to use. Instead of using a VF as the security identity, it
uses a PASID.

This is a logical partitioning and it matches the partioning we'd have
if it was a real device.

> So if a queue is represented as a subdevice, then VFIO can just build
> a wrapper around that subdevice.

I think that oversimplifies the picture.

IDXD is a multi queue device that uses PASID as a security context. It
has a cdev /dev/idxd interface where userspace can use an IOCTL and
get a queue to use. The queue is bound to a PASID that is linked to an
IO Page table that mirrors the process page table. Userspace operates
the queue and does whatever with it.

VFIO is just another interface that should logically be considered a
peer of the cdev. Using VFIO userspace can get a queue, bind it to a
PASID and operate it. The primary difference between the cdev and the
VFIO mdev is user programming API - VFIO uses IOCTLs that carry
emulated MMIO read/write operations.

I consider *neither* to be a subdevice. They are just a user API,
however convoluted, to create a queue, associate it with a PASID
security context and allow userspace to operate the queue. It is much
closer to socket() than a PCI VF subdevice.

Internally the driver should be built so that the PCI driver is doing
all the device operation and the two uAPI layers are only concerend
with translating their repsective uAPIs to the internal device API.

Further, there is no reason why IMS should be reserved exclusively for
VFIO! Why shouldn't the cdev be able to use IMS vectors too? It is
just a feature of the PCI device like MSI. If the queue has a PASID it
can use IDXD's IMS.

If we really need a 2nd struct device to turn on IMS then, I'd suggest
picking the cdev, as it keeps IMS and its allocator inside the IDXD
PCIe driver and not in the VFIO world.

Regards,
Jason
