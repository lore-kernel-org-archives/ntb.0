Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id v7si2147585pfm.6.2021.12.01.02.16.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 02:16:50 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211201001748.GF4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
Date: Wed, 01 Dec 2021 11:16:47 +0100
Message-ID: <87mtlkaauo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

Jason,

CC+ IOMMU folks

On Tue, Nov 30 2021 at 20:17, Jason Gunthorpe wrote:
> On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:
>> The real problem is where to store the MSI descriptors because the PCI
>> device has its own real PCI/MSI-X interrupts which means it still shares
>> the storage space.
>
> Er.. I never realized that just looking at the patches :|
>
> That is relevant to all real "IMS" users. IDXD escaped this because
> it, IMHO, wrongly used the mdev with the IRQ layer. The mdev is purely
> a messy artifact of VFIO, it should not be required to make the IRQ
> layers work.

> I don't think it makes sense that the msi_desc would point to a mdev,
> the iommu layer consumes the msi_desc_to_dev(), it really should point
> to the physical device that originates the message with a proper
> iommu ops/data/etc.

Looking at the device slices as subdevices with their own struct device
makes a lot of sense from the conceptual level. That makes is pretty
much obvious to manage the MSIs of those devices at this level like we
do for any other device.

Whether mdev is the right encapsulation for these subdevices is an
orthogonal problem.

I surely agree that msi_desc::dev is an interesting question, but we
already have this disconnect of msi_desc::dev and DMA today due to DMA
aliasing. I haven't looked at that in detail yet, but of course the
alias handling is substantially different accross the various IOMMU
implementations.

Though I fear there is also a use case for MSI-X and IMS tied to the
same device. That network card you are talking about might end up using
MSI-X for a control block and then IMS for the actual network queues
when it is used as physical function device as a whole, but that's
conceptually a different case.

>> I'm currently tending to partition the index space in the xarray:
>> 
>>  0x00000000 - 0x0000ffff          PCI/MSI-X
>>  0x00010000 - 0x0001ffff          NTB
>
> It is OK, with some xarray work it can be range allocating & reserving
> so that the msi_domain_alloc_irqs() flows can carve out chunks of the
> number space..
>
> Another view is the msi_domain_alloc_irqs() flows should have their
> own xarrays..

Yes, I was thinking about that as well. The trivial way would be:

    struct xarray     store[MSI_MAX_STORES];

and then have a store index for each allocation domain. With the
proposed encapsulation of the xarray handling that's definitely
feasible. Whether that buys much is a different question. Let me think
about it some more.

>> which is feasible now with the range modifications and way simpler to do
>> with xarray than with the linked list.
>
> Indeed!

I'm glad you like the approach.

Thanks,

        tglx


