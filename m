Return-Path: <jgg@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com. [40.107.93.51])
        by gmr-mx.google.com with ESMTPS id bs32si2272476qkb.7.2021.12.06.13.06.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:06:12 -0800 (PST)
Date: Mon, 6 Dec 2021 17:06:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211206210609.GN4670@nvidia.com>
References: <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
 <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com>
 <87fsr54tw1.ffs@tglx>
 <20211206170035.GJ4670@nvidia.com>
 <875ys14gw0.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ys14gw0.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 09:28:47PM +0100, Thomas Gleixner wrote:

> That's already the plan in some form, but there's a long way towards
> that. See below.

Okay, then I think we are thinking the same sorts of things, it is
good to see
 
> Also there will be a question of how many different callbacks we're
> going to create just to avoid one conditional. At some point this might
> become silly.

Yes, but I think the the overal point is that it we could have ops
that do exactly what they need, and we can choose when we get there
which makes the most sense. ie the 64 vs 32 is probably silly.

> > Surprised! These are actually IMS. The HPET and DMAR devices both
> > have device-specific message storage! So these could use
> > msi_storage_ops. And WTF is IOMMU DMAR driver code doing in
> > apic/msi.c ???
> 
> Historical reasons coming from the pre irqdomain aera. Also DMAR needs
> direct access to the x86 low level composer which we didn't want to
> expose. Plus DMAR is shared with ia64 to make it more interesting.
>
> Yes, they can be converted. But that's the least of my worries. Those
> are straight forward and not really relevant for the design.
> 
> > arch/powerpc/platforms/pseries/msi.c:   .irq_write_msi_msg      = pseries_msi_write_msg,
> >
> > AFAICT this is really like virtualization? The hypervisor is
> > controlling the real MSI table and what the OS sees is faked out
> > somewhat.
> >
> > This is more of quirk in the PCI MSI implementation (do not touch the
> > storage) and a block on non-PCI uses of MSI similar to what x86 needs?
> 
> There is an underlying hypervisor of some sorts and that stuff needs to
> deal with it. I leave that to the powerpc wizards to sort out.
> 
> > drivers/irqchip/irq-gic-v2m.c:  .irq_write_msi_msg      = pci_msi_domain_write_msg,
> > drivers/irqchip/irq-gic-v3-its-pci-msi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,
> > drivers/irqchip/irq-gic-v3-mbi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,
> >
> > ARM seems to be replacing the 'mask at source' with 'mask at
> > destination' - I wonder why?
> 
> Because the majority of PCI/MSI endpoint implementations do not provide
> masking...
> 
> We're telling hardware people for 15+ years that this is a horrible
> idea, but it's as effective as talking to a wall. Sure the spec grants
> them to make my life miserable...
> 
> > Should this really be hierarchical where we mask *both* the MSI
> > originating device (storage_ops->mask) and at the CPU IRQ controller?
> > (gicv2m_mask_msi_irq ?) if it can?
> 
> I wish I could mask underneath for some stuff on x86. Though that would
> not help with the worst problem vs. affinity settings. See the horrible
> dance in:

My thinking here is that this stuff in ARM is one of the different
cases (ie not using MSI_FLAG_USE_DEF_CHIP_OPS), and I guess we can
just handle it cleanly by having the core call both the irq_chip->mask
and the msi_storage_ops->mask and we don't need ARM to be different,
x86 just won't provide a mask at destination op.

>     x86/kernel/apic/msi.c::msi_set_affinity()

Okay, so it is complicated, but it is just calling
   irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);

So, from a msi_storage_ops perspective, things are still clean.

> > PCI, HPET, DMAR move to msi_storage_ops instead of using irq_chip
> 
> With different parent domains. DMAR hangs always directly off the vector
> domain. HPET has its own IOMMU zone.
> 
> You forgot IO/APIC which is a MSI endpoint too, just more convoluted but
> it's not using MSI domains so it's not in the way. I'm not going to
> touch that with a ten foot pole. :)

I left off IOAPIC because I view it as conceptually different. I used
the phrasse "device that originated the interrupt" deliberately,
IOAPIC is just a middle box that converts from a physical interrupt
line to a message world, it belongs with the physical interrupt
infrastructure.

Possibly the IOAPIC considerations is what motivated some of this to
look the way it does today, because it really was trying to hide MSI
under normal PCI INTX physical pins with full compatability. We kind
of kept doing that as MSI grew into its own thing.

> > Seems like a nice uniform solution?
> 
> That's where I'm heading.

Okay, it looks like a lot TBH, but I think the direction is clean and
general.

I'm curious to see if you end up with irq_domains and irq_chips along
with what I labeled as the msi_storage above, or if those turn out to
be unnecesary for the driver to provide MSI programming.

Also, if msi_storage_ops can be robust enough you'd be comfortable
with it in a driver .c file and just a regex match in the MAINTAINERS
file :)

>    - Have a transition mechanism to convert one part at a time to keep
>      the patch sizes reviewable and the whole mess bisectable.

This seems difficult all on its own..

> I have a pretty good picture in my head and notes already, which needs
> to be dumped into code. But let me post part 1-3 V2 first, so that pile
> gets out of the way. Not having to juggle 90 patches makes life easier.

Okay! Thanks

Jason
