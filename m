Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D2381AE0
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182761; cv=none; b=guSM8lUoAkxCsjqN6BQzaOAFQNr1Xw+jCKXGzCa8QdrK2VkCxqQvvNpZKcR14lrZ9xwGbz7S7z0XFOKmGQzEDyEBoNr/t6TLIY4EgiW93JWT5M6xgmHZcqHU3WYNxUr6VJoO/6qpsuF92bRPxcG/DX3BjXdcycdc9aLpdES3jKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182761; c=relaxed/simple;
	bh=UKycuMgV9hIAWudS/jnJ0dB2Rr0udPWNWD9eW2uN4nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9S803WNtTFEeN1o4eXma74gWErpUxedTE651unlh388afTZvuio9LxzNCmu5gT0ZDlogfaN6FNh90+yJ8hmqXDuDnl/MUOnQ7AvZvfAav2Bo4ozKn6L6aGfrdQYs4nvc87J83+pPrk2X6RFl5wX7aE2Hc2J7hIolQKdb5fPN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbRISsyV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbRISsyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787182760; x=1818718760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UKycuMgV9hIAWudS/jnJ0dB2Rr0udPWNWD9eW2uN4nE=;
  b=JbRISsyV5eQA8N5J2VWflZ86+cD3x5JWnHwQPmjAtNLwjtYp07vOEsS+
   aBY8gR9uMUSmqqqwW3PDbsyuqlJJkOlcj6wNbYCrnLOZT1zzclPlDuBDp
   lTxrZnSlcM4xn+m8/Te9Dq61Wu/g5kw7K/fp3ZltbVr7IxdvlXPLZfsDC
   IBzz76X69+h1xIsRM6k6l42L7eBQ6kjW316zhzhyKBpaJ28G6SYYnRrJO
   9D38Uuhsd7R9Od6vXz9WAc2Cx8LPbW7VuHa9vFpmThlmLZAZqRCp43TeJ
   GsE9HB+pxaKHPX3+CffcUGsCAavLT+jimkqOgmxYdo7fu0Y9etW2QJ9OI
   Q==;
X-CSE-ConnectionGUID: PhjALGuhRf64+OJV3KZmvQ==
X-CSE-MsgGUID: vqyRPFIlRdWiHEG+6VOaDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113251715"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="113251715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:39:19 -0700
X-CSE-ConnectionGUID: 9hmj9M2wRNGT0XN01L+O3w==
X-CSE-MsgGUID: U2gavyp0RWKehpR7ZG0QvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="266350708"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:39:17 -0700
Message-ID: <cb4c7775-0307-4b0d-8963-cd5889261658@intel.com>
Date: Wed, 19 Aug 2026 16:39:17 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] net: ntb_netdev: Fix TX busy and drop handling
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-3-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817053519.4135287-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 10:35 PM, Koichiro Den wrote:
> Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
> also increments the drop and error counters while leaving the skb owned
> by the qdisc, and may return BUSY with the subqueue still awake.
> Retrying a permanent error cannot succeed either.
> 
> The unconditional BUSY return and premature accounting date back to the
> initial driver. The error-path queue stop was later removed without
> changing that return value. The current flow-control code includes a
> resource check, but ntb_netdev does not honor its result before enqueue.
> 
> Honor the resource check before enqueue. For -EAGAIN and -EBUSY, stop
> the subqueue, arm the existing reaper timer, and return BUSY without
> touching the skb. For other errors, free the skb, increment tx_dropped,
> and return NETDEV_TX_OK.
> 
> Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
> Fixes: d723485cb4ca ("ntb_netdev: remove tx timeout")

This is probably the only Fixes tag we need.

> Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
> Cc: stable@vger.kernel.org> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 029a4a532a10..02b35cf53a62 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -199,8 +199,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
>  static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
>  				    struct ntb_netdev_queue *q, int size)
>  {
> -	if (__netif_subqueue_stopped(ndev, q->qid) ||
> -	    (ntb_transport_tx_free_entry(q->qp) >= size))
> +	if (__netif_subqueue_stopped(ndev, q->qid))
> +		return -EBUSY;
> +
> +	if (ntb_transport_tx_free_entry(q->qp) >= size)
>  		return 0;
>  
>  	return __ntb_netdev_maybe_stop_tx(ndev, q, size);
> @@ -256,21 +258,30 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  
>  	q = &dev->queues[qid];
>  
> -	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
> +	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
> +		return NETDEV_TX_BUSY;
>  
>  	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
> -	if (rc)
> -		goto err;
> +	if (rc) {
> +		if (rc == -EAGAIN || rc == -EBUSY) {
> +			netif_stop_subqueue(ndev, q->qid);
> +			mod_timer(&q->tx_timer,
> +				  jiffies + usecs_to_jiffies(tx_time));
> +			return NETDEV_TX_BUSY;
> +		}
> +
> +		goto drop;
> +	}
>  
>  	/* check for next submit */
>  	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
>  
>  	return NETDEV_TX_OK;
>  
> -err:
> +drop:
> +	dev_kfree_skb_any(skb);
>  	ndev->stats.tx_dropped++;
> -	ndev->stats.tx_errors++;
> -	return NETDEV_TX_BUSY;
> +	return NETDEV_TX_OK;
>  }
>  
>  static void ntb_netdev_tx_timer(struct timer_list *t)

