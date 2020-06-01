Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org. [203.11.71.1])
        by gmr-mx.google.com with ESMTPS id k1si777534ilr.0.2020.06.01.00.44.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:44:57 -0700 (PDT)
Date: Mon, 1 Jun 2020 17:44:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: Fixes tag needs some work in the ntb tree
Message-ID: <20200601174450.7a0d79a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EeKjYcGmKX4jJPzaAOqAoiG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
To: Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Arindam Nath <arindam.nath@amd.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

--Sig_/EeKjYcGmKX4jJPzaAOqAoiG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  eb3eabb28cf2 ("ntb_tool: pass correct struct device to dma_alloc_coherent=
")

Fixes tag

  Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  55480afb82bd ("ntb_perf: pass correct struct device to dma_alloc_coherent=
")

Fixes tag

  Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/EeKjYcGmKX4jJPzaAOqAoiG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7UsfIACgkQAVBC80lX
0GwnUAgAld9zNIu4OOr4xLt8SJSe3C8ofwKBmAZesfM8K1oLwVyng98JFfPKLbfu
fjpwyOrUAODbPL30urB8GTq92N2S8/mbC3LAYCg70raHKM6Vts055hh9Mj2s69EB
+fRJ8Kr9ttfDEw52xGy9CZTw1akgg+8+a7Xe4p8Xhvm5vwppMV9BlTKNFC+PLipD
PPNSBUf1upfdOpt2SKmcsjAGJ1LFmnFXXRVeDcVUanzOTR5i14SmzYkZxJKaRO5C
i1fpSQlQx8N2KGGem7wxcaBDvX3Ra54+QHLS1POoCyhzlsKklE2ZhwqYwKhscxgv
Y6ehfvtLoytjtf+HIztYmxTPppLlZQ==
=CPSM
-----END PGP SIGNATURE-----

--Sig_/EeKjYcGmKX4jJPzaAOqAoiG--
