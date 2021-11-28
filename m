Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id i23si588247edr.1.2021.11.28.11.22.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 11:22:31 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
In-Reply-To: <20211128010037.GV4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.531194050@linutronix.de>
 <20211128010037.GV4670@nvidia.com>
Date: Sun, 28 Nov 2021 20:22:30 +0100
Message-ID: <877dcsf5l5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
>> + * Notes:
>> + *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
>> + *    pair.
>> + *  - It is safe to remove a retrieved MSI descriptor in the loop.
>> + */
>> +#define msi_for_each_desc_from(desc, dev, filter, base_index)			\
>> +	for ((desc) = __msi_first_desc((dev), (filter), (base_index)); (desc);	\
>> +	     (desc) = msi_next_desc((dev)))
>
> Given this ends up as an xarray it feels really weird that there is a
> hidden shared __next/__iter_idx instead of having the caller provide
> the index storage as is normal for xa operations.
>
> I understand why that isn't desirable at this patch where the storage
> would have to be a list_head pointer, but still, seems like an odd
> place to end up at the end of the series.
>
> eg add index here unused and then the last patch uses it instead of
> __iter_idx.

TBH, didn't think about doing just that. OTH, given the experience of
looking at the creative mess people create, this was probably also a
vain attempt to make it harder in the future.

> Also, I don't understand why filter was stored in the dev and not
> passed into msi_next_desc() in the macro here?

No real reason. I probably just stored it along with the rest. Lemme try
that index approach.

Thanks,

        tglx
