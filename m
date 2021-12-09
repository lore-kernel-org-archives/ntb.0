Return-Path: <jgg@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com. [40.107.220.70])
        by gmr-mx.google.com with ESMTPS id 15si250622vkc.1.2021.12.08.17.01.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 17:01:04 -0800 (PST)
Date: Wed, 8 Dec 2021 21:01:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 00/31] genirq/msi, PCI/MSI: Spring cleaning - Part 3
Message-ID: <20211209010100.GM6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210600.123171746@linutronix.de>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:02PM +0100, Thomas Gleixner wrote:
> This is the third part of [PCI]MSI refactoring which aims to provide the
> ability of expanding MSI-X vectors after enabling MSI-X.

I read through this and didn't have any substantive remarks

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
