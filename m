Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com. [2607:f8b0:4003:c06::229])
        by gmr-mx.google.com with ESMTPS id c10-v6si25449pgu.4.2018.07.03.12.40.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:40:43 -0700 (PDT)
Received: by mail-oi0-x229.google.com with SMTP id w126-v6so6164970oie.7
        for <linux-ntb@googlegroups.com>; Tue, 03 Jul 2018 12:40:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com> <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Jul 2018 16:40:42 -0300
Message-ID: <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 3, 2018 at 3:47 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Ok, I'm at a bit of a loss... When I look at the assembly before and
> after the patch, it looks pretty much the same. Additionally, the
> function where the undefined exception occurs (caam_jr_interrupt())
> doesn't make any use of wr_reg64 or rd_reg64 which is the only thing the
> patch changes...
>
> Also, it looks like the nonatomic headers are doing what they are
> supposed to on this arch and generating two 32-bit ios and not a 64 bit one.
>
> So I have no idea what's going on here... Are we sure this is the patch
> causing the problem? Did you bisect?

Yes, I am sure that 46e4bf08f6388ba748 is the one causing the kernel boot issue.

If I revert 46e4bf08f6388ba748 in linux-next then I can boot mx6 just fine.

kernelci.org reports also confirm the same:

https://storage.kernelci.org/next/master/next-20180629/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6q-wandboard.html

Thanks
