Return-Path: <kevin.tian@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id l13si376090lfg.1.2021.12.09.04.31.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 04:31:11 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Thu, 9 Dec 2021 12:31:05 +0000
Message-ID: <BN9PR11MB527661C48959F977AC3594438C709@BN9PR11MB5276.namprd11.prod.outlook.com>
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
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
In-Reply-To: <87sfv2yy19.ffs@tglx>
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
> Sent: Thursday, December 9, 2021 4:37 PM
>=20
> On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> I don't see anything wrong with that. A subdevice is it's own entity a=
nd
> >> VFIO can chose the most conveniant representation of it to the guest
> >> obviously.
> >>
> >> How that is backed on the host does not really matter. You can expose
> >> MSI-X to the guest with a INTx backing as well.
> >>
> >
> > Agree with this point. How the interrupts are represented to the guest
> > is orthogonal to how the backend resource is allocated. Physically MSI-=
X
> > and IMS can be enabled simultaneously on an IDXD device. Once
> > dynamic allocation is allowed for both, either one can be allocated for
> > a subdevice (with only difference on supported #subdevices).
> >
> > When an interrupt resource is exposed to the guest with the same type
> > (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the
> > guest as long as a hypercall machinery is in place to get addr/data pai=
r
> > from the host (as you suggested earlier).
>=20
> As I pointed out in the conclusion of this thread, IMS is only going to
> be supported with interrupt remapping in place on both host and guest.

I still need to read the last few mails but thanks for pointing it out now.

>=20
> As these devices are requiring a vIOMMU on the guest anyway (PASID, User
> IO page tables), the required hypercalls are part of the vIOMMU/IR
> implementation. If you look at it from the irqdomain hierarchy view:
>=20
>                          |- PCI-MSI
>   VECTOR -- [v]IOMMU/IR -|- PCI-MSI-X
>                          |- PCI-IMS
>=20
> So host and guest use just the same representation which makes a ton of
> sense.
>=20
> There are two places where this matters:
>=20
>   1) The activate() callback of the IR domain
>=20
>   2) The irq_set_affinity() callback of the irqchip associated with the
>      IR domain
>=20
> Both callbacks are allowed to fail and the error code is handed back to
> the originating call site.
>=20
> If you look at the above hierarchy view then MSI/MSI-X/IMS are all
> treated in exactly the same way. It all becomes the common case.
>=20
> No?
>=20

Yes, I think above makes sense.=20

For a new guest OS which supports this enlightened hierarchy the same
machinery works for all type of interrupt storages and we have a
failure path from host to guest in case of host-side resource shortage.
And no trap is required on guest access to the interrupt storage.

A legacy guest OS which doesn't support the enlightened hierarchy
can only use MSI/MSI-X which is still trapped. But with vector=20
reallocation support from your work the situation already improves=20
a lot than current awkward way in VFIO (free all previous vectors=20
and then re-allocate).

Overall I think this is a good modeling.

Thanks
Kevin
