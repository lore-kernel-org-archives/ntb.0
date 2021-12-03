Return-Path: <jgg@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com. [40.107.244.83])
        by gmr-mx.google.com with ESMTPS id u2si664238qkp.6.2021.12.03.08.41.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:41:07 -0800 (PST)
Date: Fri, 3 Dec 2021 12:41:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211203164104.GX4670@nvidia.com>
References: <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dcl681d.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Dec 03, 2021 at 04:07:58PM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Thu, Dec 02 2021 at 20:37, Jason Gunthorpe wrote:
> > On Thu, Dec 02, 2021 at 11:31:11PM +0100, Thomas Gleixner wrote:
> >> >> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
> >> >> dedicated xarray or by partitioning the xarray space. Both have their
> >> >> pro and cons.
> >> >
> >> > This decision seems to drive the question of how many 'struct devices'
> >> > do we need, and where do we get them..
> >> 
> >> Not really. There is nothing what enforces to make the MSI irqdomain
> >> storage strictly hang off struct device. There has to be a connection to
> >> a struct device in some way obviously to make IOMMU happy.
> >
> > Yes, I thought this too, OK we agree
> 
> One thing which just occured to me and I missed so far is the
> association of the irqdomain.

Oh? I though this was part of what you were thinking when talkinga
about using the mdev struct device.

> but I really need to look at all of the MSI infrastructure code whether
> it makes assumptions about this:
> 
>    msi_desc->dev->irqdomain
> 
> being the correct one. Which would obviously just be correct when we'd
> have a per queue struct device :)

Right

I'd half expect the msi_desc to gain a pointer to the 'lfunc'

Then msi_desc->dev becomes msi_desc->origin_physical_device and is
only used by IOMMU code to figure out MSI remapping/etc. Maybe that
allows solve your aliasing problem (Is this the RID aliasing we see
with iommu_groups too?)

> > Lets imagine a simple probe function for a simple timer device. It has
> > no cdev, vfio, queues, etc. However, the device only supports IMS. No
> > MSI, MSI-X, nothing else.
> >
> > What does the probe function look like to get to request_irq()?
> 
> The timer device would be represented by what? A struct device?

Lets say it is a pci_device and probe is a pci_driver probe function

> If so then something needs to set device->irqdomain and then you can
> just do:
> 
>      msi_irq_domain_alloc_irqs(dev->irqdomain, dev, ...);

Okay, but that doesn't work if it is a PCI device and dev->irqdomain
is already the PCI MSI and INTx irqdomain?

> To do that, I need to understand the bigger picture and the intended
> usage because otherwise we end up with an utter mess.

Sure
 
> >> The idea is to have a common representation for these type of things
> >> which allows:
> >> 
> >>  1) Have common code for exposing queues to VFIO, cdev, sysfs...
> >> 
> >>     You still need myqueue specific code, but the common stuff which is
> >>     in struct logical_function can be generic and device independent.
> >
> > I will quote you: "Seriously, you cannot make something uniform which
> > is by definition non-uniform." :)
> >
> > We will find there is no common stuff here, we did this exercise
> > already when we designed struct auxiliary_device, and came up
> > empty.
> 
> Really?

Yes.. It was a long drawn out affair, and auxiliary_device is just a
simple container

> >>  2) Having the MSI storage per logical function (queue) allows to have
> >>     a queue relative 0 based MSI index space.
> >
> > Can you explain a bit what you see 0 meaning in this idx numbering?
> >
> > I also don't understand what 'queue relative' means?
> >
> >>     The actual index in the physical table (think IMS) would be held in
> >>     the msi descriptor itself.
> >
> > This means that a device like IDXD would store the phsical IMS table
> > entry # in the msi descriptor? What is idx then?
> >
> > For a device like IDXD with a simple linear table, how does the driver
> > request a specific entry in the IMS table? eg maybe IMS table entry #0
> > is special like we often see in MSI?
> 
> If there is a hardwired entry then this hardwired entry belongs to the
> controlblock (status, error or whatever), but certainly not to a
> dynamically allocatable queue as that would defeat the whole purpose.
> 
> That hardwired entry could surely exist in a IDXD type setup where the
> message storage is in an defined array on the device.

Agree - so how does it get accessed?

> But with the use case you described where you store the message at some
> place in per queue system memory, the MSI index is not relevant at all,
> because there is no table. So it's completely meaningless for the device
> and just useful for finding the related MSI descriptor again.

Yes

What I don't see is how exactly we make this situation work. The big
picture sequence would be:

 - Device allocates a queue and gets a queue handle
 - Device finds a free msi_desc and associates that msi_desc with the
   queue handle
 - Device specific irq_chip uses the msi_desc to get the queue handle
   and programs the addr/data

In this regard the msi_desc is just an artifact of the API, the real
work is in the msi_desc.

> Or has each queue and controlblock and whatever access to a shared large
> array where the messages are stored and the indices are handed out to
> the queues and controlblocks?

> If each of them have their own small array, then queue relative indexing
> makes a ton of sense, no?

Okay, I see.

I don't know of any use case for more than one interrupt on a queue,
and if it did come up I'd probably approach it by making the queue
handle above also specify the 'queue relative HW index'

> > All of this about logical functions just confuses
> > responsibilities. The IRQ layer should be worrying about configuring
> > IRQs and not dictating how the device will design its IRQ assignment
> > policy or subdevice scheme.
> 
> The IRQ layer _has_ to worry about it because there is a strict
> relationship between device and irqdomain today.

