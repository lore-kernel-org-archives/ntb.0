Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5C3DA7DB;
	Fri,  1 May 2026 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654842; cv=none; b=GCEAjdy1rkRQsVDFSSZJWmapCCYyhOaBVRo0HYbOEFmjGQM8x9LW5RKY3s4oTgj1ksdPhuezsO/z8NPN+oiqDSrGC6InBULse845FFiJwjL0hQ+OYRO/L/xi6oBNYo0hYVr/CGJDxLTIj0cVCqdSVq9gFGoHTPAn7erNjr6KFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654842; c=relaxed/simple;
	bh=MMHiPEfA3OPcjaDzqcD1mgeXkac1NUhCuQyTITSnWnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eq4ewYALvLynULse3BD3V3Zc5enavhcQ9Ycz6jkBEyGg/CYLOmsM+USWLqQqFk+EP0PfmTtkh5wqYiHN+aBlPcL3Zs5gB7ScnKFPHXOLFHbZ4slgTCW504rFwBZasQRRmeP1gnS7eZAg/1Uo5DO6k4qLSGhNQRwZ/YzrvRfJnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZPkcmJ5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZPkcmJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777654838; x=1809190838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MMHiPEfA3OPcjaDzqcD1mgeXkac1NUhCuQyTITSnWnU=;
  b=RZPkcmJ5S1FRa1mlZMk/z1G90biE1BMkEb7u10G+ZzvpMIG0OLre8tqZ
   wNNsypN439Du/J+OwolYhRpFIpZS0Bd1WqSf/g/OL4yriK1U2D/oKq0fb
   Bzj95XXlln+9Hfr2XeQngvXz3oS1wKX2wpqOp/q2eTXlI2Q4Fw28kicQD
   96hHgh62hZ4N8QrgNuMjB4syY2EdNCU77d15uHbMxNXRizQ0v4V3FCsNR
   1EGsWbv6uAZgAFlRY6L5m/cz1Q6oMqtgojOkcPzWeCwxVgDS2LGveFrsw
   n0ueJYLi1LzV0A4Y0l0dcbqJyrUAy/gZwW+Hx8gOHiKKf66usHOD1gDzY
   g==;
X-CSE-ConnectionGUID: n+5AUNyNQ/avDR7yRf+pjw==
X-CSE-MsgGUID: A/QXMTypSySWXy/EHHMKBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="81186470"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="81186470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 10:00:29 -0700
X-CSE-ConnectionGUID: KsjoK2uUTASap7x3n6yknw==
X-CSE-MsgGUID: ECdjj8MUQNW2v1RUXRgJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="239233535"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.150]) ([10.125.109.150])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 10:00:28 -0700
Message-ID: <4dcc8e09-3e8c-4d94-b5b2-a025ae375b08@intel.com>
Date: Fri, 1 May 2026 10:00:28 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ntb: Use consistent DMA attributes when freeing
 DMA mappings
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-2-8dbac75cd501@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260501-dma-attrs-debug-v2-2-8dbac75cd501@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/26 11:35 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The counterpart of dma_alloc_attrs() is dma_free_attrs(), which must
> receive the same DMA attributes used during allocation. The code
> previously used dma_free_coherent(), which does not accept or apply any
> DMA attributes.
> 
> Fixes: 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/ntb/ntb_transport.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 771eb7d9f4356..f59f926d4bfaa 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -766,8 +766,8 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  		return;
>  
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> -	dma_free_coherent(dma_dev, mw->alloc_size,
> -			  mw->alloc_addr, mw->original_dma_addr);
> +	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
> +		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
>  	mw->xlat_size = 0;
>  	mw->buff_size = 0;
>  	mw->alloc_size = 0;
> @@ -828,8 +828,8 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
>  	return 0;
>  
>  err:
> -	dma_free_coherent(ntb_dev, mw->alloc_size, alloc_addr, dma_addr);
> -
> +	dma_free_attrs(ntb_dev, mw->alloc_size, alloc_addr, dma_addr,
> +		       DMA_ATTR_FORCE_CONTIGUOUS);
>  	return rc;
>  }
>  
> 

