Return-Path: <jgg@nvidia.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com. [40.107.92.85])
        by gmr-mx.google.com with ESMTPS id f19si674402iox.3.2021.11.27.17.00.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 17:00:41 -0800 (PST)
Date: Sat, 27 Nov 2021 21:00:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
Message-ID: <20211128010037.GV4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.531194050@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.531194050@linutronix.de>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
> In preparation for dynamic handling of MSI-X interrupts provide a new set
> of MSI descriptor accessor functions and iterators. They are benefitial per
> se as they allow to cleanup quite some code in various MSI domain
> implementations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>  include/linux/msi.h |   58 ++++++++++++++++++++++++++++
>  kernel/irq/msi.c    |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
> 
> +++ b/include/linux/msi.h
> @@ -140,6 +140,18 @@ struct msi_desc {
>  	struct pci_msi_desc		pci;
>  };
>  
> +/*
> + * Filter values for the MSI descriptor iterators and accessor functions.
> + */
> +enum msi_desc_filter {
> +	/* All descriptors */
> +	MSI_DESC_ALL,
> +	/* Descriptors which have no interrupt associated */
> +	MSI_DESC_NOTASSOCIATED,
> +	/* Descriptors which have an interrupt associated */
> +	MSI_DESC_ASSOCIATED,
> +};
> +
>  /**
>   * msi_device_data - MSI per device data
>   * @lock:		Spinlock to protect register access
> @@ -148,6 +160,8 @@ struct msi_desc {
>   * @platform_data:	Platform-MSI specific data
>   * @list:		List of MSI descriptors associated to the device
>   * @mutex:		Mutex protecting the MSI list
> + * @__next:		Cached pointer to the next entry for iterators
> + * @__filter:		Cached descriptor filter
>   */
>  struct msi_device_data {
>  	raw_spinlock_t			lock;
> @@ -156,6 +170,8 @@ struct msi_device_data {
>  	struct platform_msi_priv_data	*platform_data;
>  	struct list_head		list;
>  	struct mutex			mutex;
> +	struct msi_desc			*__next;
> +	enum msi_desc_filter		__filter;
>  };
>  
>  int msi_setup_device_data(struct device *dev);
> @@ -193,6 +209,48 @@ static inline unsigned int msi_get_virq(
>  void msi_lock_descs(struct device *dev);
>  void msi_unlock_descs(struct device *dev);
>  
> +struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
> +struct msi_desc *msi_next_desc(struct device *dev);
> +
> +/**
> + * msi_first_desc - Get the first MSI descriptor associated to the device
> + * @dev:	Device to search
> + */
> +static inline struct msi_desc *msi_first_desc(struct device *dev)
> +{
> +	return __msi_first_desc(dev, MSI_DESC_ALL, 0);
> +}
> +
> +
> +/**
> + * msi_for_each_desc_from - Iterate the MSI descriptors from a given index
> + *
> + * @desc:	struct msi_desc pointer used as iterator
> + * @dev:	struct device pointer - device to iterate
> + * @filter:	Filter for descriptor selection
> + * @base_index:	MSI index to iterate from
> + *
> + * Notes:
> + *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
> + *    pair.
> + *  - It is safe to remove a retrieved MSI descriptor in the loop.
> + */
> +#define msi_for_each_desc_from(desc, dev, filter, base_index)			\
> +	for ((desc) = __msi_first_desc((dev), (filter), (base_index)); (desc);	\
> +	     (desc) = msi_next_desc((dev)))

Given this ends up as an xarray it feels really weird that there is a
hidden shared __next/__iter_idx instead of having the caller provide
the index storage as is normal for xa operations.

I understand why that isn't desirable at this patch where the storage
would have to be a list_head pointer, but still, seems like an odd
place to end up at the end of the series.

eg add index here unused and then the last patch uses it instead of
__iter_idx.

Also, I don't understand why filter was stored in the dev and not
passed into msi_next_desc() in the macro here?

Jason
