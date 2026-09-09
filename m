Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046954078CE;
	Wed,  9 Sep 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985493; cv=none; b=FKyQbNIx1mIcCftlEwBscjpf2R5EN0iuShPpRa6Om87Fihf3A43NH0MzbhpZ/5gFTOYQPBL+4sHIwiV5RoVfUKoDZGZBwGHU+Vmt/YPgycrHSDkh+2O7whwUODjPAc3jNZS9q+TKdMTMsgzJF4yLe3tt8G46zIiK8/fwrEDxU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985493; c=relaxed/simple;
	bh=vA8GQDwEttERFXiEv2exGAUqQps+QEisY3MxnclNaQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/oJgcjfJTRLMtlkZlI5eK0JapcvnZFV73Rz/1tXUbUVBuPIM9s4hLN4TkkdDF5KKDSEZNYXFuYtRXy9DaQ+eBgTGXtQg4SU5EGSG+w33b+w7EB5uhHW4ssw8TNwll0/XW+f0aDMf+wx4rDOKm9J4YMdvKrIpbfTHgodaiCOHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6/di12Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6/di12Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF21F000FF;
	Wed,  9 Sep 2026 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985488;
	bh=MG41yJroXvNsuKMGfaRPWeb3urWGspCK37/9qv09+bg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z6/di12ZEagL2Gdj8XoVRsG32nOuO7efP2OQ6QiCRYZdt2xcs0zq9TgQ0IfvCmFrw
	 QW7HvMIoq1lpoKgDv46yGQybP+/3R507mZsYeOD02njo9TE1PaQ160lXEwTCObkqdn
	 bqTtcTffmhBtzw2UQx52QQDJSX7ivMAatKNOkU795zeCHJIqRk8Be6v3uNODMYkmc4
	 /Bc2R1rV4G+iouRvwbJ3DyESCeWfs1wmOXJiCK0MSjiIRO2gjvhnqCNrxx0e009d+R
	 QF0X0S70RbDCltgh1Y9pPVuQUoxY6OdLbwjfc8cKTb87pazu7pKocUL2qzQSQAEuob
	 sRE1+T6Mrgjcw==
Subject: Re: [PATCH net-next v3 3/4] NTB: ntb_transport: Add per-payload
 client metadata
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: kuba@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 20:24:47 +0000
Message-ID: <178898548739.219967.9364673888469288357@kernel.org>
In-Reply-To: <20260904052134.2970111-4-den@valinux.co.jp>
References: <20260904052134.2970111-4-den@valinux.co.jp>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 1

- [Low] The kernel-doc added for ntb_transport_tx_enqueue() documents the
  new parameter only as '@meta: client metadata to send with the buffer'…

Pre-existing issues:
- [High] Missing barrier / lockless publication of struct ntb_queue_entry
  state in ntb_process_rxc(): entry->rx_hdr, entry->rx_index,…

--

NTB: ntb_transport: Add per-payload client metadata

This adds opaque per-payload client metadata to ntb_transport by carrying
it in the upper 24 bits of the existing payload header flags field, exposed
through ntb_transport_tx_enqueue() and the rx_handler callback. The low
byte stays reserved for transport flags, and ntb_netdev is adapted to the
new interfaces without using metadata.

