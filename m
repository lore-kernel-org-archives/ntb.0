Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id i17si1316674ila.3.2021.11.29.14.27.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:27:27 -0800 (PST)
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Date: Mon, 29 Nov 2021 15:27:20 -0700
MIME-Version: 1.0
In-Reply-To: <874k7ueldt.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>



On 2021-11-29 1:51 p.m., Thomas Gleixner wrote:
> Logan,
> 
> On Mon, Nov 29 2021 at 11:21, Logan Gunthorpe wrote:
>> On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
>>> Replace the about to vanish iterators, make use of the filtering and take
>>> the descriptor lock around the iteration.
>>
>> This patch looks good to me:
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> thanks for having a look at this. While I have your attention, I have a
> question related to NTB.
> 
> The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
> to allocate non-hardware backed MSI-X descriptors.
> 
> AFAIU these descriptors are not MSI-X descriptors in the regular sense
> of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
> usage is somewhere in NTB which has nothing to do with the way how the
> real MSI-X interrupts of a device work which explains why we have those
> pci.msi_attrib.is_virtual checks all over the place.
> 
> I assume that there are other variants feeding into NTB which can handle
> that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
> in that code.
> 
> Could you please shed some light on the larger picture of this?

Yes, of course. I'll try to explain:

The NTB code here is trying to create an MSI interrupt that is not
triggered by the PCI device itself but from a peer behind the
Non-Transparent Bridge (or, more carefully: from the CPU's perspective
the interrupt will come from the PCI device, but nothing in the PCI
device's firmware or hardware will have triggered the interrupt).

In most cases, the NTB code needs more interrupts than the hardware
actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
for: it allows the driver to request more interrupts than the hardware
advertises (ie. pci_msix_vec_count()). These extra interrupts are
created, but get flagged with msi_attrib.is_virtual which ensures
functions that program the MSI-X table don't try to write past the end
of the hardware's table.

The NTB code in drivers/ntb/msi.c uses these virtual MSI-X interrupts.
(Or rather it can use any interrupt: it doesn't care whether its virtual
or not, it would be fine if it is just a spare interrupt in hardware,
but in practice, it will usually be a virtual one). The code uses these
interrupts by setting up a memory window in the bridge to cover the MMIO
addresses of MSI-X interrupts. It communicates the offsets of the
interrupts (and the MSI message data) to the peer so that the peer can
trigger the interrupt simply by writing the message data to its side of
the memory window. (In the code: ntbm_msi_request_threaded_irq() is
called to request and interrupt which fills in the ntb_msi_desc with the
offset and data, which is transferred to the peer which would then use
ntb_msi_peer_trigger() to trigger the interrupt.)

Existing NTB hardware does already have what's called a doorbell which
provides the same functionally as the above technique. However, existing
hardware implementations of doorbells have significant latency and thus
slow down performance substantially. Implementing the MSI interrupts as
described above increased the performance of ntb_transport by more than
three times[1].

There aren't really other "variants". In theory, IDT hardware would also
require the same quirk but the drivers in the tree aren't quite up to
snuff and don't even support ntb_transport (so nobody has added
support). Intel and AMD drivers could probably do this as well (provided
they have extra memory windows) but I don't know that anyone has tried.

Let me know if anything is still unclear or you have further questions.
You can also read the last posting of the patch series[2] if you'd like
more information.

Logan

[1] 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
[2]
https://lore.kernel.org/all/20190523223100.5526-1-logang@deltatee.com/T/#u




