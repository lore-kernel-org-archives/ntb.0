Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id p88si9707259pfi.0.2016.01.06.10.20.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 10:20:11 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1450878160-9259-1-git-send-email-Xiangliang.Yu@amd.com>
In-Reply-To: <1450878160-9259-1-git-send-email-Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V2 0/3] Change notes of V2
Date: Wed, 6 Jan 2016 13:19:52 -0500
Message-ID: <000101d148ae$d6ad3540$84079fc0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Xiangliang Yu' <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

From: Xiangliang Yu <Xiangliang.Yu@amd.com>:
> Main changes in V2:
> 1. Fixed compiler warning;
> 2. Add marcro argument of ndev in NTB_READ_REG/NTB_WRITE_REG;
> 3. Add notes for flush and wakeup interfaces;
>=20
> Xiangliang Yu (3):
>   NTB: Add AMD PCI-Express NTB driver
>   NTB: Add AMD NTB support in Kconfig and Makefile
>   NTB: Add flush_req and wakeup interface

Could you re-spin these patches as:

Patch 1:
	Only the parts of the driver that fit the current NTB APIs.

Patch 2:
	The new flush_req API, and the related code in the AMD driver.

Patch 3:
	The new wakeup API, and related code in the AMD driver.

In particular, I think we need feedback on #3 from PCI and power =
management maintainers.

When making #1, please make sure that the patch stands on its own, =
without any of the code related to #2 or #3 in #1.  Do put the makefile =
and kconfig changes in #1.

Thanks,
Allen

