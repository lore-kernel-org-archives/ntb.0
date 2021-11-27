Return-Path: <gregkh@linuxfoundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [139.178.84.217])
        by gmr-mx.google.com with ESMTPS id z64si1401337wmc.0.2021.11.27.04.19.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 04:19:12 -0800 (PST)
Date: Sat, 27 Nov 2021 13:19:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
Message-ID: <YaIiPISLr7VokL8P@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.708730446@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

No changelog?

Anyway, why do we care about the number of decriptors?


> ---
>  include/linux/msi.h |    3 +++
>  kernel/irq/msi.c    |   18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -156,6 +156,7 @@ enum msi_desc_filter {
>   * msi_device_data - MSI per device data
>   * @lock:		Spinlock to protect register access
>   * @properties:		MSI properties which are interesting to drivers
> + * @num_descs:		The number of allocated MSI descriptors for the device
>   * @attrs:		Pointer to the sysfs attribute group
>   * @platform_data:	Platform-MSI specific data
>   * @list:		List of MSI descriptors associated to the device
> @@ -166,6 +167,7 @@ enum msi_desc_filter {
>  struct msi_device_data {
>  	raw_spinlock_t			lock;
>  	unsigned long			properties;
> +	unsigned int			num_descs;
>  	const struct attribute_group    **attrs;
>  	struct platform_msi_priv_data	*platform_data;
>  	struct list_head		list;
> @@ -208,6 +210,7 @@ static inline unsigned int msi_get_virq(
>  
>  void msi_lock_descs(struct device *dev);
>  void msi_unlock_descs(struct device *dev);
> +unsigned int msi_device_num_descs(struct device *dev);
>  
>  struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
>  struct msi_desc *msi_next_desc(struct device *dev);
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -82,6 +82,7 @@ int msi_add_msi_desc(struct device *dev,
>  	desc->pci = init_desc->pci;
>  
>  	list_add_tail(&desc->list, &dev->msi.data->list);
> +	dev->msi.data->num_descs++;
>  	return 0;
>  }
>  
> @@ -109,6 +110,7 @@ int msi_add_simple_msi_descs(struct devi
>  		list_add_tail(&desc->list, &list);
>  	}
>  	list_splice_tail(&list, &dev->msi.data->list);
> +	dev->msi.data->num_descs += ndesc;
>  	return 0;
>  
>  fail:
> @@ -142,6 +144,7 @@ void msi_free_msi_descs_range(struct dev
>  			continue;
>  		list_del(&desc->list);
>  		free_msi_entry(desc);
> +		dev->msi.data->num_descs--;
>  	}
>  }
>  
> @@ -157,6 +160,21 @@ bool msi_device_has_property(struct devi
>  	return !!(dev->msi.data->properties & prop);
>  }
>  
> +/**
> + * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
> + * @dev:	The device to read from
> + *
> + * Note: This is a lockless snapshot of msi_device_data::num_descs
> + *
> + * Returns the number of MSI descriptors which are allocated for @dev
> + */
> +unsigned int msi_device_num_descs(struct device *dev)
> +{
> +	if (dev->msi.data)
> +		return dev->msi.data->num_descs;

As this number can change after it is read, what will callers do with
it?

thanks,

greg k-h
