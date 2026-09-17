Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262303FF1A5;
	Thu, 17 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678189; cv=none; b=FBXAbzmaTKEE0WaBuCqUReoK8tnKi3snAriPjC+E0EawlwFSelnreFZxf3OLR/Vg6v3K37PaSPh0wwyzH3zQ4PO7w9PEk1pAMFici19VIfj8qfWL6OpRLYo1boBM8efZH6cyLQL7p56M14wrL2n/q5+8/xXcJkCuUj/gmicEnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678189; c=relaxed/simple;
	bh=zsDmhwWHYvoIt/HxpaReoniAaJqVMhzM2NHBm9bMwuk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnqQQvKTZoaHUuLvDiG+6Ea++MVVOM6W3Lpldnwpo2x1xgdt2iEtHNOrFYodIlMd+XmO1qVHDdLDdTEQXQtcBKd0jRMt6/rXddS/w7EwVdSbnW7c6Cl9KPJCfM8bqLCyuBJVuMmuinBxoyU1VLU+mq1E7VdCwc4KmmeffiPnFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsh/tguD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsh/tguD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251441F000FF;
	Thu, 17 Sep 2026 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678187;
	bh=fxSxCTj0CbggTJuh7xoFnDD6RMIDSPTLnDM5wEcmZpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fsh/tguDtDbwVNx5sHNJ6d+KllIVWkBdznKYEJPFssDkdnyU2wlpo/RAq1jpdf8oK
	 9Bsvpoj8jVfWEVd/VKlDFCTk1dXYYkA/T5Y4u7am07YRhuMsHFGdCiy4PzXCgjjeEa
	 G8C9h4lUJZUzR/ClcjiEKdlOxQntwtCM5ATBpKWqN+jM7GE1bD3yC8APX6BLSpMA8n
	 p93DDjN7zDMrRNB9vGj4Mxo5T3Ma92jJSvAnC1m1OzuHCnUpnq9SnX9DoxAqziXUDA
	 f+s+4AOwvG58K6s3SRIgwleNxVGFdBQRKLddmVj6m9p485ZSZ4RDMNjtA0EManAcqi
	 bHqXyLjcV+ZSA==
Subject: Re: [PATCH net-next v4 09/10] net: ntb_netdev: Introduce an optional
 packet header, ntb_netdev_hdr
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:49:46 +0000
Message-ID: <178967818671.22033.983923987727607954@kernel.org>
In-Reply-To: <20260914084838.2158249-10-den@valinux.co.jp>
References: <20260914084838.2158249-10-den@valinux.co.jp>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 2

- [Low] RX buffers are now posted with size = ndev->mtu + ETH_HLEN +
  sizeof(struct ntb_netdev_hdr) (drivers/net/ntb_netdev.c:97 and :158),…
- [Low] In ntb_netdev_rx_handler() the replacement-skb allocation
  (drivers/net/ntb_netdev.c:183) is attempted before hdr->flags is…

Pre-existing issues:
- [High] RX completion handler re-posts an already-allocated skb using a
  receive length recomputed from an unsynchronized read of ndev->mtu.

--

net: ntb_netdev: Introduce an optional packet header, ntb_netdev_hdr

This adds an optional 4-byte ntb_netdev_hdr in front of the packet, marked
by a new client metadata bit, and accounts for it in the TX headroom, the
MTU and the RX buffer sizes. The flags field must be zero for now, with
checksum metadata coming in the next patch.

