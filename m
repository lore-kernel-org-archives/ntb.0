Return-Path: <jgg@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com. [40.107.220.61])
        by gmr-mx.google.com with ESMTPS id be25si1348191oib.3.2021.12.06.06.19.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 06:19:25 -0800 (PST)
Date: Mon, 6 Dec 2021 10:19:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211206141922.GZ4670@nvidia.com>
References: <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9044fkb.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Sat, Dec 04, 2021 at 03:20:36PM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Fri, Dec 03 2021 at 12:41, Jason Gunthorpe wrote:
> > On Fri, Dec 03, 2021 at 04:07:58PM +0100, Thomas Gleixner wrote:
> > Lets do a thought experiment, lets say we forget about the current PCI
> > MSI API.

I've read both your emails, and I'll make a few small remarks on this
one, mainly to try to clearly communicate what I was thinking

Just want to call out the above paragraph, not suggesting we do it,
but the thought exercise of what should we do if not weighed down by
endless engineering cruft is usually informative.

> > What if it worked more like this:
> >
> > probe()
> >  // Access the real PCI SIG MSI/MSI-X table
> >  mystruct->msi_table = pci_allocate_msi_table(pci_dev);
> >
> >  // Special interrupt 0
> >  mstruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
> >  request_irq(mystruct->desc0, ..)
> 
> A device driver should not even know about msi_desc. Period.

Here, this wasn't really about the msi_desc, it was just about some
pointer-based handle. Call it what you will, and force it to be opaque
to the drivers.

eg this 'msi table' layer can just have a 

struct msi_handle;

In headers

and in a C it can be:

struct msi_handle {
   struct msi_desc desc;
};

And achieve what you've asked for

> >  - msi_table is a general API for accessing MSIs. Each bus type
> >    would provide some kind of logical creation function for their
> >    bus standardized MSI table type. eg MSI/MSI-X/etc
> 
> You can't give up on that table thing, right? We just established that
> for devices like yours IMS is not necessary a table and does not even
> need the index. The fact that MSI-X uses a table does not make
> everything a nail^Wtable. :)

It is just a name for the idea of a handle to a device's MSI
mechanism.

Call it 'msi_hw' or something.

My concept is that each device, integral to the device, has some ways
to operate the device's MSI storage (MSI/MSI-X/IMS/Platform), so lets
give that a name and give it a struct and an API. It is all still core
code.

Think of it as a clean separation between 'determining the addr/data
pair' and 'writing the addr/data pair to HW'.

Today you are thinking about this object as an irqdomain, irqchip, and
msi xarray - I think?

> >    It is a logical handle for the physical resource the holds the MSI
> >    addr/data paris.
> >
> >  - Use a pointer instead of idx as the API for referring to a MSI
> >    irq. Most drivers probably only use msi_desc->irq?
> 
> No. pci_irq_vector() translates the hw index to linux irq number.  The
> hardware index is known by the driver when it is doing a batched
> allocation, right?

Yes

> I'm fine with using the info struct I described above as the reference
> cookie.

IMHO an opaque pointer to refer to the MSI is cleaner
 
> >  - We do not have device->msi, it is held in the driver instead.
> 
> No. First of all drivers have no business with that, really.

I'm reading your second email and still not entirely clear what your
thinking is for devices->msi?

> >    dev->irqdomain is always the bus/platform originated irqdomain of
> >    the physical device.
> 
> This is a guarantee for subtle bugs and I'm not even remotely interested
> going there. See also below.

Not sure I follow this? My suggestion is that it is either as-is today
or NULL and we don't try to use eg mdev->irqdomain for anything.

> >    Thus we break the 1:1 of the device and irqdomain. A device can
> >    spawn many msi_tables, but only one would be on the dev->irqdomain
> 
> Why are you trying brute force to push things into device drivers?
> That's really the wrong direction. We want common infrastructure to be
> managed by generic code. And all of this is about common infrastructure.

The driver needs some kind of handle to tell the core code what MSI
'namespace' it is talking about in every API - eg MSI or IMS.

Pointers are the usual way to make such a handle.

Going along the IMS == MSI principle that says there should be a
driver facing API with a pointer handle for the MSI and a pointer
handle for the IMS.

Yes, this means the existing API is some compat wrapper around a
pointer API and would have to store the pointer handle in the device,
but the idea would be to make that pci->dev ONLY for the compat API,
not used in the IRQ infrastructure.

> > Is it sane? What really needs device->msi anyhow?
> 
> device->msi is a container for interrupt management and that's done by
> the interrupt code and not by random device drivers. Again, struct
> msi_desc is a software construct which the interrupt core code and the
> irqdomains and irq chip implementation use for various purposes. Nothing
> outside of this realm has to even know about the fact that this data
> structure exists in the first place. See below.

I imagined that msi_desc remains as part of the interrupt core code
and the 'msi_table' object is another interrupt core code object for
dealing with device's MSI

> > IMS is a logical progression of this concept:
> >
> > probe()
> >    mystruct->msi_table = pci_allocate_msi_table(pci_dev);
> >    mystruct->ims_irqdomain = <....>
> >    mystruct->ims_table = msi_allocate_table(pci_dev->dev,  mystruct->ims_irqdomain ..)
> >
> >    // Use MSI
> >    mystruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
> >    // Use IMS
> >    mystruct->desc1 = msi_table_alloc_vector(mystruct->ims_table, hw_label=0);
> >
> > Not saying we can/should go out and just do something so radical, but
> > as a thought experiment, can it guide toward a direction like this?
> 
> What I agree on is that the interface should be in a way that the driver
> can:
> 
>  1) Allocate vectors at a given hardware index
> 
>  2) Allocate vectors within a given hardware index range
> 
>  3) The core returns the hardware index and the Linux irq number in
>     a separate info structure which is independent of the interrupt
>     stack internal data representations.

Still slightly like an opaque pointer better than a two entry struct -
but compat is compat..

> Sure the driver can get a cookie of some sort to do allocation/free from
> different resource pools, e.g. PCI-MSI[X] and IMS. But the internal data
> representation management has to be done at the core level.

And here I still see it in the core level - this 'msi table' is a core
level data-structure and the opaque 'msi handle' is a core level
data-structure
 
We are just exposing a handle that the drive can use to. You are
calling it a cooking, but IMHO using a cookie instead of a pointer
seems obfuscating a bit?

> even try to make the irqchip/domain code mangled into the other device
> code. It should create the irqdomain with the associated chip and that
> creation process returns a cookie which is passed to the actual device
> specific code. Allocation then can use that cookie and not the irqdomain
> pointer itself.

Sounds like your cookie == my msi_table? Maybe we are all agreeing at
this point then?

> So thanks for being patient in educating me here.

I'm happy you got something out of all these words!
 
> The fact that we will be able to support this at all is based on years
> of cleanups, consolidation and restructuring of the infrastructure. The
> result of doing this is that my trust in driver developers in that
> regard is very close to zero. The cleanup patches I had to do for this
> series just to solve the single irqdomain case did not help to elevate
> the trust level either.

Yes, it is amazing how many patches this is at already.

Jason
