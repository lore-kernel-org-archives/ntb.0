Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455A3D5244;
	Wed,  9 Sep 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985495; cv=none; b=JWBNFzBoBTLvKr1A/Kk8N16xVOOHMFQErG0ZowCjwuBZ/F/IIaYRWiDqOZxaBLAUwMmznb2ZXE4VRSK6Smrr70GOb6XQV118Euo6PfofAnoCzBEXzkTNLYolKoG878sG96FvTX+jvNDAXUPIvinySiob9mal5XrNg1sw5yg1HOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985495; c=relaxed/simple;
	bh=HMD89yzhz9VRWfYoWdBhNKT4isY2wX0oNZEJxpHBF0s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKfc9nnanHkTTG7KmMCUiSiYE6BfUlCMY0OHSn+l8DB3M8kOeT24aq5BewaEmYHIsdGjdnYJo9DOkS3ie7KOqmesyvwU0YWOwEFrgzudz4H0ZebHhLGf5cI1kEdSAS5TJ6PMtO6MJutdyqHqvaHu4McsYSXKYTGgKADlVM0Sn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJM294Kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJM294Kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390F41F00893;
	Wed,  9 Sep 2026 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985489;
	bh=QfMNELUrrswP6e2qeeqqC6pvQsk1MNlYVOXS2w7NmAA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GJM294KkBQhFm0jxpwLGwN0LrKWn/mOFcnHbkSrhK4U95OS1NuusLhKYTtLrlnQ4y
	 M0KRbtjLS+XjLM76+GST44ekWa/AQ+i+ELDeV2H4Qu7dVBxcfNvzTyZUcIYjYtCAj3
	 b8GvFYQhYh9K3siDtYCxSq0oNvGyMX6FNNjbWtnSUYF37LDwOA0CikdRnlRGquHBFP
	 ke/Y3g7mEkRjsrRtdNt2dtswoSUQOi+/8fRx8KEZTOoQ4pe4T0FB8khtEXuRr9zDoP
	 R3vVDLD2ZLHKq0CbXRWpxD72mSWo2Me8h0H0k4iHl68vgvmfMJQ4nXaUxS+9JSaZ/R
	 ymfIsN8SUuMlQ==
Subject: Re: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: kuba@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 20:24:48 +0000
Message-ID: <178898548878.219967.14452142614850430350@kernel.org>
In-Reply-To: <20260904052134.2970111-5-den@valinux.co.jp>
References: <20260904052134.2970111-5-den@valinux.co.jp>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] ntb_netdev_start_xmit() unconditionally seeds `meta =
  NTB_NETDEV_META_CAP_CSUM` (drivers/net/ntb_netdev.c:317), so the…
- [Medium] dev->peer_csum is a device-wide lockless bool written from two
  unsynchronised contexts: ntb_netdev_event_handler() clears it…
- [Low] ntb_netdev_rx_handler() performs an unconditional
  `WRITE_ONCE(dev->peer_csum, true)` for every received frame carrying…

--

net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

This carries CHECKSUM_PARTIAL, csum_start and csum_offset across the NTB
link in the transport meta field, advertising the capability on every frame
and falling back to software checksumming until the peer capability is
observed.  TX and RX checksum offload are added to hw_features but left
disabled by default.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index d03cbda1637d9..de8c4f320614d 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c

[ ... ]

