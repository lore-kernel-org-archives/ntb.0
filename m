Return-Path: <kevin.tian@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id w5si201497ede.3.2021.12.11.00.06.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Dec 2021 00:06:42 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Sat, 11 Dec 2021 08:06:36 +0000
Message-ID: <BN9PR11MB5276AD88A1D1A1AA313E228C8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0sy7xd.ffs@tglx>
In-Reply-To: <87lf0sy7xd.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, December 10, 2021 8:13 PM
>=20
> >>   5) It's not possible for the kernel to reliably detect whether it is
> >>      running on bare metal or not. Yes we talked about heuristics, but
> >>      that's something I really want to avoid.
> >
> > How would the hypercall mechanism avoid such heuristics?
>=20
> The availability of IR remapping where the irqdomain which is provided
> by the remapping unit signals that it supports this new scheme:
>=20
>                     |--IO/APIC
>                     |--MSI
>      vector -- IR --|--MSI-X
>                     |--IMS
>=20
> while the current scheme is:
>=20
>                     |--IO/APIC
>      vector -- IR --|--PCI/MSI[-X]
>=20
> or
>=20
>                     |--IO/APIC
>      vector --------|--PCI/MSI[-X]
>=20
> So in the new scheme the IR domain will advertise new features which are
> not available on older kernels. The availability of these new features
> is the indicator for the interrupt subsystem and subsequently for PCI
> whether IMS is supported or not.
>=20
> Bootup either finds an IR unit or not. In the bare metal case that's the
> usual hardware/firmware detection. In the guest case it's the
> availability of vIR including the required hypercall protocol.

Given we have vIR already, there are three scenarios:

1) Bare metal: IR (no hypercall, for sure)
2) VM: vIR (no hypercall, today)
3) VM: vIR (hypercall, tomorrow)

IMS should be allowed only for 1) and 3).

But how to differentiate 2) from 1) if no guest heuristics?

btw I checked Qemu history to find vIR was introduced in 2016:

commit 1121e0afdcfa0cd40e36bd3acff56a3fac4f70fd
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Jul 14 13:56:13 2016 +0800

    x86-iommu: introduce "intremap" property

    Adding one property for intel-iommu devices to specify whether we shoul=
d
    support interrupt remapping. By default, IR is disabled. To enable it,
    we should use (take Intel IOMMU as example):

      -device intel_iommu,intremap=3Don

    This property can be shared by Intel and future AMD IOMMUs.

    Signed-off-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

>=20
> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> > Again Qemu doesn't have such information since it doesn't know
> > which MSI[-X] entry points to this handle due to no trap.
> >
> > This implies that we may also need carry device ID, #msi entry, etc.
> > in the hypercall, so Qemu can associate the virtual routing info
> > to the right [irqfd, gsi].
> >
> > In your model the hypercall is raised by IR domain. Do you see
> > any problem of finding those information within IR domain?
>=20
> IR has the following information available:
>=20
>    Interrupt type
>     - MSI:   Device, index and number of vectors
>     - MSI-X: Device, index
>     - IMS:   Device, index
>=20
>   Target APIC/vector pair
>=20
> IMS: The index depends on the storage type:
>=20
>      For storage in device memory, e.g. IDXD, it's the array index.
>=20
>      For storage in system memory, the index is a software artifact.
>=20
> Does that answer your question?
>=20

Yes.

Thanks
Kevin
