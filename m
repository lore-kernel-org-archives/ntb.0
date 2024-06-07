Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556319A2B8
	for <ntb@lists.linux.dev>; Fri,  7 Jun 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776874; cv=none; b=tYDTGYsacWV96v19MLH2CpcjY98QFO1HWL3yZuAX11iuXLGjbUiHIDyyBYxepvh9SFDSbr8yVb8Ar6ZvRvWSlMl9cKk8lxAkUx4GUhnm78cW7aWanHBCjKVBpxldaQU5VA0u+ZtR2YC/OBFX/4c3tf6PXiu5YJoMm44BM1x5pG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776874; c=relaxed/simple;
	bh=9strxmh/teWZJ6BahDMnrBoMEOAPAaV0j6k+qZDc3x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIECrqbKliS6PSZWgdEv3nprnXICRDamRSfVHagROO6DDz8SZ29k9AD+f9Y/AkSBmC1vC4jgOQRL3EI6k5jotWSiBMS/gYHlMccuLBR5go9ZhwnYUujgSuh5HfqYX7OryU5ByGUff+jj18WM0vhbTgIx1WDesKWHAHZmhPFDR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdwDewYH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdwDewYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717776872; x=1749312872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9strxmh/teWZJ6BahDMnrBoMEOAPAaV0j6k+qZDc3x4=;
  b=RdwDewYH+2rwRhotCXyfMnOPaFphdqURVGVPRX0Ttoqo7TMlDZownIpS
   ae7eCUiLmMPHaLlVHFD5OM5D8G1/TkZ5YTAj7CIdlnlN7tM+xzDBGkitJ
   792zETVE7AfffcJ0yLErfVIbHw13cMw0KokWzizGeViqVfQQ2UtW7Ye3q
   8zevSGATH3Lkkay/aWttGOMDOdramhtiO+9vxYIWzVdgXpaPdYkHzuvWQ
   ZHSEKsEdMACnC6qzmcXBRSnJqxBzMSRAd2xvHl9IGoQgwPpC7tssAHCdY
   OGm6fhaywkURlwLk51wrD2bDPBORbmNdiRH1chvW2FLaIc3TygEbeHgOi
   Q==;
X-CSE-ConnectionGUID: 2fZSPIzySFKTgCLaimByAQ==
X-CSE-MsgGUID: 5uB8g+owS4e2/qdTRE0d1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18359438"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18359438"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:14:31 -0700
X-CSE-ConnectionGUID: 2euzQzGZQgGl5iqkTtXFtQ==
X-CSE-MsgGUID: Aw/uYym3Twiv/vbsFrFnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38298218"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.239]) ([10.125.109.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:14:30 -0700
Message-ID: <1f393cc9-7195-4d58-b1ab-3616a184a88f@intel.com>
Date: Fri, 7 Jun 2024 09:14:29 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] ntb: Fix kernel-doc param for
 ntb_transport_create_queue
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/7/24 12:57 AM, Yang Li wrote:
> The patch updates ntb_transport_create_queue() kdoc header to specify the
> correct input parameters used by the function.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thank you!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

I do recommend attaching the revision history below the '---' line next time for common patch posting practice. Thanks
>  drivers/ntb/ntb_transport.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9e7847a378e..5d466a3f117b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1966,9 +1966,10 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
>  
>  /**
>   * ntb_transport_create_queue - Create a new NTB transport layer queue
> - * @rx_handler: receive callback function
> - * @tx_handler: transmit callback function
> - * @event_handler: event callback function
> + * @data: user-defined data to associate with the queue
> + * @client_dev: the device structure of the NTB client
> + * @handlers: structure containing receive, transmit, and event callback
> + *	      functions
>   *
>   * Create a new NTB transport layer queue and provide the queue with a callback
>   * routine for both transmit and receive.  The receive callback routine will be
