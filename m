Return-Path: <jgg@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com. [40.107.93.49])
        by gmr-mx.google.com with ESMTPS id j18si189706pgb.5.2021.12.08.16.47.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:47:05 -0800 (PST)
Date: Wed, 8 Dec 2021 20:47:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 02/31] genirq/msi: Add mutex for MSI list protection
Message-ID: <20211209004702.GL6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210747.708877269@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210747.708877269@linutronix.de>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:05PM +0100, Thomas Gleixner wrote:
> +++ b/kernel/irq/msi.c
> @@ -127,12 +127,37 @@ int msi_setup_device_data(struct device
>  		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&md->list);
> +	mutex_init(&md->mutex);
>  	dev->msi.data = md;
>  	devres_add(dev, md);
>  	return 0;
>  }
>  
>  /**
> + * msi_lock_descs - Lock the MSI descriptor storage of a device
> + * @dev:	Device to operate on
> + */
> +void msi_lock_descs(struct device *dev)
> +{
> +	if (WARN_ON_ONCE(!dev->msi.data))
> +		return;

Is this useful? Other places that call msi_lock_descs will continue on and deref
null dev->msi anyhow - is the dump from the WARN_ON that much better
than the oops from the null deref here:

> +	mutex_lock(&dev->msi.data->mutex);

?

Honestly, still a bit unclear on what the community consensus is for
using WARN_ON.

Jason
