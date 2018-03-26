Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com. [2607:f8b0:400d:c09::234])
        by gmr-mx.google.com with ESMTPS id a6-v6si824817otc.3.2018.03.26.03.53.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 03:53:05 -0700 (PDT)
Received: by mail-qk0-x234.google.com with SMTP id o184so19512826qkd.13
        for <linux-ntb@googlegroups.com>; Mon, 26 Mar 2018 03:53:05 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180321163745.12286-2-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com> <20180321163745.12286-2-logang@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 12:53:04 +0200
Message-ID: <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Mar 21, 2018 at 5:37 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> The semantics of the iowriteXXbe() functions are to write a
> value in CPU endianess to an IO register that is known by the
> caller to be in Big Endian. The mmio_writeXXbe() macro, which
> is called by iowriteXXbe(), should therefore use cpu_to_beXX()
> instead of beXX_to_cpu().
>
> Seeing both beXX_to_cpu() and cpu_to_beXX() are both functionally
> implemented as either null operations or swabXX operations there
> was no noticable bug here. But it is confusing for both developers
> and code analysis tools alike.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Your patch is a clear improvement of what we had before, but I notice
that we have a weird asymmetry between big-endian and little-endian
accessors before and after this patch:

void iowrite32(u32 val, void __iomem *addr)
{
        IO_COND(addr, outl(val,port), writel(val, addr));
}
void iowrite32be(u32 val, void __iomem *addr)
{
        IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
}

The little-endian iowrite32() when applied to mmio registers uses
a 32-bit wide atomic store to a little-endian register with barriers to
order against both spinlocks and DMA.

The big-endian iowrite32be() on the same pointer uses a nonatomic
store with no barriers whatsoever and the opposite endianess.

On most architectures, this is not important:
- For x86, the stores are aways atomic and no additional barriers
  are needed, so the two are the same
- For ARM (both 32 and 64-bit), powerpc and many others, we don't
  use the generic iowrite() and just fall back to writel() or
  writel(swab32()).

However, shouldn't we just use the writel(swab32()) logic here as well
for the common case rather than risking missing barriers?

       Arnd
