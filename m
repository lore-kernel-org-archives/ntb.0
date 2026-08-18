Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB94846A
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035792; cv=none; b=q2KVkjwh5blLEvYG34eCQub2YbIFeY1jtOnPkGTk1iX1lBLG6LueXgzyIFtV8I0DVwntxVLdP6JOIvV5Kf54ETQ7dRQh6beBetSU3ouJi2at78o54wQ/I39n0rO8PwoOjCGLwxAk5Oo0775aE67U+lxWyXlH4cvGujOAOt0H0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035792; c=relaxed/simple;
	bh=hfC2tvGYvhtViXPzwq08tSHNJW9xrus/xohK0L+Pi98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bJkV3Dbv8i9I2MQz1pQfVvkf++Lcw9s7HAX6rKg5DMo0Ac2J3HSREIiNQQgoNjRQOLIRTBb0zDHtryKoM0irreiCDCZn5sVs6+sQtnPA1LRWGwqgeOct4wRUxN1QAyrf4bIRrtqmbcGOzgWWnZYuR67foofhl9uVd2dkPEjR3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES3by3MB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES3by3MB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F6B1F00A3A;
	Tue, 18 Aug 2026 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787035791;
	bh=vesk5qfegGBMQZfrd+6RWafp91a7SSt0ybzV0fi7GaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ES3by3MBtLEy4u/UUPzZZyjjsJeu6jZONKjGQ6RNhyseL72eRhrbK/XUUC8wG5AD6
	 OuvRqfuBLGOocBdQrEpQuz1LRh0iab3BDhYpPCh5ATAgEc7glsuLeSuHRSdHX290P9
	 3YhEz8qN02HbNcOp14lNkuwA7KxWzAdgWuQOj9MhhUQ6Y6f4TPTTpeIOwgRZCSOX0H
	 XvaUdW/NPpD8z43/xwvi6jvsUeNpGeVPLMBPg2n6TNBjHaSpchu3vw5wL7JXy5kTQ1
	 T86Gy0fGnwgCKGaQA49aQz4R4l/fnIlcz9bDG+uPN4GU3KJ31yioIGR5a4jJCo6Ddq
	 bWshVg5PRgVjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/4] NTB: ntb_transport: Add per-payload
 client metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817064916.13278-4-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:49:50 +0000
Message-Id: <20260818064950.C2F6B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of SKB when NTB queue link is down during transmit.
- [High] Memory leak of the transmitted SKB when the payload exceeds the ma=
ximum frame size.
- [High] Memory leak of receive buffers (SKBs) if completed when the client=
 is not ready.
--

--- Patch [3]: [PATCH net-next v2 3/4] NTB: ntb_transport: Add per-payload =
client metadata ---
commit 21a42de29f1891a17d65f9eb283c9a3b65134a03
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Add per-payload client metadata

ntb_transport currently carries only payload bytes, with no way for clients
to associate metadata with an individual payload. This patch adapts the
interface to pass metadata in the payload header.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 967a5ad381646..70be06a42201f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1436,6 +1440,7 @@ static void ntb_complete_rxc(struct ntb_transport_q=
p *qp)
>  	struct ntb_queue_entry *entry;
>  	void *cb_data;
>  	unsigned int len;
> +	unsigned int meta;
>  	unsigned long irqflags;
> =20
>  	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
> @@ -1451,13 +1456,14 @@ static void ntb_complete_rxc(struct ntb_transport=
_qp *qp)
> =20
>  		cb_data =3D entry->cb_data;
>  		len =3D entry->len;
> +		meta =3D entry->flags >> DESC_META_SHIFT;
> =20
>  		list_move_tail(&entry->entry, &qp->rx_free_q);
> =20
>  		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
> =20
>  		if (qp->rx_handler && qp->client_ready)
> -			qp->rx_handler(qp, qp->cb_data, cb_data, len);
> +			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);

[Severity: High]
This is a pre-existing issue, but does this lead to a memory leak of receive
buffers (SKBs) if an RX packet completes while the client is not ready?

If ntb_complete_rxc() runs during a link down event (!qp->client_ready), the
function skips invoking the client's rx_handler. However, it moves the entry
to qp->rx_free_q without releasing the client-provided buffer stored in
cb_data.

During teardown, the client uses ntb_transport_rx_remove() to recover unused
buffers, but that function only checks qp->rx_pend_q. Are the buffers left
stranded in rx_free_q permanently lost?

> =20
>  		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
>  	}

[ ... ]

> @@ -2349,12 +2357,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for succ=
ess.
>   */
>  int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void=
 *data,
> -			     unsigned int len)
> +			     unsigned int len, unsigned int meta)
>  {
>  	struct ntb_queue_entry *entry;
>  	int rc;
> =20
> -	if (!qp || !len)
> +	if (!qp || !len || meta > NTB_TRANSPORT_MAX_META)
>  		return -EINVAL;
> =20
>  	/* If the qp link is down already, just ignore. */
>  	if (!qp->link_is_up)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but does returning 0 instead of an error code
cause a memory leak of the SKB when the link is down?

If ntb_transport_tx_enqueue() returns 0, the caller (such as
ntb_netdev_start_xmit()) receives a success code and assumes the buffer
was successfully enqueued, returning NETDEV_TX_OK without calling
dev_kfree_skb_any().

Should this return an error like -ENETDOWN so the caller knows to drop the
packet?

> =20
>  	entry =3D ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
>  	if (!entry) {
> @@ -2370,7 +2378,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_q=
p *qp, void *cb, void *data,
>  	entry->cb_data =3D cb;
>  	entry->buf =3D data;
>  	entry->len =3D len;
> -	entry->flags =3D 0;
> +	entry->flags =3D meta << DESC_META_SHIFT;
>  	entry->errors =3D 0;
>  	entry->tx_index =3D 0;
> =20
>  	rc =3D ntb_process_tx(qp, entry);

[Severity: High]
This is a pre-existing issue, but can this lead to an SKB memory leak when
the payload exceeds the maximum frame size?

When a packet is larger than the NTB transport MTU, ntb_process_tx() handles
the overflow like this:

drivers/ntb/ntb_transport.c:ntb_process_tx() {
	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
		if (qp->tx_handler)
			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);

		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
			     &qp->tx_free_q);
		return 0;
	}
	...
}

Because ntb_process_tx() passes NULL instead of entry->cb_data to the=20
tx_handler, the client (ntb_netdev_tx_handler()) cannot recover and free=20
the SKB. ntb_process_tx() then returns 0, so the original caller also think=
s=20
the packet was enqueued and does not free it.

>  	if (rc)
>  		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
>  			     &qp->tx_free_q);
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817064916.1327=
8-1-den@valinux.co.jp?part=3D3
