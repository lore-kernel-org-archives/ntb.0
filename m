Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701347B413;
	Tue, 18 Aug 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070464; cv=none; b=d27sZjyyM5dAiau0ya9ns5+bg8h8D4Iep+CGKclKVe3m0SXVaLkaooWWNL6C95g8flIXxVIyYpB74k0SSNc+UP8WtsRGPv8koVlXAl7JnLQumuaT0G8ixkWjxQSHP8aWlegnIpYkq/IXW3q9sHl3oYxdG7aAsMRh87bkhbCG2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070464; c=relaxed/simple;
	bh=EuuglWPFgCsHEsorwXoh4oZef2iCsU107ulh2a8Sk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvkPysCdKGMB4VV5HZ/UYpEvpFcL4g9QLs+QKkG2k4FvnYxMO3ZSjsZSAlP4MaUq343kTqKs3M/rMFjV1O/YD4DYVc6J18Fgx+UmWen2lLXxr81l8kdA0DVSb8Kg9ziW9yLuJllvrEvu6RahHaDEFsg+Xyh150uSv17LY5uVeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edXwfoR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edXwfoR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB81F000E9;
	Tue, 18 Aug 2026 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070462;
	bh=7qyXEHRIzL5ub2Z020Io0fMnItzLx939D2rpddcw+Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edXwfoR6Yz7gSAECoaxVEQkgcWlpH6ST/Okf6qZB+uLw7Dqjua82iinY+ei2xUPki
	 /hduiqQMVgm7I2vO575BpNmDXj/bushOFYHy3BHQPm2VVMhU9ocZZGg8YCrqgIsXgr
	 nv1hLUvgFA5QJv1MgAwtDtsUVhkmmTIgRveAll9Ohi/P6+wAOHW1+JtrmiRm43Sg7F
	 nGF/qs0L8UlWMjpLh0paLtzffumt5uaqVRml8dbtVBNiXHrneYY4XWWIxGxW9a8Apo
	 +Ru6C2xzjczYClVfF8qBXyjgOq+fB32KAFFmfcEO2YRDQH/vt0BEkNTPcm3D1BNr4t
	 5G5oNBTg5KLvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: den@valinux.co.jp
Cc: Jakub Kicinski <kuba@kernel.org>,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
Date: Tue, 18 Aug 2026 09:27:41 -0700
Message-ID: <20260818162741.3982261-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814032913.3558500-3-den@valinux.co.jp>
References: <20260814032913.3558500-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

This carries CHECKSUM_PARTIAL (csum_start and csum_offset) in the NTB
transport metadata word so that L4 checksums do not have to be computed
on either side of the link. A capability bit is advertised on every
transmitted frame, and both TX and RX checksum offload are left off by
default and exposed through hw_features so users can opt in.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 5c7fe6883cb93..b9a78ff695c87 100644
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
> @@ -108,6 +125,8 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
>  	struct net_device *ndev;
>  
>  	ndev = dev->ndev;
> +	if (!link_is_up)
> +		WRITE_ONCE(dev->peer_csum, false);
>  
>  	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
>  		   ntb_transport_link_query(q->qp), q->qid);
> @@ -151,8 +170,21 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  	}
>  
>  	skb_put(skb, len);
> +	if (meta & NTB_NETDEV_META_CAP_CSUM)
> +		WRITE_ONCE(dev->peer_csum, true);

[Severity: Medium]
Can the clear of dev->peer_csum in ntb_netdev_event_handler() be lost
against this set in ntb_netdev_rx_handler()?

The two writes run from different contexts with no common lock, and
WRITE_ONCE() only prevents tearing:

CPU0 (workqueue, ntb_qp_link_cleanup() -> qp->event_handler())
	ntb_netdev_event_handler(link_is_up = 0)
	    WRITE_ONCE(dev->peer_csum, false);

CPU1 (rx tasklet, ntb_complete_rxc() -> qp->rx_handler(), called after
      spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags))
	ntb_netdev_rx_handler()
	    WRITE_ONCE(dev->peer_csum, true);   /* stale frame */

ntb_qp_link_context_reset() only sets qp->active = false, which gates
future tasklet_schedule() calls; tasklet_kill(&qp->rxc_db_work) happens
only in ntb_transport_free_queue(). So an rx callback from the previous
link generation can still run after, or overlap with, the clear.

Since there is no matching re-initialisation on the link-up transition
(ntb_qp_link_work() just calls the event handler with link_is_up = 1),
does the stale true then persist? After reconnecting to a peer that
ignores the metadata word, ntb_netdev_start_xmit() would read true, set
NTB_NETDEV_META_CSUM and skip skb_checksum_help(), so frames leave with
only a pseudo-header checksum and the old peer's stack drops them without
incrementing any counter on either side. Would tying the flag to a link
generation, or clearing it unconditionally in the event handler
(including on link-up), close this?

