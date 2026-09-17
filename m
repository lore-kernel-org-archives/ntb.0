Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E233DEFF0;
	Thu, 17 Sep 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678191; cv=none; b=d23TnzeicK0X76Djqe2U/8tWp13j2eS2q1qAi+IpKtGbk9b4hzWNYI454TKG9gjmilUAlB3zI9pCxC6bpuHZVTTGXzV9T6X+uJ82MwNUGvi0Y9xTfu3gczThdmAb4wwNkOsZuOcCLB9joavTIOtJaHNNQ6X0oUZI9dYmzsKOa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678191; c=relaxed/simple;
	bh=/BJ0QS5jlH64br0ka2MQOyDMVdBvi8GnvwVYD4v0/zg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QA+YRbV3lA8/L0XfY8tcCS00BYW+n5lMVaZumsfGz2FlLJD+vNzqEUNOCI84s8CDYJ6MggvrU8VkFLzsKHd/9iha83hx359ezhZcj35XwShOPXP+fIZQoXEswzXmtRyXMZjVO+zdgT3viJXzttZuaO357Aog2TD/YE+pM3AAb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8LlTWb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8LlTWb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D7A1F00898;
	Thu, 17 Sep 2026 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678189;
	bh=N+YmeDxsn8Mjt3AEO6Az/HUP0aZMhX+SK+CkWg2Ez6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c8LlTWb0Sw79WSnfAaTdgvydXjRPIvLZD8Vqesx2Y9cOfUoQ3pprFbxRJ7MolF2mI
	 t77ia+eMVKChkzWQfJxQwftmswCrPODHLYCIGXpk9aL26aPw/Rqs2omENycTaHKCTW
	 MamtOe9ZBwY+a9Sa+sghTkoZQGBce9O6mXI0R9HJcly+4rYULnZn+QrR19gGzSPTVg
	 WZtLMQZUkvWBgOZuyKF+ZGmrLdoukaotfrV//o630CQAQ+SLdAGS4VasvK4KleSJQR
	 3NVn48EQkSV2H9t+8R/EEqEFyiYATVaf8rLsqmbf3eBwmK1oixkHTmBEl5U8Kfr+z7
	 LNab3Y/rihbkQ==
Subject: Re: [PATCH net-next v4 10/10] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:49:47 +0000
Message-ID: <178967818794.22033.14565840392924332606@kernel.org>
In-Reply-To: <20260914084838.2158249-11-den@valinux.co.jp>
References: <20260914084838.2158249-11-den@valinux.co.jp>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] When TX checksum offload is negotiated (skb->ip_summed ==
  CHECKSUM_PARTIAL and READ_ONCE(q->peer_csum) true),…
- [Low] Growing `struct ntb_netdev_hdr` from 4 to 8 bytes silently
  shrinks the usable MTU by 4 bytes for every user, including users who…
- [Low] ntb_netdev advertises NETIF_F_HW_CSUM in `ndev->hw_features` and
  installs an `ndo_features_check` that calls `vlan_features_check()`,…
- [Low] ntb_netdev_close() flips NETIF_F_RXCSUM (via
  netdev_update_features()) while the NTB transport RX callback…

--

net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

This adds an optional ntb_netdev header that carries csum_start and
csum_offset so CHECKSUM_PARTIAL survives the NTB hop, with receive support
exchanged at QP link-up and a software fallback when the peer does not
advertise it.  Both the TX and RX checksum features stay off by default and
NETIF_F_RXCSUM is frozen while the interface is up.

A few questions below.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 67cfe0f1a49a2..d889c8538be0c 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c

[ ... ]

> @@ -29,12 +30,19 @@ static unsigned int tx_stop = 5;
>  #define NTB_NETDEV_MAX_QUEUES		64
>  #define NTB_NETDEV_DEFAULT_QUEUES	1
>  
> +#define NTB_NETDEV_CAP_CSUM		BIT(0)
> +
>  /* An ntb_netdev_hdr precedes the packet. */
>  #define NTB_NETDEV_META_HDR		BIT(0)
>  
> +#define NTB_NETDEV_HDR_F_CSUM		BIT(0)
> +
>  struct ntb_netdev_hdr {
>  	__le16 len;		/* Header length in bytes, a multiple of 2. */
>  	__le16 flags;
> +	/* From the packet start, excluding this header. */
> +	__le16 csum_start;
> +	__le16 csum_offset;
>  };

