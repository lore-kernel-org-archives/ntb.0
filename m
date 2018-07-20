Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h9-v6si99325pgp.5.2018.07.20.11.00.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 11:00:46 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 20 Jul 2018 12:00:30 -0600
Message-Id: <20180720180034.3964-5-logang@deltatee.com>
In-Reply-To: <20180720180034.3964-1-logang@deltatee.com>
References: <20180720180034.3964-1-logang@deltatee.com>
Subject: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This commit fixes pingpong support for existing drivers that do not
implement ntb_default_port_number() and ntb_default_peer_port_number().
This is required for hardware (like the crosslink topology of
switchtec) which cannot assign reasonable port numbers to each port due
to its perfect symmetry.

Instead of picking the doorbell to use based on the the index of the
peer, we use the peer's port number. This is a bit clearer and easier
to understand.

Fixes: c7aeb0afdcc2 ("NTB: ntb_pp: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_pingpong.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 65865e460ab8..18d00eec7b02 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -121,15 +121,14 @@ static int pp_find_next_peer(struct pp_ctx *pp)
 	link = ntb_link_is_up(pp->ntb, NULL, NULL);
 
 	/* Find next available peer */
-	if (link & pp->nmask) {
+	if (link & pp->nmask)
 		pidx = __ffs64(link & pp->nmask);
-		out_db = BIT_ULL(pidx + 1);
-	} else if (link & pp->pmask) {
+	else if (link & pp->pmask)
 		pidx = __ffs64(link & pp->pmask);
-		out_db = BIT_ULL(pidx);
-	} else {
+	else
 		return -ENODEV;
-	}
+
+	out_db = BIT_ULL(ntb_peer_port_number(pp->ntb, pidx));
 
 	spin_lock(&pp->lock);
 	pp->out_pidx = pidx;
@@ -303,7 +302,7 @@ static void pp_init_flds(struct pp_ctx *pp)
 			break;
 	}
 
-	pp->in_db = BIT_ULL(pidx);
+	pp->in_db = BIT_ULL(lport);
 	pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
 	pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
 
@@ -435,4 +434,3 @@ static void __exit pp_exit(void)
 	debugfs_remove_recursive(pp_dbgfs_topdir);
 }
 module_exit(pp_exit);
-
-- 
2.11.0

