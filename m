Return-Path: <gregkh@linuxfoundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [139.178.84.217])
        by gmr-mx.google.com with ESMTPS id o19si1625848wme.2.2021.11.27.04.19.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 04:19:46 -0800 (PST)
Date: Sat, 27 Nov 2021 13:19:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 01/32] genirq/msi: Move descriptor list to struct
 msi_device_data
Message-ID: <YaIiXcRABq2E6/sJ@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.349989857@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.349989857@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 02:22:29AM +0100, Thomas Gleixner wrote:
> It's only required when MSI is in use.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/base/core.c    |    3 ---
>  include/linux/device.h |    4 ----
>  include/linux/msi.h    |    4 +++-
>  kernel/irq/msi.c       |    5 ++++-
>  4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
