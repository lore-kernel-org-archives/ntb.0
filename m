Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com. [2607:f8b0:400d:c0d::242])
        by gmr-mx.google.com with ESMTPS id z142si2386362ywa.10.2017.08.22.10.43.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 10:43:41 -0700 (PDT)
Received: by mail-qt0-x242.google.com with SMTP id g13so6912060qta.4
        for <linux-ntb@googlegroups.com>; Tue, 22 Aug 2017 10:43:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822170228.17196-1-logang@deltatee.com>
References: <20170822170228.17196-1-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Aug 2017 20:43:41 +0300
Message-ID: <CAHp75Vd6O6vQFgU48tgMswhN0zT47Dqrvtf5JHLPrTVxR_DCrQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] make io{read|write}64 globally usable
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 22, 2017 at 8:02 PM, Logan Gunthorpe <logang@deltatee.com> wrot=
e:
> This is just a resend seeing I've gotten no feedback in a couple weeks.

Overall quite a good clean up! Thanks!
After addressing my comments you may take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Changes since v6:
>  ** none **
>
> Changes since v5:
> - Added a fix to the tilcdc driver to ensure it doesn't use the
>   non-atomic operation. (This includes adding io{read|write}64[be]_is_non=
atomic
>   defines).
>
> Changes since v4:
> - Add functions so the powerpc implementation of iomap.c compiles. (As
>   noticed by Horia)
>
> Changes since v3:
>
> - I noticed powerpc didn't use the appropriate functions seeing
>   readq/writeq were not defined when iomap.h was included. Thus I've
>   included a patch to adjust this
> - Fixed some mistakes with a couple of the defines in io-64-nonatomic*
>   headers
> - Fixed a typo noticed by Horia.
>
> (earlier versions were drastically different)
>
> Horia Geant=C4=83 (1):
>   crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
>
> Logan Gunthorpe (6):
>   drm/tilcdc: ensure nonatomic iowrite64 is not used
>   powerpc: io.h: move iomap.h include so that it can use readq/writeq
>     defs
>   powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
>   iomap: introduce io{read|write}64_{lo_hi|hi_lo}
>   io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
>   ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
>
>  arch/powerpc/include/asm/io.h         |   6 +-
>  arch/powerpc/kernel/iomap.c           |  40 +++++++++++
>  drivers/crypto/caam/regs.h            |  35 ++-------
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h  |   2 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.c   |  30 +-------
>  include/asm-generic/iomap.h           |  26 +++++--
>  include/linux/io-64-nonatomic-hi-lo.h |  64 +++++++++++++++++
>  include/linux/io-64-nonatomic-lo-hi.h |  64 +++++++++++++++++
>  lib/iomap.c                           | 132 ++++++++++++++++++++++++++++=
++++++
>  9 files changed, 331 insertions(+), 68 deletions(-)
>
> --
> 2.11.0



--=20
With Best Regards,
Andy Shevchenko
