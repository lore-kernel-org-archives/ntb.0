Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id o19si121887wme.2.2021.12.06.14.21.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:21:22 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206210609.GN4670@nvidia.com>
References: <87o85y63m8.ffs@tglx> <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx> <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx> <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com> <87fsr54tw1.ffs@tglx>
 <20211206170035.GJ4670@nvidia.com> <875ys14gw0.ffs@tglx>
 <20211206210609.GN4670@nvidia.com>
Date: Mon, 06 Dec 2021 23:21:21 +0100
Message-ID: <87zgpd2x3y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06 2021 at 17:06, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 09:28:47PM +0100, Thomas Gleixner wrote:
>> I wish I could mask underneath for some stuff on x86. Though that would
>> not help with the worst problem vs. affinity settings. See the horrible
>> dance in:
>
> My thinking here is that this stuff in ARM is one of the different
> cases (ie not using MSI_FLAG_USE_DEF_CHIP_OPS), and I guess we can
> just handle it cleanly by having the core call both the irq_chip->mask
> and the msi_storage_ops->mask and we don't need ARM to be different,
> x86 just won't provide a mask at destination op.
>
>>     x86/kernel/apic/msi.c::msi_set_affinity()
>
> Okay, so it is complicated, but it is just calling
>    irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
>
> So, from a msi_storage_ops perspective, things are still clean.

Yes.

>> You forgot IO/APIC which is a MSI endpoint too, just more convoluted but
>> it's not using MSI domains so it's not in the way. I'm not going to
>> touch that with a ten foot pole. :)
>
> I left off IOAPIC because I view it as conceptually different. I used
> the phrasse "device that originated the interrupt" deliberately,
> IOAPIC is just a middle box that converts from a physical interrupt
> line to a message world, it belongs with the physical interrupt
> infrastructure.

I mentioned it because there is mbigen on arm64 which is the same thing,
translates hundreds of wire inputs into MSI. It's even worse than
IO/APIC. There is a horrible hack to make it "work" which Marc and I are
looking at whether we can kill it on the way.

> Possibly the IOAPIC considerations is what motivated some of this to
> look the way it does today, because it really was trying to hide MSI
> under normal PCI INTX physical pins with full compatability. We kind
> of kept doing that as MSI grew into its own thing.

Not really. It was more to avoid having a complete separate
infrastructure for irqdomain based MSI[X]. Lazyness and lack of time
added the rest of non-motivation :)

> I'm curious to see if you end up with irq_domains and irq_chips along
> with what I labeled as the msi_storage above, or if those turn out to
> be unnecesary for the driver to provide MSI programming.

I cant avoid irq chips because from the interrupt handling side of view
that's unavoidable unless we create a duplicate zoo there. What I have
in mind is to convert the msi ops provided by the device driver into a
real chip as that just falls in place without further changes.

The irqdomain will be real as well just to make things consistent and to
share as much code as possible.

> Also, if msi_storage_ops can be robust enough you'd be comfortable
> with it in a driver .c file and just a regex match in the MAINTAINERS
> file :)

That might work. Let's see when we are there.

>>    - Have a transition mechanism to convert one part at a time to keep
>>      the patch sizes reviewable and the whole mess bisectable.
>
> This seems difficult all on its own..

I've done that before. It just needs some thought.

Thanks,

        tglx
