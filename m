Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id m13si290672lji.2.2022.01.18.16.00.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:00:16 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] genirq/msi: Populate sysfs entry only once
In-Reply-To: <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de> <87leznqx2a.ffs@tglx>
 <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com>
Date: Wed, 19 Jan 2022 00:59:58 +0100
Message-ID: <87a6fsa935.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Kunihiko,

On Wed, Jan 12 2022 at 09:05, Kunihiko Hayashi wrote:
> Is this fix the same as below?
> https://marc.info/?l=linux-kernel&m=164061119923119&w=2

pretty much the same, but I missed that patch. I was off for 2+ weeks
and on return Boris poked me about this issue and I fixed it. Then I
went ahead and marked all vacation mail read as I always do :)

So sorry for not noticing that patch.

Thanks,

        Thomas