> @@ -29,6 +30,21 @@ static unsigned int tx_stop = 5;
>  #define NTB_NETDEV_MAX_QUEUES		64
>  #define NTB_NETDEV_DEFAULT_QUEUES	1
>  
> +/*
> + * Checksum metadata layout:
> + *   bit 23     capability, advertised on every packet
> + *   bit 22     per-packet CHECKSUM_PARTIAL flag
> + *   bit 21..6  skb_checksum_start_offset() (16 bits)
> + *   bit 5..0   skb->csum_offset (6 bits)
> + *
> + * Until the capability is observed, complete partial checksums in software.
> + * Six offset bits cover TCP/UDP. Larger offsets use software checksumming.
> + */
> +#define NTB_NETDEV_META_CAP_CSUM		BIT(23)
> +#define NTB_NETDEV_META_CSUM			BIT(22)
> +#define NTB_NETDEV_META_CSUM_START_SHIFT	6
> +#define NTB_NETDEV_META_CSUM_OFFSET_MASK	GENMASK(5, 0)
> +
>  struct ntb_netdev;
>  
>  struct ntb_netdev_queue {
> @@ -44,6 +60,7 @@ struct ntb_netdev {
>  	struct net_device *ndev;
>  	unsigned int num_queues;
>  	struct ntb_netdev_queue *queues;
> +	bool peer_csum;
>  };
>  
>  #define	NTB_TX_TIMEOUT_MS	1000
> @@ -108,6 +125,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
>  	struct net_device *ndev;
>  
>  	ndev = dev->ndev;
> +	WRITE_ONCE(dev->peer_csum, false);

[Severity: Medium]
Can this clear of peer_csum be lost?  ntb_netdev_event_handler() runs in
workqueue/process context out of the transport, while
ntb_netdev_rx_handler() sets the same field from the qp rxc_db tasklet or
from an RX DMA completion (ntb_rx_copy_callback() -> ntb_complete_rxc()).

Looking at ntb_qp_link_cleanup() in drivers/ntb/ntb_transport.c, the
event handler is invoked without stopping the rxc_db tasklet or draining
outstanding RX DMA completions:

	cancel_delayed_work_sync(&qp->link_work);
	ntb_qp_link_down_reset(qp);

	if (qp->event_handler)
		qp->event_handler(qp->cb_data, qp->link_is_up);

and ntb_complete_rxc() still calls into the driver because transport link
loss does not clear client_ready:

		if (qp->rx_handler && qp->client_ready)
			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);

So a completion belonging to the previous link generation can run
WRITE_ONCE(dev->peer_csum, true) after the link-down clear, and after the
following link-up clear too.  If the peer that comes back does not
implement the capability (for example it rebooted into a pre-patch
kernel), ntb_netdev_start_xmit() then sees peer_csum == true, sets
NTB_NETDEV_META_CSUM and skips skb_checksum_help(), and the old peer marks
those frames CHECKSUM_NONE with only the pseudo-header sum in place.
Wouldn't that silently break TCP/UDP over the link until it is bounced
again?  READ_ONCE()/WRITE_ONCE() only prevent torn access here.

A related question: peer_csum is device-wide while the event handler is
per-queue, and multi-queue is reachable through the driver's ethtool
set_channels.  Should one queue's link event clobber capability state
learned on the other queues that are still up?

>  
>  	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
>  		   ntb_transport_link_query(q->qp), q->qid);

[ ... ]

> @@ -146,21 +174,32 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  		goto enqueue_again;
>  	}
>  
> -	tstats = this_cpu_ptr(ndev->tstats);
> -	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
> -	u64_stats_inc(&tstats->rx_packets);
> -	u64_stats_add(&tstats->rx_bytes, len);
> -	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
> -
>  	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
>  	if (!new_skb) {
> +		ntb_netdev_rx_stats_add(ndev, len);
>  		DEV_STATS_INC(ndev, rx_dropped);
>  		goto enqueue_again;
>  	}
>  
>  	skb_put(skb, len);
> +	if (meta & NTB_NETDEV_META_CAP_CSUM)
> +		WRITE_ONCE(dev->peer_csum, true);

[Severity: Low]
This isn't a bug, but does this need to store on every frame?  peer_csum
only ever goes false -> true within a link session, and it sits in the
shared struct ntb_netdev next to ndev/num_queues/queues, which
ntb_netdev_start_xmit() reads once per transmitted packet:

	q = &dev->queues[qid];
	...
		if (READ_ONCE(dev->peer_csum))

Every received frame therefore dirties a cacheline that each TX queue
reads per packet, possibly from another CPU (more so with multiple queues
via set_channels).  Would a test before the store, or per-queue state,
avoid that?

	if (!READ_ONCE(dev->peer_csum))
		WRITE_ONCE(dev->peer_csum, true);