[Severity: Low]
Does growing struct ntb_netdev_hdr from 4 to 8 bytes shrink the usable MTU
for everyone, including users who never enable the new opt-in features?

Both the default MTU and the MTU ceiling are derived from sizeof(struct
ntb_netdev_hdr).  In ntb_netdev_probe():

	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN -
		    sizeof(struct ntb_netdev_hdr);

and in ntb_netdev_change_mtu():

	size = new_mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr);
	if (size > ntb_transport_max_size(dev->queues[0].qp))
		return -EINVAL;

With the default transport_mtu of 0x10000, max_size is 65524, so the
default and maximum MTU move from 65506 to 65502.  Would an existing
"ip link set ntb0 mtu 65506" now fail with -EINVAL?  The RX buffer size and
ndev->needed_headroom also grow by 4 bytes unconditionally.

Could the commit message mention this, given it describes the change as
opt-in?

> @@ -189,16 +199,29 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  
>  	skb_put(skb, len + hdr_len);
>  	if (hdr) {
> +		u16 offset = le16_to_cpu(hdr->csum_offset);
> +		u16 start = le16_to_cpu(hdr->csum_start);
>  		u16 flags = le16_to_cpu(hdr->flags);
>  
>  		skb_pull(skb, hdr_len);
> -		if (flags)
> +		if (flags & ~NTB_NETDEV_HDR_F_CSUM)
>  			goto rx_drop;
> +
> +		if (flags & NTB_NETDEV_HDR_F_CSUM) {
> +			if (!(ndev->features & NETIF_F_RXCSUM)) {
> +				ntb_netdev_rx_stats_add(ndev, len);
> +				DEV_STATS_INC(ndev, rx_dropped);
> +				goto rx_free;
> +			}
> +
> +			if (start < ETH_HLEN ||
> +			    !skb_partial_csum_set(skb, start, offset))
> +				goto rx_drop;
> +		}
>  	}

[ ... ]

> @@ -316,6 +340,8 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  	struct ntb_netdev *dev = netdev_priv(ndev);
>  	u16 qid = skb_get_queue_mapping(skb);
>  	struct ntb_netdev_queue *q;
> +	unsigned int hdr_len = 0;
> +	unsigned int meta = 0;
>  	int rc;
>  
>  	q = &dev->queues[qid];
> @@ -323,7 +349,29 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
>  		return NETDEV_TX_BUSY;
>  
> -	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (READ_ONCE(q->peer_csum)) {
> +			struct ntb_netdev_hdr hdr = {
> +				.len = cpu_to_le16(sizeof(hdr)),
> +				.flags = cpu_to_le16(NTB_NETDEV_HDR_F_CSUM),
> +			};
> +
> +			if (skb_cow_head(skb, sizeof(hdr)))
> +				goto drop;
> +
> +			hdr.csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
> +			hdr.csum_offset = cpu_to_le16(skb->csum_offset);
> +			hdr_len = sizeof(hdr);
> +			/* Keep skb->len unchanged for retries and byte accounting. */
> +			memcpy(skb->data - hdr_len, &hdr, hdr_len);
> +			meta = NTB_NETDEV_META_HDR;
> +		} else if (skb_checksum_help(skb)) {
> +			goto drop;
> +		}
> +	}
> +
> +	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data - hdr_len,
> +				      skb->len + hdr_len, meta);

[Severity: Medium]
Should the header only be prepended when skb->len + sizeof(hdr) still fits
the transport frame?

The MTU accounting reserves exactly 8 bytes on top of MTU + ETH_HLEN, so the
on-wire budget equals ntb_transport_max_size() and the default MTU already
sits at that maximum.  If skb->len is larger than ndev->mtu + ETH_HLEN, the
enqueue is rejected in ntb_transport_tx_enqueue():

	if (len > qp->tx_max_frame - sizeof(struct ntb_payload_header))
		return -EMSGSIZE;

-EMSGSIZE is neither -EAGAIN nor -EBUSY, so it lands in the drop path:

