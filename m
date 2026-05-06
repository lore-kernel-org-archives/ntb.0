Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C34BCAD4
	for <ntb@lists.linux.dev>; Wed,  6 May 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089662; cv=none; b=AO/ihcvkiJ6SJAtRY3P/fyxMnFNUOwxOmJeO1OY3Cu0ui7wT5kjnztRxwHI+Eh38QvNyn7AMEvFfMpjMLLQeL2uvozcFWIFwk5fMISXL3m+hvNR3vjo1D87/BYA/GCLzT12XZulZUvHcVFNpAKHMjLi0iF2qXXS8R1eh3gFrtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089662; c=relaxed/simple;
	bh=aik4UUSHAC8a5AGO/wN4zQeig4UP3Zc7cMBUEntTcWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhAyjRvQase+R4NpNbrFim4WgTzORx+Cx6J9oAiVODj6j7GxR7e12VBMPzHUd9XyX2eU6Zv8lDrMl2IcXf6D1lXOlM4+r/pXg1VUbgDikEGauOaLcggJPSTwsZ0QCZ7gf2w2MImdsougYr4zhDS1KMkYxPw7eykREtj7MmycHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUeFWr9F; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUeFWr9F"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so13295ad.0
        for <ntb@lists.linux.dev>; Wed, 06 May 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778089655; x=1778694455; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KybkGyEAPJd/UFSLc8blkH8y2mvfwlowve0vuV+Is5U=;
        b=FUeFWr9FHCL9sLkSVhEkTbsURO3hvxRH/EknC+IWQ3X5KU46mvq5yiG4Z1Yok3QOG0
         Tt3NY5VHNm8FgMROEQIKR8qGWJs6xsitSpbkFT9/1atR6iP1Caef+JAnhbWWIF+IICz/
         VnipTaRu/h6RdKO5Ag/ldGNIlXqwPWSb0KV9AG9y1dID2U72iQWLoruO/fNj9RhfgVja
         8Q+MremlOzLdQa0izV0QTMPucqqK+9uJTPghhcjCdh3Gb/KKqfInhvaJWP2HTLccLwmd
         jCAxq2UjUOi8oHFZB4ZMwiTeXAXfLxSmwURcbjnKu4ENmMnIEj+Ucy8twIBoLzzm/Owu
         gIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089655; x=1778694455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KybkGyEAPJd/UFSLc8blkH8y2mvfwlowve0vuV+Is5U=;
        b=XXrnsy7K58rSJa+VXaHLwafZyA+7haoa3GU0/jxKkBnr7Qi7hkqmX0PkOBZ1lJRzv4
         k6htX6cvBQWowRaWgq8VtTRWIIvbn5CvQwKsXFIFaKdIiHnixiodI8fKh5265iQgMwW/
         6n+8prrwoNeNt2u0XVWcu/9K2/mODIXOlqYp61/4WYvsErwhvedjL+xw+vzzfAAOJ//W
         ZCSxaSQ4KUnMkh6WNL1WeQyjNVnaUVlojk0SUs7dHbu9ubOZ46t7T956z2qRHKn33SCU
         RCvFEhA3ZhMo9dsufAqxtOmHTBG5sG7B8PbDzkAaQM+8yWTyndQLiM3W+R4CWTCNpgx9
         hCLA==
X-Forwarded-Encrypted: i=1; AFNElJ8jY5EGx8VelwVDKAAQLH2B//E5bcvGhsohVSAMHU/A6+r2jgGEEpO/FMusZQ99xkzdppM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7TE9pm4dP8k4A3J4YSjcPduFZ2Hx/A+dMEDdEHYSPtS+Z7QsG
	JSfzmi3x6TllaM8D3HhxfkXVAvCyqIVaD2Lete2wtl4LICNTtUWTspDXvCNZ4PUlBQ==
