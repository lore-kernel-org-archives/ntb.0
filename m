Return-Path: <jgg@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com. [40.107.94.78])
        by gmr-mx.google.com with ESMTPS id l9si623759pjf.1.2021.11.29.16.01.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 16:01:53 -0800 (PST)
Date: Mon, 29 Nov 2021 20:01:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211130000150.GB4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <20211129233133.GA4670@nvidia.com>
 <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 29, 2021 at 04:52:35PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2021-11-29 4:31 p.m., Jason Gunthorpe wrote:
> > On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:
> > 
> >> In most cases, the NTB code needs more interrupts than the hardware
> >> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> >> for: it allows the driver to request more interrupts than the hardware
> >> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> >> created, but get flagged with msi_attrib.is_virtual which ensures
> >> functions that program the MSI-X table don't try to write past the end
> >> of the hardware's table.
> > 
> > AFAICT what you've described is what Intel is calling IMS in other
> > contexts.
> > 
> > IMS is fundamentally a way to control MSI interrupt descriptors that
> > are not accessed through PCI SIG compliant means. In this case the NTB
> > driver has to do its magic to relay the addr/data pairs to the real
> > MSI storage in the hidden devices.
> 
> With current applications, it isn't that there is real "MSI storage"
> anywhere; the device on the other side of the bridge is always another
> Linux host which holds the address (or rather mw offset) and data in
> memory to use when it needs to trigger the interrupt of the other
> machine. 

Sure, that is fine "MSI Storage". The triggering device only needs to
store the addr/data pair someplace to be "MSI Storage".

Jason
