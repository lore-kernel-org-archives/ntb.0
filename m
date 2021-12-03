Return-Path: <jgg@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com. [40.107.93.80])
        by gmr-mx.google.com with ESMTPS id b8si202656qtg.5.2021.12.02.16.37.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 16:37:53 -0800 (PST)
Date: Thu, 2 Dec 2021 20:37:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211203003749.GT4670@nvidia.com>
References: <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o85y63m8.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 02, 2021 at 11:31:11PM +0100, Thomas Gleixner wrote:

> The software representation aka struct msi_desc is a different
> story. That's what we are debating.

Okay, I did mean msi_desc storage, so we are talking about the same thigns

> >> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
> >> dedicated xarray or by partitioning the xarray space. Both have their
> >> pro and cons.
> >
> > This decision seems to drive the question of how many 'struct devices'
> > do we need, and where do we get them..
> 
> Not really. There is nothing what enforces to make the MSI irqdomain
> storage strictly hang off struct device. There has to be a connection to
> a struct device in some way obviously to make IOMMU happy.

Yes, I thought this too, OK we agree

> Just badly named because the table itself is where the resulting message
> is stored, which is composed with the help of the relevant MSI
> descriptor. See above.

I picked the name because it looks like it will primarily contain an
xarray and the API you suggested to query it is idx based. To me that
is a table. A table of msi_desc storage to be specific.

It seems we have some agreement here as your lfunc also included the
same xarray and uses an idx as part of the API, right?

> We really should not try to make up an artifical table representation
> for something which does not necessarily have a table at all, i.e. the
> devices you talk about which store the message in queue specific system
> memory. Pretending that this is a table is just silly.

Now I'm a bit confused, what is the idx in the lfunc? 

I think this is language again, I would call idx an artificial table
representation?

> Also I disagree that this has to be tied to a PCI specific interface,
> except for creating a PCI specific wrapper for it to not make a driver
> developer have to write '&pdev->dev', which is the very least of our
> problems.

Agreed, just trying to be illustrative at a higher level
 
> Aside of that 'my_irq_chip' does not cut it at all because of the way
> how the resulting messages are stored. IDXD has IOMEM storage and a
> storage space limitation while your device uses system memory storage
> and has other limitations, i.e. system memory and the number of queues
> the device can provide.

Okay, so the device must setup the domain because it must provide
information during setup. Makes sense

> Not really. I was really reasoning about an abstract representation for
> a functional queue, which is more than just a queue allocated from the
> PF or VF device.
> 
> I really meant a container like this:
> 
> struct logical_function {
>         /* Pointer to the physical device */
>         struct device		*phys_device;
>         /* MSI descriptor storage */
> 	struct msi_data		msi;

Up to here is basically what I thought the "message table" would
contain. Possibly a pointer to the iommu_domain too?

>         /* The queue number */
>         unsigned int		queue_nr;
>         /* Add more information which is common to these things */

Not sure why do we need this?

Lets imagine a simple probe function for a simple timer device. It has
no cdev, vfio, queues, etc. However, the device only supports IMS. No
MSI, MSI-X, nothing else.

What does the probe function look like to get to request_irq()?

Why does this simple driver create something called a 'logical
function' to access its only interrupt?

I think you have the right idea here, just forget about VFIO, the IDXD
use case, all of it. Provide a way to use IMS cleanly and concurrently
with MSI.

Do that and everything else should have sane solutions too.

> The idea is to have a common representation for these type of things
> which allows:
> 
>  1) Have common code for exposing queues to VFIO, cdev, sysfs...
> 
>     You still need myqueue specific code, but the common stuff which is
>     in struct logical_function can be generic and device independent.

I will quote you: "Seriously, you cannot make something uniform which
is by definition non-uniform." :)

We will find there is no common stuff here, we did this exercise
already when we designed struct auxiliary_device, and came up
empty. 

>  2) Having the MSI storage per logical function (queue) allows to have
>     a queue relative 0 based MSI index space.

Can you explain a bit what you see 0 meaning in this idx numbering?

I also don't understand what 'queue relative' means?

