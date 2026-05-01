Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D02770A;
	Fri,  1 May 2026 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617339; cv=none; b=O+PFe81p7F2Sxds2vr53oPRuKz9UAMtc/p2ShqzNKI40UZGoPn/R9JIxo6HBJPO5NIkFw92Ik87U8fObpYQMlnPr8co+N2xgBUEXdgH45klVRlj2EcBR8Hl7lcBVJkD9yvsHLl0LcOIVqMd2V0CQ5N1P/T5mkwDQ65pO0q7nb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617339; c=relaxed/simple;
	bh=XXU1K2WLKtohzllOvk1zXQ0oKkUYvIfV5iTsJ5+CamQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K12zZfqOpo9x8b8j3Ry6INMLLQmnGtqji0QLaHRKwZRBiGX8KIipBr381Nv2BRZh13feZQX/yrWfW5o/qgYf3JVNO+dWmE+Txt3LRprxYgyXHYyUwP5VRNjGGiCxkNbIHEgh7u+yXah5I9Y25BkqmP4LO0R5B7iSBKgkj91PgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG1LD8uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG1LD8uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026CAC2BCB7;
	Fri,  1 May 2026 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617339;
	bh=XXU1K2WLKtohzllOvk1zXQ0oKkUYvIfV5iTsJ5+CamQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XG1LD8uh1zKA90wmytCfmAxjQ4A4cKpMmMG9S3UJPYuFbQxG9T+nIqW4w8iVO0AG3
	 KDK8g0RdKAywJnW/PjJbiBZUgOhHoph9GxkD0i27nmprma8PTuP75My9vxhIrrl0QS
	 KiBKFCWvLAHn8LtvKKfsGAo3mxrIdbKMjJYuIzy9T/MbKgX5qUndx5bs2wxamMw7g7
	 lzdemHMuN6DT5c4GN/Ey6bTdcm3porIGBLgaNXjpXdCFD1zAVYgV25x+7Q1L963Ozt
	 qreQvF37Ttj4QRdf0a6D4XKgs8lTH5n3hNEmFigXujcHVH2qeu3SGv+tVH8BTjsrYo
	 rtlv0oJUEKwzw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 1/6] ntb: Store original DMA address for future release
Date: Fri,  1 May 2026 09:35:05 +0300
Message-ID: <20260501-dma-attrs-debug-v2-1-8dbac75cd501@nvidia.com>
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

The DMA API requires that dma_free_attrs receive the exact dma_handle
originally returned by the allocation function. Do not modify it.

Fixes: fc5d1829f9bf ("NTB: transport: Try harder to alloc an aligned MW buffer")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 7cabc82305d6b..771eb7d9f4356 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -223,6 +223,7 @@ struct ntb_transport_mw {
 	void *alloc_addr;
 	void *virt_addr;
 	dma_addr_t dma_addr;
+	dma_addr_t original_dma_addr;
 };
 
 struct ntb_transport_client_dev {
@@ -766,7 +767,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_coherent(dma_dev, mw->alloc_size,
-			  mw->alloc_addr, mw->dma_addr);
+			  mw->alloc_addr, mw->original_dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
 	mw->alloc_size = 0;
@@ -802,6 +803,7 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
 		return -ENOMEM;
 	}
 	virt_addr = alloc_addr;
+	mw->original_dma_addr = dma_addr;
 
 	/*
 	 * we must ensure that the memory address allocated is BAR size

-- 
2.53.0

