Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id i204si526631ywc.3.2016.01.14.08.00.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2016 08:00:04 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
Subject: RE: [PATCH v6] ntb: ntb perf tool
Date: Thu, 14 Jan 2016 10:59:40 -0500
Message-ID: <000201d14ee4$93e3e0b0$bbaba210$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

> From: Dave Jiang <dave.jiang@intel.com>
> Sent: Wednesday, January 13, 2016 3:30 PM
> To: Hubbe, Allen; jdmason@kudzu.us
> Cc: linux-ntb@googlegroups.com
> Subject: [PATCH v6] ntb: ntb perf tool
>=20
> Providing raw performance data via a tool that directly access data =
from
> NTB w/o any software overhead. This allows measurement of the hardware
> performance limit. In revision one we are only doing single direction
> CPU and DMA writes. Eventually we will provide bi-directional writes.
>=20
> The measurement using DMA engine for NTB performance measure does
> not measure the raw performance of DMA engine over NTB due to software
> overhead. But it should provide the peak performance through the Linux
> DMA
> driver.
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Tested-by: Allen Hubbe <Allen.Hubbe@emc.com>

This driver seems to work as described.  My performance results were =
lower than expected, but I tested on a nonstandard ntb config.

Allen

