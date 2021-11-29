Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id l17si672793plb.1.2021.11.29.10.21.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:21:38 -0800 (PST)
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
Date: Mon, 29 Nov 2021 11:21:30 -0700
MIME-Version: 1.0
In-Reply-To: <20211126232735.547996838@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>



On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
> Replace the about to vanish iterators, make use of the filtering and take
> the descriptor lock around the iteration.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: linux-ntb@googlegroups.com

This patch looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
