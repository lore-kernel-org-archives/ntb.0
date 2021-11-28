Return-Path: <gregkh@linuxfoundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org. [145.40.68.75])
        by gmr-mx.google.com with ESMTPS id t71si835669lff.6.2021.11.28.03.07.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Nov 2021 03:07:45 -0800 (PST)
Date: Sun, 28 Nov 2021 12:07:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
Message-ID: <YaNi/YqN0ARC3h2z@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de>
 <YaIiPISLr7VokL8P@kroah.com>
 <87o865flot.ffs@tglx>
 <87ilwdfkmp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilwdfkmp.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 08:45:18PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 20:22, Thomas Gleixner wrote:
> 
> > On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
> >> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>
> >> No changelog?
> >
> > Bah. This one should not be there at all.
> >
> >> Anyway, why do we care about the number of decriptors?
> 
> The last part of this really cares about it for the dynamic extension
> part, but that's core code which looks at the counter under the lock.

Ah, that should be documented well as right now you are saying "this is
done lockless" in the comment :)

thanks,

greg k-h
