Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5F6F2EB
	for <ntb@lists.linux.dev>; Fri, 31 May 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170765; cv=none; b=Jz1WDL2CHrw/aJwbfnQC/yGwk4b95nnNzEvipySQZ7l1yWPRDZciFlzWjRz4RnB7utRtT88myVvIBYXsSZVP99amoSr1+J1m/YBXrhVs6CfxtqEr9f8CApIyrPqQdrV4BV5OpcZmJb710bJDceIP0zW54lHjrIoA55cgHqHOtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170765; c=relaxed/simple;
	bh=J0kbwRHmV/+gyGrwgRmUSbnanlbcmQ5Rx6idzys8fSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfw0FH4bpiFELJLtLLM2WqRJM1VBDzHTpTsfOldJ+5hlpoe7UWoHHFdI/Zk1c3ds1k8gBru1iU9GY/QCq/bmYyiSMU41scVMSSgNRgelitvKDmSsUrWjyr/Kn7LbUzgl3sSZ6jX23UHidwgiBHRDvm7tZSYduDiKRqUDhSiiCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+Kll7eo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+Kll7eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717170764; x=1748706764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J0kbwRHmV/+gyGrwgRmUSbnanlbcmQ5Rx6idzys8fSY=;
  b=V+Kll7eontUmoQcYHIaBDCkAeuM5srA5F9mQHmxs8DeHpggW8xikdgzN
   KXX9dvSmR0Epp+Q38/cXAb5t4zsISfsq1gd0MSDV8g+4/jZcf0dseHOA0
   5jMTyVo0t+aIESATdM3tgZYpuO+lcmTLPA4sAOxRM45FyIDmb9cbb77r/
   UQ2ol/3gVSnTL1Mhm4t13AYDFpPoWSDRrkEvadQ6tLQMaTJ6/1W28X6Dc
   LamaQqmR6XnwnbGtHvwJ0YslwH4kPDaoreH7J5TP5dab6ZmSMhr8BHdkC
   pIzcKZYX5xxZD+Zxyf9F3PMevM50SxYaEFkkWj2Q9ARID1iu/qncI8+4e
   w==;
X-CSE-ConnectionGUID: oVpGhbNtR7ODzJ2H92Ok+w==
X-CSE-MsgGUID: XnXboTjlS3ysF53okrMiDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13587513"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13587513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:52:43 -0700
X-CSE-ConnectionGUID: zpuuR3eiRQ60zgBo3cKqcg==
X-CSE-MsgGUID: +jYVfnZySUSdu642MgqtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59376531"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.62]) ([10.125.108.62])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:52:42 -0700
Message-ID: <457b2e1c-00b7-45d5-9c66-6d03c39586d5@intel.com>
Date: Fri, 31 May 2024 08:52:41 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ntb: Fix kernel-doc param for
 ntb_transport_create_queue
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240531072124.64352-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240531072124.64352-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/24 12:21 AM, Yang Li wrote:
> The patch updates the function documentation comment for
> ntb_transport_create_queue to adhere to the kernel-doc specification.

I wouldn't say it's not adhering to kernel-doc specification but rather that it's documenting the incorrect/out of date parameters. So maybe something like:

Update ntb_transport_create_queue() kdoc header to specify the correct input parameters used by the function.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Besides the commit log change,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
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
