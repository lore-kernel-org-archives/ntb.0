Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6F1A6826;
	Thu,  5 Mar 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673218; cv=none; b=PreLQ4DvXAfv3WEGQNLXyMEUbZ5Of3GO188BiIJ13CR/YRCJYoEaUs5ur8ijcmhTJXQ6dmqrwyMo3d882jzsB6M0K/wYmILA2l1j8nMnfjKRCcIuiUXC3o3PnqsofYjFIPLeTxiIr7E1idWyK4IuF8M88CSfbnl0qHwJecj6ZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673218; c=relaxed/simple;
	bh=weiyKpq5MXMGHYFHBO5zGj8yed3VoNRb2J0HyzwTDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV6vMpRlKDtFpiB0hQSdkhwCHBdkTVtFQcXgCyTKFmYaMt13+SwIryvhy1FkuQDO6af3RFQP97ZNUEiL0OedKgccG+dso2glOmV/W0dsD7ASmHldb1dTUcXnk/kdfRRZZDPXRaKGEhW0BlSWUcftMyUGqh4zRcEUqQGO475L7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW+AFmkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW+AFmkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC2EC4CEF7;
	Thu,  5 Mar 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772673218;
	bh=weiyKpq5MXMGHYFHBO5zGj8yed3VoNRb2J0HyzwTDGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FW+AFmkBkXbCWnXFGVqHTfrRSD73MxCMKbqPjq7J6oNNc9FjRLAcC+blornL1cai2
	 9/Qt0gJzfKxkuGvnNibGvMC+Md3Ry70mcAYAW2a9ypi4urDqK69x8RSoKtkZxwfSgL
	 BG91vFt36c1QZXyX2yDX6qKuEZ0tXwz9Cnk0v4fqFilzJV0YC4+/Ohh1MHVfp6IJog
	 31NYHUBA/l7l2iR7caKIAwKpj/+JFYjdfoxCYeONMbQZO5G7TYTZHQ3QtZtEsyYJ6g
	 z3tWOODUCwDSwF5vLy2GUITDUSVlniwgGekasYvkR0pQ//mFzF677Kq5eiAJyVIgaD
	 f25vqTg3gVoKA==
Date: Wed, 4 Mar 2026 17:13:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: ntb_netdev: Introduce per-queue context
Message-ID: <20260304171337.5bc44eef@kernel.org>
In-Reply-To: <20260228145538.3955864-2-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
	<20260228145538.3955864-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 23:55:35 +0900 Koichiro Den wrote:
> @@ -99,7 +114,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
>  static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  				  void *data, int len)
>  {
> -	struct net_device *ndev = qp_data;
> +	struct ntb_netdev_queue *q = qp_data;
> +	struct ntb_netdev *dev = q->ntdev;
> +	struct net_device *ndev = dev->ndev;
>  	struct sk_buff *skb;
>  	int rc;
>  
> @@ -118,6 +135,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  	skb_put(skb, len);
>  	skb->protocol = eth_type_trans(skb, ndev);
>  	skb->ip_summed = CHECKSUM_NONE;
> +	skb_record_rx_queue(skb, q->qid);
>  
>  	if (netif_rx(skb) == NET_RX_DROP) {
>  		ndev->stats.rx_errors++;
> @@ -135,7 +153,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  	}
>  
>  enqueue_again:
> -	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
> +	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,

nit: I think in this case you don't have to replace qp qith q->qp ?
qp is an argument of ntb_netdev_rx_handler()

> @@ -208,16 +227,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  					 struct net_device *ndev)
>  {
>  	struct ntb_netdev *dev = netdev_priv(ndev);
> +	u16 qid = skb_get_queue_mapping(skb);
> +	struct ntb_netdev_queue *q;
>  	int rc;
>  
> -	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
> +	if (unlikely(!dev->num_queues))

please avoid such defensive checks, this should never happen

> +		goto err;
>  
> -	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
> +	if (unlikely(qid >= dev->num_queues))

same, the stack should not sent patches for disabled queues

> +		qid = 0;
> +

>  static void ntb_netdev_tx_timer(struct timer_list *t)
>  {
> -	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
> +	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
> +	struct ntb_netdev *dev = q->ntdev;
>  	struct net_device *ndev = dev->ndev;

nit: if you can't maintain the longest to shortest order because of
dependencies the init should be moved out-of-line

>  static int ntb_netdev_open(struct net_device *ndev)
>  {
>  	struct ntb_netdev *dev = netdev_priv(ndev);
> +	struct ntb_netdev_queue *queue;
>  	struct sk_buff *skb;
> -	int rc, i, len;
> +	unsigned int q;
> +	int rc = 0, i, len;

nit: sort variable declaration lines longest to shortest (there's at
least one more of such issues in this patch)

> @@ -420,6 +485,16 @@ static int ntb_netdev_probe(struct device *client_dev)
>  	dev = netdev_priv(ndev);
>  	dev->ndev = ndev;
>  	dev->pdev = pdev;
> +	dev->client_dev = client_dev;
> +	dev->num_queues = 0;
> +
> +	dev->queues = kcalloc(NTB_NETDEV_MAX_QUEUES, sizeof(*dev->queues),
> +			      GFP_KERNEL);

I think we may be expected to use kzalloc_objs() now


> @@ -464,9 +560,14 @@ static void ntb_netdev_remove(struct device *client_dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(client_dev);
>  	struct ntb_netdev *dev = netdev_priv(ndev);
> +	unsigned int q;
> +
>  

nit double new line
-- 
pw-bot: cr
