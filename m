Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id u19si1435802ljl.5.2021.11.30.11.48.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:48:04 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
Date: Tue, 30 Nov 2021 20:48:03 +0100
Message-ID: <87v909bf2k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>

Logan,

On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
> On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>> I'm way too tired to come up with a proper solution for that, but that
>> PCI_IRQ_VIRTUAL has to die ASAP.
>
> I'm willing to volunteer a bit of my time to clean this up, but I'd need
> a bit more direction on what a proper solution would look like. The MSI
> domain code is far from well documented nor is it easy to understand.

Fair enough. I'm struggling with finding time to document that properly.

I've not yet made my mind up what the best way forward for this is, but
I have a few ideas which I want to explore deeper.

But the most important question is right now on which architectures
these switchtec virtual interrupt things are used.

If it's used on any architecture which does not use hierarchical
irqdomains for MSI (x86, arm, arm64, power64), then using irqdomains is
obviously a non-starter unless falling back to a single interrupt would
not be considered a regression :)

Thanks,

        tglx