drop:
	dev_kfree_skb_any(skb);
	DEV_STATS_INC(ndev, tx_dropped);
	return NETDEV_TX_OK;

Frames slightly over MTU + ETH_HLEN do reach ndo_start_xmit with
CHECKSUM_PARTIAL: __is_skb_forwardable() allows dev->mtu +
dev->hard_header_len + VLAN_HLEN for bridged traffic, and packet_snd()
allows len <= dev->mtu + reserve + VLAN_HLEN while virtio_net_hdr_to_skb()
marks the skb CHECKSUM_PARTIAL.  ntb_netdev_features_check() only clears
NETIF_F_CSUM_MASK for csum_start < ETH_HLEN, so those frames keep
CHECKSUM_PARTIAL and take the header path.

Before this patch such a frame was transmitted with a software checksum;
now it is freed and counted as tx_dropped.  Would falling back to
skb_checksum_help() when the header does not fit preserve the old
behaviour?

> @@ -346,6 +394,28 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> +static netdev_features_t ntb_netdev_features_check(struct sk_buff *skb,
> +						   struct net_device *ndev,
> +						   netdev_features_t features)
> +{
> +	if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +	    skb_checksum_start_offset(skb) < ETH_HLEN)
> +		features &= ~NETIF_F_CSUM_MASK;
> +
> +	return vlan_features_check(skb, features);
> +}

[Severity: Low]
Can vlan_features_check() do anything useful here while ndev->vlan_features
stays at 0?

netif_skb_features() has already masked the features for any tagged skb
before ndo_features_check runs:

net/core/dev.c:netif_skb_features() {
	...
	if (skb_vlan_tagged(skb))
		features = netdev_intersect_features(features,
						     dev->vlan_features |
						     NETIF_F_HW_VLAN_CTAG_TX |
						     NETIF_F_HW_VLAN_STAG_TX);
	...
}

ntb_netdev_probe() only sets ndev->features and ndev->hw_features, so
NETIF_F_HW_CSUM is not in vlan_features and cannot be intersected back in.
vlan_dev_fix_features() derives the VLAN upper device features from
real_dev->vlan_features as well.

Does that mean VLAN traffic (on a VLAN upper device or as tagged frames on
ntb0) always takes the skb_checksum_help() path and never uses the new
header?  Should NETIF_F_HW_CSUM be added to ndev->vlan_features?

[ ... ]

> @@ -420,6 +500,9 @@ static int ntb_netdev_close(struct net_device *ndev)
>  		timer_delete_sync(&queue->tx_timer);
>  	}
>  
> +	/* Apply RX checksum changes deferred while the interface was up. */
> +	netdev_update_features(ndev);
> +
>  	return 0;
>  }

[Severity: Low]
Is ndev->features stable here with respect to the transport RX callback?

netdev_update_features() mutates NETIF_F_RXCSUM while
ntb_netdev_rx_handler() may be reading the same flag from the tasklet:

		if (flags & NTB_NETDEV_HDR_F_CSUM) {
			if (!(ndev->features & NETIF_F_RXCSUM)) {

Nothing in the close path appears to quiesce that tasklet.
ntb_transport_link_down() only clears client_ready, withdraws the QP
readiness bit and sends the link-down descriptor:

drivers/ntb/ntb_transport.c:ntb_transport_link_down() {
	...
	qp->client_ready = false;
	...
	ntb_qp_up_request(qp, false);

	if (qp->link_is_up)
		ntb_send_link_down(qp);
}

tasklet_kill(&qp->rxc_db_work) only appears in ntb_transport_free_queue(),
and the doorbell is not masked, so ntb_transport_rxc_db() ->
ntb_process_rxc() -> qp->rx_handler can still run while
ntb_netdev_close() flips the feature bit.  Frames in flight would then
either get an extra rx_dropped or be pushed to the stack with
CHECKSUM_PARTIAL after RXCSUM was cleared.

Would using the per-QP capability negotiated with the peer instead of the
device-global ndev->features in the RX path avoid this?

> @@ -716,7 +801,8 @@ static int ntb_netdev_probe(struct device *client_dev)
>  
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> -	ndev->hw_features = ndev->features;
> +	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
> +	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
>  	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914084838.2158249-1-den%40valinux.co.jp
