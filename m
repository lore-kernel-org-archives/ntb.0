Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AE3446A6
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035794; cv=none; b=NjP8kMOQWzoFIJyh8x3ci7oMG9w495R7j9bLy8d/QVLsrcIAWY63FmaaMJW9MzJ9/dkk1GcPMO7UDHnqURua6cEN4QCMQxoTzjLwfHLnorHpxVvryM/WZ0E/S0ETICWru3EOAQPsr++EWYhQIMApwMOaQE9zUhqwnwWMQ8DzeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035794; c=relaxed/simple;
	bh=mN0ODw1MRMrRFUYmzLEnqXVDdoDTQ40O6iCvet6+Ws4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HT3Vof3NkawpAG1X6A8VSnfjm5C5E4uOrYTEcCFYbqpBnsf/NNZBlxh5h2plGfGVeZr8cVF2lCnVfN51lK35iqNXd0NhUaYJki4Hdkdpz8BTqHxp7aNjjCvpMtvqeuYUls+MwlSDqrihchwZmDWdCMoGuWJPizmW58EiEwjQNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+hd9BD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+hd9BD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A489D1F00A3E;
	Tue, 18 Aug 2026 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787035792;
	bh=bCthYxbGJ2Mh+Sz2zq79oRgUpW2Zbf7LDe8N6LsB23g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+hd9BD+hJrCIlTRwWEcIJlWAgz5m5CiHIUhhxys9GbUUcsmdcRfh1a/HbK5qA88j
	 jB9sRGw/1pCTSmmVxU26pw+vUSqaqvHZAfyS7xRqTjla3oJaWxP6tfLuPji0g/hcNk
	 3o3oTVGSAdefmrjlHeuj9m9/edUNg0faXfC3pHMtPw/VQVNwLUcGQ28ftHCrKgdyzf
	 OLA2B69Z3WEeWEeb75mSYVrt2xbSf6/crkHdVwgAJ2LG3JX2p/I4LuZNOBD9bq5qwP
	 8qhEIDckwoVDqdvhyuBw1fBM8G9K9YrdCCVrlC+NaV+3+2D0bmuwiChoqJuNytPFbB
	 tgV68WkrTY29w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817064916.13278-5-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:49:52 +0000
Message-Id: <20260818064952.A489D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak of `skb` when transmitting while the NTB =
link is down.
--

--- Patch [4]: [PATCH net-next v2 4/4] net: ntb_netdev: Preserve CHECKSUM_P=
ARTIAL across NTB ---
commit 52574632d1af60a032a3fbef27bc73eb5ad8f90c
Author: Koichiro Den <den@valinux.co.jp>

net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

This commit carries CHECKSUM_PARTIAL with csum_start and csum_offset across
the NTB link to offload checksum calculations to the peer. It advertises
support in every frame and falls back to software until the peer capability
is seen.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 5c7fe6883cb93..9cfb463e472c3 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c

[ ... ]

> @@ -249,6 +288,7 @@ static const struct ntb_queue_handlers ntb_netdev_han=
dlers =3D {
>  static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  					 struct net_device *ndev)
>  {
> +	unsigned int meta =3D NTB_NETDEV_META_CAP_CSUM;

[ ... ]

> -	rc =3D ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		if (READ_ONCE(dev->peer_csum))
> +			meta |=3D NTB_NETDEV_META_CSUM |
> +				(skb_checksum_start_offset(skb) <<
> +				 NTB_NETDEV_META_CSUM_START_SHIFT) |
> +				skb->csum_offset;
> +		else if (skb_checksum_help(skb))
> +			goto drop;
> +	}
> +
> +	rc =3D ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, meta);

[Severity: High]
This is a pre-existing issue, but does this code leak the skb when the NTB
link is down?

Looking at ntb_transport_tx_enqueue() in drivers/ntb/ntb_transport.c, if the
link is down, it returns 0 without taking ownership of the buffer:

drivers/ntb/ntb_transport.c:ntb_transport_tx_enqueue() {
    ...
    /* If the qp link is down already, just ignore. */
    if (!qp->link_is_up)
        return 0;
    ...
}

Since ntb_netdev_start_xmit() sees a return code of 0, it assumes successful
queuing and returns NETDEV_TX_OK without freeing the skb. Because the driver
accepts packets from the networking stack regardless of the physical link
state, sending packets while the link is disconnected appears to cause an
unbounded memory leak.

>  	if (rc)
>  		goto err;
> =20
> @@ -267,12 +317,29 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_=
buff *skb,
> =20
>  	return NETDEV_TX_OK;
> =20
> +drop:
> +	dev_kfree_skb_any(skb);
> +	ndev->stats.tx_dropped++;
> +	ndev->stats.tx_errors++;
> +	return NETDEV_TX_OK;
> +
>  err:
>  	ndev->stats.tx_dropped++;
>  	ndev->stats.tx_errors++;
>  	return NETDEV_TX_BUSY;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817064916.1327=
8-1-den@valinux.co.jp?part=3D4