>     The actual index in the physical table (think IMS) would be held in
>     the msi descriptor itself.

This means that a device like IDXD would store the phsical IMS table
entry # in the msi descriptor? What is idx then?

For a device like IDXD with a simple linear table, how does the driver
request a specific entry in the IMS table? eg maybe IMS table entry #0
is special like we often see in MSI?

>         msi_get_virq(&myqueue->lfunc.msi, idx = 0)
>
>     v.s.
>
>         idx = myqueue->msidx[0];
>         msi_get_virq(pcidev->dev, idx);
 
>         where the queue management code has to set up myqueue->msidx[]
>         and stick the index of the underlying device storage into it.

For the devices I know about there are two approaches for allocating
interrupts. 

Many devices have a few special interrupts at fixed table
indexes. These can only be used for their single purpose. Eg MSI 0 and
1. An example is IRQ 1 signals the device had an error, read the error
reporting MMIO registers.

Then the device has a broad pool of fungible vectors. These are all
interchangeable, any vector can be used with any queue. eg MSI 2->128

A common mode operation is to setup the special vectors first, and
then assign on demand the pool vectors as CPUs are allocated for
use. Basically each CPU gets a vector and then many device objects are
attached to that vector. This scheme gives CPU locality and doesn't
exhaust CPU vectors. As example nvme uses 1 queue per CPU and 1 vector
per queue and userspace tells it how many queues (and thus CPUs) to
consume.

A device like mlx5 may have 1000's of queues and hundreds of sub
devices sharing a single CPU interrupt. This is desirable because we
can quickly run out of interrupts when we are talking about 100's of
concurrent subdevices.

When a "VFIO mdev" gets involved (mlx5 has this already, it is just
called VDPA, don't ask) the same allocator is used by the VFIO part
except VFIO has to request a dedicated MSI. Dedicated is because the
Intel VTx is used to deliver that MSI addr/data directly to the
guest's vAPIC.

When I imagine mlx5 using IMS, I see IMS as a simple extension of the
existing MSI-X vector pool. Every IMS vector is interchangable and the
main PCI driver will apply exactly the same allocation algorithm we
already have today for MSI, just with even more vectors. When VFIO
wants a vector it may get a MSI or it may get an IMS, I don't want to
care.

All of this about logical functions just confuses
responsibilities. The IRQ layer should be worrying about configuring
IRQs and not dictating how the device will design its IRQ assignment
policy or subdevice scheme.

>  3) Setup and teardown would be simply per logical function for
>     all of the related resources which are required.
> 
>     Interrrupt teardown would look like this:
> 
>       msi_domain_free_all_irqs(irqdomain, &lfunc->msi);

Looks nice

> Now change struct logical_function to:
> 
> struct logical_function {
> -       /* Pointer to the physical device */
> -       struct device		*phys_device;
> 
> +       /* Pseudo device to allow using devres */
> +       struct pseudo_device	pseudo_device;
> 
> 	/* MSI descriptor storage */
> 	struct msi_data		msi;
>         /* The queue number */
>         unsigned int		queue_nr;
>         /* Add more information which is common to these things */
> };
> 
> where struct pseudo_device holds the phys_device pointer and then you
> can utilize the devres infrastructure like you do for any other device
> and do:
> 
>       pseudo_device_add(&myqueue->lfunc.pseudo_device);
> 
> at setup time and
> 
>       pseudo_device_remove(&myqueue->lfunc.pseudo_device);
> 
> on teardown and let all the resources including MSI interrupts be
> released automatically.

We are already doing this with struct auxiliary_device and other
similar things. I don't see the value to couple the msi_data into the
lifetime model?

> I might be completely off track. Feel free to tell me so :)

I think you have the right core idea, just shrink your thinking of
logical_function to only cover msi stuff and leave the device model to
the other places that already have good mechansims. eg auxiliary device

IMHO this has become hyper focused on the special IDXD VFIO use case -
step back and think about my timer example above - a simple pci_driver
that just wants to use IMS for itself. No queues, no VFIO, no
mess. Just how does it configure and use the interrupt source.

Is it helpful feedback?

Regards,
Jason
