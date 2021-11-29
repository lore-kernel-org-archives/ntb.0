Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id p10si355763plr.4.2021.11.29.01.26.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:26:14 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
In-Reply-To: <877dcsf5l5.ffs@tglx>
Date: Mon, 29 Nov 2021 10:26:11 +0100
Message-ID: <87o863e2j0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Jason,

On Sun, Nov 28 2021 at 20:22, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
>> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
>> I understand why that isn't desirable at this patch where the storage
>> would have to be a list_head pointer, but still, seems like an odd
>> place to end up at the end of the series.
>>
>> eg add index here unused and then the last patch uses it instead of
>> __iter_idx.
>
> TBH, didn't think about doing just that. OTH, given the experience of
> looking at the creative mess people create, this was probably also a
> vain attempt to make it harder in the future.
>
>> Also, I don't understand why filter was stored in the dev and not
>> passed into msi_next_desc() in the macro here?
>
> No real reason. I probably just stored it along with the rest. Lemme try
> that index approach.

After looking at all the call sites again, there is no real usage for
this local index variable.

If anything needs the index of a descriptor then it's available in the
descriptor itself. That won't change because the low level message write
code needs the index too and the only accessible storage there is
msi_desc.

So the "gain" would be to have a pointless 'unsigned long index;'
variable at all usage sites.

What for? The usage sites should not have to care about the storage
details of a facility they are using.

So it might look odd in the first place, but at the end it's conveniant
and does not put any restrictions on changing the underlying mechanics.

Thanks,

        tglx

