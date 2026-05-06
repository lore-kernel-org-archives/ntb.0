Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD74A2E01
	for <ntb@lists.linux.dev>; Wed,  6 May 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090813; cv=none; b=iw/BOo7kZSMRKvF42efAlPcXH6IIRHlPaf3fgJKuCIi5hDZteweauOK/BkqqYisqVb4/iOqemDlVQVgk23WA15PMZYSvqTLc3VVqyel6G4JbAeNDHdOLIupVbf4KiE9PWzhbp4NQIIFm9i99eUKu75tc3I4G41kcpCzdaH+owP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090813; c=relaxed/simple;
	bh=XMUkfGBqGHRl2Qmuvo2NWgJYpIC+bwtX8lQsG8v6MwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX7OASQ18Jsodqh3H+QXd1X73+4YaH36OljLJ6K5rz02/qpBeGNuoqknihShCbYvkDeDicXgz965rYaRi+2fTfQuZrt4Q9tymZ6hrmC4mQVq0oeF6TR7XL5/7D7MoV8W8NPMnb8/n+PPe47dnVT6xr/2eAZth/DMIYGLkI7Q1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niogFOoG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niogFOoG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso15165ad.0
        for <ntb@lists.linux.dev>; Wed, 06 May 2026 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778090810; x=1778695610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SCkx6Yh6YZ1BPi+tG3iQfCUha6CFKOYQ/X+Py4gHbo=;
        b=niogFOoGu7/06Mfb44FLhb4KF+IPL42ZIGo+6FWvguVFcSo7j1fKcVwCy98jCR/Bll
         o1mrphXB8r2CjmGiCiB5lbBE9ujgdcZKUq4paIZSpvi6rs8nVBcgDvbGj/XVkMV443bu
         4gcnJYY2q/uTJZskCrk7iFVS6DiopxKsWflmJwzkdkpPFSQhKT34lKRFxp9UDHv5CxSx
         POysC8TOAGehHUYTh5tARn2wxjOKce5vhBOG+6dW8xvlFL0lfsxq/GtnhKSkpc4Qq3PP
         YPsaSXgpkdW0xgew3n0ne6VX6o5/XUZXV66QStyVe1k/aocU8tmV1a2KCbp+39twt2ex
         +WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778090810; x=1778695610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SCkx6Yh6YZ1BPi+tG3iQfCUha6CFKOYQ/X+Py4gHbo=;
        b=Y29OQWYpt2nO2vbc0GxxGVU4dL7/P4JAmTlA83uEBBZ8zttXFtsf7BJ1P98YwfSPsi
         CYsm8OIJGT+85XeKR5eEEQncEvOGjmI6QZe6fm0wRjOUzShHTjRhyxMqVD3uzRFci8oH
         cOhQMIDi46I834b61LS/2lKV1NE/1txmg1Y508MryxOXP/s/ydhtgI87pxTH7IGZV8z5
         hVBe8++u6wF7q0RQ5OKe1khV9uWQqnEYZmOThnv7+X1fqyG9gajWPUlJwwghQavcSLA3
         g4zyAJWKBH4aFbIXgY1AOZXtD/DGRHxbDwolV/kzfzXTn9/ds34CaHpWV6pPUlvzXwBR
         6zuw==
X-Forwarded-Encrypted: i=1; AFNElJ/gAkgwKWNmwgPzrjlyQR4JnKR8G8Zc+TZSy4BPcV669knKZwPaiaLxhezPe2YSd3Mm/js=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcR3FL4KE1h6oxuVOb0BTRJHiArXr1e/bvo7hOnvUXvsF+Pyq7
	6m2+5NDmoAQJBDaVtu307IG+bnPXSYNwRfAwyERIaeGkzG5J+1rsActlJJxCn9QSpQ==
X-Gm-Gg: AeBDieuibPlrb+HysfLQPo4Do/pYhrVUPa4bSVMMV64wcy+7pA8+s0Rr+kegoXOgKAw
	8OQGRbrBhUPRQNvFdQDw4x1+IdyFq6VcFrhYNPj1+Xhh8y1eIO3yejerQyxLqzEBFNr3kX89TDK
	hkN/ELS191gEn9F2+bD96u01bc13yXaEvdh0AM2/yR8ByHaknTpVE5jKco7APPcKiRuj/emjfHs
	b5Js7JuxyeQbO3B0Yg+1U3XabP6GXWqhEW3REJwqBsp8uJIdpZSnHXgkmzavnc3C+n4Ws01Qpk8
	mno8930srdYuUl90q3ca84Q01BDN8xSRG/fFMGVDIF/1vdtGxtRX30hJdzMJcCL/SoLc0jXcf0M
	zmBxzWOkqRiZjrPv6Pl4VsHMWRg0KkXW/pbloq7jcyim2l4wFgRRnB5HuQSOmIABKRWhOUAq1S2
	BISXa4IJfjgUMtaq6+zbhWtPoMp5gN2ywgNyvyQsQEA7WK3B5dGFEROBfkvWe1YVwAI0r5La63s
	UsjowXT
X-Received: by 2002:a17:903:124b:b0:2b9:a39a:e5db with SMTP id d9443c01a7336-2bab63fdaeemr399045ad.7.1778090809148;
        Wed, 06 May 2026 11:06:49 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1af7sm32405505ad.46.2026.05.06.11.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:06:48 -0700 (PDT)
Date: Wed, 6 May 2026 18:06:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 5/6] dma-debug: Feed DMA attribute for unmapping flows
 too
