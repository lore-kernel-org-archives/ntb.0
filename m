Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A60443A97;
	Thu, 27 Aug 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828698; cv=none; b=dsv6dwo+0Sk9/AD5g9Z9M6DCUvNtSeqyrwbb+Mg15wbPcDP55r4Spj6+pwHCQox2ep4MQVZuvoC99aYYsWb2qgf62JqRtAbU+qdUGIcg5Kay3Murc6oahS9H7TMTrHQuyvARNIySWLDvh8xGd8WNFQok4LVuX04uhT0gA6xXW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828698; c=relaxed/simple;
	bh=uqK5KltcbwpqUBeSergeS/QuUrYZoB8S81EH8qYNC5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULWK4+Y7Aa8nlKWupRS8H8yEsf710KP2VVaKi+Um91Re86rx9kJcOLfqZs1mHNvAUZiHjrOe0i0EawcmkiKkFBWFPUMMQUDNmSUkQJOQeYgDV/lquKkPSfR+G55NLHc6pE6LM8GlBNDfrxC9Sv74t/13uSiPMzFpQVtqPHN7d9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkoXgfHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkoXgfHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8611F00A3A;
	Thu, 27 Aug 2026 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828690;
	bh=fvzPWXzSuaZU03OKJ9pJj5UCDL8q2ZeT6Fzq1mkL1fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fkoXgfHOedd8s0fPmX9t8dB1uCsv4oXDRwXZh1WPJWqDSmiB2eujR6FVkwBBjpYty
	 giK+l+ossnXnMpBhbDHuh2LV2f5G7ZKMSjPSBTsvvmS1+AZgAhnOm0Fo90nuf0WHeh
	 KHBEZ6SSBRqWqoH/88b8maaFKSGydELX+LFZxpcS7MudFZsHbQfG1kLhBkpsBgEW29
	 vmv3wY+FCsS3BOi5CBHLkN0esktPvm2HxITqWrIgPwKy3tukcNTu7USaeGZhcIwaTm
	 6ItrI7sCkKwl40YJyOGrt+ScAoaONc04G8yooGGP9Wu5RfprgGeRP13ichH9Dz6U2b
	 VN/ACG+5forgg==
Date: Thu, 27 Aug 2026 12:04:45 +0100
From: Simon Horman <horms@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ntb_netdev: Fix statistics races
Message-ID: <20260827110445.GD396647@horms.kernel.org>
References: <20260824025720.3520288-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824025720.3520288-1-den@valinux.co.jp>

On Mon, Aug 24, 2026 at 11:57:20AM +0900, Koichiro Den wrote:
> ntb_netdev updates shared net_device stats from per-QP RX and TX
> callbacks. Once multiple queues are enabled, concurrent updates can be
> lost.
> 
> Use core-managed per-CPU dstats for packet, byte and drop counters.
> Keep infrequent error counters in net_device_stats with atomic
> DEV_STATS_INC(). The core handles allocation and aggregation.
> 
> Transport queues can still complete after ndo_stop. Tear them down from
> ndo_uninit before the core frees dstats.
> 
> Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> This is the follow-up mentioned here:
> https://lore.kernel.org/r/20260819172539.1450821-1-den@valinux.co.jp/
> The related TX and RX fixes have now landed in net.
> 
>  drivers/net/ntb_netdev.c | 44 ++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 9c171697e762..6a1e58d5d7d6 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c

...

