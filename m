Return-Path: <vilhelm.gray@gmail.com>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com. [2607:f8b0:4864:20::744])
        by gmr-mx.google.com with ESMTPS id a7si780938ybj.5.2020.07.04.05.31.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 05:31:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so30964265qkn.11
        for <linux-ntb@googlegroups.com>; Sat, 04 Jul 2020 05:31:19 -0700 (PDT)
Return-Path: <vilhelm.gray@gmail.com>
Date: Sat, 4 Jul 2020 08:31:16 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 00/17] Documentation/driver-api: eliminate duplicated
 words
Message-ID: <20200704123116.GB5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:44:45PM -0700, Randy Dunlap wrote:
> Remove occurrences of duplicated words in Documentation/driver-api/.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: linux-ntb@googlegroups.com
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-usb@vger.kernel.org
> Cc: Eli Billauer <eli.billauer@gmail.com>
>=20
>=20
>  Documentation/driver-api/dmaengine/provider.rst        |    2 +-
>  Documentation/driver-api/driver-model/platform.rst     |    2 +-
>  Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
>  Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
>  Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
>  Documentation/driver-api/firmware/request_firmware.rst |    2 +-
>  Documentation/driver-api/generic-counter.rst           |    2 +-
>  Documentation/driver-api/iio/buffers.rst               |    2 +-
>  Documentation/driver-api/media/cec-core.rst            |    2 +-
>  Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
>  Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
>  Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
>  Documentation/driver-api/ntb.rst                       |    2 +-
>  Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
>  Documentation/driver-api/uio-howto.rst                 |    2 +-
>  Documentation/driver-api/usb/URB.rst                   |    2 +-
>  Documentation/driver-api/xillybus.rst                  |    2 +-
>  17 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8AdpQACgkQhvpINdm7
VJIBvxAAqwgnnmzKHJ8nY2Ip3r9kE7Fygjzlzj9bHCF7iXLQVTYqC4W7cN0q0Bfu
QotqGgl0sAWKftn9qkvUzFI6TFRROjPuzPdDPucm+pQ5pW2m6HIEOgK42qjcuHLn
wvVJmYNuV3L+Y6NQtUS1PBulobtAYL8fMMhtQiG6rialiiB6yaJeHkpU7BP5cdUn
+n6i9IJIdl9//biQjBd5FQy7wqPLr+aXBZLAMSWT+hKl0huWGUXmFBTmcGLkGhAT
OEKrj9H7j8U7CmavcpNe0bHRLlucKl3a1wQTtf6CV+SwfaaFEtKhaEKEIsB4M9QI
sRvbV0gY9yJX2y3DabCS61B/EcCA2htBnk++AlNY+HvfXckvW9+g4xaMcCAU0cow
1EFaMIVEGWrEuaBIRDQJX5f9n97Wvc0Zp2B/hlxYvSo1xmaCObehZ9+UecKCW1C0
71A8NFc0cYiELXFZmQ+Vf7I9K3UeaRBaeoB8r4YEBNOO3JhmHq9E8re8ULoMvEse
HKZyuoGyoOhW27cZXoBw1ymZZ07Nnmpupyukmh9wQllQcMj5smqQAcbCtBNCcqXb
L+dlXBeIpE+KZHRFJ/2RtmDX903PaDcZ0Y5+NZUJsvt/KJCzg1rASkGcHC6lVTLj
4jBBZt4JmxUWKLxsdnkHXb12eTXPB7DkjhCiSThpm1A2Re9P4Jg=
=6Gqy
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
