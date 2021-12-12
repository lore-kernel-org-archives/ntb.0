Return-Path: <kevin.tian@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id u19si409968ljl.5.2021.12.11.17.56.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Dec 2021 17:56:37 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Sun, 12 Dec 2021 01:56:31 +0000
Message-ID: <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
In-Reply-To: <875yrvwavf.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Saturday, December 11, 2021 9:05 PM
>=20
> Kevin,
>=20
> On Sat, Dec 11 2021 at 07:44, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> On Fri, Dec 10 2021 at 08:39, Jason Gunthorpe wrote:
> >> > It is clever, we don't have an vIOMMU that supplies vIR today, so by
> >> > definition all guests are excluded and only bare metal works.
> >>
> >> Dammit. Now you spilled the beans. :)
> >
> > Unfortunately we do have that today. Qemu supports IR for
> > both AMD and Intel vIOMMU.
>=20
> can you point me to the code?
>=20
> All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
> vIR related there.
>=20

Well, virtio-iommu is a para-virtualized vIOMMU implementations.

In reality there are also fully emulated vIOMMU implementations (e.g.
Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
the IR logic in existing iommu drivers just apply:

	drivers/iommu/intel/irq_remapping.c
	drivers/iommu/amd/iommu.c
	...

As I replied in another mail, the 1st vIR implementation was introduced
to Qemu back to 2016:

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

Thanks
Kevin
