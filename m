Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id g66si537722ywf.4.2016.01.14.07.55.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2016 07:55:42 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com>
In-Reply-To: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V3 0/2] AMD NTB V3 changes
Date: Thu, 14 Jan 2016 10:55:31 -0500
Message-ID: <000001d14ee3$ffd532c0$ff7f9840$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Xiangliang Yu' <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

> From: Xiangliang Yu <Xiangliang.Yu@amd.com>
>=20
> Main changes in V3
> 1. Remove all power managment related code.

Can you send the third patch with the power management code?  I think it =
is important functionality.

Furthermore, a review of the power management patch will help with =
getting the flush patch accepted.  If the power management patch is =
reviewed and acked as is, the flush patch is probably ok, too, as is.  =
If there are changes to power management that are also applicable to the =
flush patch, it would be good to keep it all consistent when adding the =
functionality to the api.

> 2. Put makefile and kconfig changes in first patch.
> 3. Call readl/writel directly, not use macros to hide it.

I think this is almost ready.  See comments in NTB: Add AMD PCI-Express =
NTB driver.

Allen

