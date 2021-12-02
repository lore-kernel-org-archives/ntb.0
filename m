Return-Path: <jgg@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com. [40.107.220.89])
        by gmr-mx.google.com with ESMTPS id be25si456698oib.3.2021.12.02.06.45.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 06:45:17 -0800 (PST)
Date: Thu, 2 Dec 2021 10:45:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211202144514.GQ4670@nvidia.com>
References: <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <YajW6veanK4GZUkv@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajW6veanK4GZUkv@kroah.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 02, 2021 at 03:23:38PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 02, 2021 at 09:55:02AM -0400, Jason Gunthorpe wrote:
> > Further, there is no reason why IMS should be reserved exclusively for
> > VFIO! Why shouldn't the cdev be able to use IMS vectors too? It is
> > just a feature of the PCI device like MSI. If the queue has a PASID it
> > can use IDXD's IMS.
> 
> No, sorry, but a cdev is not for anything resembling any real resource
> at all.

My point is that when the user asks the driver to allocate a queue
through a cdev ioctl it should be able to get the queue attached to an
IMS, today it can only get a queue attached to a MSI.

> It is ONLY for the /dev/NODE interface that controls the character
> device api to userspace.  The struct device involved in it is ONLY for
> that, nothing else.  Any attempt to add things to it will be gleefully
> rejected.

I agree with you!
 
> > If we really need a 2nd struct device to turn on IMS then, I'd suggest
> > picking the cdev, as it keeps IMS and its allocator inside the IDXD
> > PCIe driver and not in the VFIO world.
> 
> No!  Again, a cdev is to control the lifespan/lifecycle of the /dev/NODE
> only.  Anything other than that is not ok to do at all.

Said the same thing in a prior email - which is why I think the only
logical choice here is to make IMS work on the pci_device

FWIW I feel the same way about the VFIO mdev - its *ONLY* purpose is
to control the lifecycle and we are close to stripping away all the
other abuses using it for other things.

Jason
