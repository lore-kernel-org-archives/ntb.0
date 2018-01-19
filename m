Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id g45si1396908eda.0.2018.01.19.06.58.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 06:58:19 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] NTB: ntb_perf: fix printing of resource_size_t
Date: Fri, 19 Jan 2018 15:55:28 +0100
Message-Id: <20180119145813.1141817-1-arnd@arndb.de>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Gary R Hook <gary.hook@amd.com>, Serge Semin <fancer.lancer@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On 32-bit architectures, resource_size_t is usually 'unsigned int' or
'unsigned long' but not 'unsigned long long', so we get a warning
about printing the wrong data:

drivers/ntb/test/ntb_perf.c: In function 'perf_setup_peer_mw':
drivers/ntb/test/ntb_perf.c:1390:35: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Werror=format=]

This changes the format string to the special %pa that is already
used elsewhere in the same file.

Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 8de72f3fba4d..1829a17dd461 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1387,8 +1387,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
 		dev_warn(&peer->perf->ntb->dev,
-			"Peer %d outbuf reduced to %#llx\n", peer->pidx,
-			peer->outbuf_size);
+			"Peer %d outbuf reduced to %pa\n", peer->pidx,
+			&peer->outbuf_size);
 	}
 
 	return 0;
-- 
2.9.0

