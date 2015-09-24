Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id el2si11097pbb.0.2015.09.24.13.20.49
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2015 13:20:50 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20150924200304.3052.96889.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20150924200304.3052.96889.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH] NTB: unify translation addresses
Date: Thu, 24 Sep 2015 16:20:34 -0400
Message-ID: <00c401d0f706$786a4800$693ed800$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang [dave.jiang@intel.com]
> There is no need for the upstream and downstream addresses to be
> different
> for the NTB configs. Go to using a single set of address. It is still
> possible to configure them differently using module parameter override
> however.
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Thanks for leaving in the separately configurable usd/dsd addrs, even =
though the defaults are now the same.

Acked and (pick one)
Tested-by: Allen Hubbe <Allen.Hubbe@emc.com>

