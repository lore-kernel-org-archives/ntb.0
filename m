Return-Path: <gregkh@linuxfoundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [139.178.84.217])
        by gmr-mx.google.com with ESMTPS id b11si729535lfv.12.2021.11.27.04.32.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 04:32:37 -0800 (PST)
Date: Sat, 27 Nov 2021 13:32:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
Message-ID: <YaIlX8bef2jPLkUE@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232736.135247787@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
> The sysfs handling for MSI is a convoluted maze and it is in the way of
> supporting dynamic expansion of the MSI-X vectors because it only supports
> a one off bulk population/free of the sysfs entries.
> 
> Change it to do:
> 
>    1) Creating an empty sysfs attribute group when msi_device_data is
>       allocated
> 
>    2) Populate the entries when the MSI descriptor is initialized

How much later does this happen?  Can it happen while the device has a
driver bound to it?

>    3) Free the entries when a MSI descriptor is detached from a Linux
>       interrupt.
> 
>    4) Provide functions for the legacy non-irqdomain fallback code to
>       do a bulk population/free. This code won't support dynamic
>       expansion.
> 
> This makes the code simpler and reduces the number of allocations as the
> empty attribute group can be shared.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |    7 +
>  kernel/irq/msi.c    |  196 +++++++++++++++++++++++-----------------------------
>  2 files changed, 95 insertions(+), 108 deletions(-)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -72,6 +72,7 @@ struct irq_data;
>  struct msi_desc;
>  struct pci_dev;
>  struct platform_msi_priv_data;
> +struct device_attribute;
>  
>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  #ifdef CONFIG_GENERIC_MSI_IRQ
> @@ -127,6 +128,7 @@ struct pci_msi_desc {
>   * @dev:	Pointer to the device which uses this descriptor
>   * @msg:	The last set MSI message cached for reuse
>   * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
> + * @sysfs_attr:	Pointer to sysfs device attribute
>   *
>   * @write_msi_msg:	Callback that may be called when the MSI message
>   *			address or data changes
> @@ -146,6 +148,9 @@ struct msi_desc {
>  #ifdef CONFIG_IRQ_MSI_IOMMU
>  	const void			*iommu_cookie;
>  #endif
> +#ifdef CONFIG_SYSFS
> +	struct device_attribute		*sysfs_attrs;
> +#endif
>  
>  	void (*write_msi_msg)(struct msi_desc *entry, void *data);
>  	void *write_msi_msg_data;
> @@ -171,7 +176,6 @@ enum msi_desc_filter {
>   * @lock:		Spinlock to protect register access
>   * @properties:		MSI properties which are interesting to drivers
>   * @num_descs:		The number of allocated MSI descriptors for the device
> - * @attrs:		Pointer to the sysfs attribute group
>   * @platform_data:	Platform-MSI specific data
>   * @list:		List of MSI descriptors associated to the device
>   * @mutex:		Mutex protecting the MSI list
> @@ -182,7 +186,6 @@ struct msi_device_data {
>  	raw_spinlock_t			lock;
>  	unsigned long			properties;
>  	unsigned int			num_descs;
> -	const struct attribute_group    **attrs;
>  	struct platform_msi_priv_data	*platform_data;
>  	struct list_head		list;
>  	struct mutex			mutex;
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -19,6 +19,7 @@
>  
>  #include "internals.h"
>  
> +static inline int msi_sysfs_create_group(struct device *dev);
>  #define dev_to_msi_list(dev)	(&(dev)->msi.data->list)
>  
>  /**
> @@ -208,6 +209,7 @@ static void msi_device_data_release(stru
>  int msi_setup_device_data(struct device *dev)
>  {
>  	struct msi_device_data *md;
> +	int ret;
>  
>  	if (dev->msi.data)
>  		return 0;
> @@ -216,6 +218,12 @@ int msi_setup_device_data(struct device
>  	if (!md)
>  		return -ENOMEM;
>  
> +	ret = msi_sysfs_create_group(dev);
> +	if (ret) {
> +		devres_free(md);
> +		return ret;
> +	}
> +
>  	raw_spin_lock_init(&md->lock);
>  	INIT_LIST_HEAD(&md->list);
>  	mutex_init(&md->mutex);
> @@ -395,6 +403,20 @@ int __msi_get_virq(struct device *dev, u
>  EXPORT_SYMBOL_GPL(__msi_get_virq);
>  
>  #ifdef CONFIG_SYSFS
> +static struct attribute *msi_dev_attrs[] = {
> +	NULL
> +};
> +
> +static const struct attribute_group msi_irqs_group = {
> +	.name	= "msi_irqs",
> +	.attrs	= msi_dev_attrs,
> +};
> +
> +static inline int msi_sysfs_create_group(struct device *dev)
> +{
> +	return devm_device_add_group(dev, &msi_irqs_group);

Much nicer, but you changed the lifetime rules of when these attributes
will be removed, is that ok?

I still worry that these attributes show up "after" the device is
registered with the driver core, but hey, it's no worse than it
currently is, so that's not caused by this patch series...

> @@ -404,97 +426,74 @@ static ssize_t msi_mode_show(struct devi
>  	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
>  }
>  
> -/**
> - * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
> - * @dev:	The device(PCI, platform etc) who will get sysfs entries
> - */
> -static const struct attribute_group **msi_populate_sysfs(struct device *dev)
> +static void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc)
>  {
> -	const struct attribute_group **msi_irq_groups;
> -	struct attribute **msi_attrs, *msi_attr;
> -	struct device_attribute *msi_dev_attr;
> -	struct attribute_group *msi_irq_group;
> -	struct msi_desc *entry;
> -	int ret = -ENOMEM;
> -	int num_msi = 0;
> -	int count = 0;
> +	struct device_attribute *attrs = desc->sysfs_attrs;
>  	int i;
>  
> -	/* Determine how many msi entries we have */
> -	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
> -		num_msi += entry->nvec_used;
> -	if (!num_msi)
> -		return NULL;
> +	if (!attrs)
> +		return;
>  
> -	/* Dynamically create the MSI attributes for the device */
> -	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
> -	if (!msi_attrs)
> -		return ERR_PTR(-ENOMEM);
> -
> -	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
> -		for (i = 0; i < entry->nvec_used; i++) {
> -			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> -			if (!msi_dev_attr)
> -				goto error_attrs;
> -			msi_attrs[count] = &msi_dev_attr->attr;
> -
> -			sysfs_attr_init(&msi_dev_attr->attr);
> -			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
> -							    entry->irq + i);
> -			if (!msi_dev_attr->attr.name)
> -				goto error_attrs;
> -			msi_dev_attr->attr.mode = 0444;
> -			msi_dev_attr->show = msi_mode_show;
> -			++count;
> -		}
> +	desc->sysfs_attrs = NULL;
> +	for (i = 0; i < desc->nvec_used; i++) {
> +		if (attrs[i].show)
> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
> +		kfree(attrs[i].attr.name);

That's a cute hack, but should be documented somewhere in the code (that
if there is no show function, that means no attribute was registered
here).

If you add a comment for this (either here or when you register the
attribute), feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
