Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com. [2607:f8b0:4003:c06::241])
        by gmr-mx.google.com with ESMTPS id f18si58045itf.3.2017.06.26.13.43.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 13:43:40 -0700 (PDT)
Received: by mail-oi0-x241.google.com with SMTP id l130so978434oib.2
        for <linux-ntb@googlegroups.com>; Mon, 26 Jun 2017 13:43:40 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170622164817.25515-3-logang@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com> <20170622164817.25515-3-logang@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Jun 2017 22:43:40 +0200
Message-ID: <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] iomap: implement ioread64 and iowrite64
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

> +u64 ioread64(void __iomem *addr)
> +{
> +       u64 low, high;
> +
> +       low = ioread32(addr);
> +       high = ioread32(addr + sizeof(u32));
> +       return low | (high << 32);
> +}
> +u64 ioread64be(void __iomem *addr)
> +{
> +       u64 low, high;
> +
> +       low = ioread32be(addr + sizeof(u32));
> +       high = ioread32be(addr);
> +       return low | (high << 32);
> +}
> +#endif

This hardcodes the behavior of include/linux/io-64-nonatomic-hi-lo.h, which
I find rather confusing, as only about one in five drivers wants this
behavior.

I'd suggest you don't add it in lib/iomap.c at all for 32-bit architectures,
but rather use the same logic that we have for readq/writeq in
io-64-nonatomic-hi-lo.h and io-64-nonatomic-lo-hi.h, adding
{lo_hi,hi_lo}_{ioread,iowrite}{,be} to the same files, and provide
the {ioread,iowrite}{,be} macros only if they have not been defined
at that point.

       Arnd
