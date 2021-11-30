Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id w22si2017221qkp.2.2021.11.30.12.14.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:14:47 -0800 (PST)
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8a1fae8b-3811-6368-50da-9de9e286c8e5@deltatee.com>
Date: Tue, 30 Nov 2021 13:14:42 -0700
MIME-Version: 1.0
In-Reply-To: <87v909bf2k.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Doug Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2021-11-30 12:48 p.m., Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
>> On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>>> I'm way too tired to come up with a proper solution for that, but that
>>> PCI_IRQ_VIRTUAL has to die ASAP.
>>
>> I'm willing to volunteer a bit of my time to clean this up, but I'd need
>> a bit more direction on what a proper solution would look like. The MSI
>> domain code is far from well documented nor is it easy to understand.
> 
> Fair enough. I'm struggling with finding time to document that properly.
> 
> I've not yet made my mind up what the best way forward for this is, but
> I have a few ideas which I want to explore deeper.
> 
> But the most important question is right now on which architectures
> these switchtec virtual interrupt things are used.
> 
> If it's used on any architecture which does not use hierarchical
> irqdomains for MSI (x86, arm, arm64, power64), then using irqdomains is
> obviously a non-starter unless falling back to a single interrupt would
> not be considered a regression :)

Well that's a hard question to answer. The switchtec hardware is a very
generic PCI switch that can technically be used on any architecture that
supports PCI. However, NTB is a very specialized use case and only a
handful of companies have attempted to use it for anything, as is. I
can't say I know for sure, but my gut says the vast majority (if not
all) are using x86. Maybe some are trying with arm64 or power64, but the
only architecture not in that list that I'd conceivably think someone
might care about down the road might be riscv.

Most other NTB hardware (specifically AMD and Intel) are built into x86
CPUs so should be fine with this restriction.

I personally expect it would be fine to add a dependency on
CONFIG_IRQ_DOMAIN_HIERARCHY to CONFIG_NTB_MSI. However, I've copied Doug
from GigaIO who's the only user I know that might have a better informed
opinion on this.

Logan
