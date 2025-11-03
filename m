Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19823314B
	for <ntb@lists.linux.dev>; Mon,  3 Nov 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191915; cv=none; b=uxEAqaouYTanP+PEw0bT36QhVwWBzVTa+BaC23rbCJjWPlbxju4kckgHwAgI4n4ElxV0ZFRWxsffIMQD8EMZib7mjY9IEtBcYhajnVmpzTdJGzVo699k7THk4UjNkv5k+xwHV2CWVCIWhUyG1RFFv5VKxNSpiNDa8mVLM3jWr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191915; c=relaxed/simple;
	bh=C5IB+OJBYWDRiLwvBHd2v+8LHYgGF9Jtih3KiVfK8tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKDWWcKoEP/2/x79mlPtw0mOmb97jxBGiUaowPV6u5YECwyq52wC04GB2/dyRn4Cr+0Gt+MK7b4YzkB2PGqX/KHiUM7Do+Ba4xg88nvE39cgWwU9lIZKngUokdnI3Yali6rEvYShv/4EwTHOZVZ0AzlzxeTZxiPgQIlial/sXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4KUadW7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4KUadW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762191914; x=1793727914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C5IB+OJBYWDRiLwvBHd2v+8LHYgGF9Jtih3KiVfK8tc=;
  b=Y4KUadW7cz4ow0iW4p9AF6IaSRoFncSZyRNyS1ejtwZTgqDxRnMSmTVj
   6Is2bvHGU/ZRDMOcUBz80hyOebWW0PX22QGuLBDXAcDBXqDOGHytIKrLn
   zW9WJFCIn59yQK5OWEDteoDqoVUFmqXS3K43AMbpfoOA6aYKsileHa0pg
   tROMJ5YtP0Ee7qicwTJtMc7dC5L78d27+EPe63rVc9WFfIUVkkOhtj6tm
   vKvm07lmwTmXrl5ijfZ3CPvB7+t3y06UooMhHok3eCxUoeFeNhzwvk7mu
   qWCWVXMvG5AzZDHOMDLop3F+/YibwLBXUlxhyROqtADAUbJexdL94kLs8
   w==;
X-CSE-ConnectionGUID: DZT33sh6QVO+H0b8L79haQ==
X-CSE-MsgGUID: N8PCIGHwS4OoKbUdCvgJhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63970625"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="63970625"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 09:45:13 -0800
X-CSE-ConnectionGUID: I1jbixl9Q/6EtMIeiwNwBw==
X-CSE-MsgGUID: NcLk+twVS6mmTh1B5XnYzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186602698"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 09:45:12 -0800
Message-ID: <92ff3abf-fd15-44f1-ac18-7a6ea049197d@intel.com>
Date: Mon, 3 Nov 2025 10:45:10 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NTB: ntb_transport: fix use after free
To: Baruch Siach <baruch@tkos.co.il>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev
References: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 10:23 AM, Baruch Siach wrote:
> Don't call dmaengine_unmap_put() twice for the same pointer. This
> results in mempool_free() being called on a freed element.
> 
> Fixes: 6f57fd0578df ("NTB: convert to dmaengine_unmap_data")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/ntb/ntb_transport.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index eb875e3db2e3..809fb09658b4 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1573,14 +1573,14 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
>  				      pay_off, len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->to_cnt = 1;
>  
>  	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
>  				      buff_off, len, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[1]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->from_cnt = 1;
>  
> @@ -1588,7 +1588,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  					     unmap->addr[0], len,
>  					     DMA_PREP_INTERRUPT);
>  	if (!txd)
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	txd->callback_result = ntb_rx_copy_callback;
>  	txd->callback_param = entry;
> @@ -1596,7 +1596,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	cookie = dmaengine_submit(txd);
>  	if (dma_submit_error(cookie))
> -		goto err_set_unmap;
> +		goto err_unmap;
>  
>  	dmaengine_unmap_put(unmap);
>  
> @@ -1606,9 +1606,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	return 0;
>  
> -err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> -err_get_unmap:
> +err_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
>  	return -ENXIO;
> @@ -1854,14 +1852,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
>  				      buff_off, len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->to_cnt = 1;
>  
>  	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
>  					     DMA_PREP_INTERRUPT);
>  	if (!txd)
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	txd->callback_result = ntb_tx_copy_callback;
>  	txd->callback_param = entry;
> @@ -1869,16 +1867,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  
>  	cookie = dmaengine_submit(txd);
>  	if (dma_submit_error(cookie))
> -		goto err_set_unmap;
> +		goto err_unmap;
>  
>  	dmaengine_unmap_put(unmap);
>  
>  	dma_async_issue_pending(chan);
>  
>  	return 0;
> -err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> -err_get_unmap:
> +err_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
>  	return -ENXIO;

