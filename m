Return-Path: <jgg@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com. [40.107.93.68])
        by gmr-mx.google.com with ESMTPS id i18si503170qtx.0.2021.12.10.04.30.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 04:30:31 -0800 (PST)
Date: Fri, 10 Dec 2021 08:30:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211210123028.GD6385@nvidia.com>
References: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Dec 10, 2021 at 07:36:12AM +0000, Tian, Kevin wrote:

> /*
>  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>  * which allows direct access to non-MSIX registers which happened to be within
>  * the same system page.
>  *
>  * Even though the userspace gets direct access to the MSIX data, the existing
>  * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
     ^^^^^^^^^^^^^^^^^^^^^

It is this I think we don't want, there should be no hypervisor
involvment on installing the addr/data pair

Guessing by what I saw in PPC there is a hypercall to install a MSI
and the guest never touches the page even though it is
mapped. Presumably there is some IR like thing making this secured

PPC has the same basic problem, I think they have a hypercall to
install a MSI, not a hypercall to provision a generic addr/data pair.

Jason
