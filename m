Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615235E947;
	Fri,  1 May 2026 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617349; cv=none; b=EH80m/RldjdSlpzrVTz9sNWAjYQhqi7DUxyeCng41F9sHmLOrRzx4uPvLpk4mXi6qZbUjvdiswUqZFz/st6VV/oo/ZxqXDS1BiH1Gs7IQqDz7mZU9b5nWafChct9fcxeoCWzadpp9XLgrQzc2nIqLze7hAB02G/CUHreu7p4py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617349; c=relaxed/simple;
	bh=HJrpn+aNgMdOWPnmtanzs/jmRZW7gC7eZCqUOLhqwoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+97bwkbLeGgAlAyQSWocaRpGVt+uba5bSL2W3aybNmUAhTqFEy1772mAIR65vXt4VurxBfXP+T6/4gLtDfl6cy+866IaLq4vL5HP3Npr3QwCOCcwBeI3s7SUwsL1Q+yx4TceRvA8L/VsBDF5HtOsVgRNnWKt13STn3JW/n4G3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd4REYQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd4REYQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C22C2BCB9;
	Fri,  1 May 2026 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617348;
	bh=HJrpn+aNgMdOWPnmtanzs/jmRZW7gC7eZCqUOLhqwoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xd4REYQJ/6+sO6IufzPA2Xq9E+b3lyJW8AaZsyKkvbiVng9Ln+7Y+DvhiNhM1tua3
	 i6QpJMzZ2ZA6BbnmglYNFbhmy0AHyh34Ac3DmHQDnjj7blhIzwzk+kkKmnKGyRJFjo
	 Na51XkhLy+Xhu84TocFJu/iKrQdQ7BzZN/bKDJk16/AcoJEgsnpbn18avUKiQfUzHp
	 kAt05rDKk0PC7WULfRskUHWIPZ45lavAM4bSM9IXJU6CjL/HgOUXbyQWWOU3dEw7HY
	 ljFbcWuCVewm4qTxlEu8WGIGfrZVxso4HDr3Pbp6wQ/vdEzib2tLESTNYGz+36KdAQ
	 rSCFLnz45xj5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 4/6] dma-debug: Record DMA attributes in debug entry
Date: Fri,  1 May 2026 09:35:08 +0300
Message-ID: <20260501-dma-attrs-debug-v2-4-8dbac75cd501@nvidia.com>
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

To enable reliable comparison of DMA attributes between map and
unmap operations, store the attribute value in dma_debug_entry.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3b53495337f5c..f07e6a1e9fbab 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -63,7 +63,7 @@ enum map_err_types {
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
  * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
- * @is_cache_clean: driver promises not to write to buffer while mapped
+ * @attrs: dma attributes
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
  */
@@ -78,7 +78,7 @@ struct dma_debug_entry {
 	int		 sg_mapped_ents;
 	phys_addr_t	 paddr;
 	enum map_err_types map_err_type;
-	bool		 is_cache_clean;
+	unsigned long	 attrs;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
@@ -478,6 +478,9 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
 				   bool *overlap_cache_clean)
 {
 	phys_addr_t cln = to_cacheline_number(entry);
+	bool is_cache_clean = entry->attrs &
+			      (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
+			       DMA_ATTR_REQUIRE_COHERENT);
 	unsigned long flags;
 	int rc;
 
@@ -495,12 +498,15 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
 	if (rc == -EEXIST) {
 		struct dma_debug_entry *existing;
 
-		active_cacheline_inc_overlap(cln, entry->is_cache_clean);
+		active_cacheline_inc_overlap(cln, is_cache_clean);
 		existing = radix_tree_lookup(&dma_active_cacheline, cln);
 		/* A lookup failure here after we got -EEXIST is unexpected. */
 		WARN_ON(!existing);
 		if (existing)
-			*overlap_cache_clean = existing->is_cache_clean;
+			*overlap_cache_clean =
+				existing->attrs &
+				(DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
+				 DMA_ATTR_REQUIRE_COHERENT);
 	}
 	spin_unlock_irqrestore(&radix_lock, flags);
 
@@ -544,12 +550,13 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
+					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s attrs=0x%lx\n",
 					 type2name[entry->type], idx,
 					 &entry->paddr, entry->dev_addr,
 					 entry->size, &cln,
 					 dir2name[entry->direction],
-					 maperr2str[entry->map_err_type]);
+					 maperr2str[entry->map_err_type],
+					 entry->attrs);
 			}
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
@@ -575,14 +582,15 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
+				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s attrs=0x%lx\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
 				   &entry->paddr, entry->dev_addr,
 				   entry->size, &cln,
 				   dir2name[entry->direction],
-				   maperr2str[entry->map_err_type]);
+				   maperr2str[entry->map_err_type],
+				   entry->attrs);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
 	}
@@ -594,16 +602,14 @@ DEFINE_SHOW_ATTRIBUTE(dump);
  * Wrapper function for adding an entry to the hash.
  * This function takes care of locking itself.
  */
-static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
+static void add_dma_entry(struct dma_debug_entry *entry)
 {
+	unsigned long attrs = entry->attrs;
 	bool overlap_cache_clean;
 	struct hash_bucket *bucket;
 	unsigned long flags;
 	int rc;
 
-	entry->is_cache_clean = attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
-					 DMA_ATTR_REQUIRE_COHERENT);
-
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
 	put_hash_bucket(bucket, flags);
@@ -612,9 +618,10 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST &&
-		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		   !(entry->is_cache_clean && overlap_cache_clean) &&
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
+			      DMA_ATTR_REQUIRE_COHERENT) &&
+		     overlap_cache_clean) &&
 		   dma_get_cache_alignment() >= L1_CACHE_BYTES &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
@@ -1250,6 +1257,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	entry->size      = size;
 	entry->direction = direction;
 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
+	entry->attrs     = attrs;
 
 	if (!(attrs & DMA_ATTR_MMIO)) {
 		check_for_stack(dev, phys);
@@ -1258,7 +1266,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 			check_for_illegal_area(dev, phys_to_virt(phys), size);
 	}
 
-	add_dma_entry(entry, attrs);
+	add_dma_entry(entry);
 }
 
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -1345,10 +1353,11 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		entry->direction      = direction;
 		entry->sg_call_ents   = nents;
 		entry->sg_mapped_ents = mapped_ents;
+		entry->attrs          = attrs;
 
 		check_sg_segment(dev, s);
 
-		add_dma_entry(entry, attrs);
+		add_dma_entry(entry);
 	}
 }
 
@@ -1440,8 +1449,9 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
+	entry->attrs     = attrs;
 
-	add_dma_entry(entry, attrs);
+	add_dma_entry(entry);
 }
 
 void debug_dma_free_coherent(struct device *dev, size_t size,
@@ -1585,7 +1595,7 @@ void debug_dma_alloc_pages(struct device *dev, struct page *page,
 	entry->dev_addr  = dma_addr;
 	entry->direction = direction;
 
-	add_dma_entry(entry, 0);
+	add_dma_entry(entry);
 }
 
 void debug_dma_free_pages(struct device *dev, struct page *page,

-- 
2.53.0

