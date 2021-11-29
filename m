Return-Path: <jgg@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com. [40.107.244.86])
        by gmr-mx.google.com with ESMTPS id s4si930658qtc.4.2021.11.29.15.31.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 15:31:36 -0800 (PST)
Date: Mon, 29 Nov 2021 19:31:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211129233133.GA4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:

> In most cases, the NTB code needs more interrupts than the hardware
> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> for: it allows the driver to request more interrupts than the hardware
> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> created, but get flagged with msi_attrib.is_virtual which ensures
> functions that program the MSI-X table don't try to write past the end
> of the hardware's table.

AFAICT what you've described is what Intel is calling IMS in other
contexts.

IMS is fundamentally a way to control MSI interrupt descriptors that
are not accessed through PCI SIG compliant means. In this case the NTB
driver has to do its magic to relay the addr/data pairs to the real
MSI storage in the hidden devices.

PCI_IRQ_VIRTUAL should probably be fully replaced by the new dynamic
APIs in the fullness of time..

> Existing NTB hardware does already have what's called a doorbell which
> provides the same functionally as the above technique. However, existing
> hardware implementations of doorbells have significant latency and thus
> slow down performance substantially. Implementing the MSI interrupts as
> described above increased the performance of ntb_transport by more than
> three times[1].

Does the doorbell scheme allow as many interrupts?

Jason
