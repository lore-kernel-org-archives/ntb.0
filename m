Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0E20125F
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031344; cv=none; b=M+WSntsp0PMkhVcfsEaPy1aGgJqm7XU6c4JHWtqIQo6XWPP9Vm4jQ8uB1HHfmCwpqiV01TgJTOCDnZVgC65KD/aCGEtAFTLpO3WQVGxmIA7MUDYbt0Quq+pv7Led8GBjifZB7I4ZYN+L5xJQMG0ch0y+nQ0yYa6dk6ENgKpQWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031344; c=relaxed/simple;
	bh=tGBD1kG9uMD2lZ7A+6kYQMMBk49h401FIe9SKHCSekw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CCVhki1/FD9drF+n0XEAv/TEaEa67tEKCeLArvRdQr29DxZhmoyeB8qS8juhCRXqJ177ofjVryuP9iLjHyWvWmlVaoydPl0T5MBWbVs3K4W5x788OxSnqRtpv0P2h1Op5U1IzLQdYwMLtCeF3h0SYvQFITJjk6gr29ZMZtzN294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWszsLkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWszsLkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC751F00A3D;
	Tue, 18 Aug 2026 05:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031342;
	bh=f6pK+V/fmtrFO7nH3dt8yeBviw7/1H+AUn6wyRGefV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWszsLkX1pQurCSjsrZiaTC5m6+DfQPZh9DBidmAwwX+4pACPSDKmyAbaID6ZzNae
	 uAHTGG8EKrgTWZ2TIX3e+tuiR2kBoLdEmmoXk2615xFcNi6YqqCFxA0HfnZS36L/K5
	 JXOLACkKmoVDoJ2GE69fSuC0cRk9wmKGRE0WSvlhfI8z9UO2JteiVwHeS7taZFXsPv
	 UG+guafLO5qWtFK1dyZsKrFX2SodFsKIoTEIz99zWmcoSx/dWBaeBT32YwXfUQBTRV
	 YXV1V96DCSK1Dx5LzxpU3P+AQyrk8p0pu2rBifjv7eu9N3xOKD+TtHGYCKm1Z0a//w
	 ifXUys/5q50sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/4] NTB: ntb_transport: Fail TX enqueue when the QP
 link is down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817053519.4135287-4-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 05:35:42 +0000
Message-Id: <20260818053542.9EC751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race and state corruption during concurrent link down and pac=
ket transmission.
- [Medium] Silent memory leak of SKBs when the QP link transitions down.
--

--- Patch [3]: [PATCH net 3/4] NTB: ntb_transport: Fail TX enqueue when the=
 QP link is down ---
commit d31ae522b81066694c3712e62ed7ae6b70c6a06a
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Fail TX enqueue when the QP link is down

Commit f195a1a6fe41 meant to make ntb_transport_tx_enqueue() drop packets
submitted while the qp link is down, but it only returns 0 without
consuming the packet. This patch returns an error instead, restoring the
contract that a non-zero return leaves the buffer owned by the caller.

Fixes: f195a1a6fe41 ("ntb: Drop packets when qp link is down")
Cc: stable@vger.kernel.org

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index e92b96f4afad8..4bdd81edcb87a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2353,9 +2353,8 @@ int ntb_transport_tx_enqueue(struct ntb_transport_q=
p *qp, void *cb, void *data,
>  	if (!qp || !len)
>  		return -EINVAL;
> =20
> -	/* If the qp link is down already, just ignore. */
>  	if (!qp->link_is_up)
> -		return 0;
> +		return -ENOLINK;

[Severity: High]
This isn't a bug introduced by this patch, but does the lockless qp reset in
ntb_transport_link_down() race with concurrent packet transmission?

If an administrator changes the mtu, ntb_netdev_change_mtu() calls
ntb_transport_link_down() without first stopping the tx queues via
netif_tx_disable():

drivers/net/ntb_netdev.c:ntb_netdev_change_mtu() {
	/* Bring down the link and dispose of posted rx entries */
	for (q =3D 0; q < dev->num_queues; q++)
		ntb_transport_link_down(dev->queues[q].qp);
}

Concurrently, the network stack can call ntb_netdev_start_xmit() and reach
ntb_transport_tx_enqueue(), which processes tx entries.
Meanwhile, ntb_transport_link_down() triggers ntb_send_link_down() and
ntb_qp_link_down_reset(), which resets qp->tx_index to 0 locklessly.

drivers/ntb/ntb_transport.c:ntb_send_link_down() {
	rc =3D ntb_process_tx(qp, entry);
	...
	ntb_qp_link_down_reset(qp);
}

Since ntb_async_tx() writes to tx_index without synchronization:

drivers/ntb/ntb_transport.c:ntb_async_tx() {
	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
}

Could this lead to concurrent modifications of qp->tx_index, qp->tx_pkts, a=
nd
hardware io memory window corruption?

[Severity: Medium]
This is a pre-existing issue, but does dropping the client_ready flag in
ntb_transport_link_down() cause a silent memory leak of skb objects?

When the interface link goes down, ntb_transport_link_down() disables the
client:

drivers/ntb/ntb_transport.c:ntb_transport_link_down() {
	qp->client_ready =3D false;
}

Later, the receive tasklet ntb_complete_rxc() processes dma completions from
rx_post_q. Since client_ready is false, it skips calling the network receive
handler that would normally free the skb:

drivers/ntb/ntb_transport.c:ntb_complete_rxc() {
		if (qp->rx_handler && qp->client_ready)
			qp->rx_handler(qp, qp->cb_data, cb_data, len);
}

The cleanup function only drains rx_pend_q:

drivers/ntb/ntb_transport.c:ntb_transport_rx_remove() {
	entry =3D ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);
}

Does this leave skb objects in rx_post_q stranded without being freed?

> =20
>  	entry =3D ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
>  	if (!entry) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817053519.4135=
287-1-den@valinux.co.jp?part=3D3
