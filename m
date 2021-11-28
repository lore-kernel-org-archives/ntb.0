Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id z3si1204201wmi.2.2021.11.28.11.23.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 11:23:16 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
In-Reply-To: <YaNi/YqN0ARC3h2z@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de> <YaIiPISLr7VokL8P@kroah.com>
 <87o865flot.ffs@tglx> <87ilwdfkmp.ffs@tglx> <YaNi/YqN0ARC3h2z@kroah.com>
Date: Sun, 28 Nov 2021 20:23:15 +0100
Message-ID: <874k7wf5jw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Nov 28 2021 at 12:07, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 08:45:18PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 27 2021 at 20:22, Thomas Gleixner wrote:
>> 
>> > On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
>> >> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
>> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> >>
>> >> No changelog?
>> >
>> > Bah. This one should not be there at all.
>> >
>> >> Anyway, why do we care about the number of decriptors?
>> 
>> The last part of this really cares about it for the dynamic extension
>> part, but that's core code which looks at the counter under the lock.
>
> Ah, that should be documented well as right now you are saying "this is
> done lockless" in the comment :)

I already zapped the whole patch as the function is not required for the
core code.

Thanks,

        tglx
