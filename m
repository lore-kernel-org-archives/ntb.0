Return-Path: <kevin.tian@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id f11si291227lfv.6.2021.12.10.23.53.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 23:53:05 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Sat, 11 Dec 2021 07:52:59 +0000
Message-ID: <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
In-Reply-To: <20211210123938.GF6385@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc
 Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian
 Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, December 10, 2021 8:40 PM
>=20
>=20
> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> > Again Qemu doesn't have such information since it doesn't know
> > which MSI[-X] entry points to this handle due to no trap.
>=20
> No this is already going wrong. qemu *cannot* know the MSI information
> because there is no MSI information for IMS.

I haven't thought of IMS at this step. The IR approach applies to
all types of interrupt storages, thus I'm more interested in how it
affect the storages which are already virtualized today (MSI[-X]=20
in my thought practice).

>=20
> All qemu should get is the origin device information and data about
> how the guest wants the interrupt setup.

yes, this is what I concluded in previous mail. The hypercall should
provide those information to the host and then get addr/data pair
back from the host.

>=20
> Forget about guests and all of this complexity, design how to make
> VFIO work with IMS in pure userspace like DPDK.
>=20
> We must have a VFIO ioctl to acquire a addr/data pair and link it to
> an event fd.

No question on it. Still need more thought down this road.

Thanks
Kevin
