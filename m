Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id i18si1705344qtx.0.2021.11.30.11.21.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:21:30 -0800 (PST)
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
Date: Tue, 30 Nov 2021 12:21:21 -0700
MIME-Version: 1.0
In-Reply-To: <87ilwacwp8.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
> At the conceptual level these interrupts are in separate irq domains:
> 
>      |   _______________________
>      |   |                      |
>      |   | NTB                  |
>      |   |                      |
>      |   | PCI config space     |
>      |   |     MSI-X space      | <- #1 Global or per IOMMU zone PCI/MSI domain
>      |   |_____________________ |
>      |---|                      |
>          | Memory window A      |
>          | Memory window ..     | <- #2 Per device NTB domain
>          | Memory window N      |
>          |______________________|
> 
> You surely can see the disctinction between #1 and #2, right?

I wouldn't say that's entirely obvious or even irrefutable. However, I'm
certainly open to this approach if it improves the code.

> I'm way too tired to come up with a proper solution for that, but that
> PCI_IRQ_VIRTUAL has to die ASAP.

I'm willing to volunteer a bit of my time to clean this up, but I'd need
a bit more direction on what a proper solution would look like. The MSI
domain code is far from well documented nor is it easy to understand.

Logan
