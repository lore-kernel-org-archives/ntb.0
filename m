Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFD4EB847;
	Thu, 17 Sep 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675981; cv=none; b=IJkZFILaiaUnFTR8LX00V++E2TdsgDBGTVDw54Hhmlqaq5enpELOP6ya0axnyv0HBfyGaggRk6Qv78ElR5eayfXozjsSGjj1hCIufsTBNdxF1TB7XpYS6ShB9eo1Ai3wE/iurXedAxHp3QENW2LreU3Ng7JsIfaibcDDwNMslOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675981; c=relaxed/simple;
	bh=MItVxbonx0GBF8xjgQU/JLV54KRBzxa2wfW8Y6UYxiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FW9iVcS/DOvV4s1bi7yoPDvYNvVvvHs4ePQIRaZkX6JhWXUswtkLOxbnbuBRqflg+ijClRF01Eyds4hcLBSMNLqagGhMB2HIPrqsW05lrulSPbZfI42E9i/72JNO8vQ1ht+M/Jg2i2LwU1sUEjU8OjLRaoEC7HRvHAQPkHKzJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hv5uAgWw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hv5uAgWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789675977; x=1821211977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MItVxbonx0GBF8xjgQU/JLV54KRBzxa2wfW8Y6UYxiI=;
  b=hv5uAgWwG892g1/N+j7qfUg1FLBgxqI4kbBws7MTHpVNlGCROQtQgZRC
   7ndXn7QsvE9RTmECFeS4ioncW2eOqcVavlJ7/gzzGlwV7uJxtz7YBVOqP
   w7gR6hMnHbf4tbRAw409Nk5UykMOSkFL1KaZb+2YrYa3Ir3N6brNbaX9a
   0jdn4taRm1uR7ZIez/8Mwy00AvDTLUvYtvNExHpoFCOCgEr1dV5q0dEbm
   ulJg0FVpUETmSN5Y2WPW25FMuOObwLTeIEw9k8B/jRzbeqWgSuqWrMr7v
   b5/eCs2hhpfeUjGI2rmZYfUmATKG3mpZMFvWYOnDbgJAfhdfjy1oCLDVG
   Q==;
X-CSE-ConnectionGUID: Zcyd0y0HTnSkoMzFdBE1nQ==
X-CSE-MsgGUID: yFdjVHrHSUuThn+7Je9n1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93973017"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93973017"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:12:52 -0700
X-CSE-ConnectionGUID: COg2Otv7TkKNRQh0nOsBCw==
X-CSE-MsgGUID: VI2n0fE+TnOHmdMqgRQ1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2432467"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.63]) ([10.125.109.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:12:52 -0700
Message-ID: <ef1d2815-e284-4950-a485-792247588fb1@intel.com>
Date: Thu, 17 Sep 2026 13:12:49 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NTB: ntb_transport: replace direct ->device_prep*()
 calls with standard DMA engine API
To: Frank.Li@oss.nxp.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20260917190831.1194795-1-Frank.Li@oss.nxp.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260917190831.1194795-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 12:08 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> DMA engine consumers must not call the channel's device_prep_*() function
> pointers directly. Use the standard dmaengine wrapper APIs instead.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..45144abfb7aad 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1551,9 +1551,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	unmap->from_cnt = 1;
>  
> -	txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> -					     unmap->addr[0], len,
> -					     DMA_PREP_INTERRUPT);
> +	txd = dmaengine_prep_dma_memcpy(chan, unmap->addr[1],
> +					unmap->addr[0], len,
> +					DMA_PREP_INTERRUPT);
>  	if (!txd)
>  		goto err_get_unmap;
>  
> @@ -1884,8 +1884,8 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  
>  	unmap->to_cnt = 1;
>  
> -	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
> -					     DMA_PREP_INTERRUPT);
> +	txd = dmaengine_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
> +					DMA_PREP_INTERRUPT);
>  	if (!txd)
>  		goto err_get_unmap;
>  

