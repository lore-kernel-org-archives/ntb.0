Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id mu12si434441pjb.3.2021.12.01.10.37.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:37:35 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211201151121.GL4670@nvidia.com>
References: <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <871r2w9y3x.ffs@tglx> <20211201151121.GL4670@nvidia.com>
Date: Wed, 01 Dec 2021 19:37:32 +0100
Message-ID: <87sfvc893n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 01 2021 at 11:11, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 03:52:02PM +0100, Thomas Gleixner wrote:
>> So we really can go and create a MSI irqdomain and stick the pointer
>> into stdev->dev.irqdomain. The parent domain of this irqdomain is
>> 
>>      stdev->pdev.dev.irqdomain->parent
>
> It can work (pending some solution to the iommu stuff), but IMHO it is
> strange/hacky to put HW objects like irqdomain on what is a character
> struct device with a set major/minor in dev->devt and associated
> struct cdev.
>
> Conceptually it makes no sense to me, cdevs are software constructs,
> they should never go into HW areas..

I picked that because it _is_ already used to establish the connection
to the switchtec_class NTB driver which is beyond the usual cdev muck.

Thanks,

        tglx
