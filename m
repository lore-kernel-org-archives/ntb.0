Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id o29si200919wms.1.2021.12.15.12.50.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:50:59 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 21/31] soc: ti: ti_sci_inta_msi: Rework MSI
 descriptor allocation
In-Reply-To: <20211206210748.737904583@linutronix.de>
References: <20211206210600.123171746@linutronix.de>
 <20211206210748.737904583@linutronix.de>
Date: Wed, 15 Dec 2021 21:50:58 +0100
Message-ID: <87a6h1r3rh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Nishanth Menon <nm@ti.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 06 2021 at 23:51, Thomas Gleixner wrote:
>
> No functional change intended.

Famous last words.

>  static int ti_sci_inta_msi_alloc_descs(struct device *dev,
>  				       struct ti_sci_resource *res)
>  {
> -	struct msi_desc *msi_desc;
> +	struct msi_desc msi_desc;
>  	int set, i, count = 0;
>  
> +	memset(&msi_desc, 0, sizeof(msi_desc));

This fails to initialize msi_desc.nvec_used which makes the subsequent
interrupt allocation fail. Delta fix below.

Thanks,

        tglx
---
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -68,6 +68,7 @@ static int ti_sci_inta_msi_alloc_descs(s
 	int set, i, count = 0;
 
 	memset(&msi_desc, 0, sizeof(msi_desc));
+	msi_desc.nvec_used = 1;
 
 	for (set = 0; set < res->sets; set++) {
 		for (i = 0; i < res->desc[set].num; i++, count++) {
