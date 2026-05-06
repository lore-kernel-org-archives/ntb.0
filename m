Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9A4C0406
	for <ntb@lists.linux.dev>; Wed,  6 May 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091400; cv=none; b=almb53H9OAo2IoaQQycf0gzyUae3p8MDKMWfnx1h7WXjpjGj1R02qI/J0ZhJdbko5SCN4dzMNiw9Wzzuwx6yLsRF7Gjl65747S9hdmisWNvfW3R5z6hb9e3twMs/0H2qwiGO+SeADzChumVCgjsh5hFD2+abJ4HDwmLHK45Z4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091400; c=relaxed/simple;
	bh=S9mvrWt8MHwjrniC+5hfqEcZPJwFH1boXGZmNPTls+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRdiT4KskenYlVB9plFNnvIpspMdUMfn1F6zE3KWQRYrRoqArCn1dWKNiMeluLoxGv/hgKJQy/HEcgr094ZQQB80wX27jDFv/DktJFivWGstp/Cmiy8aevGepIb7AU4zS10M2TdsHVIT4+jN2MgjylEQLeRNjFGllif8V2Cxukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5668+1i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5668+1i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so17655ad.0
        for <ntb@lists.linux.dev>; Wed, 06 May 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778091391; x=1778696191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7Y9JqHzZKULv50XrRzWAnOBKFiT4J2l9mPMNIlCT3Y=;
        b=T5668+1irnqfVlnAadlu/zg+zXkWSFN2jGfoaRfWAwSKAWVImzBpVtuOoujQYKg1nD
         h5OK6cpd3YTSLnwqsNcbHfhhxjag8a94puCbL1xt/x73ZpRBVm+iuefKqLG4N0Uomd6n
         ZtbFaQm31gRwTrhYOox6314NX+u6ViTAZCfZJBlli1sIeA3Ru1PmqzwSmbfvRtofFXn4
         5l3fxkSVXDBvi9oVxDK1yFtL+1fIHWpRnflnl0Lzj1vmv1+v5AXCIbnpx/Aa8R9UShst
         4gyawgCKMxhoRgCVb/sSGSUdUTQKihcVzV233HsKYyNFGR/j4BV5sEFjgJIO2GjYGYvB
         vs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091391; x=1778696191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7Y9JqHzZKULv50XrRzWAnOBKFiT4J2l9mPMNIlCT3Y=;
        b=pNasUZIuz4ulStLi/1rDLlvI0fjanjbdWmL+9TneVk9s33mKyBOJc3DsI3rwZ94SGK
         J7HzQexFd3iQVl26ynnbxktTK6j2U23HJ/A24xELvovv+2LTXUQiRwjbpg/nAzRZPcF0
         H8puPzxkTsWGaYvFuInZKh+lQPcBb8wBix4hVWpr1KvWn+/hagWHRCw4xLou5RhpH2AU
         lCKueaXoTsl210M8DU3M/cZpIdvWwTY4w4/bXbqlLthvUk5JyyqV90XjKHufzmCL1/GV
         veFIXtZBpHCKQgtt6yBJLtEoSlDM4y9XF0zEH1Bz+bSIdEYNN81p4SUqHTgQ0jeY7AlG
         tC6A==
X-Forwarded-Encrypted: i=1; AFNElJ9Aw+jyGRnjXTEaZ45hBC6+T/1VJcKWzfko0a46shFc+K9ZHh8FDp7NWx4y9VnQ2s31g00=@lists.linux.dev
X-Gm-Message-State: AOJu0YxyFjdAYBrMi+dJHC2V+B1llJZtWvVYOvhgcCrEunocO9GesHEl
	fPANgH/7uvB7s5W2spQ0dxY2/M9FHYYEzDW/oQPksPKFafigXXwpE6UmSt0VoDjR5A==
X-Gm-Gg: AeBDieuACiKAqqgZYi5arc8J1IOcvJK3V4XjFZAGk/09VhHJ12i2ZbDCF1r5cSXdc+O
	/34A1j92euHpBFBCF0V+dH88A4+zH4dUiEvCqI4WgTrHCN/grEj/1zUrAxEzoM+DCP3I8zEgMYw
	UQY3T/7V1K4NPZCypR2riTh1TAlED5WVdst46g/kj0qFoGgasZuUyXOe+EMDyK9SjEIsA/CHpR2
	LHigYdU8IT+QeZSNQ1i+wvEk+tkSEjT6cTFO7rOeOOiCOU8ndMFS/PRHlHNRr7OtCTZHoniUDp4
	t8bGt0FofMbQQfEh7qiJ7MtiWDeu6ZWjmYK5alG9LYwNSP7cEr9AmYNQrseHYOAUVD6V3nRSt0W
	08I6aJ+U99FJDmzN4MIq+oEXq4iEmp4weyTDYiEMV3nhixJDegScL9KUpmRtC+32kkSpddnss9+
	P9iHi+lubyWXfCCR7kcbCiXYyuFX6Ds/5/nig/HqvxqnmIz21X4JFI78Y4DsxUXTAakq2jEO3TH
	pLolQO4
X-Received: by 2002:a17:903:3887:b0:2b7:b03d:9847 with SMTP id d9443c01a7336-2ba7cecf689mr4399065ad.7.1778091390466;
        Wed, 06 May 2026 11:16:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c196ecsm3120637a91.6.2026.05.06.11.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:16:30 -0700 (PDT)
Date: Wed, 6 May 2026 18:16:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 6/6] dma-debug: Ensure mappings are created and
 released with matching attributes
Message-ID: <afuFcwO8hHqWZWuc@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-6-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-6-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:10AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>The DMA API expects that callers use the same attributes when mapping
>and unmapping. Add tracking to verify this and catch mismatches.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index 3dfed51c3d9aa..c38efc1ac8d6c 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1074,6 +1074,29 @@ static void check_unmap(struct dma_debug_entry *ref)
> 			   type2name[entry->type]);
> 	}
>
>+	/*
>+	 * This may be no bug in reality - but DMA API still expects
>+	 * that entry is unmapped with same attributes as it was mapped.
>+	 *
>+	 * DMA_ATTR_UNMAP_VALID lists the attributes that must be identical
>+	 * between map and unmap. Any attribute outside this set (e.g.
>+	 * DMA_ATTR_NO_WARN, DMA_ATTR_SKIP_CPU_SYNC) is allowed to differ.
>+	 */
>+#define DMA_ATTR_UNMAP_VALID                                               \
>+	(DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_FORCE_CONTIGUOUS |          \
>+	 DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT | DMA_ATTR_PRIVILEGED | \
>+	 DMA_ATTR_CC_SHARED)
>+	if ((ref->attrs & DMA_ATTR_UNMAP_VALID) !=
>+	    (entry->attrs & DMA_ATTR_UNMAP_VALID)) {
>+		err_printk(ref->dev, entry,
>+			   "device driver frees "
>+			   "DMA memory with different attributes "
>+			   "[device address=0x%016llx] [size=%llu bytes] "
>+			   "[mapped with 0x%lx] [unmapped with 0x%lx]\n",
>+			   ref->dev_addr, ref->size, entry->attrs, ref->attrs);
>+	}
>+#undef DMA_ATTR_UNMAP_VALID
>+
> 	hash_bucket_del(entry);
> 	put_hash_bucket(bucket, flags);
>
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