Yes. Absolutely.

This is what I've been thinking for a few messages now :)

I liked your lfunc/"msi_table" (without the queue stuff) because it
breaks that 1:1 without bringing in struct device to do it.

If that seems reasonable I think it is the best way to go.

Lets do a thought experiment, lets say we forget about the current PCI
MSI API.

What if it worked more like this:

probe()
 // Access the real PCI SIG MSI/MSI-X table
 mystruct->msi_table = pci_allocate_msi_table(pci_dev);

 // Special interrupt 0
 mstruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
 request_irq(mystruct->desc0, ..)

 // Special interrupt 1
 mystruct->desc1 = msi_table_alloc_vector(mystruct->msi_table, hw_label=1);
 request_irq(mystruct->desc1->irq, ..)

 // Fungible queue interrutps are 3->MAX
 for (nqueues) {
   queue[i]->desc = msi_table_alloc_vector_range(mystruct->msi_table, lowest=3, highest=MAX);
   request_irq(queue[i]->desc->irq, ..)
 }

remove()
 for (nqueues)
     msi_table_free_vector(mystruct->msi_table, queue[i]->desc)
 msi_table_free_vector(mystruct->msi_table, mystruct->desc1);
 msi_table_free_vector(mystruct->msi_table, mystruct->desc0);
 msi_table_free(mystruct->msi_table);

(please take some latitude when reading this, I am just trying to
sketch)

Here I am trying to show:

 - msi_table is a general API for accessing MSIs. Each bus type
   would provide some kind of logical creation function for their
   bus standardized MSI table type. eg MSI/MSI-X/etc

   It is a logical handle for the physical resource the holds the MSI
   addr/data paris.

 - Use a pointer instead of idx as the API for referring to a MSI
   irq. Most drivers probably only use msi_desc->irq?

 - We do not have device->msi, it is held in the driver instead.
   dev->irqdomain is always the bus/platform originated irqdomain of
   the physical device.

   Thus we break the 1:1 of the device and irqdomain. A device can
   spawn many msi_tables, but only one would be on the dev->irqdomain

 - Rely on dynamic allocation instead of the awkward batch interfaces.
   This means a msi_table starts out with 0 msi_descs and as we go
   they are allocated, installed in the xarray, and connected to the
   HW.

 - hw_label is defined by whatever type of msi_table it is:
   for PCI MSI this is the MSI table index
   for IDXD IMS this is the IMS table index
   for mlx5 memory IMS it is -1 (?) and the msi_desc is just placed
   anywhere in the xarray. msi_desc->xarray_index can store its
   location

 - 'msi_table_alloc_vector_range' allows a simple API to get any
   free entry from a group of fungible entries to make it clear
   to readers the typical special/pooled HW design pattern

Is it sane? What really needs device->msi anyhow?

IMS is a logical progression of this concept:

probe()
   mystruct->msi_table = pci_allocate_msi_table(pci_dev);
   mystruct->ims_irqdomain = <....>
   mystruct->ims_table = msi_allocate_table(pci_dev->dev,  mystruct->ims_irqdomain ..)

   // Use MSI
   mystruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
   // Use IMS
   mystruct->desc1 = msi_table_alloc_vector(mystruct->ims_table, hw_label=0);

Not saying we can/should go out and just do something so radical, but
as a thought experiment, can it guide toward a direction like this?

> That's why my initial reaction was to partition the device into
> subdevices which would have solved the problem nicely.

Yes, I see that logic.

> > IMHO this has become hyper focused on the special IDXD VFIO use case -
> > step back and think about my timer example above - a simple pci_driver
> > that just wants to use IMS for itself. No queues, no VFIO, no
> > mess. Just how does it configure and use the interrupt source.
> 
> That would mean that the PCI device would not use MSI-X at all, right?
> So it could have pci_dev.dev.irqdomain = IMSdomain.

Yes, but I'm not trying to get that as a solution. I fully expect all
real PCI devices to have MSI tables to support OS's without IMS
capability (notably old Linux)

So IMS and MSI must co-exist.

> > Is it helpful feedback?
> 
> Yes, definitely. It helps me to understand the bigger picture and to
> find a proper representation of these things so that we don't end up
> with the usual mess in drivers/* which makes it a fricking nightmare to
> change anything at the core code at all.

Great!

I agree alot with the other email you wrote that IMS == MSI - I think
that is key.

So much of these conversations have been warped by thinking of IMS as
some wonky thing for virtualization, or trying to focus on VFIO as the
only use case.

I think the other sort of tangential issue when you think on IMS ==
MSI is how pci_msi_create_irq_domain() is basically a special case for
PCI MSI by providing chip ops that only work for PCI to the irqdomain.

Not only that, but instead of cleanly having two irq_chip ops for the
very different HW programming under the MSI and MSI-X cases it is
handled with a 'if (msi_desc->msix)' on each op.

If IMS == MSI, then couldn't we conceptually have the dev->irqdomain
completely unable to handle IMS/MSI/MSI-X at all, and instead, when
the driver asks for PCI MSI access we create a new hierarchical
irqdomain and link it to a MSI chip_ops or a MSI-X chip_ops - just as
you outlined for IMS?  (again, not saying to do this, but let's ask if
that makes more sense than the current configuration)

Jason
