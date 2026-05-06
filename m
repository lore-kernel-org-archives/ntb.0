Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4A4C6EF2
	for <ntb@lists.linux.dev>; Wed,  6 May 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090030; cv=none; b=KGuwQ/5vfr/JDqWgasOOsVZgak/kZV6n3eSAl7cwef3Uh8sjdQMbi1AS/Amn8yPhUwZqWNXc4DMSVtJqAQ7Rn4ByZElp2vDpdxFhRfleQKysUGpRh8CQyl2re2WvhxX20r6Y/v10jgy687IVVjMUWgtxRXZQESadA4jLMMUyLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090030; c=relaxed/simple;
	bh=wnFqSmEXKzsnB/u/mjRfMXJEvr7Ke3sxm8mmWQCr8qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ/ghPMMwkDIG5V2VK0YsMzsaw7wvORnHy9eoNAk+VWzLgJpS9TQ8rLdIqu8L3pnkIb6HeWkPlbABaDAXuIloQNbFr/MIjhSND+ZIFAVOFHUzJRIx/Fd3YabFqkUXZBRrW07IMxNjckipb9xqcbspR7MAJfkOhAiC81koXz0x+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8Kex2qs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8Kex2qs"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso121695ad.1
        for <ntb@lists.linux.dev>; Wed, 06 May 2026 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778090021; x=1778694821; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hNJkjM7lsYWdxDnxF/NStv4UkFAgxjJPdYoLTpx42s=;
        b=k8Kex2qsqaX0WXlKPfsiuevuMCP8GC/yLg3CeJCH4lc9lgPNlKILxyOSyLmMrsl/zy
         KH2P96s/L3+Z0Hrf2jf/GnzIN+OZBd8UIq57Q63cXBK4QD7JUHQdc0V+Yl9APpZcd5ae
         6hNrEaY35eEfhfioHmW7orLeXAZiRpc58BqG5+CF75aK32UGFnnhVxNol11s1btyjGRb
         aMuPkbdMNViFUX0W6e5IZduRyMOOle0hVFhOJixGEbmDuApSPh7eQxFleVli+e3EGse5
         j/Nk7g6PmL2XeLKEqbUOIigAsH4QkQJHinpHBelrAymcuBtMITyGcxb0169753OIDtSw
         33/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778090021; x=1778694821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hNJkjM7lsYWdxDnxF/NStv4UkFAgxjJPdYoLTpx42s=;
        b=kYE0TzGzkKKwY5FkM98z0YZwaA39t4eZsDGMl9q3tvg+b/5x/ahAXtm3mYrb2UYDBa
         9xFu1th5hR7LVAzfVSw19+CMMw8/cVi9JkWlYd2T3Y0S2Ex7vnVIcyDr3OX/Vy9sadj+
         55AqVOv6V9qTSvTWeLfqCo9rS9br3O/hjOUq0BYTWlds4+f3qq0pIiqvTZm9RCjIJF9o
         O74nlnuaV83UhFPhUqknd0x0QgswlAnet4IbHkVhXI9PCwBoHwBzX/A8gxX2VFf4gPxb
         mtTmOhjiOoXHqIRslOg7VZh1tGS7z2VAeMi+Ak/v1WoeL1cwEKwpN06hatXy3LQeH7Sj
         Qwlg==
X-Forwarded-Encrypted: i=1; AFNElJ+0E/3Psq5aBmGWXwJsjM0dWogSOq6Td/HGyFLOtfODpDzQpYSL0QZ1rrcQQqUH36PIUVs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7kOic+QbTdvVgNtL8Pk4tlT+lNWD7mv26FykPYDnQd721KcJ+
	zS88+WfMhzPf7ewviwgDNWDUl1Ae/otSXpiJNCrY7Alww4+giWpQ/cI2A9qlq29ueA==
