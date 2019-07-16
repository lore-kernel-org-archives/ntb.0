Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org. [2401:3900:2:1::2])
        by gmr-mx.google.com with ESMTPS id w82si683613qka.7.2019.07.15.21.54.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 21:54:39 -0700 (PDT)
Date: Tue, 16 Jul 2019 14:54:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warning after merge of the ntb tree
Message-ID: <20190716145431.26da7a75@canb.auug.org.au>
In-Reply-To: <7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
References: <20190716130341.03b02792@canb.auug.org.au>
	<7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6wNty9WHNNpLB=upKszJLxs"; protocol="application/pgp-signature"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

--Sig_/6wNty9WHNNpLB=upKszJLxs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Logan,

On Mon, 15 Jul 2019 21:46:42 -0600 Logan Gunthorpe <logang@deltatee.com> wr=
ote:
>
> I renamed the ntb.c file to core.c so we could add more files to build
> ntb.ko. See [1].

But that was last changed in June, so I assume that some change to the
build system has caused this warning to be produced now.

--=20
Cheers,
Stephen Rothwell

--Sig_/6wNty9WHNNpLB=upKszJLxs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tWIcACgkQAVBC80lX
0GzAEwf+Kilbh4hmWSH4gsjN7AcjrvhLIzGrDTEzWyIHM6XLba1XNBOHCMFgT2w1
v5eMjG03GH4nQikQO8eaYwAlsiDWM15thNUGqF/sld235ZCW/w17XIVbwXzrvsLF
ErvmrWyZEoArrEFy1Js6dMCDvbuUJQkKBLIDd+x13q/Cf8ZAzVsguXQN5hSbLq87
Wz2GWXNB53lyfV+NttjkdZj7W12H6df2IHqny3qe7OxGipbsNWFTIRHJkWI/xpsd
e9Ofh61XkKXgiHdQWlNZyHyk8iWMdLfMkl+x854+6CElPiniFRdfyjYACsC06YEn
Gjt5uvPhnEbjYyrBIOlTEIfADAvSgA==
=hXRI
-----END PGP SIGNATURE-----

--Sig_/6wNty9WHNNpLB=upKszJLxs--
