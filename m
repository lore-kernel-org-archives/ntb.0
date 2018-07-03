Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com. [2607:f8b0:4003:c06::22f])
        by gmr-mx.google.com with ESMTPS id s15-v6si125784iog.0.2018.07.03.16.56.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:56:59 -0700 (PDT)
Received: by mail-oi0-x22f.google.com with SMTP id r16-v6so7315991oie.3
        for <linux-ntb@googlegroups.com>; Tue, 03 Jul 2018 16:56:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <81e128b6-b365-b2c8-d86e-50f40024eb9d@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <CAHp75VefGpNkF0ANA_wBm627aZXS60NPZ9VAdOYqr_iZ8Hvpzw@mail.gmail.com>
 <CAOMZO5Ayn4ik4F3sWhTo9Q5DGHG6nuf71M3DLsM+heMi0TFjVg@mail.gmail.com> <81e128b6-b365-b2c8-d86e-50f40024eb9d@deltatee.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Jul 2018 20:56:58 -0300
Message-ID: <CAOMZO5Dyk+shJFRFimZOyvJkS=OsNUbfjtLUoqSdZ6bQVCDTUQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 3, 2018 at 6:16 PM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Is this a virtual machine? And if so, any chance we can get an image and
> qemu command line to run it ourselves?

This is a real imx6 development board. I have never tried it on qemu.
Let me see if I can reproduce it on quemu.
