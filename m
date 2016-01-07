Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id dz2si4575438pab.1.2016.01.07.06.43.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2016 06:43:32 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1450878160-9259-1-git-send-email-Xiangliang.Yu@amd.com> <000101d148ae$d6ad3540$84079fc0$@emc.com> <BLUPR12MB0420EEA096245F2D6DEDD483EBF50@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB0420EEA096245F2D6DEDD483EBF50@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH V2 0/3] Change notes of V2
Date: Thu, 7 Jan 2016 09:43:09 -0500
Message-ID: <000001d14959$bb730790$325916b0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> > In particular, I think we need feedback on #3 from PCI and power
> > management maintainers.
>
> I don't get your concern.
> I think we can add device attribute file to let application to trigger
> wakeup function, then NTB hardware will do the rest. NTB driver just
> need to implement suspend/resume interface of PCI PM.
>=20
> Add one more thing, do you think NTB should support runtime power
> management?
>

I think it is good to make the power management functionality available. =
 In other words, yes, to your last question.

My concern is that I would like some degree of certainty that it is done =
right, in harmony with the rest of the kernel.  I don't know what "done =
right" means in this case, which is why I would like someone else to =
review it.  A smaller patch with only (and all of) the power management =
code will have a better chance of being reviewed.

I'm also concerned about the waiting behavior in #2 and #3.  I'm not =
saying it's wrong.  At least now that behavior is noted in the api =
documentation; thanks for that.  If a PCI or power management expert has =
no objection to the waiting behavior in #3, then I would be comfortable =
with that behavior in #2 as well.

Allen