A few questions on the RX path below.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index cddfe8d63fc18..67cfe0f1a49a2 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -29,6 +29,14 @@ static unsigned int tx_stop = 5;
>  #define NTB_NETDEV_MAX_QUEUES		64
>  #define NTB_NETDEV_DEFAULT_QUEUES	1
>  
> +/* An ntb_netdev_hdr precedes the packet. */
> +#define NTB_NETDEV_META_HDR		BIT(0)
> +
> +struct ntb_netdev_hdr {
> +	__le16 len;		/* Header length in bytes, a multiple of 2. */
> +	__le16 flags;
> +};
> +
>  struct ntb_netdev;
>  
>  struct ntb_netdev_queue {
> @@ -83,15 +91,16 @@ static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
>  				    struct ntb_netdev_queue *queue)
>  {
>  	struct sk_buff *skb;
> +	unsigned int size;
>  	int rc, i;
>  
> +	size = ndev->mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr);
>  	for (i = 0; i < NTB_RXQ_SIZE; i++) {
> -		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
> +		skb = netdev_alloc_skb(ndev, size);
>  		if (!skb)
>  			return -ENOMEM;
>  
> -		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
> -					      ndev->mtu + ETH_HLEN);
> +		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data, size);
>  		if (rc) {
>  			dev_kfree_skb(skb);
>  			return rc;
> @@ -137,34 +146,57 @@ static void ntb_netdev_rx_stats_add(struct net_device *ndev,
>  static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  				  void *data, int len, unsigned int meta)
>  {
> +	const struct ntb_netdev_hdr *hdr = NULL;
>  	struct ntb_netdev_queue *q = qp_data;
>  	struct ntb_netdev *dev = q->ntdev;
> +	unsigned int size, hdr_len = 0;
>  	struct sk_buff *skb, *new_skb;
>  	struct net_device *ndev;
>  	int rc;
>  
>  	ndev = dev->ndev;
> +	size = ndev->mtu + ETH_HLEN + sizeof(*hdr);
>  	skb = data;
>  	if (!skb)
>  		return;
>  
>  	netdev_dbg(ndev, "%s: %d byte payload received\n", __func__, len);
>  
> +	/* Validate the frame and optional header lengths. */
>  	if (len < ETH_HLEN) {
>  		DEV_STATS_INC(ndev, rx_errors);
>  		DEV_STATS_INC(ndev, rx_length_errors);
>  		goto enqueue_again;
>  	}
> +	if (meta & NTB_NETDEV_META_HDR) {
> +		hdr = (void *)skb->data;
> +		hdr_len = le16_to_cpu(hdr->len);
> +		if (hdr_len < sizeof(*hdr) || !IS_ALIGNED(hdr_len, 2) ||
> +		    hdr_len > len - ETH_HLEN) {
> +			DEV_STATS_INC(ndev, rx_errors);
> +			DEV_STATS_INC(ndev, rx_length_errors);
> +			goto enqueue_again;
> +		}
> +		len -= hdr_len;
> +	}

[Severity: Low]
Now that ntb_netdev_queue_rx_fill() and ntb_netdev_rx_handler() post
buffers of ndev->mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr), and the
only length gate in ntb_netdev_rx_handler() is the len < ETH_HLEN test,
what rejects an over-MTU frame when the peer does not set
NTB_NETDEV_META_HDR?

Before this change the posted buffer was exactly mtu + ETH_HLEN, so
ntb_process_rxc() dropped such a frame:

	if (len > entry->len) {

and the driver counted rx_length_errors. With the extra reservation, a
frame of up to mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr) now fits the
buffer, so it is skb_put() and handed to netif_rx() as a good packet, i.e.
4 bytes over the configured MTU here and 8 bytes by the end of the series.
The len -= hdr_len subtraction that would re-bound the payload never runs
in that case.

The two sides of the link are configured independently, so a peer with a
larger MTU reaches this. Still present at the end of the series
(a68dfbeaf017).

>  
> -	ntb_netdev_rx_stats_add(ndev, len);
> -
> -	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
> +	new_skb = netdev_alloc_skb(ndev, size);
>  	if (!new_skb) {
> +		ntb_netdev_rx_stats_add(ndev, len);
>  		DEV_STATS_INC(ndev, rx_dropped);
>  		goto enqueue_again;
>  	}

[Severity: Low]
The replacement skb is allocated before hdr->flags is checked. When
netdev_alloc_skb() fails, is a frame carrying a non-zero flags value
counted as a successfully received packet?

This path calls ntb_netdev_rx_stats_add(ndev, len) plus rx_dropped and goes
straight to enqueue_again, skipping the validation added just below:

	if (hdr) {
		u16 flags = le16_to_cpu(hdr->flags);

		skb_pull(skb, hdr_len);
		if (flags)
			goto rx_drop;
	}

So whether a malformed frame ends up in rx_errors depends on whether the
atomic allocation happened to succeed. Would moving the flags check ahead
of the allocation keep the classification consistent? The same ordering
also bypasses the checksum metadata validation added later in the series
(a68dfbeaf017).

>  
> -	skb_put(skb, len);
> +	skb_put(skb, len + hdr_len);
> +	if (hdr) {
> +		u16 flags = le16_to_cpu(hdr->flags);
> +
> +		skb_pull(skb, hdr_len);
> +		if (flags)
> +			goto rx_drop;
> +	}
> +
> +	ntb_netdev_rx_stats_add(ndev, len);
>  	skb->protocol = eth_type_trans(skb, ndev);
>  	skb->ip_summed = CHECKSUM_NONE;
>  	skb_record_rx_queue(skb, q->qid);
> @@ -174,12 +206,19 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  	skb = new_skb;
>  
>  enqueue_again:
> -	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
> +	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, size);
>  	if (rc) {
>  		dev_kfree_skb_any(skb);
>  		DEV_STATS_INC(ndev, rx_errors);
>  		DEV_STATS_INC(ndev, rx_fifo_errors);
>  	}
> +	return;
> +
> +rx_drop:
> +	DEV_STATS_INC(ndev, rx_errors);
> +	dev_kfree_skb_any(skb);
> +	skb = new_skb;
> +	goto enqueue_again;
>  }

