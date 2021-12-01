Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id q19si17845pfj.0.2021.12.01.06.52.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:52:05 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <87o861banv.ffs@tglx>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
Date: Wed, 01 Dec 2021 15:52:02 +0100
Message-ID: <871r2w9y3x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 30 2021 at 22:23, Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 16:28, Jason Gunthorpe wrote:
>
> The real problem is where to store the MSI descriptors because the PCI
> device has its own real PCI/MSI-X interrupts which means it still shares
> the storage space.

Bah. I confused myself by staring at the existing code instead of
looking at how this NTB stuff actually works.

So if I understand it correctly then the end result looks like this:

1) PCIe device (switchtec)

   The device has 4 MSI[X] interrupts: event, dma_rpc, message,
   doorbell. The event and dma_rpc interrupts are requested by the
   switchtec PCI driver itself.

2) Switchtec character device

   The switchtec PCI driver creates a character device which is exposed
   for device specific IOCTLs

   The device belongs to the switchtec_class device class.

3) Switchtec NTB device

   The ntb_hw_switchtec driver registers the switchtec_class class
   interface.

   So when #2 is registered with the driver core the switchtec class
   interface add_dev() function is invoked. That function creates a NTB
   device, requests the message and the doorbell interrupts which have
   been allocated by the underlying PCIe device driver (#1) and
   registers the NTB device with the NTB core.

4) The NTB core then tries to use the virtual MSI vectors which have
   been allocated by the switchtec driver in #1 and requires the msg
   write intercept to actually expose it to the peers.

So we really can go and create a MSI irqdomain and stick the pointer
into stdev->dev.irqdomain. The parent domain of this irqdomain is

     stdev->pdev.dev.irqdomain->parent

which is either the irq remapping domain or the vector domain. Which is
pretty much what I proposed as general facility for IMS/IDXD. I need to
go back and polish that up on top of the current pile.

Along with that have an irq chip implementation which exposes:

static struct irq_chip ntb_chip = {
	.name			= "ntb",
	.irq_ack		= irq_chip_ack_parent,
	.irq_write_msi_msg	= ntb_msi_write_msg,
#ifdef CONFIG_SMP
	.irq_set_affinity	= irq_chip_set_affinity_parent,
#endif
};

We just need some reasonable solution for the DMA/remap problem Jason
mentioned vs. msi_desc::dev, but that wants to be cleaned up in any
case for all the aliasing muck.

Thanks,

        tglx


