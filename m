Return-Path: <vilhelm.gray@gmail.com>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com. [2607:f8b0:4864:20::744])
        by gmr-mx.google.com with ESMTPS id m23si1198927ooe.0.2020.07.04.05.30.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 05:30:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b185so20399175qkg.1
        for <linux-ntb@googlegroups.com>; Sat, 04 Jul 2020 05:30:56 -0700 (PDT)
Return-Path: <vilhelm.gray@gmail.com>
Date: Sat, 4 Jul 2020 08:30:41 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 06/17] Documentation/driver-api: generic-counter: drop
 doubled word
Message-ID: <20200704123041.GA5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-7-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-7-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:44:51PM -0700, Randy Dunlap wrote:
> Drop the doubled word "the".
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/driver-api/generic-counter.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20200701.orig/Documentation/driver-api/generic-counter.rst
> +++ linux-next-20200701/Documentation/driver-api/generic-counter.rst
> @@ -262,7 +262,7 @@ the system.
>  Counter Counts may be allocated via counter_count structures, and
>  respective Counter Signal associations (Synapses) made via
>  counter_synapse structures. Associated counter_synapse structures are
> -stored as an array and set to the the synapses array member of the
> +stored as an array and set to the synapses array member of the
>  respective counter_count structure. These counter_count structures are
>  set to the counts array member of an allocated counter_device structure
>  before the Counter is registered to the system.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8AdmgACgkQhvpINdm7
VJKL2g/9H6mqC4m/nbUz0xx6u/KB2FTl+BheIuZdhAKQ7vaavuFT9QQK7KdB4VlZ
9/mxbfR37ZCap3U06SMiqcB3cBirDGz38z0kpQEnjoRLfO86+gb7WfpBn19BkBt3
SgI+iKUWbpFBZQnOXpP/mpmGDIIBJdb/oPeqamTmeCP5zmkGPStlR66mReRTCF5A
C1ISpNFBpFTCSLXvMannoxxEWHfug95Oq+z2MxNY87LfNKQm+jtRD+yjfvNJJDEO
EA/p8gavvQuNNS7HnwjzT7F5xc+1eoZINk5w4/KkoSJzcyMQEBnPCKQV/T6YJT9A
odyOiKcmBQOQ4SjjWZwsaf86ELIGt85SR6MtjXAv/+Hakuim0lvEN53LjeLw42XS
UiQ6k3UvFMLccw56hfUrntSUWiMCNSHJHi7CNiHKoR8Bu2lUpGZUbsj2dJ5f2f6B
QTZxZrFKdYpWQ6Bj56Gw+qz7n6YKWoAdhW6BhSqmnNn+gvgpWqPTgz5OG6hXARgI
2MyKfuKyyc73wPPenSuCF+0ugENfjmYAfkKkFIHweBP82YemBQH1gzRNtusQgjp3
NYyhPpdbiSDucr9uicWqOTwEjOppSfUpNIehHwKmZQOePA+Ewj1U0mbKsA17IbDm
7tXxxkVxTlKSuEIfgiDufrHw5oOner+LPe/QKsMK4nNBHKTRGpQ=
=Q9+X
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
