Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com. [40.107.236.52])
        by gmr-mx.google.com with ESMTPS id k16si112305qkg.0.2019.12.10.05.07.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 05:07:58 -0800 (PST)
From: Sanjay R Mehta <Sanju.Mehta@amd.com>
Subject: [PATCH] ntb_perf: pass correct struct device to dma_alloc_coherent
Date: Tue, 10 Dec 2019 07:07:35 -0600
Message-Id: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain
Return-Path: Sanju.Mehta@amd.com
MIME-Version: 1.0
To: Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us
Cc: logang@deltatee.com, dave.jiang@intel.com, allenbh@gmail.com, will@kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

Currently, ntb->dev is passed to dma_alloc_coherent
and dma_free_coherent calls. The returned dma_addr_t
is the CPU physical address. This works fine as long
as IOMMU is disabled. But when IOMMU is enabled, we
need to make sure that IOVA is returned for dma_addr_t.
So the correct way to achieve this is by changing the
first parameter of dma_alloc_coherent() as ntb->pdev->dev
instead.

Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index f5df33a..8729838 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+					 peer->inbuf_size, &peer->inbuf_xlat,
+					 GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
-- 
2.7.4

