Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org. [203.11.71.1])
        by gmr-mx.google.com with ESMTPS id t132si965246ywc.0.2019.07.15.20.03.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 20:03:48 -0700 (PDT)
Date: Tue, 16 Jul 2019 13:03:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: build warning after merge of the ntb tree
Message-ID: <20190716130341.03b02792@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cTsYyZ8h2iTZsMdZQarLg/K"; protocol="application/pgp-signature"
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ntb tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: could not open /home/sfr/next/next/drivers/ntb/ntb.c: No such file=
 or directory

The only thing I could see that might be relevant is commit

  56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules=
")

and some others in the kbuild tree. Nothing has changed recently in the
ntb tree ...

drievrs/ntb builds a module called ntb but there is no ntb.c file.

Any ideas?

--=20
Cheers,
Stephen Rothwell

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tPo0ACgkQAVBC80lX
0Gzn6gf9HJlCinilJIQsR3fkTgS8aCGXiAw/tla3nTkmnnkGJXG9et4Y+3ARzj1p
7kqiIc2FcGes8uKYU0jn6wG03HTuh4aoYNeVBnPocPFGLjUeuDR5PZUNPBG5RZzs
F1SgIDwi6BK2j03rlhb2vlKAYl121km/ZREt9mUhu2WJWBMw+crNWVGvHK17sWCe
cgRG3F7JFywlYRb7BY16GPQ0dR+Pv5i/lHjHdcLxVyRf7O/jQFudKMfXJQaVZeDv
M8dBcBrkaLuUf46ouwcfZu8K8j9Y/KnlTjld8YAoi+wpmxfppY5zGmMMDr9Wsqdi
Cnfn+9ZmIMLYBJzE3zc6Y37ICC6HCQ==
=EAmG
-----END PGP SIGNATURE-----

--Sig_/cTsYyZ8h2iTZsMdZQarLg/K--
