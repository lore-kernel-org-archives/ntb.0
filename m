Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E73290A6
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031343; cv=none; b=lajsJEVL1nLn9v1mw+fz11qx8kXqEe4SWUrLLcwyDabRI/bci4sisoxxJ8tWW7UMKKB8x30ICbAuPHdHWiglAwiuhMBqYOAZHlFbIW2NNEazoIbI/D50h3u7ENpXhQmji26YeAki0gjfGNPteQbQYxx2Zco5zh88BOtIGSnPiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031343; c=relaxed/simple;
	bh=2RE290DRz8U9tq1PMOXXkDwRtY45IWp4qiLhe92mLAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=at7C+hvMofPurFSov0FhFl8DV9fsVZ8iexkVxRwuX7MYV3ADT6HkJl6VATjRmYavh+FhlxQY6brzkaNZFJZFAPIzWgyHStyKnyXIHqLb1QeEPxPLuCTh/xI5V0i9IH95N+8vQ6dB7Glo7JAbABf5dsTtwEX08WAQiI1G1KxTMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8/s0gil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8/s0gil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420151F000E9;
	Tue, 18 Aug 2026 05:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031341;
	bh=NI5feMpWl45yUTc65UuZL875Fgh7DDKv+EDkVMaAq6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n8/s0gilK1KYQ5yf+nEaMR9l9ok3SErvY9n2PwWvrtxdWUbhmzf7GJQr98RZuiM58
	 HWvWQKp5Gfj053OQCIAt7eIcpyO2aNu8j5y9bOUARNMHNKfgbfrgDMFr+US6E9ieY1
	 PbGbHxIijRtqWs3XOVeq7JSS5uhTVZLkidxh9WT1p+egjtlhtKI7AFWy/cONMJ3HFW
	 W1OyPvGoJS++2Jz4lx4OxQb3HCpyRw2Yd2FPTsQnZGQpt5RqXXR/uvoMlsfIi+S/pU
	 sRQymYQhc2AVCH75djHxBBYJgQu9wwPWAsUE+5l0G9MRB2qAMQ3VEyKSqK+UhOD1U7
	 6Jufga9h4QMGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/4] NTB: ntb_transport: Reject oversized TX buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817053519.4135287-5-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 05:35:40 +0000
Message-Id: <20260818053541.420151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated `transport_mtu` module parameter allows division by ze=
ro and integer underflows leading to out-of-bounds memory writes.
- [High] Queue entries are leaked in `ntb_send_link_down()` when the transm=
ission ring is full.
- [High] Queue teardown permanently leaks `ntb_queue_entry` objects and ass=
ociated network payload buffers.
--

--- Patch [4]: [PATCH net 4/4] NTB: ntb_transport: Reject oversized TX buff=
ers ---
commit 0674c1f1ad07dc65b6ed7cc1cb352ca787323a36
Author: Koichiro Den <den@valinux.co.jp>
Subject: NTB: ntb_transport: Reject oversized TX buffers

This commit moves the oversized buffer check from ntb_process_tx() to=20
ntb_transport_tx_enqueue(). It returns -EMSGSIZE before acquiring a queue
entry, allowing the caller to retain ownership and free the buffer.

Link: https://lore.kernel.org/r/20260810165136.2292436-3-den@valinux.co.jp/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4bdd81edcb87a..f9caa1a653c5b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1955,15 +1955,6 @@ static int ntb_process_tx(struct ntb_transport_qp =
*qp,
>  		return -EAGAIN;
>  	}
> =20
> -	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
> -		if (qp->tx_handler)
> -			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
> -
> -		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> -			     &qp->tx_free_q);
> -		return 0;
> -	}
> -
>  	ntb_async_tx(qp, entry);

[Severity: High]
This is a pre-existing issue, but does ntb_send_link_down() leak queue entr=
ies
when ntb_process_tx() fails?

When ntb_process_tx() returns an error like -EAGAIN,
ntb_transport_tx_enqueue() correctly adds the entry back to tx_free_q.
However, ntb_send_link_down() doesn't seem to return the entry to the
queue or free it:

drivers/ntb/ntb_transport.c:ntb_send_link_down() {
    ...
    rc =3D ntb_process_tx(qp, entry);
    if (rc)
        dev_err(&pdev->dev, "ntb: QP%d unable to send linkdown msg\n",
                qp->qp_num);
    ...
}

Could repeated link flaps permanently exhaust the queue?

[ ... ]

> @@ -2356,6 +2347,9 @@ int ntb_transport_tx_enqueue(struct ntb_transport_q=
p *qp, void *cb, void *data,
>  	if (!qp->link_is_up)
>  		return -ENOLINK;
> =20
> +	if (len > qp->tx_max_frame - sizeof(struct ntb_payload_header))
> +		return -EMSGSIZE;

[Severity: High]
This is a pre-existing issue, but if a user sets the transport_mtu module
parameter to a small value (like 1 to 11), could this length check underflo=
w?

If qp->tx_max_frame evaluates to less than sizeof(struct ntb_payload_header=
),
the subtraction will underflow to a large positive integer, bypassing the
bounds check. This would then lead to out-of-bounds memory writes during
pointer arithmetic in ntb_async_tx():

drivers/ntb/ntb_transport.c:ntb_async_tx() {
    ...
    hdr =3D offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
    ...
}

Also, if transport_mtu is set to 0, it appears to cause a division by zero =
in
ntb_transport_init_queue():

drivers/ntb/ntb_transport.c:ntb_transport_init_queue() {
    ...
    qp->tx_max_entry =3D tx_size / qp->tx_max_frame;
    ...
}

Should the module parameter be validated to prevent this?

> +
>  	entry =3D ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
>  	if (!entry) {
>  		qp->tx_err_no_buf++;

[Severity: High]
This is a pre-existing issue, but does queue teardown permanently leak
ntb_queue_entry objects and their associated network buffers?

In ntb_transport_free_queue(), entries are freed without invoking their
completion handlers (like tx_handler) to release the attached network
buffers:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    while ((entry =3D ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
        kfree(entry);
    ...
}

Additionally, it seems DMA operations are terminated without callbacks:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    dmaengine_terminate_all(chan);
    ...
}

Because ntb_async_tx_submit() doesn't populate qp->last_cookie with the
TX cookie, does the preceding dma_sync_wait() incorrectly wait on the RX
cookie, allowing engine termination to orphan all active TX entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817053519.4135=
287-1-den@valinux.co.jp?part=3D4
