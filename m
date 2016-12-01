Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03on0047.outbound.protection.outlook.com. [104.47.42.47])
        by gmr-mx.google.com with ESMTPS id p84si1432034itg.1.2016.12.01.11.12.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:12:22 -0800 (PST)
From: Shyam Sundar S K <ssundark@amd.com>
Subject: [PATCH 1/2] ntb_transport: Limit memory windows based on available,
 scratchpads
Message-ID: <77f276f0-18df-6365-1b66-dfe4b30ee7d8@amd.com>
Date: Fri, 2 Dec 2016 00:41:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>, Dave Jiang <dave.jiang@intel.com>
Cc: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Su,
 Richard (Bin)" <Richard1.Su@amd.com>, "Subramaniyan, Ramkumar" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

When the underlying NTB H/W driver advertises more memory windows
than the number of scratchpads available to setup MW's, it is likely
that we may end up filling the remaining memory windows with garbage.
So to avoid that, lets limit the memory windows that transport driver
can setup based on the available scratchpads.

Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
---
 drivers/ntb/ntb_transport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4eb8adb..50d6b06 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1064,7 +1064,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt;
 	struct ntb_transport_mw *mw;
-	unsigned int mw_count, qp_count;
+	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
 	u64 qp_bitmap;
 	int node;
 	int rc, i;
@@ -1090,8 +1090,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;

 	nt->ndev = ndev;
+	spad_count = ntb_spad_count(ndev);

-	nt->mw_count = mw_count;
+    /* Limit the MW's based on the availability of scratchpads */
+	if (spad_count > NUM_MWS + 2) {
+		max_mw_count_for_spads = (spad_count - (NUM_MWS + 1)) >> 1;
+		nt->mw_count = min(mw_count, max_mw_count_for_spads);
+	} else {
+		nt->mw_count = 0;
+		goto err;
+	}

 	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
 				  GFP_KERNEL, node);
-- 
2.7.4
