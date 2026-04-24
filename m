Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA671DF26E
	for <ntb@lists.linux.dev>; Fri, 24 Apr 2026 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044733; cv=none; b=g6x2MyCGe08fkOji1/JMPYTEOj8oCxDTLL6qxKnfYr2VVZffmQNJXBWtDmNhlFjuXvuI/QP0Klkb6OFMlSy6KTB7MCwLRMBgHDq41o2sQJGfmjiY6ryzkKygLZwAJJffPj3dN+zEd3NvkmBQQMaq2/8OMa6WAtuRWnOdOlzKk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044733; c=relaxed/simple;
	bh=64iLAXQ+F1u8jn8wqJpcCLIJXCPRsbJWkuiku7EpHU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPXu5fGRdkDxf8q8pEJVLCGcqv/EXFggfHp0xBjNFdcJf3JtTfnkUfIBMlD/q4VdRm9j/CWleX860H90bFGkb9wRhheO2cdF2a4kEP22781JyXmLzMTzqm656D0PNlaTdg6iN0nrRJMxst/ATT5MlpMr8TpDRPSOKrap4fOw2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFlvdWkz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFlvdWkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777044733; x=1808580733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64iLAXQ+F1u8jn8wqJpcCLIJXCPRsbJWkuiku7EpHU4=;
  b=jFlvdWkzN+CUZjflPb8kcX/UwoNeMKsDjyqJXd+ckMkSA87vsm5W2mGD
   ZIJ6n0sEBThEFGG5cC+HjzSb3VPn+3DhaS0RpuB/n5/oMSVXNp7C9vtH7
   kSUEToanr5HCRBzJ98gT8REWDpf0a9BC72BFQYwZnECC7aPWpDyLRCst0
   iGuV8lvGioPJRyn0wxgJJJDNTyopcykrZCCUVgJ7+8Rwpduel0Zn1/Uqo
   tedthjtw0gv71kfpNVCiekPrtfY8FKBH4nhl+dsb+ZP9TY2V6RShYYVCS
   Lfxq5R7XFF2mVAmE34Vaj41GEjP2pTaDMRrb1mb0uUMp1ZWmZmkxWXmGr
   g==;
X-CSE-ConnectionGUID: ngolsOuCQbOUxkQYRGlRxg==
X-CSE-MsgGUID: nI9QL4ltSOWrTtAj3GcNUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="89490159"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89490159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:32:12 -0700
X-CSE-ConnectionGUID: 2v9/hZs+RWyV5YvB9OlrXA==
X-CSE-MsgGUID: YiC+N661QZ+Geenzzjsx9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232885304"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.86]) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:32:12 -0700
Message-ID: <2834c77d-9077-4462-9e64-3460fe9d2ec0@intel.com>
Date: Fri, 24 Apr 2026 08:32:11 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ntb_transport: replace wmb() with dma_wmb() in TX
 paths
To: Xingbang Liu <liu.airalert@gmail.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260424092340.3792297-1-liu.airalert@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260424092340.3792297-1-liu.airalert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 2:23 AM, Xingbang Liu wrote:
> The TX paths currently use wmb() after memcpy_toio() to ensure that
> writes to the peer memory window are visible before subsequent
> notification.
> 
> The actual ordering requirement is to ensure that data written to the
> peer memory is observed before the associated notification or status
> update. This matches the semantics of dma_wmb(), which orders memory
> writes with respect to external observers.
> 
> The peer memory window is mapped with ioremap_wc(), allowing
> write-combining. On weakly ordered architectures such as arm64,
> dma_wmb() ensures that prior writes are committed from write-combining
> buffers and become visible to the peer before subsequent operations.
> 
> This aligns with common patterns in PCIe-based drivers, where it is
> used to order descriptor or payload writes before notification, while
> avoiding the stronger ordering semantics of wmb().
> 
> The ordering with respect to peer observation is completed by the
> subsequent notification mechanism.
> 
> No functional change is intended.
> 
> Signed-off-by: Xingbang Liu <liu.airalert@gmail.com>

NAK. dma_wmb() is used for shared memory between CPU and a device. For example:

memcpy(dma_buffer, data, size);
dma_wmb(); /* Ensure CPU writes visible to device DMA */
writel(DOORBELL, device->reg + DB_OFFSET); /* trigger device DMA from dma_buffer */

In this case we are copying data to MMIO and therefore wmb() is needed to ensure all MMIO writes have happened before we proceed.

DJ

> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 7cabc82305d6..c8ef46ddcc57 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1791,7 +1791,7 @@ static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *
>  #endif
>  
>  	/* Ensure that the data is fully copied out before setting the flags */
> -	wmb();
> +	dma_wmb();
>  
>  	ntb_tx_copy_callback(entry, NULL);
>  }

