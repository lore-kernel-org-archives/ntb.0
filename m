Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id y199si3437462ywd.5.2016.01.20.22.17.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 22:17:02 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1453365583-9823-1-git-send-email-Xiangliang.Yu@amd.com> <000001d15405$24fe24a0$6efa6de0$@emc.com> <BLUPR12MB04204F0184C91CC2FB96E5DCEBC30@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB04204F0184C91CC2FB96E5DCEBC30@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH V5 1/1] NTB: Add support for AMD PCI-Express Non-Transparent Bridge
Date: Thu, 21 Jan 2016 01:16:41 -0500
Message-ID: <000101d15413$4c466a50$e4d33ef0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Yu, Xiangliang [mailto:Xiangliang.Yu@amd.com]
> > > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > > Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> >
> > NO.
>=20
> Ok, I'll change it if you doesn't want to change it.

Nah, just remember it for next time...

I'm satisfied with this v5.

Reviewed-by: Allen Hubbe <Allen.Hubbe@emc.com>

> I don=E2=80=99t think so. In here, the i/o memory is only happened =
when
> pci_iomap return
> Success, so the register can't be accessed through IO port way. And
> ioread* will
> Check if the memory type is mmio type or IO port type (please see the
> definition).
>  I don=E2=80=99t think we need to check It, so I use read* because It =
can make
> more efficient.
> I think we need to think about actual usage, not only follow book.
> And, I have said it in previous version, I don=E2=80=99t like explain =
it again,
> and again.
> If you have any concern, please tell me after my comment.

It's not more efficient, on this platform it's the same.

If it were my driver I would change it... but you can keep it this way.

> > This is different from v4.  It used to be:
>=20
> Because peer_sta is change to 0, so amd_link_is_up will return 0
> (offline)
> And will not check hardware link status. So It maybe make it offline
> forever

It fixed a bug?  Great!

> > I'm nervous about ndev->peer_sta, the behavior of link_is_up,
> > timers...
>
> Actually, the code is designed according to Atom NTB, except for the
> peer_sta.

Except for peer_sta, and that's a pretty critical design change.  I'm =
still nervous, but I'll trust that you have been able to test this =
behavior thourougly.

> I'll add the explaination when having changes.

Thanks.

Allen