X-Gm-Gg: AeBDieu+Z90fYq+BNJnqGGQWH8r4Iq8GzKraxjDrX/w+TIVdcE8onWpxou2to1a7Ax8
	FfdfgmXs441bNa/o3iNwzq1L5OCGa/ijuKuRifH6OEHwQFSpPzU+nWFrJdCnscLImpit2MVcUaa
	inPURasX4wxaD27ywSA4PIaRjGABgWckmdMZvC+jg7s9zXY3J30+D05mHZgP6b6J2A7M4XgQLGt
	eJnFEP/x7zeEbNe6FV9kp0b1TttQ9jK+oK5tQmRgVh6PoX7JBv36ySoXwv2IUE+eYn8oWEl4Y38
	v3/ECClftwgdhouYCQtq4xKe3dluKO+qnVY0vSSbsvBphzImxUYD58wqy1WCrDlI74VI42Rml9O
	6cJ7HKCf3JLGgKeh+WqfsNaDsGmE4179zj9xdbgihCRfIvuWy/x0dREi6adkE8N5K+iNL7A+oiJ
	Bj0KnzyfBmUfvBJLLJRCJE+JruHNToojYsVb/XkM9hXaz4ny1sq4MiQSV22QNION4g06T+UjW2e
	IbSfNyy
X-Received: by 2002:a17:903:1a24:b0:2b4:6153:e541 with SMTP id d9443c01a7336-2ba7cc54db5mr4362405ad.3.1778089655109;
        Wed, 06 May 2026 10:47:35 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365c25f8cf9sm3409281a91.4.2026.05.06.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:47:34 -0700 (PDT)
Date: Wed, 6 May 2026 17:47:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 3/6] dma-debug: Remove unused DMA attribute parameter
Message-ID: <aft-oG90nnHkjzDb@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-3-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-3-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:07AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>debug_dma_alloc_pages() always receives a DMA attribute value of 0,
>because dma_alloc_pages() never receives any attributes from its callers.
>As preparation for upcoming patches, remove this unused attribute from
>the debug routine.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c   | 5 ++---
> kernel/dma/debug.h   | 6 ++----
> kernel/dma/mapping.c | 2 +-
> 3 files changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index 1a725edbbbf6a..3b53495337f5c 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1567,8 +1567,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>
> void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 			   size_t size, int direction,
>-			   dma_addr_t dma_addr,
>-			   unsigned long attrs)
>+			   dma_addr_t dma_addr)
> {
> 	struct dma_debug_entry *entry;
>
>@@ -1586,7 +1585,7 @@ void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 	entry->dev_addr  = dma_addr;
> 	entry->direction = direction;
>
>-	add_dma_entry(entry, attrs);
>+	add_dma_entry(entry, 0);
> }
>
> void debug_dma_free_pages(struct device *dev, struct page *page,
>diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
>index da7be0bddcf67..24b8610850fbd 100644
>--- a/kernel/dma/debug.h
>+++ b/kernel/dma/debug.h
>@@ -47,8 +47,7 @@ extern void debug_dma_sync_sg_for_device(struct device *dev,
> 					 int nelems, int direction);
> extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 				  size_t size, int direction,
>-				  dma_addr_t dma_addr,
>-				  unsigned long attrs);
>+				  dma_addr_t dma_addr);
> extern void debug_dma_free_pages(struct device *dev, struct page *page,
> 				 size_t size, int direction,
> 				 dma_addr_t dma_addr);
>@@ -113,8 +112,7 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
>
> static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 					 size_t size, int direction,
>-					 dma_addr_t dma_addr,
>-					 unsigned long attrs)
>+					 dma_addr_t dma_addr)
> {
> }
>
>diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>index 23ed8eb9233e5..6cbefbd4158c8 100644
>--- a/kernel/dma/mapping.c
>+++ b/kernel/dma/mapping.c
>@@ -733,7 +733,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
> 	if (page) {
> 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
> 				      size, dir, gfp, 0);
>-		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
>+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle);
> 	} else {
> 		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
> 	}
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
