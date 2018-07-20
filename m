Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x26-v6si114153qtp.2.2018.07.20.11.00.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 11:00:42 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 20 Jul 2018 12:00:32 -0600
Message-Id: <20180720180034.3964-7-logang@deltatee.com>
In-Reply-To: <20180720180034.3964-1-logang@deltatee.com>
References: <20180720180034.3964-1-logang@deltatee.com>
Subject: [PATCH v2 6/8] NTB: perf: Fix support for hardware that doesn't have port numbers
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Legacy drivers do not have port numbers (but is reliably only two ports)
and was broken by the recent commit that added mult-port support to
ntb_perf. This is especially important to support the cross link
topology which is perfectly symmetric and cannot assign unique port
numbers easily.

Hardware that returns zero for both the local port and the peer should
just always use gidx=0 for the only peer.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index fe27412ffe91..6285cb8515ac 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1417,6 +1417,16 @@ static int perf_init_peers(struct perf_ctx *perf)
 	if (perf->gidx == -1)
 		perf->gidx = pidx;
 
+	/*
+	 * Hardware with only two ports may not have unique port
+	 * numbers. In this case, the gidxs should all be zero.
+	 */
+	if (perf->pcnt == 1 &&  ntb_port_number(perf->ntb) == 0 &&
+	    ntb_peer_port_number(perf->ntb, 0) == 0) {
+		perf->gidx = 0;
+		perf->peers[0].gidx = 0;
+	}
+
 	for (pidx = 0; pidx < perf->pcnt; pidx++) {
 		ret = perf_setup_peer_mw(&perf->peers[pidx]);
 		if (ret)
-- 
2.11.0

