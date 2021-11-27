Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id c2si1957387wmq.2.2021.11.27.11.31.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:31:38 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
In-Reply-To: <YaIlX8bef2jPLkUE@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de> <YaIlX8bef2jPLkUE@kroah.com>
Date: Sat, 27 Nov 2021 20:31:37 +0100
Message-ID: <87lf19fl9i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27 2021 at 13:32, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
>> The sysfs handling for MSI is a convoluted maze and it is in the way of
>> supporting dynamic expansion of the MSI-X vectors because it only supports
>> a one off bulk population/free of the sysfs entries.
>> 
>> Change it to do:
>> 
>>    1) Creating an empty sysfs attribute group when msi_device_data is
>>       allocated
>> 
>>    2) Populate the entries when the MSI descriptor is initialized
>
> How much later does this happen?  Can it happen while the device has a
> driver bound to it?

That's not later than before. It's when the driver initializes the
MSI[X] interrupts, which usually happens in the probe() function.

The difference is that the group, (i.e.) directory is created slightly
earlier.

>> +
>> +static inline int msi_sysfs_create_group(struct device *dev)
>> +{
>> +	return devm_device_add_group(dev, &msi_irqs_group);
>
> Much nicer, but you changed the lifetime rules of when these attributes
> will be removed, is that ok?

The msi entries are removed at the same place as they are removed in the
current mainline code, i.e. when the device driver shuts the device
down and disables MSI[X], which happens usually during remove()

What's different now is that the empty group stays around a bit
longer. I don't see how that matters.

> I still worry that these attributes show up "after" the device is
> registered with the driver core, but hey, it's no worse than it
> currently is, so that's not caused by this patch series...

Happens that register before or after driver->probe()?

>> -		}
>> +	desc->sysfs_attrs = NULL;
>> +	for (i = 0; i < desc->nvec_used; i++) {
>> +		if (attrs[i].show)
>> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
>> +		kfree(attrs[i].attr.name);
>
> That's a cute hack, but should be documented somewhere in the code (that
> if there is no show function, that means no attribute was registered
> here).
>
> If you add a comment for this (either here or when you register the
> attribute), feel free to add:

Will do.

Thanks,

        tglx
