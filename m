Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D524A090B
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264981; cv=none; b=Q2GbdMcY/enZE07DE+I/Pcie2OsM5wRe4ycxN+zzCbV2m3dZ6P2l8xJIcL7j/bKzF6su3qVcJD7QYQSDEpJPSiEG+x/g37GpiI35Y7C7Te8XMEeKNRjqCmqee/Q7M6nD5fjA/KLpOsgnokbUuiRPf/6lHzO6LycP2ao49Kv2O00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264981; c=relaxed/simple;
	bh=lboV5YV78Zed8jcQuQTEpJv1QJ+dmz/OU0ema2AxzGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoWWXTQQnZOxmX56Hpy5ZoALib6x471wIS+IXfQEUSMrs8fP1MxYxeVOJQ8vHP8D+cNb1D5JdFCF0M4cXA7j1uOaIv96rOi0I9CIHtepCVLo61tBIKeMUxmcUyosnBR78wXtqgJNcHvsBeNv0ePIJ5A0C56L/5eYK7tdpBKC6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkKXe0pg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkKXe0pg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790264977; x=1821800977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lboV5YV78Zed8jcQuQTEpJv1QJ+dmz/OU0ema2AxzGc=;
  b=BkKXe0pgmg+avK9XHNai01d69ajoyHSX5xxdwSgyy/qWIZDZm1DWiVMJ
   5+yW32SeR4hpzBolEVWlQPxVRHcE555cMtwCTb79Q+e4HF0QBIeziI6nQ
   JB+I5tsaNPjUrVmL+dYTi8ae1GNMM3Ry/7inrK4604Kl1tVDbMBLLdxWk
   gBiusRRu3cvf0VKnOUbfMJCYDNUG/9n13og9bPzN1nh/laLutb6E2rbOW
   JDeyif8JVTuykIM2HBKSp3gSwyGM65FXZhxatDeBTG+StWaPZIZItoVLg
   6vNyFmWdcC7wO71Q8wGrf+QTPhiQIbFuJA6vkYQMThhJWiPsDQ+qnuQ2r
   w==;
X-CSE-ConnectionGUID: so0kMXJmQAyeaM7SnUnUMQ==
X-CSE-MsgGUID: smny/OvxQlW25xMeq5cLnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108534856"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="108534856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:49:36 -0700
X-CSE-ConnectionGUID: GEZtSdbxTSGNP0txW9uOOA==
X-CSE-MsgGUID: mOxb0klqQZSpxehw+huXQg==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:49:36 -0700
Message-ID: <f1cd3816-8933-4ad7-bff1-73c103dff533@intel.com>
Date: Thu, 24 Sep 2026 08:49:34 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] NTB: ntb_transport: Stop RX tasklet scheduling
 before freeing a queue
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-9-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> A caller can read qp->active before teardown clears it, then schedule
> the RX tasklet after tasklet_kill() returns. The MSI handler does not
> check active at all. Teardown also releases DMA channels before
> draining the tasklet.
> 
> Protect active updates and the check-and-schedule sequence with
> rx_sched_lock, including the MSI path. Clear active under the lock,
> then drain the tasklet before releasing DMA channels or queue entries.
> QP link work is already disabled, so it cannot reactivate RX. Use a
> separate lock to avoid contention with RX list operations.
> 
> Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I do wonder at some point we should convert tasklet to threaded irq...

> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 50 +++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index e5599c7ca93f..45d4365becac 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -179,6 +179,8 @@ struct ntb_transport_qp {
>  	unsigned int rx_max_frame;
>  	unsigned int rx_alloc_entry;
>  	dma_cookie_t last_cookie;
> +	/* Protect active and RX tasklet scheduling. */
> +	spinlock_t rx_sched_lock;
>  	struct tasklet_struct rxc_db_work;
>  
>  	void (*event_handler)(void *data, int status);
> @@ -649,11 +651,26 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	return 0;
>  }
>  
> +static void ntb_transport_set_qp_active(struct ntb_transport_qp *qp, bool active)
> +{
> +	guard(spinlock_irqsave)(&qp->rx_sched_lock);
> +
> +	qp->active = active;
> +}
> +
> +static void ntb_transport_schedule_rxc(struct ntb_transport_qp *qp)
> +{
> +	guard(spinlock_irqsave)(&qp->rx_sched_lock);
> +
> +	if (qp->active)
> +		tasklet_schedule(&qp->rxc_db_work);
> +}
> +
>  static irqreturn_t ntb_transport_isr(int irq, void *dev)
>  {
>  	struct ntb_transport_qp *qp = dev;
>  
> -	tasklet_schedule(&qp->rxc_db_work);
> +	ntb_transport_schedule_rxc(qp);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -895,7 +912,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
>  {
>  	qp->link_is_up = false;
> -	qp->active = false;
> +	ntb_transport_set_qp_active(qp, false);
>  
>  	qp->tx_index = 0;
>  	qp->rx_index = 0;
> @@ -1159,13 +1176,12 @@ static void ntb_qp_link_work(struct work_struct *work)
>  	if (val & BIT(qp->qp_num)) {
>  		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
>  		qp->link_is_up = true;
> -		qp->active = true;
> +		ntb_transport_set_qp_active(qp, true);
>  
>  		if (qp->event_handler)
>  			qp->event_handler(qp->cb_data, qp->link_is_up);
>  
> -		if (qp->active)
> -			tasklet_schedule(&qp->rxc_db_work);
> +		ntb_transport_schedule_rxc(qp);
>  	} else {
>  		ntb_transport_schedule_qp_link(qp,
>  					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> @@ -1193,6 +1209,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->ndev = nt->ndev;
>  	qp->client_ready = false;
>  	qp->event_handler = NULL;
> +	spin_lock_init(&qp->rx_sched_lock);
>  	ntb_qp_link_context_reset(qp);
>  
>  	if (mw_num < qp_count % mw_count)
> @@ -1729,8 +1746,7 @@ static void ntb_transport_rxc_db(unsigned long data)
>  
>  	if (i == qp->rx_max_entry) {
>  		/* there is more work to do */
> -		if (qp->active)
> -			tasklet_schedule(&qp->rxc_db_work);
> +		ntb_transport_schedule_rxc(qp);
>  	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
>  		/* the doorbell bit is set: clear it */
>  		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
> @@ -1741,8 +1757,7 @@ static void ntb_transport_rxc_db(unsigned long data)
>  		 * ntb_process_rxc and clearing the doorbell bit:
>  		 * there might be some more work to do.
>  		 */
> -		if (qp->active)
> -			tasklet_schedule(&qp->rxc_db_work);
> +		ntb_transport_schedule_rxc(qp);
>  	}
>  }
>  
> @@ -2209,7 +2224,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  	disable_work_sync(&qp->link_cleanup);
>  	disable_delayed_work_sync(&qp->link_work);
>  	qp->link_is_up = false;
> -	qp->active = false;
> +	ntb_transport_set_qp_active(qp, false);
> +
> +	qp_bit = BIT_ULL(qp->qp_num);
> +	ntb_db_set_mask(qp->ndev, qp_bit);
> +	tasklet_kill(&qp->rxc_db_work);
>  
>  	if (qp->tx_offload_thread) {
>  		kthread_stop(qp->tx_offload_thread);
> @@ -2251,11 +2270,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  		dma_release_channel(chan);
>  	}
>  
> -	qp_bit = BIT_ULL(qp->qp_num);
> -
> -	ntb_db_set_mask(qp->ndev, qp_bit);
> -	tasklet_kill(&qp->rxc_db_work);
> -
>  	qp->cb_data = NULL;
>  	qp->rx_handler = NULL;
>  	qp->tx_handler = NULL;
> @@ -2350,8 +2364,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  
>  	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
>  
> -	if (qp->active)
> -		tasklet_schedule(&qp->rxc_db_work);
> +	ntb_transport_schedule_rxc(qp);
>  
>  	return 0;
>  }
> @@ -2548,8 +2561,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
>  		qp_num = __ffs(db_bits);
>  		qp = &nt->qp_vec[qp_num];
>  
> -		if (qp->active)
> -			tasklet_schedule(&qp->rxc_db_work);
> +		ntb_transport_schedule_rxc(qp);
>  
>  		db_bits &= ~BIT_ULL(qp_num);
>  	}

