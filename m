Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id y8si14926lfj.0.2021.12.09.07.57.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:57:43 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
 <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Thu, 09 Dec 2021 16:57:41 +0100
Message-ID: <87mtl9zs7e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 09 2021 at 12:17, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> I think you are looking at that from the internal implementation details
>> of IDXD. But you can just model it in an IDXD implementation agnostic
>> way:
>> 
>>      ENQCMD(PASID, IMS-ENTRY,.....)
>
> Not exactly IMS-ENTRY. MSI-ENTRY also works.

Sure.

>> 
>> implies an on demand allocation of a virtual queue, which is deallocated
>> when the command completes. The PASID and IMS-ENTRY act as the 'queue'
>> identifier.
>> 
>> The implementation detail of IDXD that it executes these computations on
>> an internal shared workqueue does not change that.
>> 
>> Such a workqueue can only execute one enqueued command at a time,
>> which
>> means that during the execution of a particular command that IDXD
>> internal workqueue represents the 'virtual queue' which is identified by
>> the unique PASID/IMS-ENTRY pair.
>
> While it's one way of looking at this model do we want to actually
> create some objects to represent this 'virtual queue' concept? that
> implies each ENQCMD must be moderated to create such short-lifespan
> objects and I'm not sure the benefit of doing so.

You don't have to create anything. The PASID/ENTRY pair represents that
'virtual queue', right?

> If not then from driver p.o.v it's still one queue resource and driver 
> needs to manage its association with multiple interrupt entries and 
> PASIDs when it's connected to multiple clients.

That's correct, but there is nothing problematic with it. It's like
allocating multiple interrupts for any other hardware device or
subdevice, right?

What's probably more interresting is how the PASID/interrupt/RID
relations are managed.

Thanks,

        tglx

