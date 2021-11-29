Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id t71si1338978lff.6.2021.11.29.12.51.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:51:11 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
Date: Mon, 29 Nov 2021 21:51:10 +0100
Message-ID: <874k7ueldt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>

Logan,

On Mon, Nov 29 2021 at 11:21, Logan Gunthorpe wrote:
> On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
>> Replace the about to vanish iterators, make use of the filtering and take
>> the descriptor lock around the iteration.
>
> This patch looks good to me:
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

thanks for having a look at this. While I have your attention, I have a
question related to NTB.

The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
to allocate non-hardware backed MSI-X descriptors.

AFAIU these descriptors are not MSI-X descriptors in the regular sense
of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
usage is somewhere in NTB which has nothing to do with the way how the
real MSI-X interrupts of a device work which explains why we have those
pci.msi_attrib.is_virtual checks all over the place.

I assume that there are other variants feeding into NTB which can handle
that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
in that code.

Could you please shed some light on the larger picture of this?

Thanks,

        tglx
