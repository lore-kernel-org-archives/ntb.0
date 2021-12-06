Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id s8si631257edx.4.2021.12.06.07.06.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:06:21 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206141922.GZ4670@nvidia.com>
References: <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com> <87v9044fkb.ffs@tglx>
 <20211206141922.GZ4670@nvidia.com>
Date: Mon, 06 Dec 2021 16:06:20 +0100
Message-ID: <87lf0x4vtf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

Jason,

On Mon, Dec 06 2021 at 10:19, Jason Gunthorpe wrote:
> On Sat, Dec 04, 2021 at 03:20:36PM +0100, Thomas Gleixner wrote:
>> even try to make the irqchip/domain code mangled into the other device
>> code. It should create the irqdomain with the associated chip and that
>> creation process returns a cookie which is passed to the actual device
>> specific code. Allocation then can use that cookie and not the irqdomain
>> pointer itself.
>
> Sounds like your cookie == my msi_table? Maybe we are all agreeing at
> this point then?

I think so. It's going to be something the driver can use as a
reference. Same for the actual interrupt allocated through this domain
reference.

>> So thanks for being patient in educating me here.
>
> I'm happy you got something out of all these words!

Definitely so. That's why we are having these discussions, right?

The shiny irq subsystem is not so shiny when the drivers cannot use
it. OTOH, it's often enough the case that driver folks want to use it
the wrong way just because.

> Yes, it is amazing how many patches this is at already.

Don't worry. You'll get a few more patch bombs in your inbox until IMS
is supported, unless you want to be "unsubscribed".

Thanks,

        tglx
