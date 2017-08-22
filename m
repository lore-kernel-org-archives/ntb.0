Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u1si18482itc.3.2017.08.22.10.55.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Aug 2017 10:55:51 -0700 (PDT)
References: <20170822170228.17196-1-logang@deltatee.com>
 <20170822170228.17196-6-logang@deltatee.com>
 <CAHp75Ve3gG6KdjVBmJZAw25uXRmzfCMUv1kFvg0TbhN7ebTqdw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ac32fc61-8a54-faf9-55ad-cd2da5fd6503@deltatee.com>
Date: Tue, 22 Aug 2017 11:55:43 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve3gG6KdjVBmJZAw25uXRmzfCMUv1kFvg0TbhN7ebTqdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 5/7] io-64-nonatomic: add
 io{read|write}64[be]{_lo_hi|_hi_lo} macros
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-ID: <linux-ntb.googlegroups.com>



On 22/08/17 11:40 AM, Andy Shevchenko wrote:
> ldd -> LDD

Ok.

> Recomendation is kinda arguable. I doubt modern architectures make
> difference between IO operations and MMIO.
> Does, for example, PCI requires some special signal (message / wire)
> handling when pio_*() accessors used vs. mmio_*() ones?

Sort of. There is a difference between the two in x86. But really if 
it's not a valid recommendation someone should just go through and 
deprecate one of them or document better when one should be used over 
the other. In any case it's still really ugly to mix the two types in 
the same driver.

> cc -> Cc ?

Fixed.

Logan

