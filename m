Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id g66si2754655ywf.4.2016.01.20.08.26.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 08:26:53 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1453205805-851-1-git-send-email-Xiangliang.Yu@amd.com> <000301d152f8$2e7a7780$8b6f6680$@emc.com> <BLUPR12MB04207EF72B53019C43947550EBC20@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB04207EF72B53019C43947550EBC20@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH V4 1/1] NTB: Add support for AMD PCI-Express Non-Transparent Bridge
Date: Wed, 20 Jan 2016 11:26:42 -0500
Message-ID: <000101d1539f$5966cd70$0c346850$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> > There is some concept of "split bar" in this function, and I want to
> be sure to
> > understand it correctly.
> >
> > BAR0 - configuration?
> > BAR1 - 32bit memory window? i.e. "split" bar?
> > BAR2+3 - 64bit memory window?
> > BAR4+5 - 64bit memory window?
>=20
> Yes

Ok.

> > Note that "split" in the intel driver refers to BAR4+5, which is
> normally a 64bit
> > memory window, split into independent 32bit windows BAR4 and BAR5 by
> > bios configuration.  Calling it "split" there makes sense.  Here,
> calling it "split"
> > is confusing, but as long as the code is correct, I think it's ok.
>=20
> AMD NTB has similar design.

If by similar design, you mean that BAR2+3 or BAR4+5 can be split, those =
configurations are not currently supported by this driver.  If needed, =
support for those configurations can be added later, as a patch.

Ok with the current implementation.

> > I see a lot of readl/writel and ioread/iowrite in the same file, =
even
> in the
> > same function as there is here.  Pick one variant of the functions,
> preferably
> > the ioread/iowrite variant, and be consistent in its usage =
throughout
> the file.
>=20
> Ioread/iowrite is only for 64bit read/write, I don't think it has any
> confusion.

It's not just for 64bit: there are ioread8,16,32.  In fact, ioread64 is =
the one that's not provided by io.h: not all hardware can do a true =
64bit read or write.  We don't need a true 64bit operation, so ioread64 =
is provided locally, for convenience within this driver.

> Actually, Intel NTB driver has same behavior.

Actually, Intel NTB driver does not use readl/writel.

Would you please fix this?

> > It's also interesting that if it hits the last branch, =
ndev->peer_sta
> is assigned
> > zero, but the function returns zero, not LNK_STA.  If the function
> were
> > immediately called again, it would return LNK_STA.  Can you please
> explain
> > the logic here?
>=20
> Force to read link status register again because the opposite side =
maybe
> still
> In resuming progress, the status variable can't show the right state,
> have to
> Read register directly.

There's no indication in this function that it interacts with the timer. =
 With your suggestion, I'll take a closer look at the interactions =
between this function and the timer.

