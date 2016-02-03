Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id u66si1005242pfa.2.2016.02.03.10.11.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 10:11:15 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <8b17fab4dd0a98d2b19d40b000b81312de551732.1454485437.git.baruch@tkos.co.il>
In-Reply-To: <8b17fab4dd0a98d2b19d40b000b81312de551732.1454485437.git.baruch@tkos.co.il>
Subject: RE: [PATCH] NTB: doc: remove underscore escaping
Date: Wed, 3 Feb 2016 13:10:51 -0500
Message-ID: <000001d15eae$393fd4a0$abbf7de0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Baruch Siach' <baruch@tkos.co.il>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

> From: Baruch Siach
> This escaping sequence makes the plain text file hard to read, and
> obscures the
> name of identifies like module parameters. This is probably a left =
over
> from a
> markup version of the text.

s/identifies/identifiers/

Rather than guessing the original intent, you can say, "This is an =
artifact left over from formatting the document as markdown."

>=20
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

> -### NTB Transport Client (ntb\_transport) and NTB Netdev =
(ntb\_netdev)
> +### NTB Transport Client (ntb_transport) and NTB Netdev (ntb_netdev)

You are correct.  The escaping of underscore is to avoid italicizing the =
text between underscores when the document is processed with markdown.  =
The escaping is intentional.

There is not much by way of official guidance around the use or non-use =
of markup/markdown/asciidoc in Linux/Documentation (or, I have not found =
it - please direct me).  There are a few other files under Documentation =
with similar markup; most seem to be related to acpi.  It seems to me =
that subsystems like acpi have autonomy in deciding how to markup their =
own documentation.  There is also value in being consistent, and =
documents with markup are distinctly in the minority.  I also recognize =
your point about the markup making the plain text marginally harder to =
read.

On the other hand, anyone familiar with markdown will recognize the =
section headings, fixed width annotations, and preformatted blocks.  =
Someone might take this document, recognize the format, and process it =
with markdown.  If the escaping is taken away, the result of processing =
will look strange.  Therefore, if the underscore escaping is to be =
removed, I would rather see the whole document changed in such a way =
that makes it obvious that the document is not markdown.

I would leave it in, but I will not stand in the way if Jon and Dave =
would rather take it out.

Allen

