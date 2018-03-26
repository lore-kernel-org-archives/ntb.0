Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q6si1251664oic.5.2018.03.26.13.33.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 13:33:21 -0700 (PDT)
References: <20180321163745.12286-1-logang@deltatee.com>
 <20180321163745.12286-2-logang@deltatee.com>
 <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
 <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
 <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6a063b65-668a-ef9c-696e-8c378e6b2640@deltatee.com>
Date: Mon, 26 Mar 2018 14:33:13 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HGW=PWBtFL_96rztqa7KUAhuYBHTL3cGKY2VE=Ag1rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 26/03/18 01:50 PM, Arnd Bergmann wrote:
> I wouldn't expect it to matter: the byte swap is almost always much
> cheaper compared to the actual bus access for the MMIO, and I
> would also guess that modern compilers can eliminate the double
> byte swap on architectures where writel() is an inline function. Most of
> the important architectures use ARCH_USE_BUILTIN_BSWAP, which
> guarantees that.

Fair enough. Sometime this week I'll update my patch set to change that.

Thanks,

Logan
