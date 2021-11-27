Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id d5si755001ede.2.2021.11.27.11.22.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:22:27 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
In-Reply-To: <YaIiPISLr7VokL8P@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de> <YaIiPISLr7VokL8P@kroah.com>
Date: Sat, 27 Nov 2021 20:22:26 +0100
Message-ID: <87o865flot.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> No changelog?

Bah. This one should not be there at all.

> Anyway, why do we care about the number of decriptors?
>> +/**
>> + * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
>> + * @dev:	The device to read from
>> + *
>> + * Note: This is a lockless snapshot of msi_device_data::num_descs
>> + *
>> + * Returns the number of MSI descriptors which are allocated for @dev
>> + */
>> +unsigned int msi_device_num_descs(struct device *dev)
>> +{
>> +	if (dev->msi.data)
>> +		return dev->msi.data->num_descs;
>
> As this number can change after it is read, what will callers do with
> it?

I wanted to get rid of this, but then forgot. Getting old.

Thanks,

        tglx
