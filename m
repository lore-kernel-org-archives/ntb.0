Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com. [40.107.223.78])
        by gmr-mx.google.com with ESMTPS id y77si63834vky.0.2020.05.05.21.23.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 21:23:01 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 5/5] ntb_perf: avoid false dma unmap of destination address
Date: Tue,  5 May 2020 23:21:52 -0500
Message-Id: <1588738912-24827-6-git-send-email-sanju.mehta@amd.com>
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

The DMA map and unmap of destination address is already being
done in perf_init_test() and perf_clear_test() functions.
Hence avoiding it by making necessary changes in perf_copy_chunk()
function.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dbcfdaa..95a0853 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -804,7 +804,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dst_vaddr = dst;
 	dst_dma_addr = peer->dma_dst_addr + (dst_vaddr - vbase);
 
-	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
 	if (!unmap)
 		return -ENOMEM;
 
@@ -817,15 +817,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dst_dma_addr;
-	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
-		ret = -EIO;
-		goto err_free_resource;
-	}
-	unmap->from_cnt = 1;
-
 	do {
-		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, unmap->addr[1],
+		tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, dst_dma_addr,
 			unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!tx)
 			msleep(DMA_MDELAY);
-- 
2.7.4

