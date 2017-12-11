Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id q34si666675qtg.2.2017.12.11.11.18.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 11:18:03 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20171209000217.18366-1-logang@deltatee.com> <20171209000217.18366-2-logang@deltatee.com> <000201d37290$81605eb0$84211c10$@dell.com> <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com>
In-Reply-To: <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com>
Subject: RE: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()
Date: Mon, 11 Dec 2017 14:17:38 -0500
Message-ID: <000301d372b4$b6042100$220c6300$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe

> mw_get_align doesn't communicate the fact that the buffer has to be
> aligned by its size.

Is that not the purpose of the addr_align out parameter of =
ntb_mw_get_align()?

> It may also be that all hardware does not have this
> restriction (ie. if the hardware adds to the base address instead of
> just replacing the lower bits).
>=20
> There is definitely a need to print this error somewhere as I hit this
> case and it caused very weird behavior. It was a huge pain to debug.
> Also, it's a security issue and huge bug if we end up mapping the =
memory
> we didn't think we were mapping.

Of course the driver should validate its parameters not allow bad =
mappings.  I was only commenting on the dev_err() message to the =
console.

What makes best sense for client drivers with regards to ntb api changes =
is a fair argument.  Let's see what others say.

> I don't think it's a good idea for us
> to require clients to check this as that requires a number of checks =
and
> a client author may forget to add it to their driver. I'd maybe go =
with
> a check in ntb_mw_set_trans before calling the driver, but that only
> makes sense if all hardware has the same requirement.
>=20
> Logan

