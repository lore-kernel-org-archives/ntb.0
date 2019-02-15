Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-eopbgr770070.outbound.protection.outlook.com. [40.107.77.70])
        by gmr-mx.google.com with ESMTPS id s3-v6si248097ljg.5.2019.02.15.01.20.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 01:20:10 -0800 (PST)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 1/4] NTB: ntb_perf: Increased the number of message retries to
 1000
Date: Fri, 15 Feb 2019 09:20:07 +0000
Message-ID: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

while waiting for the peer ntb_perf to initialize scratchpad
registers, local side ntb_perf  might have already exhausted the
maximum number of retries which is currently set to 500. To avoid
this and to give little more time to the peer ntb_perf for scratchpad
initialization, increased the number of retries to 1000

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0..a828d0e 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -100,7 +100,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement To=
ol");
 #define DMA_TRIES		100
 #define DMA_MDELAY		10
=20
-#define MSG_TRIES		500
+#define MSG_TRIES		1000
 #define MSG_UDELAY_LOW		1000
 #define MSG_UDELAY_HIGH		2000
=20
--=20
2.7.4

