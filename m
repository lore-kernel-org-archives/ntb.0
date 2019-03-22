Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com. [2607:f8b0:4864:20::d2e])
        by gmr-mx.google.com with ESMTPS id y202si461018qka.2.2019.03.22.08.35.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:35:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so2059316iop.3
        for <linux-ntb@googlegroups.com>; Fri, 22 Mar 2019 08:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190321075818.24f9703a@canb.auug.org.au> <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
 <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com> <20190322072829.77e6c245@canb.auug.org.au>
In-Reply-To: <20190322072829.77e6c245@canb.auug.org.au>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 22 Mar 2019 11:34:56 -0400
Message-ID: <CAPoiz9zyT8GYo+DrGgCNP8PhHn-oTyRyd6+V4cydGgkGyF3Bww@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
Content-Type: text/plain; charset="UTF-8"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Logan Gunthorpe <logang@deltatee.com>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Mar 21, 2019 at 4:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Jon,
>
> On Thu, 21 Mar 2019 15:53:47 -0400 Jon Mason <jdmason@kudzu.us> wrote:
> >
> > Is there an existing set of tools/scripts I should run to prevent
> > things like this from happening?
>
> I have attached the script I run over all new commits submitted for
> linux-next.

Fantastic!  I'll add a variation of this to my git tree and hopefully
prevent any future issues.

Thanks,
Jon

>
> --
> Cheers,
> Stephen Rothwell
