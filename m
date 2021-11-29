Return-Path: <schnelle@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com. [148.163.158.5])
        by gmr-mx.google.com with ESMTPS id l5si871665pfc.2.2021.11.29.02.31.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 02:31:17 -0800 (PST)
Message-ID: <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
Subject: Re: [patch 14/32] s390/pci: Rework MSI descriptor walk
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 29 Nov 2021 11:31:09 +0100
In-Reply-To: <20211126232735.130164978@linutronix.de>
References: <20211126230957.239391799@linutronix.de>
	 <20211126232735.130164978@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, 2021-11-27 at 02:23 +0100, Thomas Gleixner wrote:
> Replace the about to vanish iterators and make use of the filtering.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-s390@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *
>  
>  	/* Request MSI interrupts */
>  	hwirq = bit;
> -	for_each_pci_msi_entry(msi, pdev) {
> +	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
>  		rc = -EIO;
>  		if (hwirq - bit >= msi_vecs)
>  			break;
> @@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_d
>  		return;
>  
>  	/* Release MSI interrupts */
> -	for_each_pci_msi_entry(msi, pdev) {
> -		if (!msi->irq)
> -			continue;
> +	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_set_msi_desc(msi->irq, NULL);
>  		irq_free_desc(msi->irq);
>  		msi->msg.address_lo = 0;
> 

Hi Thomas,

while the change looks good to me I ran into some trouble trying to
test it. I tried with the git repository you linked in the cover
letter:
git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-3

But with that I get the following linker error on s390:

s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_setup_msi_irqs':
/home/nschnelle/mainline/drivers/pci/msi/legacy.c:72: undefined reference to `msi_device_populate_sysfs'
s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_teardown_msi_irqs':
/home/nschnelle/mainline/drivers/pci/msi/legacy.c:78: undefined reference to `msi_device_destroy_sysfs'
make: *** [Makefile:1161: vmlinux] Error 1

This is caused by a misspelling of CONFIG_PCI_MSI_ARCH_FALLBACKS
(missing the final S) in kernel/irq/msi.c. With that fixed everything
builds and MSI IRQs work fine. So with that fixed you have my

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Best regards,
Niklas

