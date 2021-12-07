Return-Path: <helgaas@kernel.org>
Received: from sin.source.kernel.org (sin.source.kernel.org. [2604:1380:40e1:4800::1])
        by gmr-mx.google.com with ESMTPS id r20si137639vsn.2.2021.12.07.13.08.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:08:09 -0800 (PST)
Date: Tue, 7 Dec 2021 15:08:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch V2 19/31] PCI: hv: Rework MSI handling
Message-ID: <20211207210803.GA78366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210748.629363944@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:33PM +0100, Thomas Gleixner wrote:
> Replace the about to vanish iterators and make use of the filtering. Take
> the descriptor lock around the iterators.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3445,18 +3445,23 @@ static int hv_pci_suspend(struct hv_devi
>  
>  static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
>  {
> -	struct msi_desc *entry;
>  	struct irq_data *irq_data;
> +	struct msi_desc *entry;
> +	int ret = 0;
>  
> -	for_each_pci_msi_entry(entry, pdev) {
> +	msi_lock_descs(&pdev->dev);
> +	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_data = irq_get_irq_data(entry->irq);
> -		if (WARN_ON_ONCE(!irq_data))
> -			return -EINVAL;
> +		if (WARN_ON_ONCE(!irq_data)) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
>  		hv_compose_msi_msg(irq_data, &entry->msg);
>  	}
> +	msi_unlock_descs(&pdev->dev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /*
> 
