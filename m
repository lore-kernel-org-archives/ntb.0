Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com. [2607:f8b0:4864:20::544])
        by gmr-mx.google.com with ESMTPS id i27si28389uat.1.2020.02.05.09.17.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:17:47 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j4so1284307pgi.1
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 09:17:47 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 3/4] ntb_perf: pass correct struct device to dma_alloc_coherent
Date: Wed,  5 Feb 2020 22:46:57 +0530
Message-Id: <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
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
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 5116655f0211..65501f24b742 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -558,7 +558,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -587,8 +587,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
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
2.17.1