X-Gm-Gg: AeBDieu06k/lHgo9wGfBouYOEq93ew+1gUoXYWynRnTWWsWVQo0y2LAdic7eyH4XJ/k
	4e/e49BdLusfCYT83UT04FzXRpLMXGezcVwifPQBWHLhRzlLB5FBH2Ozod+LEMD6BPr3JLnwX2o
	V+zwQ1+Ew/b/y1TFul2m9N1sDH9yArYd1PAmJ72NLZXClFAIwUlKUyoNoecd1Hofict2hsBFYEw
	YaUbp1SlJm6Y66+FFki+BdE+poqWpBmHxLsK4iziFKDDp4gugvUQiyYDgxQzoikk66An7OeFKDl
	cJjaSj9IIGiLnepcQYZVkQ7XUqUO+FuPYLtZ3g0bKinrknqTXx21OM9kq+PMAQXPz4Y9rIQySAz
	MIv7DUifZFcslH2pepKokZoDzfx3b6anTaB2+cse3ZUaJvuZdPlEH8qv19p99wRfbWgB3FTLWov
	zQmrKSNmo3Cw9/XVbT1JqE+60aXBobnFuhLykG+oiyGPGmJa7m7vYfazr2HY4fDqnTBoVHqYawT
	Cr78k+d
X-Received: by 2002:a17:903:4b03:b0:2b0:b458:2dc3 with SMTP id d9443c01a7336-2ba7cf2a362mr3560235ad.21.1778090020281;
        Wed, 06 May 2026 10:53:40 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm6346338b3a.53.2026.05.06.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:53:39 -0700 (PDT)
