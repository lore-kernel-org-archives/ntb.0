Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id y75si676748ybe.3.2021.11.29.16.29.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:29:42 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Date: Tue, 30 Nov 2021 01:29:39 +0100
Message-ID: <87ilwacwp8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

Logan,

On Mon, Nov 29 2021 at 15:27, Logan Gunthorpe wrote:
> On 2021-11-29 1:51 p.m., Thomas Gleixner wrote:
>> The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
>> to allocate non-hardware backed MSI-X descriptors.
>> 
>> AFAIU these descriptors are not MSI-X descriptors in the regular sense
>> of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
>> usage is somewhere in NTB which has nothing to do with the way how the
>> real MSI-X interrupts of a device work which explains why we have those
>> pci.msi_attrib.is_virtual checks all over the place.
>> 
>> I assume that there are other variants feeding into NTB which can handle
>> that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
>> in that code.
>> 
>> Could you please shed some light on the larger picture of this?
>
> Yes, of course. I'll try to explain:
>
> The NTB code here is trying to create an MSI interrupt that is not
> triggered by the PCI device itself but from a peer behind the
> Non-Transparent Bridge (or, more carefully: from the CPU's perspective
> the interrupt will come from the PCI device, but nothing in the PCI
> device's firmware or hardware will have triggered the interrupt).

That far I got.

> In most cases, the NTB code needs more interrupts than the hardware
> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> for: it allows the driver to request more interrupts than the hardware
> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> created, but get flagged with msi_attrib.is_virtual which ensures
> functions that program the MSI-X table don't try to write past the end
> of the hardware's table.
>
> The NTB code in drivers/ntb/msi.c uses these virtual MSI-X interrupts.
> (Or rather it can use any interrupt: it doesn't care whether its virtual
> or not, it would be fine if it is just a spare interrupt in hardware,
> but in practice, it will usually be a virtual one). The code uses these
> interrupts by setting up a memory window in the bridge to cover the MMIO
> addresses of MSI-X interrupts. It communicates the offsets of the
> interrupts (and the MSI message data) to the peer so that the peer can
> trigger the interrupt simply by writing the message data to its side of
> the memory window. (In the code: ntbm_msi_request_threaded_irq() is
> called to request and interrupt which fills in the ntb_msi_desc with the
> offset and data, which is transferred to the peer which would then use
> ntb_msi_peer_trigger() to trigger the interrupt.)

So the whole thing looks like this:

    PCIe
     |
     |   ________________________
     |   |                       |
     |   | NTB                   |
     |   |                       |
     |   | PCI config space      |
     |   |     MSI-X space       |
     |   |_______________________|
     |---|                       |
         | Memory window A       |
         | Memory window ..      |
         | Memory window N       |
         |_______________________|

The peers can inject an interrupt through the associated memory window
like the NTB device itself does via the real MSI-X interrupts by writing
the associated MSI message data to the associated address (either
directly to the targeted APIC or to the IOMMU table).

As this message goes through the NTB device it's tagged as originating
from the NTB PCIe device as seen by the IOMMU/Interrupt remapping unit.

So far so good.

I completely understand why you went down the road to add this
PCI_IRQ_VIRTUAL "feature", but TBH this should have never happened.

Why?

These interrupts have absolutely nothing to do with PCI/MSI-X as defined
by the spec and as handled by the PCI/MSI core.

The fact that the MSI message is transported by PCIe does not change
that at all, neither does it matter that from an IOMMU/Interrupt
remapping POV these messages are tagged to come from that particular
PCIe device.

At the conceptual level these interrupts are in separate irq domains:

     |   _______________________
     |   |                      |
     |   | NTB                  |
     |   |                      |
     |   | PCI config space     |
     |   |     MSI-X space      | <- #1 Global or per IOMMU zone PCI/MSI domain
     |   |_____________________ |
     |---|                      |
         | Memory window A      |
         | Memory window ..     | <- #2 Per device NTB domain
         | Memory window N      |
         |______________________|

You surely can see the disctinction between #1 and #2, right?

And because they are in different domains, they simply cannot share the
interrupt chip implementation taking care of the particular oddities of
the "hardware". I know, you made it 'shared' by adding these
'is_virtual' conditionals all over the place, but that pretty much
defeats the purpose of having separate domains.

This is also reflected in drivers/ntb/msi.c::ntbm_msi_request_threaded_irq():

	for_each_pci_msi_entry(entry, ntb->pdev) {
		if (irq_has_action(entry->irq))
			continue;

What on earth guarantees that this check has any relevance? Just because
an entry does not have an interrupt requested on it does not tell
anything.

That might be an actual entry which belongs to the physical PCI NTB
device MSI-X space which is not requested yet. Just because that
swichtec device does not fall into that category does not make it any
more correct.

Seriously, infrastructure code which relies on undocumented assumptions
based on a particular hardware device is broken by definition.

I'm way too tired to come up with a proper solution for that, but that
PCI_IRQ_VIRTUAL has to die ASAP.

Thanks,

        tglx

