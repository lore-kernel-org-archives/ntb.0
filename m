Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0696.outbound.protection.outlook.com. [2a01:111:f400:fc0c::696])
        by gmr-mx.google.com with ESMTPS id s18si862189igr.3.2016.01.17.22.49.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 22:49:40 -0800 (PST)
From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V3 0/2] AMD NTB V3 changes
Date: Mon, 18 Jan 2016 06:49:38 +0000
Message-ID: <BLUPR12MB042080428FF23328B2D6685CEBC00@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com>
 <000001d14ee3$ffd532c0$ff7f9840$@emc.com>
 <BLUPR12MB0420E27CC06AF3C4046F68DAEBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
 <000001d14fb7$e7981bd0$b6c85370$@emc.com> <20160118040933.GD11303@kudzu.us>
In-Reply-To: <20160118040933.GD11303@kudzu.us>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: "dave.jiang@intel.com" <dave.jiang@intel.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>


> > > I want to add flush function into ntb_transport.c, but I can't
> > > verify the implementation
> >
> > Ok.  That's a good reason to hold back the flush mechanism: it's not be=
en
> tested.
> >
> > Nak (for now): [PATCH V3 2/2] NTB: Add support for flush request
> > interface
> >
> > Don't give up.  Please keep working on this, and the power management
> patch, to get them reviewed and accepted.  It's your choice whether or no=
t
> to submit the patches, and when.  I'd encourage you to do it early, rathe=
r
> than delay.
>=20
> I'd like to echo Allen's comment above.  Do not give up.  This code is ve=
ry
> close to being accepted (once the issues that Allen and I pointed out are
> addressed).  If you can get us another version on/before Wednesday, it
> should make the 4.5 release (assuming it is acceptable and the wdinow is =
not
> closed prematurely).
>=20
> Thanks for all of your hard work (and many thanks to Allen for his review=
s of
> the code as well).

I'll change code right now and please help reviewed it again.
