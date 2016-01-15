Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id o63si950215ywd.1.2016.01.15.09.12.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2016 09:12:41 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com> <000001d14ee3$ffd532c0$ff7f9840$@emc.com> <BLUPR12MB0420E27CC06AF3C4046F68DAEBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB0420E27CC06AF3C4046F68DAEBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH V3 0/2] AMD NTB V3 changes
Date: Fri, 15 Jan 2016 12:12:24 -0500
Message-ID: <000001d14fb7$e7981bd0$b6c85370$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> From: Yu, Xiangliang <Xiangliang.Yu@amd.com>

> I want to add flush function into ntb_transport.c, but I can't verify
> the implementation

Ok.  That's a good reason to hold back the flush mechanism: it's not =
been tested.

Nak (for now): [PATCH V3 2/2] NTB: Add support for flush request =
interface

Don't give up.  Please keep working on this, and the power management =
patch, to get them reviewed and accepted.  It's your choice whether or =
not to submit the patches, and when.  I'd encourage you to do it early, =
rather than delay.

Allen

