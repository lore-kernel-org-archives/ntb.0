Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id jj4si10691868pac.2.2016.01.08.07.39.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 07:39:50 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>	<CAPoiz9znO1QT9Fphtmf4Wp2Tkvm1H-thy2=SrPi_dT9uQ4HoMQ@mail.gmail.com>	<BLUPR12MB0420841C92C2D403A12EA4CFEBF50@BLUPR12MB0420.namprd12.prod.outlook.com> <CAPoiz9zqbgTvTA7hgKEQQGAuCbodH3D3dwmvNwkzRQPM1GA=aw@mail.gmail.com>
In-Reply-To: <CAPoiz9zqbgTvTA7hgKEQQGAuCbodH3D3dwmvNwkzRQPM1GA=aw@mail.gmail.com>
Subject: RE: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
Date: Fri, 8 Jan 2016 10:39:24 -0500
Message-ID: <000d01d14a2a$c0879d50$4196d7f0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Jon Mason' <jdmason@kudzu.us>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Jon Mason <jdmason@kudzu.us>
> On Wed, Jan 6, 2016 at 9:50 PM, Yu, Xiangliang <Xiangliang.Yu@amd.com>
> wrote:
> >> > +#define NTB_READ_REG(base, r) (ioread32(base + AMD_ ## r ##
> >> _OFFSET))
> >> > +#define NTB_WRITE_REG(base, val, r) (iowrite32(val, base +     \
> >> > +                                               AMD_ ## r ##
> _OFFSET))
> >> > +#define NTB_READ_OFFSET(base, r, of) (ioread32(base + of +
> \
> >> > +                                               AMD_ ## r ##
> _OFFSET))
> >> > +#define NTB_WRITE_OFFSET(base, val, r, of) (iowrite32(val, base =
+
> \
> >> > +                                               of + AMD_ ## r ##
> _OFFSET))
> >>
> >> Please do not use marcos to hide ioread/iowrite.  Call =
iorwad/iowrite
> directly.
> >
> > I don't see any wrong to hide ioread/iowrite, and I think the macros
> can make code readable and easy to maintain.
>=20
> I disagree.  It is an unnecessary layer and can add to confusion.
> Please make the change.

I don't like AMD_##r##_OFFSET in these macros.  It hides the use of a =
globally named constant like AMD_FOO_OFFSET, since one would read only =
FOO in the code.  It makes cross referencing difficult, since the reader =
needs to know FOO is really AMD_FOO_OFFSET.  This would defeat automatic =
cross referencing like cscope and lxr.

#define AMD_FOO_OFFSET 0xc0ff33
vs
NTB_READ_OFFSET(dev->foo_base, FOO, offset_in_foo)
// Where is FOO defined?

This macro would have at least been better written without ##; so cross =
referencing would still work.

NTB_READ_OFFSET(dev->foo_base, FOO, offset_in_foo)
vs
NTB_READ_OFFSET(dev->foo_base, AMD_FOO_OFFSET, offset_in_foo)
// AMD_FOO_OFFSET is 0xcoff33 (obviously)

But without ##, the macro is just the addition of its parameters.  =
Change the commas to addition, and the macro to ioread, and you'll see =
there is no benefit for having this macro any more.

NTB_READ_OFFSET(dev->foo_base, AMD_FOO_OFFSET, offset_in_foo)
vs
ioread32(dev->foo_base + AMD_FOO_OFFSET + offset_in_foo)

I second Jon's opinion.  Please make the change.  This would be better =
as simply ioread/write in the code.

Allen

