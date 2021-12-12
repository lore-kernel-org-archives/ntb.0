Return-Path: <jgg@nvidia.com>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2086.outbound.protection.outlook.com. [40.107.100.86])
        by gmr-mx.google.com with ESMTPS id l17si539776plb.1.2021.12.12.15.37.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 15:37:16 -0800 (PST)
Date: Sun, 12 Dec 2021 19:37:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211212233711.GN6385@nvidia.com>
References: <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsqxv8zf.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 12, 2021 at 09:55:32PM +0100, Thomas Gleixner wrote:
> Kevin,
> 
> On Sun, Dec 12 2021 at 01:56, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
> >> vIR related there.
> >
> > Well, virtio-iommu is a para-virtualized vIOMMU implementations.
> >
> > In reality there are also fully emulated vIOMMU implementations (e.g.
> > Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
> > the IR logic in existing iommu drivers just apply:
> >
> > 	drivers/iommu/intel/irq_remapping.c
> > 	drivers/iommu/amd/iommu.c
> 
> thanks for the explanation. So that's a full IOMMU emulation. I was more
> expecting a paravirtualized lightweight one.

Kevin can you explain what on earth vIR is for and how does it work??

Obviously we don't expose the IR machinery to userspace, so at best
this is somehow changing what the MSI trap does?

Jason
