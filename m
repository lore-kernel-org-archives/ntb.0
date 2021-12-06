Return-Path: <jgg@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com. [40.107.220.53])
        by gmr-mx.google.com with ESMTPS id f38si2049005qtb.3.2021.12.06.06.43.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 06:43:48 -0800 (PST)
Date: Mon, 6 Dec 2021 10:43:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211206144344.GA4670@nvidia.com>
References: <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
 <87o85v3znb.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o85v3znb.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 05, 2021 at 03:16:40PM +0100, Thomas Gleixner wrote:
> On Sat, Dec 04 2021 at 15:20, Thomas Gleixner wrote:
> > On Fri, Dec 03 2021 at 12:41, Jason Gunthorpe wrote:
> > So I need to break that up in a way which caters for both cases, but
> > does neither create a special case for PCI nor for the rest of the
> > universe, i.e. the 1:1 case has to be a subset of the 1:2 case which
> > means all of it is common case. With that solved the storage question
> > becomes a nobrainer.
> >
> > When I looked at it again yesterday while writing mail, I went back to
> > my notes and found the loose ends where I left off. Let me go back and
> > start over from there.
> 
> I found out why I stopped looking at it. I came from a similar point of
> view what you were suggesting:
> 
> >> If IMS == MSI, then couldn't we conceptually have the dev->irqdomain
> >> completely unable to handle IMS/MSI/MSI-X at all, and instead, when
> >> the driver asks for PCI MSI access we create a new hierarchical
> >> irqdomain and link it to a MSI chip_ops or a MSI-X chip_ops - just as
> >> you outlined for IMS?  (again, not saying to do this, but let's ask if
> >> that makes more sense than the current configuration)
> 
> Which I shot down with:
> 
> > That's not really a good idea because dev->irqdomain is a generic
> > mechanism and not restricted to the PCI use case. Special casing it for
> > PCI is just wrong. Special casing it for all use cases just to please
> > PCI is equally wrong. There is a world outside of PCI and x86. 
> 
> That argument is actually only partially correct.

I'm not sure I understood your reply? I think we are both agreeing
that dev->irqdomain wants to be a generic mechanism?

I'd say that today we've special cased it to handle PCI. IMHO that is
exactly what pci_msi_create_irq_domain() is doing - it replaces the
chip ops with ops that can *ONLY* do PCI MSI and so dev->irqdomain
becomes PCI only and non-generic.

> After studying my notes and some more code (sigh), it looks feasible
> under certain assumptions, constraints and consequences.
> 
> Assumptions:
> 
>   1) The irqdomain pointer of PCI devices which is set up during device
>      discovery is not used by anything else than infrastructure which
>      knows how to handle it.
> 
>      Of course there is no guarantee, but I'm not that horrified about
>      it anymore after chasing the exposure with yet more coccinelle
>      scripts.

OK


> Constraints:
> 
>   1) This is strictly opt-in and depends on hierarchical irqdomains.

OK

>      That means that devices which depend on IMS won't work on anything
>      which is not up to date.

OK - I think any pressure to get platforms to update their code is
only positive.
 
>   2) Guest support is strictly opt-in
> 
>      The underlying architecture/subarchitecture specific irqdomain has
>      to detect at setup time (eventually early boot), whether the
>      underlying hypervisor supports it.
> 
>      The only reasonable way to support that is the availability of
>      interrupt remapping via vIOMMU, as we discussed before.

This is talking about IMS specifically because of the legacy issue
where the MSI addr/data pair inside a guest is often completely fake?

>   4) The resulting irqdomain hierarchy would ideally look like this:
> 
>      VECTOR -> [IOMMU, ROUTING, ...] -> PCI/[MSI/MSI-X/IMS] domains

OK, this matches where I have come from as well
 
>      That does not work in all cases due to architecture and host
>      controller constraints, so we might end up with:
> 
>            VECTOR -> IOMMU -> SHIM -> PCI/[MSI/MSI-X/IMS] domains

OK - I dont' know enough about the architecture/controller details to
imagine what SHIM is, but if it allows keeping the PCI code as purely
PCI code, then great

>   5) The design rules for the device specific IMS irqdomains have to be
>      documented and enforced to the extent possible.
> 
>      Rules which I have in my notes as of today:
> 
>        - The device specific IMS irq chip / irqdomain has to be strictly
>          separated from the rest of the driver code and can only
>          interact via the irq chip data which is either per interrupt or
>          per device.

It seems OK with the observaion that IDXD and mlx5 will both need to
set 'per-interrupt' data before provisioning the IRQ

>          I have some ideas how to enforce these things to go into
>          drivers/irqchip/ so they are exposed to scrutiny and not
>          burried in some "my device is special" driver code and applied
>          by subsystem maintainers before anyone can even look at it. 

Means more modules, but OK
 
>        - The irqchip callbacks which can be implemented by these top
>          level domains are going to be restricted.

OK - I think it is great that the driver will see a special ops struct
that is 'ops for device's MSI addr/data pair storage'. It makes it
really clear what it is

>        - For the irqchip callbacks which are allowed/required the rules
>          vs. following down the hierarchy need to be defined and
>          enforced.

The driver should be the ultimate origin of the interrupt so it is
always end-point in the hierarchy, opposite the CPU?

I would hope the driver doesn't have an exposure to hierarchy?
 
>        - To achieve that the registration interface will not be based on
>          struct irq_chip. This will be a new representation and the core
>          will convert that into a proper irq chip which fits into the
>          hierarchy. This provides one central place where the hierarchy
>          requirements can be handled as they depend on the underlying
>          MSI domain (IOMMU, SHIM, etc.). Otherwise any change on that
>          would require to chase the IMS irqchips all over the place.

OK, I like this too.

So we have a new concept: 'device MSI storage ops'

Put them along with the xarray holding the msi_descs and you've got my
msi_table :)

 
>   2) The device centric storage concept will stay as it does not make
>      any sense to push it towards drivers and what's worse it would be a
>      major pain vs. the not yet up to the task irqdomains and the legacy
>      architecture backends to change that. I really have no interrest to
>      make the legacy code
> 
>      It also makes sense because the interrupts are strictly tied to the
>      device. They cannot originate from some disconnected layer of thin
>      air.
> 
>      Sorry Jason, no tables for you. :)

How does the driver select with 'device MSI storage ops' it is
requesting a MSI for ?

>   1) I'm going to post part 1-3 of the series once more with the fallout
>      and review comments addressed.

OK, I didn't see anything in there that was making anything harder in
this direction
 
>   5) Implement an IMS user.
> 
>      The obvious candidate which should be halfways accessible is the
>      ath11 PCI driver which falls into that category.

Aiiee:

drivers/net/wireless/ath/ath11k/pci.c:  ab_pci->msi_ep_base_data = msi_desc->msg.data;

So, we already have two in-tree PCI IMS devices!!

Agree this makes a lot of sense to focus on some first steps

Along with NTB which is in the same general camp

Thanksm
Jason
