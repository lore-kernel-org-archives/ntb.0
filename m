Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9A246781
	for <ntb@lists.linux.dev>; Sat,  5 Sep 2026 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585722; cv=none; b=KeTMxRUT3zSXsOdM6wTdGdby83OKaJNouuJ/bcqSCLRzOut4MFTWD0ntsQ8nc3bWWu4QQ0GoZMe4v10Fl3+8U+SWmJad1Un8s/ybiTgkFsKH54gzo1CQ7721PNB07MpY9EG3InVNfDZ//8+x4z+H1eU2GhJ9rVO7d0H0oJF8e4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585722; c=relaxed/simple;
	bh=UELAbrHXWpB6aWa2KFMMgBzIb+A54c7uJIXpJAtlsFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pw6swwihvj4g4LLYdGJ6/NkKtCdcPOOyCEe2x/AJNY6zgRouUaYiW6VUXo3NwemturpqhjjaovH+QlGeHVqkspRNdIb6IAkTeJTf5DOpTNhlviLtp0l6nEGci2EkqnFqqhsP/B8yPzWL4jn2Lhf39kAu7xkFJNAjsCP0Z5vz3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfBSmC6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfBSmC6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C231F00A3D;
	Sat,  5 Sep 2026 05:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788585721;
	bh=tlQCqN0ghK5RjNHJXzb/jafyfCJM1XeHyXxmMo94Ew8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfBSmC6H0/Qh2w0g04YF9wSNSI6kr/WJkDrhp9rRDXv+iTtfmP+qVRKBU5ZRhssbs
	 Crnfx69Eru3EGKRXMb4CN5Uia802rhIwu8YHo1BK+ZB6IDOHmnMg2G1TcniEg6M122
	 y1fTmw4bZof1G7LlIWLOsXbdOxNtpeVEv4ZwPk8kO0poaIAF75ekL5Kv+DJTPYyEsm
	 ymdosyOx8ZAWCdbQPI6uBQISI+r0YA+zPVgFxVFauEk2rue5jead3KRI8q+/RkOKvB
	 JouQ4QSKRf3X29S55b9iQvFO+4KlAQkaz1fy7i7c4IuUzQsL/th+3wMs+WtK47cbk0
	 ACqSgzGHaqeHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/4] NTB: ntb_transport: Order RX descriptor
 reads after completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260904052134.2970111-2-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 05:22:00 +0000
Message-Id: <20260905052200.D6C231F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Inbound memory windows are freed during link down cleanup with=
out synchronizing with the receive tasklet or terminating in-flight DMA ope=
rations.
- [High] In-flight DMA transactions are not terminated on link down, causin=
g stale DMA completions to corrupt the queue state of the subsequent link s=
ession.
- [High] An unhandled version mismatch in `ntb_process_rxc` causes a perman=
ent stall of the receive queue.
- [High] In-flight DMA descriptors and their associated `ntb_queue_entry` s=
tructures are permanently leaked during QP teardown.
- [High] Broken DMA channel synchronization causes false timeouts and aband=
oned TX transactions during teardown.
- [High] Client data buffers (SKBs) are silently leaked when `tx_offl_q` an=
d `rx_post_q` entries are freed during teardown.
- [High] DMA abort fallback copies the wrong memory payload due to improper=
 index tracking.
- [Medium] Lockless modification of `entry->len` and `entry->flags` lacks m=
emory barriers, potentially hiding overflow errors from the client.
--

commit 3308bb067cf3d0b798b94e6f70b47a7f9378fbae
Author: Koichiro Den <den@valinux.co.jp>
NTB: ntb_transport: Order RX descriptor reads after completion

