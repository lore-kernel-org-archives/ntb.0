Return-Path: <gregkh@linuxfoundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org. [145.40.68.75])
        by gmr-mx.google.com with ESMTPS id u10si796386wrb.5.2021.11.27.04.33.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 04:33:28 -0800 (PST)
Date: Sat, 27 Nov 2021 13:33:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 32/32] genirq/msi: Convert storage to xarray
Message-ID: <YaIllD3pSVCI/gbj@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.190744801@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232736.190744801@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 02:23:17AM +0100, Thomas Gleixner wrote:
> The current linked list storage for MSI descriptors is suboptimal in
> several ways:
> 
>   1) Looking up a MSI desciptor requires a O(n) list walk in the worst case
> 
>   2) The upcoming support of runtime expansion of MSI-X vectors would need
>      to do a full list walk to figure out whether a particular index is
>      already associated.
> 
>   3) Runtime expansion of sparse allocations is even more complex as the
>      current implementation assumes an ordered list (increasing MSI index).
> 
> Use an xarray which solves all of the above problems nicely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |   19 ++---
>  kernel/irq/msi.c    |  188 ++++++++++++++++++++++------------------------------
>  2 files changed, 90 insertions(+), 117 deletions(-)

Much simpler code too, nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
