Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com. [2607:f8b0:400d:c09::241])
        by gmr-mx.google.com with ESMTPS id v15si822586ywc.0.2017.08.22.13.14.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 13:14:51 -0700 (PDT)
Received: by mail-qk0-x241.google.com with SMTP id a77so17887474qkb.2
        for <linux-ntb@googlegroups.com>; Tue, 22 Aug 2017 13:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b4b38bb0-b97f-2240-0ddc-ef5444e289ef@deltatee.com>
References: <20170822170228.17196-1-logang@deltatee.com> <20170822170228.17196-7-logang@deltatee.com>
 <CAHp75VfPXjw-gTX=xQsk_0vUhyeTEYiTvoacTzw43RgyGKKaVg@mail.gmail.com> <b4b38bb0-b97f-2240-0ddc-ef5444e289ef@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Aug 2017 23:14:50 +0300
Message-ID: <CAHp75Ve-3JnD2b5Wn5zPX+jW91Wcw3utpAJ5gPkz5zHsG+2reQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] ntb: ntb_hw_intel: use io-64-nonatomic instead of
 in-driver hacks
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 22, 2017 at 8:56 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 22/08/17 11:41 AM, Andy Shevchenko wrote:
>>>
>>> @@ -59,6 +59,7 @@
>>>   #include <linux/random.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/ntb.h>
>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>
>>
>> I would rather try to squeeze to most alpabetiacelly ordered part of this
>> block.
>> Otherwise it's a pretty nice clean up!
>>
>
> I don't understand. The includes were not alphabetically in any order
> originally and I'd rather not reorder them in my patch.

In excerpt I see if you put your include before random.h you will get
3 headers in order.
There may be even better sequence, I didn't check.


-- 
With Best Regards,
Andy Shevchenko
