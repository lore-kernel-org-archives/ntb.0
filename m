Return-Path: <jdmason@kudzu.us>
Received: from mail-it1-x12f.google.com (mail-it1-x12f.google.com. [2607:f8b0:4864:20::12f])
        by gmr-mx.google.com with ESMTPS id u65si409957qkc.5.2019.03.21.12.53.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:53:59 -0700 (PDT)
Received: by mail-it1-x12f.google.com with SMTP id w15so178418itc.0
        for <linux-ntb@googlegroups.com>; Thu, 21 Mar 2019 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190321075818.24f9703a@canb.auug.org.au> <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
In-Reply-To: <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 21 Mar 2019 15:53:47 -0400
Message-ID: <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Mar 20, 2019 at 5:00 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-03-20 2:58 p.m., Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   f4d0dd1064b8 ("NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed")
> >
> > Fixes tag
> >
> >   Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Did you mean:
> >
> >   c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
>
> My fault. I sent the fix patch with the fixes tag before the original
> patch was merged upstream expecting them to be squashed. c59666bb32b9 is
> the correct hash in upstream now.

I've corrected the patch in my git branches and repushed.

Is there an existing set of tools/scripts I should run to prevent
things like this from happening?

Thanks,
Jon

>
> Logan
>
