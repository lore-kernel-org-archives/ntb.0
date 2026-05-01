Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3392C21E8;
	Fri,  1 May 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654817; cv=none; b=iapeebo9bJW74B3M7QgjMaEWBIfO3/EzzASVNUlq5HH+PsDc5o7UYHiaBbdz9ACZPfZUCls1tCiHyBZhX+fsYFykoyq/vv+MDCpuw07xtfUHp6U3za2KAglRg0CFrmC0U2KyP4CMDETJIQWrkpLh9MvVDoqI1eTaF64sOqxbZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654817; c=relaxed/simple;
	bh=OZpWVWgUv13wUUslHjkIt8bXofzxYiuFHlvNYiVxw0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGnBp9zdJbG1DY6wBV1U1QZnINEUi24uYT6tEJ0BrFXnm+YfwaS3LYe0uijX1k+43Xt4DvezVr5t0EsWAh2ocVRqHYnLu/5rENbkpYXy0Cxnaw2FjFRGi1MKSUFcLbdQRdm+LW0syzEm6n9RoU0DtZf6qJQJeqotpp77fm1n+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbGxJjDh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbGxJjDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777654813; x=1809190813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OZpWVWgUv13wUUslHjkIt8bXofzxYiuFHlvNYiVxw0s=;
  b=YbGxJjDha775rCsqyxe8SzkgsWwy7kXihRW/pVrtyHHaF4FUku40Ehju
   FQZtozfwvVfAEmj9lClwtiXezdK5a5cLQ+4hFV3fSmMqm3g9dQ7L4asvC
   s7AijFoNoPBDa6aVzFOmpKugvbCkqrC+BO5tB14utX3tGO9dL9PSnbQNw
   dmJTNBMWkeCA3HFoGGP3+/0uYIBRQi86wtVUF1omSkuz5lYzMpN/xo1VX
   1KiCjZJfBrB8sPyppq1l+5yNfym8YfyddP2FbWtAEppo+i1tHZ55jiKWm
   yGiCmfkGWKPM2oHvHEYCMzaDUHMLjz1gq+nXtqKGUDpEvq1t6ybGhVLQA
   g==;
X-CSE-ConnectionGUID: 5X0mDrlOQxmXUhnHmdElPA==
X-CSE-MsgGUID: NN5HY25uQBCjmbxBRPMjEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="81186431"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="81186431"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 10:00:12 -0700
X-CSE-ConnectionGUID: 7A3HsXT2Tfev2XZbzbd0hQ==
X-CSE-MsgGUID: +M+JkCD0SYmxKwG7ZXVOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="239233439"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.150]) ([10.125.109.150])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 10:00:11 -0700
Message-ID: <8f751a3e-0fd8-4a61-8955-027213a7bd1e@intel.com>
Date: Fri, 1 May 2026 10:00:10 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ntb: Store original DMA address for future release
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-1-8dbac75cd501@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260501-dma-attrs-debug-v2-1-8dbac75cd501@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/26 11:35 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The DMA API requires that dma_free_attrs receive the exact dma_handle
> originally returned by the allocation function. Do not modify it.
> 
> Fixes: fc5d1829f9bf ("NTB: transport: Try harder to alloc an aligned MW buffer")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 7cabc82305d6b..771eb7d9f4356 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -223,6 +223,7 @@ struct ntb_transport_mw {
>  	void *alloc_addr;
>  	void *virt_addr;
>  	dma_addr_t dma_addr;
> +	dma_addr_t original_dma_addr;
>  };
>  
>  struct ntb_transport_client_dev {
> @@ -766,7 +767,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
>  	dma_free_coherent(dma_dev, mw->alloc_size,
> -			  mw->alloc_addr, mw->dma_addr);
> +			  mw->alloc_addr, mw->original_dma_addr);
>  	mw->xlat_size = 0;
>  	mw->buff_size = 0;
>  	mw->alloc_size = 0;
> @@ -802,6 +803,7 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
>  		return -ENOMEM;
>  	}
>  	virt_addr = alloc_addr;
> +	mw->original_dma_addr = dma_addr;
>  
>  	/*
>  	 * we must ensure that the memory address allocated is BAR size
> 

