Return-Path: <jgg@nvidia.com>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com. [40.107.212.46])
        by gmr-mx.google.com with ESMTPS id i6si2259234qko.3.2021.11.30.16.17.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Nov 2021 16:17:51 -0800 (PST)
Date: Tue, 30 Nov 2021 20:17:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211201001748.GF4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o861banv.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:

> > If this doesn't become an irq_chip what other way is there to properly
> > program the addr/data pair as drivers/ntb/msi.c is doing?
> 
> That's not the question. This surely will be a separate irq chip and a
> separate irqdomain.

OK
 
> The real problem is where to store the MSI descriptors because the PCI
> device has its own real PCI/MSI-X interrupts which means it still shares
> the storage space.

Er.. I never realized that just looking at the patches :|

That is relevant to all real "IMS" users. IDXD escaped this because
it, IMHO, wrongly used the mdev with the IRQ layer. The mdev is purely
a messy artifact of VFIO, it should not be required to make the IRQ
layers work.

I don't think it makes sense that the msi_desc would point to a mdev,
the iommu layer consumes the msi_desc_to_dev(), it really should point
to the physical device that originates the message with a proper
iommu ops/data/etc.

> I'm currently tending to partition the index space in the xarray:
> 
>  0x00000000 - 0x0000ffff          PCI/MSI-X
>  0x00010000 - 0x0001ffff          NTB

It is OK, with some xarray work it can be range allocating & reserving
so that the msi_domain_alloc_irqs() flows can carve out chunks of the
number space..

Another view is the msi_domain_alloc_irqs() flows should have their
own xarrays..

> which is feasible now with the range modifications and way simpler to do
> with xarray than with the linked list.

Indeed!

Regards,
Jason
