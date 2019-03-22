Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id t17si708867itb.2.2019.03.22.09.51.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:51:14 -0700 (PDT)
Date: Fri, 22 Mar 2019 11:51:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 03/10] NTB: Introduce helper functions to calculate
 logical port number
Message-ID: <20190322165111.GO251185@google.com>
References: <20190322000645.15580-1-logang@deltatee.com>
 <20190322000645.15580-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000645.15580-4-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Mar 21, 2019 at 06:06:38PM -0600, Logan Gunthorpe wrote:
> This patch introduces the "Logical Port Number" which is similar to the
> "Port Number" in that it enumerates the ports in the system.
> 
> The original (or Physical) "Port Number" can be any number used by the
> hardware to uniquley identify a port in the system. The "Logical Port

s/uniquley/uniquely/

> Number" enumerates all ports in the system from 0 to the number of
> ports minus one.
> 
> For example a system with 5 ports might have the following port numbers
> which would be enumareted thusly:

s/enumareted/enumerated/

> + * ntb_logical_port_number() - get the logical port number of the local port
> + * @ntb:	NTB device context.
> + *
> + * The Logical Port Number is defined to be a unique number for each
> + * port starting from zero through to the number of ports minus one.
> + * This is in contrast to the Port Number where each port can be assigned
> + * any unqique physical number by the hardware.

s/unqique/unique/

> + * ntb_peer_logical_port_number() - get the logical peer port by given index
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * The Logical Port Number is defined to be a unique number for each
> + * port starting from zero through to the number of ports minus one.
> + * This is in contrast to the Port Number where each port can be assigned
> + * any unqique physical number by the hardware.

s/unqique/unique/

Bjorn