A couple of questions below, mostly about the receive-side publication of
struct ntb_queue_entry that the new metadata now rides along with.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3f497a62673fd..197376376bff5 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -264,6 +264,10 @@ enum {
>  	LINK_DOWN_FLAG = BIT(1),
>  };
>  
> +/* Reserve the low byte for transport flags. */
> +#define DESC_META_SHIFT		8
> +#define DESC_META_MASK		(~0U << DESC_META_SHIFT)
> +
>  struct ntb_payload_header {
>  	__le32 ver;
>  	__le32 len;
> @@ -1436,6 +1440,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  	struct ntb_queue_entry *entry;
>  	void *cb_data;
>  	unsigned int len;
> +	unsigned int meta;
>  	unsigned long irqflags;
>  
>  	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
> @@ -1451,13 +1456,14 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  
>  		cb_data = entry->cb_data;
>  		len = entry->len;
> +		meta = entry->flags >> DESC_META_SHIFT;
>  
>  		list_move_tail(&entry->entry, &qp->rx_free_q);
>  
>  		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
>  
>  		if (qp->rx_handler && qp->client_ready)
> -			qp->rx_handler(qp, qp->cb_data, cb_data, len);
> +			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);
>  
>  		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
>  	}
> @@ -1656,6 +1662,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  
>  	entry->rx_hdr = hdr;
>  	entry->rx_index = qp->rx_index;
> +	entry->flags = flags & DESC_META_MASK;
>  
>  	if (len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,

[Severity: High]
This isn't a bug introduced by this patch, but the new entry->flags store
joins a group of fields in ntb_process_rxc() that are written after the
entry has already been published onto qp->rx_post_q:

	entry = ntb_list_mv(&qp->ntb_rx_q_lock, &qp->rx_pend_q, &qp->rx_post_q);
	...
	entry->rx_hdr = hdr;
	entry->rx_index = qp->rx_index;
	entry->flags = flags & DESC_META_MASK;

ntb_list_mv() drops qp->ntb_rx_q_lock before returning, so those three
stores run with no lock held. In the receive-overflow branch that follows,
the bit which publishes them is set with nothing in between:

		entry->len = -EIO;
		entry->flags |= DESC_DONE_FLAG;

		ntb_complete_rxc(qp);

Meanwhile ntb_complete_rxc() can already be executing on another CPU for a
preceding entry of the same qp, out of the RX DMA completion callback:

ntb_rx_copy_callback()
	entry->flags |= DESC_DONE_FLAG;
	ntb_complete_rxc(entry->qp);

That call takes qp->ntb_rx_q_lock, pops the completed entry and then looks
at the next entry on rx_post_q, i.e. the one the rxc tasklet is still
filling in, testing the done bit and consuming exactly those fields (now
including the new meta value):

		if (!(entry->flags & DESC_DONE_FLAG))
			break;

		entry->rx_hdr->flags = cpu_to_le32(0);
		iowrite32(entry->rx_index, &qp->rx_info->entry);

		cb_data = entry->cb_data;
		len = entry->len;
		meta = entry->flags >> DESC_META_SHIFT;

Can the DESC_DONE_FLAG store here become visible before the rx_hdr,
rx_index and len stores?  Note ntb_memcpy_rx() does have a wmb() before
reaching the done store:

	memcpy(buf, offset, len);

	/* Ensure that the data is fully copied out before clearing the flag */
	wmb();

	ntb_rx_copy_callback(entry, NULL);

while the overflow path in ntb_process_rxc() has no barrier at all.

Entries are allocated with kzalloc_node() in ntb_transport_create_queue()
and rx_hdr is never initialised there, so on an entry's first use a stale
read would be NULL, which would make

		entry->rx_hdr->flags = cpu_to_le32(0);

a NULL dereference, and iowrite32() would then push a stale rx_index into
qp->rx_info->entry, which the peer uses for ring flow control.

The concurrent completion context requires the RX DMA path (use_dma and a
payload at least copy_bytes), and the barrier-free done store is on the
peer-triggerable path where the peer sends a payload larger than the local
receive buffer.

Since the metadata bits share the flags word with DESC_DONE_FLAG, the read
of meta itself is ordered with the done test, so this patch does not
introduce the ordering gap; it adds one more store into, and one more
consumer of, an already unordered publication.

Would it make sense to fill in the entry fields before ntb_list_mv()
publishes the entry, or to add an explicit write barrier before the
DESC_DONE_FLAG store with a matching read barrier after the done test?

> @@ -2337,6 +2344,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
>   * @cb: per buffer pointer for callback function to use
>   * @data: pointer to data buffer that will be sent
>   * @len: length of the data buffer
> + * @meta: client metadata to send with the buffer
>   *
>   * Enqueue a new transmit buffer onto the transport queue from which a NTB
>   * payload will be transmitted.  This assumes that a lock is being held to

[Severity: Low]
This isn't a bug, but the kernel-doc for @meta in ntb_transport_tx_enqueue()
does not mention that values above NTB_TRANSPORT_MAX_META are rejected,
which the very next lines of the function enforce:

	if (!qp || !len || meta > NTB_TRANSPORT_MAX_META)
		return -EINVAL;

Similarly, the new meta argument of struct ntb_queue_handlers.rx_handler in
include/linux/ntb_transport.h carries no description of its width or of the
fact that peers which do not send metadata always deliver 0.  The
explanation of why the low byte is unavailable only exists as the private
comment in drivers/ntb/ntb_transport.c:

	/* Reserve the low byte for transport flags. */

which clients that only see the exported header do not get.  Could a short
note be added next to @meta and next to the rx_handler prototype?

> @@ -2345,12 +2353,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
>   */
>  int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
> -			     unsigned int len)
> +			     unsigned int len, unsigned int meta)
>  {
>  	struct ntb_queue_entry *entry;
>  	int rc;
>  
> -	if (!qp || !len)
> +	if (!qp || !len || meta > NTB_TRANSPORT_MAX_META)
>  		return -EINVAL;

[ ... ]

> diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
> index 7243eb98a722e..9e807542b6c40 100644
> --- a/include/linux/ntb_transport.h
> +++ b/include/linux/ntb_transport.h
> @@ -50,6 +50,8 @@
>  
>  struct ntb_transport_qp;
>  
> +#define NTB_TRANSPORT_MAX_META	0x00ffffffU
> +
>  struct ntb_transport_client {
>  	struct device_driver driver;
>  	int (*probe)(struct device *client_dev);
> @@ -63,7 +65,7 @@ void ntb_transport_unregister_client_dev(char *device_name);
>  
>  struct ntb_queue_handlers {
>  	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
> -			   void *data, int len);
> +			   void *data, int len, unsigned int meta);
>  	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
>  			   void *data, int len);
>  	void (*event_handler)(void *data, int status);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp
