Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id g129si598363itd.1.2017.12.11.12.06.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 12:06:38 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20171209000217.18366-1-logang@deltatee.com> <20171209000217.18366-2-logang@deltatee.com> <000201d37290$81605eb0$84211c10$@dell.com> <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com> <000301d372b4$b6042100$220c6300$@dell.com> <2ec869d2-caca-e283-b7b5-a28b5908a4db@deltatee.com>
In-Reply-To: <2ec869d2-caca-e283-b7b5-a28b5908a4db@deltatee.com>
Subject: RE: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()
Date: Mon, 11 Dec 2017 15:06:22 -0500
Message-ID: <000401d372bb$84a34620$8de9d260$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 11/12/17 12:17 PM, Allen Hubbe wrote:
> >> mw_get_align doesn't communicate the fact that the buffer has to be
> >> aligned by its size.
> >
> > Is that not the purpose of the addr_align out parameter of =
ntb_mw_get_align()?
>=20
> addr_align provides the minimum alignment required by the device but =
it
> has no idea how big a buffer the caller is trying to create so it =
can't
> express that it needs to be aligned by its size.
>=20
> To be clear, the minimum alignment the Switchtec device requires is =
4KB
> so it will return 4k in addr_align. Thus, if you have a 4KB buffer it
> may be aligned to 4KB. But if you have a 1MB buffer it must be aligned
> to the nearest 1M.

In switchtec_ntb_mw_get_align, for the lut case it seems to require =
alignment the same as Intel, aligned to mw size, but for the non-lut =
case you are saying that SZ_4K is not necessarily correct.  The SZ_4K is =
the minimum, but the actual alignment restriction depends on the size of =
the buffer actually translated.  Right?

Also, for the lut case, it looks like the size also has to be the same =
size as the mw.  So, a client can't allocate a smaller buffer, assume we =
can get one that is aligned, point the start of the mw at it, and limit =
the size of the mw?

For the non-lut case I wonder, with the restriction that addr needs to =
be aligned to the size of the buffer, does the size of the buffer also =
need to be some power of two?  That would make sense, if it determines =
the alignment.  If so, SZ_4K wouldn't be correct for size_align, either.

Do you need the intended buffer size passed in as another parameter to =
ntb_mw_get_align?  The point of ntb_mw_get_align is to figure out all =
the alignment restrictions before allocating memory.

> >> It may also be that all hardware does not have this
> >> restriction (ie. if the hardware adds to the base address instead =
of
> >> just replacing the lower bits).
> >>
> >> There is definitely a need to print this error somewhere as I hit =
this
> >> case and it caused very weird behavior. It was a huge pain to =
debug.
> >> Also, it's a security issue and huge bug if we end up mapping the =
memory
> >> we didn't think we were mapping.
> >
> > Of course the driver should validate its parameters not allow bad =
mappings.  I was only commenting
> on the dev_err() message to the console.
>=20
> Ok. I still feel like it would be difficult to debug if ntb_transport
> simply was unable to establish a connection without some message in
> dmesg telling the user why.
>=20
> Also, keep in mind this is a somewhat unusual occurrence. In most =
cases
> dma_alloc_coherent() always provides a buffer that is aligned to it's
> size. It's just that the CMA (if used) provides a tunable config =
option
> which allows for larger buffers to not be aligned to their size.
>=20
> Logan

