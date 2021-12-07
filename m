Return-Path: <helgaas@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org. [145.40.73.55])
        by gmr-mx.google.com with ESMTPS id e33si82101ybi.2.2021.12.07.13.07.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:07:38 -0800 (PST)
Date: Tue, 7 Dec 2021 15:07:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch V2 09/31] PCI/MSI: Let core code free MSI descriptors
Message-ID: <20211207210732.GA78249@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210748.089085131@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:16PM +0100, Thomas Gleixner wrote:
> Set the domain info flag which tells the core code to free the MSI
> descriptors from msi_domain_free_irqs() and add an explicit call to the
> core function into the legacy code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    3 ++-
>  drivers/pci/msi/legacy.c    |    1 +
>  drivers/pci/msi/msi.c       |   14 --------------
>  3 files changed, 3 insertions(+), 15 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -171,7 +171,8 @@ struct irq_domain *pci_msi_create_irq_do
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
>  
> -	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
> +		       MSI_FLAG_FREE_MSI_DESCS;
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>  		info->flags |= MSI_FLAG_MUST_REACTIVATE;
>  
> --- a/drivers/pci/msi/legacy.c
> +++ b/drivers/pci/msi/legacy.c
> @@ -80,4 +80,5 @@ void pci_msi_legacy_teardown_msi_irqs(st
>  {
>  	msi_device_destroy_sysfs(&dev->dev);
>  	arch_teardown_msi_irqs(dev);
> +	msi_free_msi_descs(&dev->dev);
>  }
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -224,22 +224,8 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
>  
>  static void free_msi_irqs(struct pci_dev *dev)
>  {
> -	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
> -	struct msi_desc *entry, *tmp;
> -	int i;
> -
> -	for_each_pci_msi_entry(entry, dev)
> -		if (entry->irq)
> -			for (i = 0; i < entry->nvec_used; i++)
> -				BUG_ON(irq_has_action(entry->irq + i));
> -
>  	pci_msi_teardown_msi_irqs(dev);
>  
> -	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> -		list_del(&entry->list);
> -		free_msi_entry(entry);
> -	}
> -
>  	if (dev->msix_base) {
>  		iounmap(dev->msix_base);
>  		dev->msix_base = NULL;
> 
