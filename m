Return-Path: <jgg@nvidia.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com. [40.107.92.79])
        by gmr-mx.google.com with ESMTPS id y7si302329oon.2.2021.12.06.09.00.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:00:38 -0800 (PST)
Date: Mon, 6 Dec 2021 13:00:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211206170035.GJ4670@nvidia.com>
References: <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
 <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com>
 <87fsr54tw1.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsr54tw1.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 04:47:58PM +0100, Thomas Gleixner wrote:

> >>        - The irqchip callbacks which can be implemented by these top
> >>          level domains are going to be restricted.
> >
> > OK - I think it is great that the driver will see a special ops struct
> > that is 'ops for device's MSI addr/data pair storage'. It makes it
> > really clear what it is
> 
> It will need some more than that, e.g. mask/unmask and as we discussed
> quite some time ago something like the irq_buslock/unlock pair, so you
> can handle updates to the state from thread context via a command queue
> (IIRC).

Yes, I was thinking about all of that in here.

Let me ask a slightly different question

pci_msi_create_irq_domain() hooks into the platforms irq_chip as an
alternative to hierarchical irq domains (?)

eg:

		chip->irq_write_msi_msg = pci_msi_domain_write_msg;

And we see:

void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
{
	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);

Now, if we have your idea to have some:

struct msi_storage_ops {
   write_msg
   mask;
   unmask;
   lock;
   unlock;
};

Which is how a driver plugs in its storage operations.

In almost all cases 'ops' will come along with a 'state', so lets
create one:

struct msi_storage {  // Look, I avoided the word table!
   const struct msi_storage_ops *ops
};

ie:

struct msi_storage_ops {
   void (*write_msg)(struct msi_storage *msi, struct msi_desc *desc, struct msi_msg *msg);


Now, what if we made a 'generic_msi_create_irq_domain()' that hooks
the irq_chip with something like this:

void generic_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
{
	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
	struct msi_storage *msi = desc->msi;

	msi->ops->write_msg(msi, desc, msg);
}

And then have what pci_msi_domain_write_msg() did now accomplished by
having it set desc->storage to a pci_msi_storage or pci_msix_storage
with those msi_storage_ops pointing at pci_msi_domain_write_msg/etc

Then we can transform:

void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
{
	struct pci_dev *dev = msi_desc_to_pci_dev(entry);

into

struct pci_msi_storage {
        struct msi_storage storage;
        struct pci_dev *dev;
	unsigned int msi_cap_off;
};

void pci_write_msi64_msg(struct msi_storage *storage,  struct msi_desc *desc, struct msi_msg *msg)
{
	struct pci_msi_storage *msi = container_of(storage, struct pci_msi_storage, storage);
	unsigned int pos = storage->msi_cap_off;
	struct pci_dev *dev = msi->dev;

	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
	msgctl |= desc->msi_attrib.multiple << 4;
	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);

	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, msg->address_hi);
	pci_write_config_word(dev, pos + PCI_MSI_DATA_64, msg->data);
	/* Ensure that the writes are visible in the device */
	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
	desc->msg = *msg; // in core code instead ?
}

And others for the different cases. Look no ifs!

OK?

Now, we have some duplication between the struct msi_storage_ops and
the struct irq_chip. Let's see what that is about:

arch/x86/kernel/apic/msi.c:     .irq_write_msi_msg      = dmar_msi_write_msg,
arch/x86/kernel/hpet.c: .irq_write_msi_msg = hpet_msi_write_msg,

Surprised! These are actually IMS. The HPET and DMAR devices both have
device-specific message storage! So these could use
msi_storage_ops. And WTF is IOMMU DMAR driver code doing in
apic/msi.c ???

arch/powerpc/platforms/pseries/msi.c:   .irq_write_msi_msg      = pseries_msi_write_msg,

AFAICT this is really like virtualization? The hypervisor is
controlling the real MSI table and what the OS sees is faked out
somewhat.

This is more of quirk in the PCI MSI implementation (do not touch the
storage) and a block on non-PCI uses of MSI similar to what x86 needs?

drivers/irqchip/irq-gic-v2m.c:  .irq_write_msi_msg      = pci_msi_domain_write_msg,
drivers/irqchip/irq-gic-v3-its-pci-msi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,
drivers/irqchip/irq-gic-v3-mbi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,

ARM seems to be replacing the 'mask at source' with 'mask at
destination' - I wonder why?

Should this really be hierarchical where we mask *both* the MSI
originating device (storage_ops->mask) and at the CPU IRQ controller?
(gicv2m_mask_msi_irq ?) if it can?

drivers/base/platform-msi.c:            chip->irq_write_msi_msg = platform_msi_write_msg;

Oh! this is doing what I kind of just suggested, just non-generically
and hacked into platform bus drivers the same as PCI does:

static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
{
	struct msi_desc *desc = irq_data_get_msi_desc(data);
	struct platform_msi_priv_data *priv_data;

	priv_data = desc->platform.msi_priv_data;

	priv_data->write_msg(desc, msg);
}

platform_msi entirely gets deleted. Instead all platform drivers using
it will use IMS - set up a msi_storage_ops with
storage_ops->write_msg == platform_msi_priv_data::write_msg and
allocate a msi_storage someplace.

So, at least at this first order, we could have world where the
irq_chip does not overlap struct msi_storage_ops - ie we move the MSI
related things from irq_chip to msi_storage_ops.

Then, all the core code places calling into chip->[msi] would instead 
find the msi_storage_op from the irq_data. ie like (or better)

  irq_data->desc->storage->ops

Now we have a real clear split of responsibility.

The irq_domain hierarchy and irq_chip is all about classic wired
interrupts and interrupt controller path after the device launches the
message. For MSI it's job is to determine the addr/data.

msi_storage_ops is all about interrupt origin points that can hold an
addr/data pair. It's job is to store the addr/data into the device
specific registers, do mask-at-source, locking etc.

PCI, HPET, DMAR move to msi_storage_ops instead of using irq_chip

Then you get what you asked at the start, the platform's irq_domain is
now fully generic and can be 1:N to different MSI storage providers.

For API compat every pci struct device will have to instantiate a
msi_storage someplace, but that seems easy enough.

Seems like a nice uniform solution?

Jason
