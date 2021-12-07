Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id s8si860845edx.4.2021.12.07.04.46.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:46:19 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 29/31] genirq/msi: Add abuse prevention comment to
 msi header
In-Reply-To: <Ya8Zj+bADtKEISSP@kroah.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.170847844@linutronix.de> <Ya8Zj+bADtKEISSP@kroah.com>
Date: Tue, 07 Dec 2021 13:46:18 +0100
Message-ID: <87lf0w37mt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 07 2021 at 09:21, Greg Kroah-Hartman wrote:
> On Mon, Dec 06, 2021 at 11:51:49PM +0100, Thomas Gleixner wrote:
>>  #include <linux/cpumask.h>
>>  #include <linux/mutex.h>
>>  #include <linux/list.h>
>> 
> Ah, to be young and idealistic and hope that kernel developers read
> comments in header files :)

Hope dies last.

> You might want to add this to the driver-api kernel doc build?

When I do the next round of refactoring, I'm going to move the functions
which are available for drivers into a separate header file.

Thanks,

        tglx
