Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com. [2607:f8b0:400d:c09::229])
        by gmr-mx.google.com with ESMTPS id l17-v6si268873ybm.0.2018.03.06.03.57.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 03:57:51 -0800 (PST)
Received: by mail-qk0-x229.google.com with SMTP id w142so24505437qkb.8
        for <linux-ntb@googlegroups.com>; Tue, 06 Mar 2018 03:57:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306114632.GB16784@kroah.com>
References: <20180305190824.847-1-logang@deltatee.com> <20180305190824.847-8-logang@deltatee.com>
 <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com> <20180306114632.GB16784@kroah.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 13:57:50 +0200
Message-ID: <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Mar 6, 2018 at 1:46 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 06, 2018 at 12:48:29PM +0200, Andy Shevchenko wrote:
>> On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> > Clean up the ifdefs which conditionally defined the io{read|write}64
>> > functions in favour of the new common io-64-nonatomic-lo-hi header.
>>
>> >  #include <linux/kthread.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/ntb.h>
>> > +#include <linux/io-64-nonatomic-lo-hi.h>
>>
>> A nit, can we preserve alphabetical ordering?
>
> Ugh, why, it doesn't matter at all :)

I'm fine with either way, but ordering is a good thing to have in long
term prospective.
Easy to find what headers are in there, easy to understand if you need
another one or not, easy to maintain the list w/o duplications.

I saw already few examples where long list of headers contained
duplications b/c it was in messy order.

-- 
With Best Regards,
Andy Shevchenko