> +
> +	if (meta & NTB_NETDEV_META_CSUM) {
> +		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
> +		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
> +
> +		if (csum_start < ETH_HLEN ||
> +		    !skb_partial_csum_set(skb, csum_start, csum_offset))
> +			goto rx_drop;
> +
> +		if (!(ndev->features & NETIF_F_RXCSUM) &&
> +		    skb_checksum_help(skb))
> +			goto rx_drop;
> +	}

[Severity: High]
With rx-checksumming off, does this path still end up trusting the peer?

The frame is not rejected: skb_partial_csum_set() applies the
peer-supplied csum_start/csum_offset, then skb_checksum_help() in
net/core/dev.c computes the sum over the bytes that were just received and
writes it into the packet:

	offset = skb_checksum_start_offset(skb);
	...
	csum = skb_checksum(skb, offset, skb->len - offset, 0);

	offset += skb->csum_offset;
	...
	*(__sum16 *)(skb->data + offset) = csum_fold(csum) ?: CSUM_MANGLED_0;
out_set_summed:
	skb->ip_summed = CHECKSUM_NONE;

So the L4 checksum the stack later validates is one the receiver itself
generated.  Doesn't that mean corruption introduced anywhere on the NTB
path (bad DMA or memcpy, a misbehaving peer, a wrong csum_start) is turned
into an apparently valid checksum, in both feature states?  In the RXCSUM
on case skb_csum_unnecessary() treats CHECKSUM_PARTIAL with a valid
csum_start as needing no verification, and in the off case the sum is
recomputed locally, so the knob appears to select who spends the CPU
rather than whether the frame is trusted.

Together with the unconditional advertisement in ntb_netdev_start_xmit():

	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;

the capability bit is sent on every frame with no reference to the local
ndev->features & NETIF_F_RXCSUM, and the peer latches it above.  The only
place peer_csum is cleared is a qp link event in
ntb_netdev_event_handler(), so once a peer has latched it there is no
negative advertisement, timeout or renegotiation short of bouncing the
link.

The commit message says:

    Leave the TX and RX checksum features disabled by default. Users can
    just enable them explicitly for links they trust for lower CPU usage
    and/or higher throughput.

Is that accurate for the receive direction, given the receive-side
decision is made entirely by the transmitting peer?  Would gating
NTB_NETDEV_META_CAP_CSUM on the local NETIF_F_RXCSUM state, and dropping
plus counting META_CSUM frames that arrive while RXCSUM is off instead of
repairing them, match the described behaviour better?

Also, in the off case a full software checksum over every payload now runs
in the RX tasklet at the remote peer's discretion, which is the opposite
of the CPU saving the change is aiming for.

> +
> +	ntb_netdev_rx_stats_add(ndev, len);
>  	skb->protocol = eth_type_trans(skb, ndev);
> -	skb->ip_summed = CHECKSUM_NONE;
>  	skb_record_rx_queue(skb, q->qid);
>  
>  	netif_rx(skb);

[ ... ]

> @@ -268,6 +314,7 @@ static const struct ntb_queue_handlers ntb_netdev_handlers = {
>  static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  					 struct net_device *ndev)
>  {
> +	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
>  	struct ntb_netdev *dev = netdev_priv(ndev);
>  	u16 qid = skb_get_queue_mapping(skb);
>  	struct ntb_netdev_queue *q;
> @@ -278,7 +325,17 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
>  		return NETDEV_TX_BUSY;
>  
> -	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (READ_ONCE(dev->peer_csum))
> +			meta |= NTB_NETDEV_META_CSUM |
> +				(skb_checksum_start_offset(skb) <<
> +				 NTB_NETDEV_META_CSUM_START_SHIFT) |
> +				skb->csum_offset;
> +		else if (skb_checksum_help(skb))
> +			goto drop;
> +	}
> +
> +	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, meta);

[ ... ]

> @@ -671,7 +741,8 @@ static int ntb_netdev_probe(struct device *client_dev)
>  
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> -	ndev->hw_features = ndev->features;
> +	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
> +	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;

This is where NETIF_F_RXCSUM becomes a user-visible knob, and the comment
states the bypass is opt-in.  Given the receive path above accepts and
repairs offloaded frames when the bit is clear, does turning
rx-checksumming off actually keep the bypass out of the picture?

>  	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
>  
>  	eth_random_addr(ndev->perm_addr);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp
