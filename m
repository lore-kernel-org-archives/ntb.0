Return-Path: <kevin.tian@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id a1si262961wrv.4.2021.12.08.21.23.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:23:58 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Thu, 9 Dec 2021 05:23:42 +0000
Message-ID: <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
In-Reply-To: <878rx480fk.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave" <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc
 Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian
 Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, December 2, 2021 5:45 AM
>=20
> On Wed, Dec 01 2021 at 14:21, Dave Jiang wrote:
> > On 12/1/2021 1:25 PM, Thomas Gleixner wrote:
> >>> The hardware implementation does not have enough MSIX vectors for
> >>> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 I=
MS
> >>> vectors. So if we are to do MSI-X for all of them, then we need to do
> >>> the IMS backed MSIX scheme rather than passthrough IMS to guests.
> >> Confused. Are you talking about passing a full IDXD device to the gues=
t
> >> or about passing a carved out subdevice, aka. queue?
> >
> > I'm talking about carving out a subdevice. I had the impression of you
> > wanting IMS passed through for all variations. But it sounds like for a
> > sub-device, you are ok with the implementation of MSIX backed by IMS?
>=20
> I don't see anything wrong with that. A subdevice is it's own entity and
> VFIO can chose the most conveniant representation of it to the guest
> obviously.
>=20
> How that is backed on the host does not really matter. You can expose
> MSI-X to the guest with a INTx backing as well.
>=20

Agree with this point. How the interrupts are represented to the guest
is orthogonal to how the backend resource is allocated. Physically MSI-X=20
and IMS can be enabled simultaneously on an IDXD device. Once=20
dynamic allocation is allowed for both, either one can be allocated for
a subdevice (with only difference on supported #subdevices).=20

When an interrupt resource is exposed to the guest with the same type=20
(e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the=20
guest as long as a hypercall machinery is in place to get addr/data pair=20
from the host (as you suggested earlier).

Thanks
Kevin
