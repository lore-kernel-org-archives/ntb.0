Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630ED4A205F
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264298; cv=none; b=j4GxW9vM1ZI9SBA2PNgFuCvMdfNTEp46aEGsQ64QV8Ovt0uDKTRPRuRPq+sM1mLWCcE5sd4BXFOZUSf9olGb5LQxBhCV/tLGiG+jAfOs5THFlQd9etlMc0szjunQ43jstfe+EXFFB73ltn0FvwHa5ZF0hH6XMDXAemGfTrYcdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264298; c=relaxed/simple;
	bh=ABf59hpDDrsR9POz3dbMDVuCD4YJmvllbvu3itcnvzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaRyYqkVnQJoUQdwo+8TDOC1Bvo9yHwhK8ZpxLAUmY4k90KILIvVhz0CAD0dm4VhH6lS5Hypxo114rBD7H4aoWV32NfTyFmkpbwpKiVsLYH4mxx6VuGlrOLvx3gX+p3hAz1jnVdUr/MBb0mq0gKTT52MtqrhXfw2iBwx4AI6Gn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8Uw+YgU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8Uw+YgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790264295; x=1821800295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ABf59hpDDrsR9POz3dbMDVuCD4YJmvllbvu3itcnvzg=;
  b=F8Uw+YgU3/un1MihME/vmDMMlTkTKXgFtycmIw3pMOYYHuPePQTBNxc9
   R2n+P4Tb6sTFs/A81ClfeXJzpZ1mxErMBIhmeRyLwX4n0nRMEJJnwdxTu
   K6rPYVulSiWs7ehNvHXf67FokUWFa9oVkNR77WvG0zAyqQwOWXZa3Wmp/
   WkgbKU/twGRmEOXdKnHp2GXVGNLNsOcoz5iKg92/7q5kEDgrxRclJk64B
   TuafF0B0+p20OYc8QOrIpD9adCQDSrabA5IEPuaReSOX381uHvs2SqoRQ
   nCnPxtA96oc/sNb9Ls5KEbXgPXVrR4e3Tf8febhg/7sVWXiacNHd2k6wa
   A==;
X-CSE-ConnectionGUID: tI7dlaS4QQKzGTNuH+8PkA==
X-CSE-MsgGUID: t11DG63lQlyMQ2K2P6c0Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89902007"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89902007"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:38:15 -0700
X-CSE-ConnectionGUID: N9ZmJd5tQXmWr1gMyvx7lg==
X-CSE-MsgGUID: +LlJganPSxmNNsXZTpnitw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272193250"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:38:14 -0700
Message-ID: <3919542b-ffbd-46c3-b3e3-092c3b901654@intel.com>
Date: Thu, 24 Sep 2026 08:38:13 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] NTB: ntb_transport: Start TX offload thread
 after queue setup
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-3-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_transport_create_queue() starts the per-QP TX offload thread before
> DMA mappings and queue entries are allocated. If later setup fails, the
> error path returns the QP to the free bitmap without stopping the
> thread. A retry can then reinitialize its waitqueue while the old thread
> is still waiting on it.
> 
> Start the thread after queue setup.
> 
> Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - No changes.
> 
> NOTE: Originally submitted as part of the direct TX/RX series v1:
> https://lore.kernel.org/r/20260810165136.2292436-4-den@valinux.co.jp/
> 
>  drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3389d6ca9ebd..55a20ae9a85e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->tx_handler = handlers->tx_handler;
>  	qp->event_handler = handlers->event_handler;
>  
> -	init_waitqueue_head(&qp->tx_offload_wq);
> -	if (tx_memcpy_offload) {
> -		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> -						    "ntb-txcpy/%s/%u",
> -						    pci_name(ndev->pdev), qp->qp_num);
> -		if (IS_ERR(qp->tx_offload_thread)) {
> -			dev_warn(&nt->ndev->dev,
> -				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> -				 PTR_ERR(qp->tx_offload_thread));
> -			qp->tx_offload_thread = NULL;
> -		}
> -	} else
> -		qp->tx_offload_thread = NULL;
> -
>  	dma_cap_zero(dma_mask);
>  	dma_cap_set(DMA_MEMCPY, dma_mask);
>  
> @@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  			     &qp->tx_free_q);
>  	}
>  
> +	init_waitqueue_head(&qp->tx_offload_wq);
> +	qp->tx_offload_thread = NULL;
> +	if (tx_memcpy_offload) {
> +		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> +						    "ntb-txcpy/%s/%u",
> +						    pci_name(ndev->pdev), qp->qp_num);
> +		if (IS_ERR(qp->tx_offload_thread)) {
> +			dev_warn(&nt->ndev->dev,
> +				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> +				 PTR_ERR(qp->tx_offload_thread));
> +			qp->tx_offload_thread = NULL;
> +		}
> +	}
> +
>  	ntb_db_clear(qp->ndev, qp_bit);
>  	ntb_db_clear_mask(qp->ndev, qp_bit);
>  