> @@ -219,11 +218,13 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  		return;
>  
>  	if (len > 0) {
> -		ndev->stats.tx_packets++;
> -		ndev->stats.tx_bytes += skb->len;
> +		/* TX completion may run from the memcpy kthread. */
> +		local_bh_disable();
> +		dev_dstats_tx_add(ndev, skb->len);
> +		local_bh_enable();


Hi Den-san,

There is an AI-generated review of this patch available at [1].
This is separate to the AI-generated review forwarded elswhere in this
thread by sashiko-bot.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824025720.3520288-1-den%40valinux.co.jp

It raises a concern regarding using local_bh_disable/local_bh_enable.
And I wonder if this might be addressed by unrolling dev_dstats_tx_add,
something like this:

		u64_stats_update_begin_irqsave(&dstats->syncp, syncp_flags);
		u64_stats_inc(&dstats->tx_packets);
		u64_stats_add(&dstats->tx_bytes, skb->len);
		u64_stats_update_end_irqrestore(&dstats->syncp, syncp_flags);

AI-generated review text:

  Can ntb_netdev_tx_handler() run with interrupts disabled here?

  With the ntb_transport defaults (use_dma=false, tx_memcpy_offload=false)
  the TX completion is not deferred to a kthread at all, it runs inline in
  the ndo_start_xmit caller's context:

  ntb_netdev_start_xmit()
    ntb_transport_tx_enqueue()
      ntb_process_tx()
        ntb_async_tx()            /* chan == NULL, goto err */
          ntb_memcpy_tx()
            ntb_memcpy_tx_on_stack()
              ntb_tx_copy_callback()
                qp->tx_handler()  == ntb_netdev_tx_handler()

  netpoll calls ndo_start_xmit with interrupts off:

  net/core/netpoll.c:netpoll_send_skb() {
	...
	local_irq_save(flags);
	ret = __netpoll_send_skb(np, skb);
	local_irq_restore(flags);
	...
  }

  and ntb_netdev does not set IFF_DISABLE_NETPOLL, so netconsole can bind
  to the interface. In that context local_bh_enable() hits:

  kernel/softirq.c:__local_bh_enable_ip() {
	WARN_ON_ONCE(in_hardirq());
	lockdep_assert_irqs_enabled();
	...
	if (unlikely(!in_interrupt() && local_softirq_pending()))
		do_softirq();
	...
  }

  so besides the splat, softirqs would be run from inside a netpoll/printk
  section that expects interrupts to stay disabled.

  The pre-existing dev_kfree_skb_any() a couple of lines below already
  assumes this handler can be entered from hardirq or with IRQs disabled,
  which is the same assumption the plain ndev->stats.tx_packets++ was safe
  under.

  There is also a second entry path: ntb_async_tx_submit() installs
  ntb_tx_copy_callback() as txd->callback_result, and whether a dmaengine
  provider calls that from hardirq is up to the provider. If it does, a
  BH-disable is not enough to protect the pcpu_dstats syncp that the RX
  side writes from the rxc_db tasklet on the same CPU, so on 32-bit the
  seqcount can be torn.

  Would an IRQ-safe update (local_irq_save()/local_irq_restore() around
  the update, or u64_stats_update_begin_irqsave() on
  this_cpu_ptr(ndev->dstats)) be correct in all of these contexts?

>  	} else {
> -		ndev->stats.tx_errors++;
> -		ndev->stats.tx_aborted_errors++;
> +		DEV_STATS_INC(ndev, tx_errors);
> +		DEV_STATS_INC(ndev, tx_aborted_errors);
>  	}
>  
>  	dev_kfree_skb_any(skb);
> @@ -277,7 +278,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  
>  drop:
>  	dev_kfree_skb_any(skb);
> -	ndev->stats.tx_dropped++;
> +	dev_dstats_tx_dropped(ndev);
>  	return NETDEV_TX_OK;
>  }
>  
> @@ -427,7 +428,19 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
>  	return rc;
>  }
>  
> +static void ntb_netdev_uninit(struct net_device *ndev)
> +{
> +	struct ntb_netdev *dev = netdev_priv(ndev);
> +	unsigned int q;
> +
> +	for (q = 0; q < dev->num_queues; q++) {
> +		ntb_transport_free_queue(dev->queues[q].qp);
> +		dev->queues[q].qp = NULL;
> +	}
> +}
> +

[1] also raises a concern here relating to holding RTNL for too long.

I wonder if this can be addressed by quiescing the queues in
ntb_netdev_uninit() while leaving the calls ntb_transport_free_queue()
until after unregister_netdev() has been called in ntb_netdev_remove().

AI-generated review text:

  How long can RTNL be held by this new ndo_uninit path?

  ndo_uninit is called from unregister_netdevice_many_notify() with RTNL
  held (unregister_netdev() -> rtnl_net_dev_lock()):

  net/core/dev.c:unregister_netdevice_many_notify() {
	...
		if (dev->netdev_ops->ndo_uninit)
			dev->netdev_ops->ndo_uninit(dev);
	...
  }

  ntb_transport_free_queue() then drains the DMA channels for each queue
  pair, once for TX and once for RX:

  drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
	...
		dma_sync_wait(chan, qp->last_cookie);
		dmaengine_terminate_all(chan);
	...
  }

  and dma_sync_wait() is a busy-poll with a 5 second timeout and no early
  abort:

  drivers/dma/dmaengine.c:dma_sync_wait() {
	unsigned long dma_sync_wait_timeout = jiffies + msecs_to_jiffies(5000);
	dma_async_issue_pending(chan);
	do {
		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
			return DMA_ERROR;
		}
		if (status != DMA_IN_PROGRESS)
			break;
		cpu_relax();
	} while (1);
	...
  }

  With use_dma=1 and a wedged channel or a downed peer, that is up to
  roughly 10 seconds of spinning per queue pair, multiplied by
  dev->num_queues, plus kthread_stop(), tasklet_kill() and
  cancel_delayed_work_sync(), all under RTNL. Before this patch the same
  loop ran in ntb_netdev_remove() after unregister_netdev() returned, with
  no locks held.

  Since the stats fix only needs the transport callbacks to stop before
  the core frees dstats, could the channel drain and release stay in
  ntb_netdev_remove()?

>  static const struct net_device_ops ntb_netdev_ops = {
> +	.ndo_uninit = ntb_netdev_uninit,
>  	.ndo_open = ntb_netdev_open,
>  	.ndo_stop = ntb_netdev_close,
>  	.ndo_start_xmit = ntb_netdev_start_xmit,
> @@ -647,6 +660,7 @@ static int ntb_netdev_probe(struct device *client_dev)
>  	}
>  
>  	ndev->features = NETIF_F_HIGHDMA;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>  
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> @@ -696,8 +710,7 @@ static int ntb_netdev_probe(struct device *client_dev)
>  	return 0;
>  
>  err_free_qps:
> -	for (q = 0; q < dev->num_queues; q++)
> -		ntb_transport_free_queue(dev->queues[q].qp);
> +	ntb_netdev_uninit(ndev);
>  
>  err_free_queues:
>  	kfree(dev->queues);
> @@ -711,11 +724,8 @@ static void ntb_netdev_remove(struct device *client_dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(client_dev);
>  	struct ntb_netdev *dev = netdev_priv(ndev);
> -	unsigned int q;
>  
>  	unregister_netdev(ndev);
> -	for (q = 0; q < dev->num_queues; q++)
> -		ntb_transport_free_queue(dev->queues[q].qp);
>  
>  	kfree(dev->queues);
>  	free_netdev(ndev);
> 
> base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
> -- 
> 2.51.0
> 
