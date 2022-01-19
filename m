Return-Path: <hayashi.kunihiko@socionext.com>
Received: from mx.socionext.com (mx.socionext.com. [202.248.49.38])
        by gmr-mx.google.com with ESMTP id z10si901929pgv.0.2022.01.19.00.45.05
        for <linux-ntb@googlegroups.com>;
        Wed, 19 Jan 2022 00:45:05 -0800 (PST)
Subject: Re: [patch] genirq/msi: Populate sysfs entry only once
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de> <87leznqx2a.ffs@tglx>
 <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com> <87a6fsa935.ffs@tglx>
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <7d6445e9-011f-60ec-0fd0-3c354d507d57@socionext.com>
Date: Wed, 19 Jan 2022 17:45:01 +0900
MIME-Version: 1.0
In-Reply-To: <87a6fsa935.ffs@tglx>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Cedric Le Goater <clg@kaod.org>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Thomas,

On 2022/01/19 8:59, Thomas Gleixner wrote:
> Kunihiko,
> 
> On Wed, Jan 12 2022 at 09:05, Kunihiko Hayashi wrote:
>> Is this fix the same as below?
>> https://marc.info/?l=linux-kernel&m=164061119923119&w=2
> 
> pretty much the same, but I missed that patch. I was off for 2+ weeks
> and on return Boris poked me about this issue and I fixed it. Then I
> went ahead and marked all vacation mail read as I always do :)
> 
> So sorry for not noticing that patch.

No problem. If this issue wansn't resolved, the PCIe controller wouldn't
work properly, so I'm relieved to solve the issue and get your response.

Thank you,

---
Best Regards
Kunihiko Hayashi
