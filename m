Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id u2si809252qkp.6.2021.11.29.05.04.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:04:45 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 14/32] s390/pci: Rework MSI descriptor walk
In-Reply-To: <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.130164978@linutronix.de>
 <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
Date: Mon, 29 Nov 2021 14:04:43 +0100
Message-ID: <87fsrfdses.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Niklas Schnelle <schnelle@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Niklas,

On Mon, Nov 29 2021 at 11:31, Niklas Schnelle wrote:
> On Sat, 2021-11-27 at 02:23 +0100, Thomas Gleixner wrote:
>
> while the change looks good to me I ran into some trouble trying to
> test it. I tried with the git repository you linked in the cover
> letter:
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-3
>
> But with that I get the following linker error on s390:
>
> s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_setup_msi_irqs':
> /home/nschnelle/mainline/drivers/pci/msi/legacy.c:72: undefined reference to `msi_device_populate_sysfs'
> s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_teardown_msi_irqs':
> /home/nschnelle/mainline/drivers/pci/msi/legacy.c:78: undefined reference to `msi_device_destroy_sysfs'
> make: *** [Makefile:1161: vmlinux] Error 1

Yes, that got reported before and I fixed it locally already.

> This is caused by a misspelling of CONFIG_PCI_MSI_ARCH_FALLBACKS
> (missing the final S) in kernel/irq/msi.c. With that fixed everything
> builds and MSI IRQs work fine. So with that fixed you have my
>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for testing and dealing with my ineptness.

       tglx