This commit introduces a memory barrier after observing the DESC_DONE_FLAG =
in
ntb_process_rxc() to ensure that the descriptor and payload reads are prope=
rly
ordered on weakly ordered CPUs. It reads the completion word once and uses =
the
saved value for subsequent transport flag checks.

Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..74f4f8c1c7be8 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_q=
p *qp)
>  {
>  	struct ntb_payload_header *hdr;
>  	struct ntb_queue_entry *entry;
> +	unsigned int flags;
>  	void *offset;
> =20
>  	offset =3D qp->rx_buff + qp->rx_max_frame * qp->rx_index;
>  	hdr =3D offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
> =20
> -	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> -		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
> -
> -	if (!(hdr->flags & DESC_DONE_FLAG)) {
> +	flags =3D READ_ONCE(hdr->flags);
> +	if (!(flags & DESC_DONE_FLAG)) {
>  		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
>  		qp->rx_ring_empty++;
>  		return -EAGAIN;
>  	}
> =20
> -	if (hdr->flags & LINK_DOWN_FLAG) {
> +	dma_rmb();
> +
> +	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> +		qp->qp_num, hdr->ver, hdr->len, flags);
> +
> +	if (flags & LINK_DOWN_FLAG) {
>  		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
>  		ntb_qp_link_down(qp);
>  		hdr->flags =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but does an unhandled version
mismatch in ntb_process_rxc() cause a permanent stall?

In ntb_process_rxc():
	if (ver !=3D (u32)qp->rx_pkts) {
		dev_dbg(&qp->ndev->pdev->dev,
			"version mismatch, expected %llu - got %u\n",
			qp->rx_pkts, ver);
		qp->rx_err_ver++;
		return -EIO;
	}

If this check fails, the function returns -EIO and the caller breaks out
of its loop without advancing qp->rx_index or clearing DESC_DONE_FLAG.
Will the next tasklet execution evaluate the exact same descriptor,
encounter the same error, and loop indefinitely?

[Severity: Medium]
This is a pre-existing issue, but do the lockless modifications of
entry->len and flags in ntb_process_rxc() require a memory barrier?

In ntb_process_rxc() during a buffer overflow event:
		entry->len =3D -EIO;
		entry->flags |=3D DESC_DONE_FLAG;

		ntb_complete_rxc(qp);

These fields are set locklessly on an entry that is already publicly
accessible in rx_post_q. Without an smp_wmb(), could a concurrent
execution of ntb_complete_rxc() observe the DESC_DONE_FLAG but read a
stale entry->len, falsely reporting a successful transfer to the client?

[Severity: High]
This is a pre-existing issue, but does ntb_qp_link_cleanup() fail to
terminate in-flight DMA operations during a link reset?

In ntb_qp_link_cleanup():
	cancel_delayed_work_sync(&qp->link_work);
	ntb_qp_link_down_reset(qp);

	if (qp->event_handler)

If a pending DMA transaction completes asynchronously after this reset, it
triggers the callback, appending to qp->rx_post_q and calling
ntb_complete_rxc():

	entry->rx_hdr->flags =3D cpu_to_le32(0);
	iowrite32(entry->rx_index, &qp->rx_info->entry);

Could this stale DMA completion overwrite the reset state with an old
index, corrupting the peer's calculation of available free space and
permanently halting communication?

[Severity: High]
This isn't a bug introduced by this patch, but are in-flight DMA descriptors
and their ntb_queue_entry structures permanently leaked during QP teardown?

In ntb_transport_free_queue():
		dma_sync_wait(chan, qp->last_cookie);
		dmaengine_terminate_all(chan);

When dmaengine_terminate_all() aborts pending transfers, the associated
callbacks are not executed. Since entries are removed from qp->tx_free_q
during submission and only restored by the callback, do these active queue
entries leak permanently?

[Severity: High]
This is a pre-existing issue, but does the TX channel teardown wait on the
wrong DMA cookie?

In ntb_transport_free_queue(), the code synchronizes on the TX channel:
		dma_sync_wait(chan, qp->last_cookie);

However, qp->last_cookie is exclusively updated in ntb_async_rx_submit():
	qp->last_cookie =3D cookie;

If the RX cookie exceeds the TX channel's highest cookie, will
dma_sync_wait() erroneously timeout and forcefully abort healthy TX
transactions?

[Severity: High]
This isn't a bug introduced by this patch, but does ntb_transport_free_queu=
e()
silently leak client data buffers (like SKBs) when freeing entries?

	while ((entry =3D ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
		kfree(entry);
	}

And similarly for TX offload:
	while ((entry =3D ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
		kfree(entry);

Since the driver nullifies the handlers before this loop, and freeing the
entry doesn't reclaim entry->cb_data, are these client buffers permanently
leaked?

[Severity: High]
This is a pre-existing issue, but does the CPU fallback copy the wrong
memory payload during a DMA abort?

In ntb_rx_copy_callback():
			void *offset =3D qp->rx_buff + qp->rx_max_frame *
					qp->rx_index;

This computes the source offset using the globally advanced qp->rx_index.
Because qp->rx_index is advanced globally in ntb_process_rxc() right
after DMA submission, won't it point to a future, unrelated slot by the
time an error callback fires? Should this use the saved entry->rx_index
instead?

[Severity: Critical]
This isn't a bug introduced by this patch, but are inbound memory windows
freed without synchronizing with the receive tasklet or terminating DMA?

In ntb_transport_link_cleanup():
	for (i =3D 0; i < nt->mw_count; i++)
		ntb_free_mw(nt, i);

This unmaps and frees the DMA coherent memory windows, but leaves the
receive tasklet active.

In ntb_transport_rxc_db():
	for (i =3D 0; i < qp->rx_max_entry; i++) {
		rc =3D ntb_process_rxc(qp);
		if (rc)
			break;
	}

This loop executes unconditionally, proceeding to dereference qp->rx_buff
in ntb_process_rxc() before checking qp->active. Can this cause a
Use-After-Free memory access or IOMMU faults if the link goes down while
tasklets or DMA are active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904052134.2970=
111-1-den@valinux.co.jp?part=3D1
