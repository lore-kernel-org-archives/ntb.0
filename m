Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com. [2607:f8b0:4003:c06::235])
        by gmr-mx.google.com with ESMTPS id p19-v6si78216pff.0.2018.07.03.11.06.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 11:06:21 -0700 (PDT)
Received: by mail-oi0-x235.google.com with SMTP id m2-v6so5611596oim.12
        for <linux-ntb@googlegroups.com>; Tue, 03 Jul 2018 11:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com> <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Jul 2018 15:06:21 -0300
Message-ID: <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

On Tue, Jul 3, 2018 at 3:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Besides that, it looks like we are hitting an undefined instruction. So
> my best guess is that we are somehow now calling a proper 64bit read
> when we should be calling two 32-bit reads.

Yes, it seems that's the case.

> Fabio, can you send your configuration?

This is a imx6 board built with arch/arm/configs/imx_v6_v7_defconfig

Thanks
