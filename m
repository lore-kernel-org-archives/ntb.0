Return-Path: <jgg@nvidia.com>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com. [40.107.236.79])
        by gmr-mx.google.com with ESMTPS id a15si995233ilv.2.2021.12.12.15.42.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 15:42:56 -0800 (PST)
Date: Sun, 12 Dec 2021 19:42:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211212234206.GO6385@nvidia.com>
References: <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0qvfze.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf0qvfze.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 12, 2021 at 01:12:05AM +0100, Thomas Gleixner wrote:

>      PCI/MSI and PCI/MSI-X are just implementations of IMS
> 
> Not more, not less. The fact that they have very strict rules about the
> storage space and the fact that they are mutually exclusive does not
> change that at all.

And the mess we have is that virtualiation broke this
design. Virtualization made MSI/MSI-X special!

I am wondering if we just need to bite the bullet and force the
introduction of a new ACPI flag for the APIC that says one of:
- message addr/data pairs work correctly (baremetal)
- creating message addr/data pairs need to use a hypercall protocol
- property not defined so assume only MSI/MSI-X/etc work.

Intel was originally trying to do this with the 'IMS enabled' PCI
Capability block, but a per PCI device capability is in the wrong
layer.

Jason
