Return-Path: <gregkh@linuxfoundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org. [145.40.68.75])
        by gmr-mx.google.com with ESMTPS id o29si320474wms.1.2021.12.07.00.21.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:21:39 -0800 (PST)
Date: Tue, 7 Dec 2021 09:21:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch V2 29/31] genirq/msi: Add abuse prevention comment to msi
 header
Message-ID: <Ya8Zj+bADtKEISSP@kroah.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.170847844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210749.170847844@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06, 2021 at 11:51:49PM +0100, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -2,6 +2,20 @@
>  #ifndef LINUX_MSI_H
>  #define LINUX_MSI_H
>  
> +/*
> + * This header file contains MSI data structures and functions which are
> + * only relevant for:
> + *	- Interrupt core code
> + *	- PCI/MSI core code
> + *	- MSI interrupt domain implementations
> + *	- IOMMU, low level VFIO, NTB and other justified exceptions
> + *	  dealing with low level MSI details.
> + *
> + * Regular device drivers have no business with any of these functions and
> + * especially storing MSI descriptor pointers in random code is considered
> + * abuse. The only function which is relevant for drivers is msi_get_virq().
> + */
> +
>  #include <linux/cpumask.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> 

Ah, to be young and idealistic and hope that kernel developers read
comments in header files :)

You might want to add this to the driver-api kernel doc build?

Anyway, looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
