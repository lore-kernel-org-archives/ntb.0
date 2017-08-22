Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x233.google.com (mail-qt0-x233.google.com. [2607:f8b0:400d:c0d::233])
        by gmr-mx.google.com with ESMTPS id z142si2447130ywa.10.2017.08.22.14.07.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 14:07:57 -0700 (PDT)
Received: by mail-qt0-x233.google.com with SMTP id v29so102832175qtv.3
        for <linux-ntb@googlegroups.com>; Tue, 22 Aug 2017 14:07:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac32fc61-8a54-faf9-55ad-cd2da5fd6503@deltatee.com>
References: <20170822170228.17196-1-logang@deltatee.com> <20170822170228.17196-6-logang@deltatee.com>
 <CAHp75Ve3gG6KdjVBmJZAw25uXRmzfCMUv1kFvg0TbhN7ebTqdw@mail.gmail.com> <ac32fc61-8a54-faf9-55ad-cd2da5fd6503@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Aug 2017 00:07:57 +0300
Message-ID: <CAHp75VedQ_t0vo51QXNOKoGDdt4sp8nyreNkteHpu0=zKxO8rw@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo}
 macros
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 22, 2017 at 8:55 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 22/08/17 11:40 AM, Andy Shevchenko wrote:
>> Recomendation is kinda arguable. I doubt modern architectures make
>> difference between IO operations and MMIO.
>> Does, for example, PCI requires some special signal (message / wire)
>> handling when pio_*() accessors used vs. mmio_*() ones?

> Sort of. There is a difference between the two in x86.

Yes, the difference is in signaling. The question is if it's still in
use. Looks like yes...

> But really if it's
> not a valid recommendation someone should just go through and deprecate one
> of them or document better when one should be used over the other. In any
> case it's still really ugly to mix the two types in the same driver.

Mixing is ugly, totally agree.

-- 
With Best Regards,
Andy Shevchenko
