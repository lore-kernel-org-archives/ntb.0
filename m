Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id 138si70011wme.0.2021.12.09.12.07.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:07:20 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 02/31] genirq/msi: Add mutex for MSI list protection
In-Reply-To: <20211209004702.GL6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210747.708877269@linutronix.de>
 <20211209004702.GL6385@nvidia.com>
Date: Thu, 09 Dec 2021 21:07:18 +0100
Message-ID: <87bl1pzgnd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 08 2021 at 20:47, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:51:05PM +0100, Thomas Gleixner wrote:
>> +++ b/kernel/irq/msi.c
>> @@ -127,12 +127,37 @@ int msi_setup_device_data(struct device
>>  		return -ENOMEM;
>>  
>>  	INIT_LIST_HEAD(&md->list);
>> +	mutex_init(&md->mutex);
>>  	dev->msi.data = md;
>>  	devres_add(dev, md);
>>  	return 0;
>>  }
>>  
>>  /**
>> + * msi_lock_descs - Lock the MSI descriptor storage of a device
>> + * @dev:	Device to operate on
>> + */
>> +void msi_lock_descs(struct device *dev)
>> +{
>> +	if (WARN_ON_ONCE(!dev->msi.data))
>> +		return;
>
> Is this useful? Other places that call msi_lock_descs will continue on and deref
> null dev->msi anyhow - is the dump from the WARN_ON that much better
> than the oops from the null deref here:
>
>> +	mutex_lock(&dev->msi.data->mutex);

I put it there for paranoia reasons and forgot to revist it later. In
that case yes, it's of questionable value.

Thanks,

        tglx
