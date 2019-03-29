Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (mail-eopbgr810073.outbound.protection.outlook.com. [40.107.81.73])
        by gmr-mx.google.com with ESMTPS id e23si100289ybb.1.2019.03.29.04.32.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 04:32:53 -0700 (PDT)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH] point to right memory window index
Date: Fri, 29 Mar 2019 11:32:50 +0000
Message-ID: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

second parameter of ntb_peer_mw_get_addr is pointing to wrong memory
window index by passing "peer gidx" instead of "local gidx".

For ex, "local gidx" value is '0' and "peer gidx" value is '1', then

on peer side ntb_mw_set_trans() api is used as below with gidx pointing to
local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
will be programmed by peer side.

    ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
                    peer->inbuf_size);

Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx
pointing to "peer gidx" which is '1', so pointing to memory window '1'
instead of memory window '0'.

    ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
                        &peer->outbuf_size);

So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index c7d1a48..08e18d7 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1381,7 +1381,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	int ret;
=20
 	/* Get outbound MW parameters and map it */
-	ret =3D ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
+	ret =3D ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
 				   &peer->outbuf_size);
 	if (ret)
 		return ret;
--=20
2.7.4

