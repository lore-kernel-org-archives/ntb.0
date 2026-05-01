Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769192770A;
	Fri,  1 May 2026 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617331; cv=none; b=tjLErntTornfkEIXZAKnrZLLhk+vpCGUNhkLPuiuU1vi0u8ceEv3jSgo9mMN0fLOavyFHj5H1qYAyzRiecHXH53IfXkvM9x9zcnnF5Rzy7IzeIbU7XxNdtfzsKBs1Dj4HpcDTBaykRFqp8+2Lq0+ZlR+wQ0phvEBeOtRp0YJmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617331; c=relaxed/simple;
	bh=mTWNzSRIXjAV+rv/PIoaynWXUFcrPJrX27oUCT/3C5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmY/txFRrzaYqMUfsRz2kLaEeIKkgagsNnKai+YSu8fyfORxThrdFc2b5wbnYhq42x4PuDKRbzQqAxq7BCo2D1b/s0LZYGTCVo1UjfcWxbpP1wODLvJ/1JyLvmVxi6J06mF71F3cCwskXEXRTQAfItcq1IHvjfqhclhwbvfRREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht0gRM7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht0gRM7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B6C2BCB7;
	Fri,  1 May 2026 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617331;
	bh=mTWNzSRIXjAV+rv/PIoaynWXUFcrPJrX27oUCT/3C5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht0gRM7bXDDLDo14MTqfbpGLEvELUzeINxLo7cVZtabS958NkDbSOeUFXLCZ77VIb
	 5vKOLLpNNUraVRSufQdzWYkw4IaZtIQpzg0IwpbYs2QUDK+cFVcoE6R2HjeEH9zXqT
	 dBLElN2BJ3+supQiKa4WZ6sL95jk9zw77DBqS7pZnvm16g+Y3k8zoRZo1zSHdczCJ6
	 fmX14jhnf79WmHANBtdc7h46+/5nwLJC1m9ZKjAk2hhSTuZXXJB+t/rdQCO0mhdEXP
	 bJiWFvJkl/ohZPFQA7+40dQsoZVPdjlseZz+lL+P5U8572RACZG49iRSq9vUVYKaCh
	 Wqvh9rgJsL0bw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 2/6] ntb: Use consistent DMA attributes when freeing DMA mappings
Date: Fri,  1 May 2026 09:35:06 +0300
Message-ID: <20260501-dma-attrs-debug-v2-2-8dbac75cd501@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The counterpart of dma_alloc_attrs() is dma_free_attrs(), which must
receive the same DMA attributes used during allocation. The code
previously used dma_free_coherent(), which does not accept or apply any
DMA attributes.

Fixes: 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/ntb/ntb_transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 771eb7d9f4356..f59f926d4bfaa 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -766,8 +766,8 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(dma_dev, mw->alloc_size,
-			  mw->alloc_addr, mw->original_dma_addr);
+	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
+		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
 	mw->alloc_size = 0;
@@ -828,8 +828,8 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
 	return 0;
 
 err:
-	dma_free_coherent(ntb_dev, mw->alloc_size, alloc_addr, dma_addr);
-
+	dma_free_attrs(ntb_dev, mw->alloc_size, alloc_addr, dma_addr,
+		       DMA_ATTR_FORCE_CONTIGUOUS);
 	return rc;
 }
 

-- 
2.53.0

