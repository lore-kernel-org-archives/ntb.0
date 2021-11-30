Return-Path: <jgg@nvidia.com>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2076.outbound.protection.outlook.com. [40.107.212.76])
        by gmr-mx.google.com with ESMTPS id w6si789431ybt.0.2021.11.30.12.28.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:28:05 -0800 (PST)
Date: Tue, 30 Nov 2021 16:28:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211130202800.GE4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v909bf2k.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 30, 2021 at 08:48:03PM +0100, Thomas Gleixner wrote:
> Logan,
> 
> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
> > On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
> >> I'm way too tired to come up with a proper solution for that, but that
> >> PCI_IRQ_VIRTUAL has to die ASAP.
> >
> > I'm willing to volunteer a bit of my time to clean this up, but I'd need
> > a bit more direction on what a proper solution would look like. The MSI
> > domain code is far from well documented nor is it easy to understand.
> 
> Fair enough. I'm struggling with finding time to document that properly.
> 
> I've not yet made my mind up what the best way forward for this is, but
> I have a few ideas which I want to explore deeper.

I may have lost the plot in all of these patches, but I thought the
direction was moving toward the msi_domain_alloc_irqs() approach IDXD
demo'd here:

https://lore.kernel.org/kvm/162164243591.261970.3439987543338120797.stgit@djiang5-desk3.ch.intel.com/

I'd expect all the descriptor handling code in drivers/ntb/msi.c to
get wrapped in an irq_chip instead of inserting a single-use callback
to the pci core code's implementation:

void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
{
        if (entry->write_msi_msg)
                entry->write_msi_msg(entry, entry->write_msi_msg_data);

If this doesn't become an irq_chip what other way is there to properly
program the addr/data pair as drivers/ntb/msi.c is doing?

Jason
