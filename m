Return-Path: <jgg@nvidia.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com. [40.107.92.65])
        by gmr-mx.google.com with ESMTPS id bj28si470534oib.2.2021.12.12.15.28.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 15:28:04 -0800 (PST)
Date: Sun, 12 Dec 2021 19:27:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211212232758.GL6385@nvidia.com>
References: <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 12, 2021 at 08:44:46AM +0200, Mika Penttilä wrote:

> > /*
> >   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> >   * which allows direct access to non-MSIX registers which happened to be within
> >   * the same system page.
> >   *
> >   * Even though the userspace gets direct access to the MSIX data, the existing
> >   * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
> >   */
> > #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE      3
> > 
> > IIRC this was introduced for PPC when a device has MSI-X in the same BAR as
> > other MMIO registers. Trapping MSI-X leads to performance downgrade on
> > accesses to adjacent registers. MSI-X can be mapped by userspace because
> > PPC already uses a hypercall mechanism for interrupt. Though unclear about
> > the detail it sounds a similar usage as proposed here.
> > 
> > Thanks
> > Kevin
>
> I see  VFIO_REGION_INFO_CAP_MSIX_MAPPABLE is always set so if msix table is
> in its own bar, qemu never traps/emulates the access. 

It is some backwards compat, the kernel always sets it to indicate a
new kernel, that doesn't mean qemu doesn't trap.

As the comment says, ""VFIO_DEVICE_SET_IRQS interface must still be
used for MSIX configuration"" so there is no way qemu can meet that
without either trapping the MSI page or using a special hypercall
(ppc)

Jason
