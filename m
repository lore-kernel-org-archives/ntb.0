Return-Path: <sashal@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id q207si907235iod.5.2019.10.01.09.43.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:43:45 -0700 (PDT)
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 23/43] ntb: point to right memory window index
Date: Tue,  1 Oct 2019 12:42:51 -0400
Message-Id: <20191001164311.15993-23-sashal@kernel.org>
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sanjay R Mehta <sanju.mehta@amd.com>, Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

[ Upstream commit ae89339b08f3fe02457ec9edd512ddc3d246d0f8 ]

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
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0d1f193..80508da3c8b5c 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1373,7 +1373,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	int ret;
 
 	/* Get outbound MW parameters and map it */
-	ret = ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
+	ret = ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
 				   &peer->outbuf_size);
 	if (ret)
 		return ret;
-- 
2.20.1

