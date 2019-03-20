Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u185si166357oib.2.2019.03.20.14.00.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:00:40 -0700 (PDT)
References: <20190321075818.24f9703a@canb.auug.org.au>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
Date: Wed, 20 Mar 2019 15:00:37 -0600
MIME-Version: 1.0
In-Reply-To: <20190321075818.24f9703a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 2019-03-20 2:58 p.m., Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   f4d0dd1064b8 ("NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed")
> 
> Fixes tag
> 
>   Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean:
> 
>   c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")

My fault. I sent the fix patch with the fixes tag before the original
patch was merged upstream expecting them to be squashed. c59666bb32b9 is
the correct hash in upstream now.

Logan

