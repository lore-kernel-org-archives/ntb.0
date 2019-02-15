Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (mail-eopbgr740040.outbound.protection.outlook.com. [40.107.74.40])
        by gmr-mx.google.com with ESMTPS id l26si102750otf.0.2019.02.15.01.21.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:21:20 -0800 (PST)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 3/4] NTB: ntb_perf: Clear stale values in doorbell and command
 SPAD register
Date: Fri, 15 Feb 2019 09:21:19 +0000
Message-ID: <1550222458-29752-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

when ntb_perf is unloaded, the command scratchpad register still
retains the last initialized value of PERF_CMD_INVAL. When ntb_perf
is re-loaded and reads peer command scratchpad register and it mis
interprets the peer state as initialized.

To avoid this, clearing the local side command scratchpad register
in perf_disable_service

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 4a3fba4..c7d1a48 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -754,6 +754,14 @@ static void perf_disable_service(struct perf_ctx *perf=
)
 	for (pidx =3D 0; pidx < perf->pcnt; pidx++)
 		flush_work(&perf->peers[pidx].service);
=20
+	for (pidx =3D 0; pidx < perf->pcnt; pidx++) {
+		struct perf_peer *peer =3D &perf->peers[pidx];
+
+		ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx), 0);
+	}
+
+	ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
+
 	ntb_link_disable(perf->ntb);
 }
=20
--=20
2.7.4