[Severity: High]
This isn't a bug introduced by this patch, since the baseline already
re-posted the original skb with a length derived from ndev->mtu, but the
patch touches these lines and adds new peer-triggerable ways to reach
enqueue_again with the original buffer (bad hdr_len, and the flags path).

Can the size computed at the top of ntb_netdev_rx_handler():

	size = ndev->mtu + ETH_HLEN + sizeof(*hdr);

describe a buffer larger than the skb actually being re-posted here?

ntb_netdev_change_mtu() drains only rx_pend_q through
ntb_transport_rx_remove():

	entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);

while an entry whose copy is already in progress has been moved to
rx_post_q by ntb_process_rxc(), and ntb_complete_rxc() drops the RX queue
lock before invoking the client callback:

	spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);

	if (qp->rx_handler && qp->client_ready)
		qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);

So after an MTU increase, a handler still holding an skb allocated for the
old, smaller MTU reads the new, larger ndev->mtu into size, and on any
enqueue_again path re-posts that small buffer while declaring the new
capacity. The transport bounds the next incoming frame only against the
declared entry->len in ntb_process_rxc():

	if (len > entry->len) {

Can a following frame then be copied past the end of that undersized skb,
and can skb_put(skb, len + hdr_len) in the handler push skb->tail beyond
skb->end?

The mirror case, an MTU decrease, declares a smaller length than the
buffer really provides and just drops otherwise valid frames.

Would it be better to take the re-post length from the skb itself
(skb_tailroom(), or a length recorded when the buffer was allocated) and
serialize the resize against RX callbacks? A plain READ_ONCE() of
ndev->mtu would not close this. Still present at the end of the series
(a68dfbeaf017).

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> @@ -390,9 +429,11 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
>  	struct ntb_netdev_queue *queue;
>  	struct sk_buff *skb;
>  	unsigned int q, i;
> +	unsigned int size;
>  	int len, rc = 0;
>  
> -	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
> +	size = new_mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr);
> +	if (size > ntb_transport_max_size(dev->queues[0].qp))
>  		return -EINVAL;
>  
>  	if (!netif_running(ndev)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914084838.2158249-1-den%40valinux.co.jp
