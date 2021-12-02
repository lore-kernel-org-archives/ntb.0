Return-Path: <jgg@nvidia.com>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com ([40.107.236.58])
        by gmr-mx.google.com with ESMTPS id i17si125331ila.3.2021.12.02.12.00.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 12:00:21 -0800 (PST)
Date: Thu, 2 Dec 2021 16:00:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211202200017.GS4670@nvidia.com>
References: <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnkm6c77.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 02, 2021 at 08:25:48PM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Thu, Dec 02 2021 at 09:55, Jason Gunthorpe wrote:
> > On Thu, Dec 02, 2021 at 01:01:42AM +0100, Thomas Gleixner wrote:
> >> On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> >> > On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> >> > Which in turn is consistent all over the place and does not require any
> >> > special case for anything. Neither for interrupts nor for anything else.
> >> 
> >> that said, feel free to tell me that I'm getting it all wrong.
> >> 
> >> The reason I'm harping on this is that we are creating ABIs on several
> >> ends and we all know that getting that wrong is a major pain.
> >
> > I don't really like coupling the method to fetch IRQs with needing
> > special struct devices. Struct devices have a sysfs presence and it is
> > not always appropriate to create sysfs stuff just to allocate some
> > IRQs.
> >
> > A queue is simply not a device, it doesn't make any sense. A queue is
> > more like a socket().
> 
> Let's put the term 'device' for a bit please. 
> 
> > That said, we often have enough struct devices floating about to make
> > this work. Between netdev/ib_device/aux device/mdev we can use them to
> > do this.
> >
> > I think it is conceptual nonsense to attach an IMS IRQ domain to a
> > netdev or a cdev, but it will solve this problem.
> 
> The IMS irqdomain is _NOT_ part of the netdev or cdev or whatever. I
> explained that several times now.
> 
> We seem to have a serious problem of terminology and the understanding
> of topology which is why we continue to talk past each other forever.

I think I understand and agree with everything you said below.

The point we diverge is where to put the vector storage:
 
> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
> dedicated xarray or by partitioning the xarray space. Both have their
> pro and cons.

This decision seems to drive the question of how many 'struct devices'
do we need, and where do we get them..

> But what I really struggle with is how this is further represented when
> the queues are allocated for VFIO, cdev, whatever usage.

Yes, this seems to be the primary question

> The fact that the irqdomain is instantiated by the device driver does
> not make it any different. As explained above it's just an
> implementation detail which makes it possible to handle the device
> specific message storage requirement in a sane way. The actual interrupt
> resources come still from the underlying irqdomains as for PCI/MSI.

Yes! This is not under debate

> Now I was looking for a generic representation of such a container and
> my initial reaction was to bind it to a struct device, which also makes
> it trivial to store these MSI descriptors in that struct device.

Right, I've been trying to argue around just this choice.
 
> I can understand your resistance against that to some extent, but I
> think we really have to come up with a proper abstract representation
> for these.

Ok

> Such a logical function would be the entity to hand out for VFIO or
> cdev.

What is a logical function, concretely? 

Does it have struct device?

Can I instead suggest a name like 'message interrupt table' ?

Ie a device has two linearly indexed message interrupt tables - the
PCI SIG defined MSI/MSI-X one created by the PCI core and the IMS one
created by the driver.

Both start at 0 index and they have different irq_domains.

Instead of asking the driver to create a domain we ask the driver to
create a new 'message interrupt table'. The driver provides the
irq_chip to program the messages and the pci_device. The core code
manages the irq domain setup.

Using what you say below:

> If this is not split out, then every driver and wrapper has to come up
> with it's own representation of this instead of being able to do:
> 
>      request_irq(msi_get_virq(lfunc, idx=0), handler0, ...);
>      request_irq(msi_get_virq(lfunc, idx=1), handler1, ...);

We could say:
  msi_get_virq(device.pci_msi_table, index=0)

Is the 0th PCI SIG MSI vector

Something like:

 ims_table = pci_create_msi_table(pci_dev, my_irq_chip,..)
 msi_get_virq(ims_table, index=0)

Is the 0th IMS vector

Is it close to what you are thinking with lfunc?

Regards,
Jason
