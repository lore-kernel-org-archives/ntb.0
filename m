Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id i6si2175988qko.3.2021.11.30.13.23.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:23:18 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211130202800.GE4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
Date: Tue, 30 Nov 2021 22:23:16 +0100
Message-ID: <87o861banv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 30 2021 at 16:28, Jason Gunthorpe wrote:
> On Tue, Nov 30, 2021 at 08:48:03PM +0100, Thomas Gleixner wrote:
>> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
>> > On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>> >> I'm way too tired to come up with a proper solution for that, but that
>> >> PCI_IRQ_VIRTUAL has to die ASAP.
>> >
>> > I'm willing to volunteer a bit of my time to clean this up, but I'd need
>> > a bit more direction on what a proper solution would look like. The MSI
>> > domain code is far from well documented nor is it easy to understand.
>> 
>> Fair enough. I'm struggling with finding time to document that properly.
>> 
>> I've not yet made my mind up what the best way forward for this is, but
>> I have a few ideas which I want to explore deeper.
>
> I may have lost the plot in all of these patches, but I thought the
> direction was moving toward the msi_domain_alloc_irqs() approach IDXD
> demo'd here:
>
> https://lore.kernel.org/kvm/162164243591.261970.3439987543338120797.stgit@djiang5-desk3.ch.intel.com/

Yes, that's something I have in mind. Though this patch series would not
be really required to support IDXD, it's making stuff simpler.

The main point of this is to cure the VFIO issue of tearing down MSI-X
of passed through devices in order to expand the MSI-X vector space on
the host.

> I'd expect all the descriptor handling code in drivers/ntb/msi.c to
> get wrapped in an irq_chip instead of inserting a single-use callback
> to the pci core code's implementation:
>
> void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> {
>         if (entry->write_msi_msg)
>                 entry->write_msi_msg(entry, entry->write_msi_msg_data);
>
> If this doesn't become an irq_chip what other way is there to properly
> program the addr/data pair as drivers/ntb/msi.c is doing?

That's not the question. This surely will be a separate irq chip and a
separate irqdomain.

The real problem is where to store the MSI descriptors because the PCI
device has its own real PCI/MSI-X interrupts which means it still shares
the storage space.

IDXD is different in that regard because IDXD creates subdevices which
have their own struct device and they just store the MSI descriptors in
the msi data of that device.

I'm currently tending to partition the index space in the xarray:

 0x00000000 - 0x0000ffff          PCI/MSI-X
 0x00010000 - 0x0001ffff          NTB

which is feasible now with the range modifications and way simpler to do
with xarray than with the linked list.

Thanks,

        tglx