Message-ID: <afuDLtR6Q1W2_VO5@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-5-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-5-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:09AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>There are multiple unmapping flows which didn't provide DMA attributes,
>which limited DMA debug code to compare the mapping and unmapping
>attributes. Let's fix it.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c   | 13 ++++++++-----
> kernel/dma/debug.h   | 19 +++++++++++--------
> kernel/dma/mapping.c |  8 ++++----
> 3 files changed, 23 insertions(+), 17 deletions(-)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index f07e6a1e9fbab..3dfed51c3d9aa 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1307,8 +1307,8 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> }
> EXPORT_SYMBOL(debug_dma_mapping_error);
>
>-void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
>-			  size_t size, int direction)
>+void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr, size_t size,
>+			  int direction, unsigned long attrs)
> {
> 	struct dma_debug_entry ref = {
> 		.type           = dma_debug_phy,
>@@ -1316,6 +1316,7 @@ void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
> 		.dev_addr       = dma_addr,
> 		.size           = size,
> 		.direction      = direction,
>+		.attrs          = attrs,
> 	};
>
> 	if (unlikely(dma_debug_disabled()))
>@@ -1381,7 +1382,7 @@ static int get_nr_mapped_entries(struct device *dev,
> }
>
> void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>-			int nelems, int dir)
>+			int nelems, int dir, unsigned long attrs)
> {
> 	struct scatterlist *s;
> 	int mapped_ents = 0, i;
>@@ -1399,6 +1400,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
> 			.size           = sg_dma_len(s),
> 			.direction      = dir,
> 			.sg_call_ents   = nelems,
>+			.attrs          = attrs,
> 		};
>
> 		if (mapped_ents && i >= mapped_ents)
>@@ -1454,8 +1456,8 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
> 	add_dma_entry(entry);
> }
>
>-void debug_dma_free_coherent(struct device *dev, size_t size,
>-			 void *virt, dma_addr_t dma_addr)
>+void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
>+			     dma_addr_t dma_addr, unsigned long attrs)
> {
> 	struct dma_debug_entry ref = {
> 		.type           = dma_debug_coherent,
>@@ -1463,6 +1465,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
> 		.dev_addr       = dma_addr,
> 		.size           = size,
> 		.direction      = DMA_BIDIRECTIONAL,
>+		.attrs          = attrs,
> 	};
>
> 	/* handle vmalloc and linear addresses */
>diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
>index 24b8610850fbd..13e384633c32a 100644
>--- a/kernel/dma/debug.h
>+++ b/kernel/dma/debug.h
>@@ -14,21 +14,22 @@ extern void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
> 			       unsigned long attrs);
>
> extern void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
>-				 size_t size, int direction);
>+				 size_t size, int direction,
>+				 unsigned long attrs);
>
> extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 			     int nents, int mapped_ents, int direction,
> 			     unsigned long attrs);
>
> extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>-			       int nelems, int dir);
>+			       int nelems, int dir, unsigned long attrs);
>
> extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
> 				     dma_addr_t dma_addr, void *virt,
> 				     unsigned long attrs);
>
>-extern void debug_dma_free_coherent(struct device *dev, size_t size,
>-				    void *virt, dma_addr_t addr);
>+extern void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
>+				    dma_addr_t addr, unsigned long attrs);
>
> extern void debug_dma_sync_single_for_cpu(struct device *dev,
> 					  dma_addr_t dma_handle, size_t size,
>@@ -59,7 +60,8 @@ static inline void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
> }
>
> static inline void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
>-					size_t size, int direction)
>+					size_t size, int direction,
>+					unsigned long attrs)
> {
> }
>
>@@ -70,8 +72,8 @@ static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> }
>
> static inline void debug_dma_unmap_sg(struct device *dev,
>-				      struct scatterlist *sglist,
>-				      int nelems, int dir)
>+				      struct scatterlist *sglist, int nelems,
>+				      int dir, unsigned long attrs)
> {
> }
>
>@@ -82,7 +84,8 @@ static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
> }
>
> static inline void debug_dma_free_coherent(struct device *dev, size_t size,
>-					   void *virt, dma_addr_t addr)
>+					   void *virt, dma_addr_t addr,
>+					   unsigned long attrs)
> {
> }
>
>diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>index 6cbefbd4158c8..f010b3cc0ece4 100644
>--- a/kernel/dma/mapping.c
>+++ b/kernel/dma/mapping.c
>@@ -225,7 +225,7 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
> 	else if (ops->unmap_phys)
> 		ops->unmap_phys(dev, addr, size, dir, attrs);
> 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
>-	debug_dma_unmap_phys(dev, addr, size, dir);
>+	debug_dma_unmap_phys(dev, addr, size, dir, attrs);
> }
> EXPORT_SYMBOL_GPL(dma_unmap_phys);
>
>@@ -351,7 +351,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>
> 	BUG_ON(!valid_dma_direction(dir));
> 	trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
>-	debug_dma_unmap_sg(dev, sg, nents, dir);
>+	debug_dma_unmap_sg(dev, sg, nents, dir, attrs);
> 	if (dma_map_direct(dev, ops) ||
> 	    arch_dma_unmap_sg_direct(dev, sg, nents))
> 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
>@@ -693,7 +693,7 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> 	if (!cpu_addr)
> 		return;
>
>-	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
>+	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle, attrs);
> 	if (dma_alloc_direct(dev, ops) || arch_dma_free_direct(dev, dma_handle))
> 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
> 	else if (use_dma_iommu(dev))
>@@ -840,7 +840,7 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
> 		struct sg_table *sgt, enum dma_data_direction dir)
> {
> 	trace_dma_free_sgt(dev, sgt, size, dir);
>-	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
>+	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
>
> 	if (use_dma_iommu(dev))
> 		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
