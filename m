Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x16si369443qtx.5.2019.04.22.10.31.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 10:31:26 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Message-ID: <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
Date: Mon, 22 Apr 2019 11:31:23 -0600
MIME-Version: 1.0
In-Reply-To: <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: AMD IO_PAGE_FAULT w/NTB on Write ops?
To: Eric Pilmore <epilmore@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-04-22 11:14 a.m., Logan Gunthorpe wrote:
> My guess is that the reason writes work and not reads is because the
> write TLPs are posted and thus the switch doesn't apply the Proxy ID
> seeing it doesn't expect a completion. Thus the IOMMU sees the TLPs as
> coming from a permitted peripheral and doesn't complain.

Oh, oops, sounds like I got that backwards as you seem to indicate reads
work but not writes. That doesn't make as much sense to me, but I still
think it's a proxy_id problem.

Take a look at [1]. It reads to me like the AMD IOMMU only supports the
last DMA alias. So most of the proxy IDs for the switchtec device we
register are probably ignored...

One way or another I expect the working cases are because they come from
a specific proxy ID and the broken cases come from a proxy ID that the
AMD IOMMU doesn't consider.

Logan


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/iommu/amd_iommu.c#L245