> +
> +	if (meta & NTB_NETDEV_META_CSUM) {
> +		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
> +		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
> +
> +		if (!skb_partial_csum_set(skb, csum_start, csum_offset))
> +			goto rx_drop;

[Severity: High]
Is csum_start validated enough here? It is a full 16-bit peer-supplied
value, and skb_partial_csum_set() only bounds it against the frame as
received:

net/core/skbuff.c:skb_partial_csum_set() {
	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
	u32 csum_start = skb_headroom(skb) + (u32)start;

	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb)))
		...
		return false;
	skb->ip_summed = CHECKSUM_PARTIAL;
	skb->csum_start = csum_start;
	...
}

So csum_start = 0 with csum_offset = 16 is accepted. eth_type_trans()
then pulls ETH_HLEN, and skb_checksum_start_offset() becomes negative
(start - 14) while ip_summed stays CHECKSUM_PARTIAL when
NETIF_F_RXCSUM is enabled.

The other consumer of untrusted partial-checksum metadata rejects this
explicitly:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
		if (!skb_partial_csum_set(skb, start, off))
			return -EINVAL;
		if (skb_transport_offset(skb) < nh_min_len)
			return -EINVAL;
}

Downstream, a negative offset is not caught cleanly. skb_checksum_help()
compares the signed offset against unsigned skb_headlen() and fires
WARN_ONCE() plus skb_dump(), which a peer can trigger at will (fatal
with panic_on_warn). And skb_copy_and_csum_dev() does:

net/core/skbuff.c:skb_copy_and_csum_dev() {
	long csstart;

	if (skb->ip_summed == CHECKSUM_PARTIAL)
		csstart = skb_checksum_start_offset(skb);
	...
	BUG_ON(csstart > skb_headlen(skb));

	skb_copy_from_linear_data(skb, to, csstart);
}

The BUG_ON does not trigger for a negative csstart on 64-bit (the
unsigned int result is promoted to long), and the length parameter is
unsigned:

include/linux/skbuff.h:skb_copy_from_linear_data() {
	memcpy(to, skb->data, len);   /* const unsigned int len */
}

Can that turn a negative csstart into a multi-gigabyte memcpy into a
fixed-size driver TX buffer? Drivers that advertise checksum offload and
call this helper unconditionally still exist (8139too sets
NETIF_F_HW_CSUM in rtl8139_init_one() and calls skb_copy_and_csum_dev()
from rtl8139_start_xmit(); sc92031 fakes NETIF_F_IP_CSUM the same way),
so skb_csum_hwoffload_help() will not sanitize the skb first. A negative
offset survives to egress whenever the ingress pull exceeds the egress
push, for example locally terminated IPIP/GRE
(__iptunnel_pull_header() advances skb->data via skb_pull_rcsum() and
iptunnel_pull_offloads() leaves ip_summed alone) followed by forwarding
the inner packet out such a NIC.

Would a check that skb_transport_offset(skb) leaves room for the
Ethernet and L3 headers, mirroring the virtio_net one, be appropriate
here?

> +
> +		if (!(ndev->features & NETIF_F_RXCSUM) &&
> +		    skb_checksum_help(skb))
> +			goto rx_drop;
> +	}
>  	skb->protocol = eth_type_trans(skb, ndev);
> -	skb->ip_summed = CHECKSUM_NONE;
>  	skb_record_rx_queue(skb, q->qid);
>  
>  	if (netif_rx(skb) == NET_RX_DROP) {

[ ... ]

> @@ -252,13 +292,24 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  	struct ntb_netdev *dev = netdev_priv(ndev);
>  	u16 qid = skb_get_queue_mapping(skb);
>  	struct ntb_netdev_queue *q;
> +	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
>  	int rc;
>  
>  	q = &dev->queues[qid];
>  
>  	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
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
>  	if (rc)
>  		goto err;

[Severity: High]
This isn't a bug introduced by this patch, since the baseline already
treated rc == 0 as a completed handoff with meta = 0, but does the
rc == 0 path here leak the skb when the QP link is going down?

drivers/ntb/ntb_transport.c:ntb_transport_tx_enqueue() {
	/* If the qp link is down already, just ignore. */
	if (!qp->link_is_up)
		return 0;

	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
	...
	entry->cb_data = cb;
}

The early return happens before entry->cb_data = cb, so the transport
never records the skb and ntb_netdev_tx_handler() -- the only place that
calls dev_kfree_skb_any() for a transmitted skb -- is never invoked for
it. start_xmit() then returns NETDEV_TX_OK without freeing.

The window looks reachable: qp->link_is_up is cleared in
ntb_qp_link_context_reset() before ntb_netdev_event_handler() stops the
subqueue, and both __ntb_netdev_maybe_stop_tx() and
ntb_netdev_tx_timer() re-open the queue based on a check-then-act
ntb_transport_link_query():

		if (__netif_subqueue_stopped(ndev, q->qid) &&
		    ntb_transport_link_query(q->qp))
			netif_wake_subqueue(ndev, q->qid);

Would repeated peer link flaps then leak one sk_buff per racing packet?
With this patch each leaked skb can additionally carry a freshly
allocated linear buffer, because skb_checksum_help() may reallocate the
head via pskb_expand_head() just before the enqueue.

[ ... ]
-- 
pw-bot: cr
