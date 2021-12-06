Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id 138si847125wme.0.2021.12.06.07.48.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:48:00 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206144344.GA4670@nvidia.com>
References: <87r1av7u3d.ffs@tglx> <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx> <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx> <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx> <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx> <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com>
Date: Mon, 06 Dec 2021 16:47:58 +0100
Message-ID: <87fsr54tw1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

Jason,

On Mon, Dec 06 2021 at 10:43, Jason Gunthorpe wrote:
> On Sun, Dec 05, 2021 at 03:16:40PM +0100, Thomas Gleixner wrote:
>> > That's not really a good idea because dev->irqdomain is a generic
>> > mechanism and not restricted to the PCI use case. Special casing it for
>> > PCI is just wrong. Special casing it for all use cases just to please
>> > PCI is equally wrong. There is a world outside of PCI and x86. 
>> 
>> That argument is actually only partially correct.
>
> I'm not sure I understood your reply? I think we are both agreeing
> that dev->irqdomain wants to be a generic mechanism?

Yes. I managed to confuse myself there by being too paranoid about how
to distinguish things on platforms which need to support both ways, i.e.
x86 when XEN is enabled.

> I'd say that today we've special cased it to handle PCI. IMHO that is
> exactly what pci_msi_create_irq_domain() is doing - it replaces the
> chip ops with ops that can *ONLY* do PCI MSI and so dev->irqdomain
> becomes PCI only and non-generic.

Right. See above. That's why I went back to my notes, did some more
research ...

>>   2) Guest support is strictly opt-in
>> 
>>      The underlying architecture/subarchitecture specific irqdomain has
>>      to detect at setup time (eventually early boot), whether the
>>      underlying hypervisor supports it.
>> 
>>      The only reasonable way to support that is the availability of
>>      interrupt remapping via vIOMMU, as we discussed before.
>
> This is talking about IMS specifically because of the legacy issue
> where the MSI addr/data pair inside a guest is often completely fake?

This is about IMS, right. PCI/MSI[x] is handled today because the writes
to the MSI/MSI-X message store can be trapped.

>>      That does not work in all cases due to architecture and host
>>      controller constraints, so we might end up with:
>> 
>>            VECTOR -> IOMMU -> SHIM -> PCI/[MSI/MSI-X/IMS] domains
>
> OK - I dont' know enough about the architecture/controller details to
> imagine what SHIM is, but if it allows keeping the PCI code as purely
> PCI code, then great

It's today part of the arch/subarch specific PCI/MSI domain to deal with
quirks above the IOMMU level. As we can't proliferate that into the new
endpoint domain, that needs to be done as a shim layer in between which
has no real other functionality than applying the quirks. Yes, it's all
pretty. Welcome to my wonderful world.

>>        - The irqchip callbacks which can be implemented by these top
>>          level domains are going to be restricted.
>
> OK - I think it is great that the driver will see a special ops struct
> that is 'ops for device's MSI addr/data pair storage'. It makes it
> really clear what it is

It will need some more than that, e.g. mask/unmask and as we discussed
quite some time ago something like the irq_buslock/unlock pair, so you
can handle updates to the state from thread context via a command queue
(IIRC).

>>        - For the irqchip callbacks which are allowed/required the rules
>>          vs. following down the hierarchy need to be defined and
>>          enforced.
>
> The driver should be the ultimate origin of the interrupt so it is
> always end-point in the hierarchy, opposite the CPU?
>
> I would hope the driver doesn't have an exposure to hierarchy?

No.
  
> So we have a new concept: 'device MSI storage ops'
>
> Put them along with the xarray holding the msi_descs and you've got my
> msi_table :)

Hehe.
  
>>      Sorry Jason, no tables for you. :)
>
> How does the driver select with 'device MSI storage ops' it is
> requesting a MSI for ?

Via some cookie, reference whatever as discussed in the other
mail. We'll bikeshed the naming once I get there :)

>>   1) I'm going to post part 1-3 of the series once more with the fallout
>>      and review comments addressed.
>
> OK, I didn't see anything in there that was making anything harder in
> this direction

It's helping to keep the existing stuff including the !irqdomain parts
sufficiently self contained so I can actually change the inner workings
of msi domains without going back to any of these places (hopefully).
  
>>   5) Implement an IMS user.
>> 
>>      The obvious candidate which should be halfways accessible is the
>>      ath11 PCI driver which falls into that category.
>
> Aiiee:

Yes.

> drivers/net/wireless/ath/ath11k/pci.c:  ab_pci->msi_ep_base_data = msi_desc->msg.data;

That's only one part of it. Look how the address is retrieved.

Thanks,

        tglx
