Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AC35F165;
	Fri,  1 May 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617335; cv=none; b=EBkhur9pQglN784vW6Zz+F1RxPZLiAzXVH1u7AqJWIQn3Q6LRchQxC2mk2qIK30DsCbD/geRzNRagjBEgxoB177gBYKI07BBvPZpVOMar538/c78j2VQD2o5O2wIL4fqLph0t/Y5cSZEqxlMMBqr+2xT1Axmt+7uB27bPPkyE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617335; c=relaxed/simple;
	bh=Nyii8LS3VFTqihhwtU86Uleg2NsguKtgy4deSAosxs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeczDgPE1/SU5fkNubc+8z9qQ0wlrcHrEI3rxJ3X9IyiNgHm/UazsDezn0dIn9SaHA7RqD62zqc6Ej7MaRiiirO4xN53Wg3fbZtlA4xSZnfChj2q5Ot/9NuhZ5fBwK0295iW1bJN7NYdeAlDFfriUfBrXrJ9cHSNyt6z2Dh0cwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+p78jCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+p78jCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0212BC2BCB7;
	Fri,  1 May 2026 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617335;
	bh=Nyii8LS3VFTqihhwtU86Uleg2NsguKtgy4deSAosxs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+p78jCp2fICGx7XwPQrhmv4Axzcb4RN2w8OAke0ZJ87ItPaIyfp3Idu2Jl7j0GVf
	 OAAT3jyEpduX9qTC3X8CjhNgwMYWjDkmjHKA+hihKdFwPOzn5jbbLogeEr6qLxcAQu
	 2aMZnZnYtWfYDmWpJ4doC3Cwzz1ZDV9reKi1n3xrlnJYMw96A/99iKQr5SS9lX3KIq
	 g+M09kCZaQjh6Mp5hwWrIz5MtkHsBtIk76cWfUd/2clasl2ltXOZ7kUaa0OIccLtTQ
	 Wkdhq8ZSAVZ0BBBMsEx3BSGlO+fflz3dGnQ+DRY7D/TlNDlop7f0eLbp30vIJBV8oP
	 auJXrT349pmVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 3/6] dma-debug: Remove unused DMA attribute parameter
Date: Fri,  1 May 2026 09:35:07 +0300
Message-ID: <20260501-dma-attrs-debug-v2-3-8dbac75cd501@nvidia.com>
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

debug_dma_alloc_pages() always receives a DMA attribute value of 0,
because dma_alloc_pages() never receives any attributes from its callers.
As preparation for upcoming patches, remove this unused attribute from
the debug routine.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c   | 5 ++---
 kernel/dma/debug.h   | 6 ++----
 kernel/dma/mapping.c | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1a725edbbbf6a..3b53495337f5c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1567,8 +1567,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 void debug_dma_alloc_pages(struct device *dev, struct page *page,
 			   size_t size, int direction,
-			   dma_addr_t dma_addr,
-			   unsigned long attrs)
+			   dma_addr_t dma_addr)
 {
 	struct dma_debug_entry *entry;
 
@@ -1586,7 +1585,7 @@ void debug_dma_alloc_pages(struct device *dev, struct page *page,
 	entry->dev_addr  = dma_addr;
 	entry->direction = direction;
 
-	add_dma_entry(entry, attrs);
+	add_dma_entry(entry, 0);
 }
 
 void debug_dma_free_pages(struct device *dev, struct page *page,
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index da7be0bddcf67..24b8610850fbd 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -47,8 +47,7 @@ extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 int nelems, int direction);
 extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
 				  size_t size, int direction,
-				  dma_addr_t dma_addr,
-				  unsigned long attrs);
+				  dma_addr_t dma_addr);
 extern void debug_dma_free_pages(struct device *dev, struct page *page,
 				 size_t size, int direction,
 				 dma_addr_t dma_addr);
@@ -113,8 +112,7 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 
 static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
 					 size_t size, int direction,
-					 dma_addr_t dma_addr,
-					 unsigned long attrs)
+					 dma_addr_t dma_addr)
 {
 }
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e5..6cbefbd4158c8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -733,7 +733,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	if (page) {
 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
 				      size, dir, gfp, 0);
-		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle);
 	} else {
 		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
 	}

-- 
2.53.0

