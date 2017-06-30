Return-Path: <horia.geanta@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0073.outbound.protection.outlook.com. [104.47.2.73])
        by gmr-mx.google.com with ESMTPS id c86si1661945pfk.15.2017.06.29.23.18.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 23:18:16 -0700 (PDT)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
Subject: Re: [PATCH v3 4/4] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Date: Fri, 30 Jun 2017 06:18:11 +0000
Message-ID: <HE1PR0401MB2585F67CA6DE08D083AA043998D30@HE1PR0401MB2585.eurprd04.prod.outlook.com>
References: <20170629161000.15563-1-logang@deltatee.com>
 <20170629161000.15563-5-logang@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Dan
 Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On 6/29/2017 7:10 PM, Logan Gunthorpe wrote:=0A=
> From: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> =0A=
> We can now make use of the io-64-nonatomic-hi-lo header to always=0A=
Typo: we are using io-64-nonatomic-lo-hi, not hi-lo.=0A=
=0A=
Thanks,=0A=
Horia=0A=
