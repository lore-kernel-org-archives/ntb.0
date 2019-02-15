Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (mail-eopbgr720066.outbound.protection.outlook.com. [40.107.72.66])
        by gmr-mx.google.com with ESMTPS id y11si307681ita.1.2019.02.15.01.20.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 01:20:38 -0800 (PST)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 2/4] NTB: ntb_perf: Disable NTB link after clearing peer XLAT
 registers
Date: Fri, 15 Feb 2019 09:20:30 +0000
Message-ID: <1550222411-29072-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

If ntb link disabled before clearing peer's XLAT register, the clearing
won't have any effect since the link is already down. So modified the
sequence so that the link is down only towards the end of the function
after clearing the XLAT register

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index a828d0e..4a3fba4 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -737,8 +737,6 @@ static void perf_disable_service(struct perf_ctx *perf)
 {
 	int pidx;
=20
-	ntb_link_disable(perf->ntb);
-
 	if (perf->cmd_send =3D=3D perf_msg_cmd_send) {
 		u64 inbits;
=20
@@ -755,6 +753,8 @@ static void perf_disable_service(struct perf_ctx *perf)
=20
 	for (pidx =3D 0; pidx < perf->pcnt; pidx++)
 		flush_work(&perf->peers[pidx].service);
+
+	ntb_link_disable(perf->ntb);
 }
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
--=20
2.7.4