Date: Wed, 6 May 2026 17:53:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 4/6] dma-debug: Record DMA attributes in debug entry
Message-ID: <aft-2O03KaqqOXF4@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-4-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-4-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:08AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>To enable reliable comparison of DMA attributes between map and
>unmap operations, store the attribute value in dma_debug_entry.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c | 48 +++++++++++++++++++++++++++++-------------------
> 1 file changed, 29 insertions(+), 19 deletions(-)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index 3b53495337f5c..f07e6a1e9fbab 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -63,7 +63,7 @@ enum map_err_types {
>  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
>  * @paddr: physical start address of the mapping
>  * @map_err_type: track whether dma_mapping_error() was checked
>- * @is_cache_clean: driver promises not to write to buffer while mapped
>+ * @attrs: dma attributes
>  * @stack_len: number of backtrace entries in @stack_entries
>  * @stack_entries: stack of backtrace history
>  */
>@@ -78,7 +78,7 @@ struct dma_debug_entry {
> 	int		 sg_mapped_ents;
> 	phys_addr_t	 paddr;
> 	enum map_err_types map_err_type;
>-	bool		 is_cache_clean;
>+	unsigned long	 attrs;
> #ifdef CONFIG_STACKTRACE
> 	unsigned int	stack_len;
> 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
>@@ -478,6 +478,9 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
> 				   bool *overlap_cache_clean)
> {
> 	phys_addr_t cln = to_cacheline_number(entry);
>+	bool is_cache_clean = entry->attrs &
>+			      (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
>+			       DMA_ATTR_REQUIRE_COHERENT);
> 	unsigned long flags;
> 	int rc;
>
>@@ -495,12 +498,15 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
> 	if (rc == -EEXIST) {
> 		struct dma_debug_entry *existing;
>
>-		active_cacheline_inc_overlap(cln, entry->is_cache_clean);
>+		active_cacheline_inc_overlap(cln, is_cache_clean);
> 		existing = radix_tree_lookup(&dma_active_cacheline, cln);
> 		/* A lookup failure here after we got -EEXIST is unexpected. */
> 		WARN_ON(!existing);
> 		if (existing)
>-			*overlap_cache_clean = existing->is_cache_clean;
>+			*overlap_cache_clean =
>+				existing->attrs &
>+				(DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
>+				 DMA_ATTR_REQUIRE_COHERENT);
> 	}
> 	spin_unlock_irqrestore(&radix_lock, flags);
>
>@@ -544,12 +550,13 @@ void debug_dma_dump_mappings(struct device *dev)
> 			if (!dev || dev == entry->dev) {
> 				cln = to_cacheline_number(entry);
> 				dev_info(entry->dev,
>-					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
>+					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s attrs=0x%lx\n",
> 					 type2name[entry->type], idx,
> 					 &entry->paddr, entry->dev_addr,
> 					 entry->size, &cln,
> 					 dir2name[entry->direction],
>-					 maperr2str[entry->map_err_type]);
>+					 maperr2str[entry->map_err_type],
>+					 entry->attrs);
> 			}
> 		}
> 		spin_unlock_irqrestore(&bucket->lock, flags);
>@@ -575,14 +582,15 @@ static int dump_show(struct seq_file *seq, void *v)
> 		list_for_each_entry(entry, &bucket->list, list) {
> 			cln = to_cacheline_number(entry);
> 			seq_printf(seq,
>-				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
>+				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s attrs=0x%lx\n",
> 				   dev_driver_string(entry->dev),
> 				   dev_name(entry->dev),
> 				   type2name[entry->type], idx,
> 				   &entry->paddr, entry->dev_addr,
> 				   entry->size, &cln,
> 				   dir2name[entry->direction],
>-				   maperr2str[entry->map_err_type]);
>+				   maperr2str[entry->map_err_type],
>+				   entry->attrs);
> 		}
> 		spin_unlock_irqrestore(&bucket->lock, flags);
> 	}
>@@ -594,16 +602,14 @@ DEFINE_SHOW_ATTRIBUTE(dump);
>  * Wrapper function for adding an entry to the hash.
>  * This function takes care of locking itself.
>  */
>-static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>+static void add_dma_entry(struct dma_debug_entry *entry)
> {
>+	unsigned long attrs = entry->attrs;
> 	bool overlap_cache_clean;
> 	struct hash_bucket *bucket;
> 	unsigned long flags;
> 	int rc;
>
>-	entry->is_cache_clean = attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
>-					 DMA_ATTR_REQUIRE_COHERENT);
>-
> 	bucket = get_hash_bucket(entry, &flags);
> 	hash_bucket_add(bucket, entry);
> 	put_hash_bucket(bucket, flags);
>@@ -612,9 +618,10 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
> 	if (rc == -ENOMEM) {
> 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
> 		global_disable = true;
>-	} else if (rc == -EEXIST &&
>-		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>-		   !(entry->is_cache_clean && overlap_cache_clean) &&
>+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>+		   !(attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
>+			      DMA_ATTR_REQUIRE_COHERENT) &&
>+		     overlap_cache_clean) &&
> 		   dma_get_cache_alignment() >= L1_CACHE_BYTES &&
> 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> 		     is_swiotlb_active(entry->dev))) {
>@@ -1250,6 +1257,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> 	entry->size      = size;
> 	entry->direction = direction;
> 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
>+	entry->attrs     = attrs;
>
> 	if (!(attrs & DMA_ATTR_MMIO)) {
> 		check_for_stack(dev, phys);
>@@ -1258,7 +1266,7 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> 			check_for_illegal_area(dev, phys_to_virt(phys), size);
> 	}
>
>-	add_dma_entry(entry, attrs);
>+	add_dma_entry(entry);
> }
>
> void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>@@ -1345,10 +1353,11 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 		entry->direction      = direction;
> 		entry->sg_call_ents   = nents;
> 		entry->sg_mapped_ents = mapped_ents;
>+		entry->attrs          = attrs;
>
> 		check_sg_segment(dev, s);
>
>-		add_dma_entry(entry, attrs);
>+		add_dma_entry(entry);
> 	}
> }
>
>@@ -1440,8 +1449,9 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,

Unrelated to this patch/series, but I am wondering whether we should
rename this function to debug_dma_alloc_attrs() as it is called from
dma_alloc_attrs().
> 	entry->size      = size;
> 	entry->dev_addr  = dma_addr;
> 	entry->direction = DMA_BIDIRECTIONAL;
>+	entry->attrs     = attrs;
>
>-	add_dma_entry(entry, attrs);
>+	add_dma_entry(entry);
> }
>
> void debug_dma_free_coherent(struct device *dev, size_t size,
>@@ -1585,7 +1595,7 @@ void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 	entry->dev_addr  = dma_addr;
> 	entry->direction = direction;
>
>-	add_dma_entry(entry, 0);
>+	add_dma_entry(entry);
> }
>
> void debug_dma_free_pages(struct device *dev, struct page *page,
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
