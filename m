Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B935E947;
	Fri,  1 May 2026 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617344; cv=none; b=J1Q/PMN+g8VUCHeyZzNcQDVn214izba02BF2QgbShPZsq/eNBAqyR8cQNilLtXMJrxP+RAnjJJJ74bAxoR/TFW25gHwrHDxmUYEkO2mTIZvtfp33AN758911dcAaIf5TW5CNC+qBQy7jsOOhNWKJlqbBt0xwpEH/NEuVsT6+AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617344; c=relaxed/simple;
	bh=R8UbzY2Jsl+wjKd3k1yLs0tqHlWeOTCKmTzgzTX5mwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp6dfLVBO2j8EEkwA4FHGx0e+eBE064Iqq03adA2OBh4w/c7mJYsuz7+XCfx3IKSg3GRbshXZ/8jnUvNuQZxUxqKkYE+SnMP60ss5h39fgK7KsuJVdPgS/0wp6UGLrzSo40dQSw5PMv0MkAciWRxqyvKYRTxHwt+LqYLQF8NT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnemJXWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnemJXWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A12C2BCB7;
	Fri,  1 May 2026 06:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617344;
	bh=R8UbzY2Jsl+wjKd3k1yLs0tqHlWeOTCKmTzgzTX5mwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnemJXWHu2+mI+xhhNVsUDZY7x+WDnjHtRrwiUqSk/X0StW87IHeG0J/fo/InGNpx
	 uFWcbHMyC5gz9HDEt57JiSbVTzLu1eEasFeMWBCy7qo2GuxjNrEJ8AZKCJhfZZwv+6
	 og3u5OO7TQK4Lu00lNhbuc9qpnJwaQ0wpuXa92Wh6Z2ljkx8yMSnxQuebhqo4F7W5z
	 TkbLkpqZa9HfD8ZC+v8DSoL29mcpRktu1reSQQfB/77ZummltvvTl/zmvNH3OiFSe8
	 FbhMqm3P38obIawL+3X96wFnIFrig2TZpS95D+sEUOp+lseFwhm+fOUMeklvnAxdU1
	 pdgrCzk7Y+Q6Q==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 5/6] dma-debug: Feed DMA attribute for unmapping flows too
Date: Fri,  1 May 2026 09:35:09 +0300
Message-ID: <20260501-dma-attrs-debug-v2-5-8dbac75cd501@nvidia.com>
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

There are multiple unmapping flows which didn't provide DMA attributes,
which limited DMA debug code to compare the mapping and unmapping
attributes. Let's fix it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c   | 13 ++++++++-----
 kernel/dma/debug.h   | 19 +++++++++++--------
 kernel/dma/mapping.c |  8 ++++----
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f07e6a1e9fbab..3dfed51c3d9aa 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1307,8 +1307,8 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 }
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
-void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
-			  size_t size, int direction)
+void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr, size_t size,
+			  int direction, unsigned long attrs)
 {
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_phy,
@@ -1316,6 +1316,7 @@ void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
 		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = direction,
+		.attrs          = attrs,
 	};
 
 	if (unlikely(dma_debug_disabled()))
@@ -1381,7 +1382,7 @@ static int get_nr_mapped_entries(struct device *dev,
 }
 
 void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-			int nelems, int dir)
+			int nelems, int dir, unsigned long attrs)
 {
 	struct scatterlist *s;
 	int mapped_ents = 0, i;
@@ -1399,6 +1400,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			.size           = sg_dma_len(s),
 			.direction      = dir,
 			.sg_call_ents   = nelems,
+			.attrs          = attrs,
 		};
 
 		if (mapped_ents && i >= mapped_ents)
@@ -1454,8 +1456,8 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	add_dma_entry(entry);
 }
 
-void debug_dma_free_coherent(struct device *dev, size_t size,
-			 void *virt, dma_addr_t dma_addr)
+void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
+			     dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
@@ -1463,6 +1465,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
+		.attrs          = attrs,
 	};
 
 	/* handle vmalloc and linear addresses */
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index 24b8610850fbd..13e384633c32a 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -14,21 +14,22 @@ extern void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
 			       unsigned long attrs);
 
 extern void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
-				 size_t size, int direction);
+				 size_t size, int direction,
+				 unsigned long attrs);
 
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			     int nents, int mapped_ents, int direction,
 			     unsigned long attrs);
 
 extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-			       int nelems, int dir);
+			       int nelems, int dir, unsigned long attrs);
 
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
 				     dma_addr_t dma_addr, void *virt,
 				     unsigned long attrs);
 
-extern void debug_dma_free_coherent(struct device *dev, size_t size,
-				    void *virt, dma_addr_t addr);
+extern void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
+				    dma_addr_t addr, unsigned long attrs);
 
 extern void debug_dma_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dma_handle, size_t size,
@@ -59,7 +60,8 @@ static inline void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
 }
 
 static inline void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
-					size_t size, int direction)
+					size_t size, int direction,
+					unsigned long attrs)
 {
 }
 
@@ -70,8 +72,8 @@ static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 }
 
 static inline void debug_dma_unmap_sg(struct device *dev,
-				      struct scatterlist *sglist,
-				      int nelems, int dir)
+				      struct scatterlist *sglist, int nelems,
+				      int dir, unsigned long attrs)
 {
 }
 
@@ -82,7 +84,8 @@ static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static inline void debug_dma_free_coherent(struct device *dev, size_t size,
-					   void *virt, dma_addr_t addr)
+					   void *virt, dma_addr_t addr,
+					   unsigned long attrs)
 {
 }
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6cbefbd4158c8..f010b3cc0ece4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -225,7 +225,7 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 	else if (ops->unmap_phys)
 		ops->unmap_phys(dev, addr, size, dir, attrs);
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
-	debug_dma_unmap_phys(dev, addr, size, dir);
+	debug_dma_unmap_phys(dev, addr, size, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(dma_unmap_phys);
 
@@ -351,7 +351,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 	trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
-	debug_dma_unmap_sg(dev, sg, nents, dir);
+	debug_dma_unmap_sg(dev, sg, nents, dir, attrs);
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
@@ -693,7 +693,7 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	if (!cpu_addr)
 		return;
 
-	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
+	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle, attrs);
 	if (dma_alloc_direct(dev, ops) || arch_dma_free_direct(dev, dma_handle))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
 	else if (use_dma_iommu(dev))
@@ -840,7 +840,7 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
 	trace_dma_free_sgt(dev, sgt, size, dir);
-	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
+	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
 
 	if (use_dma_iommu(dev))
 		iommu_dma_free_noncontiguous(dev, size, sgt, dir);

-- 
2.53.0

