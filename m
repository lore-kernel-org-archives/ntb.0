Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com. [2607:f8b0:400d:c0d::232])
        by gmr-mx.google.com with ESMTPS id x3si679011ywj.7.2017.08.22.10.41.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 10:41:52 -0700 (PDT)
Received: by mail-qt0-x232.google.com with SMTP id v29so100115101qtv.3
        for <linux-ntb@googlegroups.com>; Tue, 22 Aug 2017 10:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822170228.17196-7-logang@deltatee.com>
References: <20170822170228.17196-1-logang@deltatee.com> <20170822170228.17196-7-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Aug 2017 20:41:52 +0300
Message-ID: <CAHp75VfPXjw-gTX=xQsk_0vUhyeTEYiTvoacTzw43RgyGKKaVg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] ntb: ntb_hw_intel: use io-64-nonatomic instead of
 in-driver hacks
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 22, 2017 at 8:02 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Now that ioread64 and iowrite64 are available in io-64-nonatomic,
> we can remove the hack at the top of ntb_hw_intel.c and replace it
> with an include.

> @@ -59,6 +59,7 @@
>  #include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/ntb.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

I would rather try to squeeze to most alpabetiacelly ordered part of this block.
Otherwise it's a pretty nice clean up!

-- 
With Best Regards,
Andy Shevchenko
