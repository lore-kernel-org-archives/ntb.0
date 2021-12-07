Return-Path: <helgaas@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org. [145.40.68.75])
        by gmr-mx.google.com with ESMTPS id o29si180627wms.1.2021.12.07.13.07.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:07:48 -0800 (PST)
Date: Tue, 7 Dec 2021 15:07:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch V2 10/31] PCI/MSI: Use msi_on_each_desc()
Message-ID: <20211207210746.GA78295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210748.142603657@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:18PM +0100, Thomas Gleixner wrote:
> Use the new iterator functions which pave the way for dynamically extending
> MSI-X vectors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    4 ++--
>  drivers/pci/msi/legacy.c    |   19 ++++++++-----------
>  drivers/pci/msi/msi.c       |   30 ++++++++++++++----------------
>  3 files changed, 24 insertions(+), 29 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -83,7 +83,7 @@ static int pci_msi_domain_check_cap(stru
>  				    struct msi_domain_info *info,
>  				    struct device *dev)
>  {
> -	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
> +	struct msi_desc *desc = msi_first_desc(dev, MSI_DESC_ALL);
>  
>  	/* Special handling to support __pci_enable_msi_range() */
>  	if (pci_msi_desc_is_multi_msi(desc) &&
> @@ -98,7 +98,7 @@ static int pci_msi_domain_check_cap(stru
>  			unsigned int idx = 0;
>  
>  			/* Check for gaps in the entry indices */
> -			for_each_msi_entry(desc, dev) {
> +			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
>  				if (desc->msi_index != idx++)
>  					return -ENOTSUPP;
>  			}
> --- a/drivers/pci/msi/legacy.c
> +++ b/drivers/pci/msi/legacy.c
> @@ -28,7 +28,7 @@ int __weak arch_setup_msi_irqs(struct pc
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> -	for_each_pci_msi_entry(desc, dev) {
> +	msi_for_each_desc(desc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
>  		ret = arch_setup_msi_irq(dev, desc);
>  		if (ret)
>  			return ret < 0 ? ret : -ENOSPC;
> @@ -42,27 +42,24 @@ void __weak arch_teardown_msi_irqs(struc
>  	struct msi_desc *desc;
>  	int i;
>  
> -	for_each_pci_msi_entry(desc, dev) {
> -		if (desc->irq) {
> -			for (i = 0; i < desc->nvec_used; i++)
> -				arch_teardown_msi_irq(desc->irq + i);
> -		}
> +	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED) {
> +		for (i = 0; i < desc->nvec_used; i++)
> +			arch_teardown_msi_irq(desc->irq + i);
>  	}
>  }
>  
>  static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
>  {
> -	struct msi_desc *entry;
> +	struct msi_desc *desc;
>  	int avail = 0;
>  
>  	if (type != PCI_CAP_ID_MSIX || ret >= 0)
>  		return ret;
>  
>  	/* Scan the MSI descriptors for successfully allocated ones. */
> -	for_each_pci_msi_entry(entry, dev) {
> -		if (entry->irq != 0)
> -			avail++;
> -	}
> +	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED)
> +		avail++;
> +
>  	return avail ? avail : ret;
>  }
>  
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -299,7 +299,6 @@ static void __pci_restore_msix_state(str
>  
>  	if (!dev->msix_enabled)
>  		return;
> -	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
>  
>  	/* route the table */
>  	pci_intx_for_msi(dev, 0);
> @@ -309,7 +308,7 @@ static void __pci_restore_msix_state(str
>  	write_msg = arch_restore_msi_irqs(dev);
>  
>  	msi_lock_descs(&dev->dev);
> -	for_each_pci_msi_entry(entry, dev) {
> +	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>  		if (write_msg)
>  			__pci_write_msi_msg(entry, &entry->msg);
>  		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
> @@ -378,14 +377,14 @@ static int msi_verify_entries(struct pci
>  	if (!dev->no_64bit_msi)
>  		return 0;
>  
> -	for_each_pci_msi_entry(entry, dev) {
> +	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>  		if (entry->msg.address_hi) {
>  			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
>  				entry->msg.address_hi, entry->msg.address_lo);
> -			return -EIO;
> +			break;
>  		}
>  	}
> -	return 0;
> +	return !entry ? 0 : -EIO;
>  }
>  
>  /**
> @@ -418,7 +417,7 @@ static int msi_capability_init(struct pc
>  		goto unlock;
>  
>  	/* All MSIs are unmasked by default; mask them all */
> -	entry = first_pci_msi_entry(dev);
> +	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
>  	pci_msi_mask(entry, msi_multi_mask(entry));
>  
>  	/* Configure MSI capability structure */
> @@ -508,11 +507,11 @@ static int msix_setup_msi_descs(struct p
>  
>  static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
>  {
> -	struct msi_desc *entry;
> +	struct msi_desc *desc;
>  
>  	if (entries) {
> -		for_each_pci_msi_entry(entry, dev) {
> -			entries->vector = entry->irq;
> +		msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL) {
> +			entries->vector = desc->irq;
>  			entries++;
>  		}
>  	}
> @@ -705,15 +704,14 @@ static void pci_msi_shutdown(struct pci_
>  	if (!pci_msi_enable || !dev || !dev->msi_enabled)
>  		return;
>  
> -	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
> -	desc = first_pci_msi_entry(dev);
> -
>  	pci_msi_set_enable(dev, 0);
>  	pci_intx_for_msi(dev, 1);
>  	dev->msi_enabled = 0;
>  
>  	/* Return the device with MSI unmasked as initial states */
> -	pci_msi_unmask(desc, msi_multi_mask(desc));
> +	desc = msi_first_desc(&dev->dev, MSI_DESC_ALL);
> +	if (!WARN_ON_ONCE(!desc))
> +		pci_msi_unmask(desc, msi_multi_mask(desc));
>  
>  	/* Restore dev->irq to its default pin-assertion IRQ */
>  	dev->irq = desc->pci.msi_attrib.default_irq;
> @@ -789,7 +787,7 @@ static int __pci_enable_msix(struct pci_
>  
>  static void pci_msix_shutdown(struct pci_dev *dev)
>  {
> -	struct msi_desc *entry;
> +	struct msi_desc *desc;
>  
>  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
>  		return;
> @@ -800,8 +798,8 @@ static void pci_msix_shutdown(struct pci
>  	}
>  
>  	/* Return the device with MSI-X masked as initial states */
> -	for_each_pci_msi_entry(entry, dev)
> -		pci_msix_mask(entry);
> +	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
> +		pci_msix_mask(desc);
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>  	pci_intx_for_msi(dev, 1);
> 
