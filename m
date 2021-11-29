Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id d5si1114856ede.2.2021.11.29.06.46.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:46:01 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
In-Reply-To: <20211129140112.GX4670@nvidia.com>
References: <877dcsf5l5.ffs@tglx> <87o863e2j0.ffs@tglx>
 <20211129140112.GX4670@nvidia.com>
Date: Mon, 29 Nov 2021 15:46:00 +0100
Message-ID: <87a6hndnpz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Jason,

On Mon, Nov 29 2021 at 10:01, Jason Gunthorpe wrote:
> On Mon, Nov 29, 2021 at 10:26:11AM +0100, Thomas Gleixner wrote:
>> After looking at all the call sites again, there is no real usage for
>> this local index variable.
>> 
>> If anything needs the index of a descriptor then it's available in the
>> descriptor itself. That won't change because the low level message write
>> code needs the index too and the only accessible storage there is
>> msi_desc.
>
> Oh, that makes it simpler, just use the current desc->index as the
> input to the xa_for_each_start() and then there should be no need of
> hidden state?

That works for alloc, but on free that's going to end up badly.

>> What for? The usage sites should not have to care about the storage
>> details of a facility they are using.
>
> Generally for_each things shouldn't have hidden state that prevents
> them from being nested. It is just an unexpected design pattern..

I'm not seeing any sensible use case for:

     msi_for_each_desc(dev)
        msi_for_each_desc(dev)

If that ever comes forth, I'm happy to debate this further :)

Thanks,

        tglx
