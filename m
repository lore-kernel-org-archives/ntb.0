Return-Path: <kevin.tian@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by gmr-mx.google.com with ESMTPS id y8si305367lfj.0.2021.12.09.04.17.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 04:17:45 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Thu, 9 Dec 2021 12:17:36 +0000
Message-ID: <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
In-Reply-To: <87pmq6ywu3.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc
 Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, December 9, 2021 5:03 PM
>=20
> Kevin,
>=20
> On Thu, Dec 09 2021 at 06:26, Kevin Tian wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> I don't know of any use case for more than one interrupt on a queue,
> >> and if it did come up I'd probably approach it by making the queue
> >> handle above also specify the 'queue relative HW index'
> >
> > We have such use case with IDXD.
> >
> > Basically the IDXD queue allows software to put an interrupt handle
> > (the index of MSI-X or IMS entry) in the submitted descriptor. Upon
> > completion of the descriptor the hardware finds the specified entry
> > and then generate interrupt to notify software.
> >
> > Conceptually descriptors submitted to a same queue can use different
> > handles, implying one queue can be associated to multiple interrupts.
>=20
> I think you are looking at that from the internal implementation details
> of IDXD. But you can just model it in an IDXD implementation agnostic
> way:
>=20
>      ENQCMD(PASID, IMS-ENTRY,.....)

Not exactly IMS-ENTRY. MSI-ENTRY also works.

>=20
> implies an on demand allocation of a virtual queue, which is deallocated
> when the command completes. The PASID and IMS-ENTRY act as the 'queue'
> identifier.
>=20
> The implementation detail of IDXD that it executes these computations on
> an internal shared workqueue does not change that.
>=20
> Such a workqueue can only execute one enqueued command at a time,
> which
> means that during the execution of a particular command that IDXD
> internal workqueue represents the 'virtual queue' which is identified by
> the unique PASID/IMS-ENTRY pair.
>=20
> No?
>=20

While it's one way of looking at this model do we want to actually
create some objects to represent this 'virtual queue' concept? that
implies each ENQCMD must be moderated to create such short-lifespan
objects and I'm not sure the benefit of doing so.

If not then from driver p.o.v it's still one queue resource and driver=20
needs to manage its association with multiple interrupt entries and=20
PASIDs when it's connected to multiple clients.

Thanks
Kevin
