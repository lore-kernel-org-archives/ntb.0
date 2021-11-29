Return-Path: <jgg@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com. [40.107.93.82])
        by gmr-mx.google.com with ESMTPS id g8si312776vsk.0.2021.11.29.06.01.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:01:15 -0800 (PST)
Date: Mon, 29 Nov 2021 10:01:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
Message-ID: <20211129140112.GX4670@nvidia.com>
References: <877dcsf5l5.ffs@tglx>
 <87o863e2j0.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o863e2j0.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 29, 2021 at 10:26:11AM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Sun, Nov 28 2021 at 20:22, Thomas Gleixner wrote:
> > On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
> >> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
> >> I understand why that isn't desirable at this patch where the storage
> >> would have to be a list_head pointer, but still, seems like an odd
> >> place to end up at the end of the series.
> >>
> >> eg add index here unused and then the last patch uses it instead of
> >> __iter_idx.
> >
> > TBH, didn't think about doing just that. OTH, given the experience of
> > looking at the creative mess people create, this was probably also a
> > vain attempt to make it harder in the future.
> >
> >> Also, I don't understand why filter was stored in the dev and not
> >> passed into msi_next_desc() in the macro here?
> >
> > No real reason. I probably just stored it along with the rest. Lemme try
> > that index approach.
> 
> After looking at all the call sites again, there is no real usage for
> this local index variable.
> 
> If anything needs the index of a descriptor then it's available in the
> descriptor itself. That won't change because the low level message write
> code needs the index too and the only accessible storage there is
> msi_desc.

Oh, that makes it simpler, just use the current desc->index as the
input to the xa_for_each_start() and then there should be no need of
hidden state?

> What for? The usage sites should not have to care about the storage
> details of a facility they are using.

Generally for_each things shouldn't have hidden state that prevents
them from being nested. It is just an unexpected design pattern..

Jason
