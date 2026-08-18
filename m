Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65471331A5B
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787031343; cv=none; b=tk73PFbK37MA/yoSrwEZZ6bIskbM515hHlV8gCOWVvnnoQ0QnbiLF2s4IgNYvxmhovdePDT3rY5yXoKtT2Tsv2xyKbFKv059f8GEdHXR4pzqnoFUV5wgVeHOEWaOcTCJ2Fh+P1BDg3O/FPe+hGe6H2MMkmxKuI1Vei8uwyUz2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787031343; c=relaxed/simple;
	bh=YNQ+6ibcco8Bdd/1arWbH1rF2Fw703LywSzfGj45G2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlwBwkSVCkX6PBEyx+sa/g0E5lJ+U+Zilqg5A+Wq7GKCVHj6EjRagOgddHWjEQ2M2mEzq8hNLgxqXbX4rH2cb6t6RliAV+qeQjlwjV9An3LBJxtknJHXdKk5JaSBihV4dvabbUj03MocIMSLRFohJU9c7Cv/5eHlhG2zfovmLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az9ScAhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az9ScAhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CD31F00A3A;
	Tue, 18 Aug 2026 05:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031342;
	bh=kbh18YtLWebykAHoRa+DYKOboCQ6bKw2ZCZTM/h90mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=az9ScAhzg6/12mxlCY+OABjGhmchliSVc4lquxEiwwntrXaTkcIB4WuLHjToN1Pkq
	 I9gof3Oe2UFEndVEEiXhOhKfcFp0w9LYKAZP8l8XPiyag+MMM+xTRrfOwGbKXuyjJv
	 1dXGyBuMqRFpmWWTpSVgfRpewRNXK//zlBk/Xp2CHKbjTd3cdZJH6bIc7j60mO0NOv
	 OCDSOtAvGvEEx5A4A16NfGVp+zSjZt0hgDe4rtrlDbeeAgNV3RSSWQGC0mJq/bB7+3
	 GcPivN7ggyRmv+UA3cLe45zGtlL8Apx15yxblM/uCmKhhHx+za67ApGaeuAMv/W72E
	 pBCtAo4LK2wdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/4] NTB: ntb_transport: Recycle TX entries before
 client callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817053519.4135287-2-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 05:35:41 +0000
Message-Id: <20260818053541.E5CD31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of client data buffers (e.g., network sk_buff) in ntb_=
process_tx() error path.
- [High] Uninitialized variable qp->last_cookie on the TX DMA path defeats =
DMA synchronization during queue teardown.
- [High] Pending TX queue entries and their associated payloads are permane=
ntly leaked when the DMA engine is terminated.
- [High] TOCTOU race on qp->tx_handler and qp->cb_data leads to a NULL poin=
ter dereference.
--

--- Patch [1]: [PATCH net 1/4] NTB: ntb_transport: Recycle TX entries befor=
e client callbacks ---
commit 48d0145779a008cdeb1d647661138f0bd59414bb
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Recycle TX entries before client callbacks

ntb_tx_copy_callback() invokes the client callback before returning the
entry to tx_free_q. The callback may wake a stopped client queue, only
for the next enqueue to find no local entry and return -EBUSY. The window
is narrow, but the retry is unnecessary.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfaa..e92b96f4afad8 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -1768,15 +1775,13 @@ static void ntb_tx_copy_callback(void *data,
>  	 * "link down" or similar.  Since no payload is being sent in these
>  	 * cases, there is nothing to add to the completion queue.
>  	 */
> -	if (entry->len > 0) {
> -		qp->tx_bytes +=3D entry->len;
> -
> -		if (qp->tx_handler)
> -			qp->tx_handler(qp, qp->cb_data, entry->cb_data,
> -				       entry->len);
> -	}
> +	if (len > 0)
> +		qp->tx_bytes +=3D len;
> =20
>  	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> +
> +	if (len > 0 && qp->tx_handler)
> +		qp->tx_handler(qp, qp->cb_data, cb_data, len);

[Severity: High]
This is a pre-existing issue, but does this introduce a race condition lead=
ing
to a null pointer dereference?

In ntb_tx_copy_callback(), this code checks if qp->tx_handler is non-null
before calling it:

drivers/ntb/ntb_transport.c:ntb_tx_copy_callback() {
    ...
    if (len > 0 && qp->tx_handler)
        qp->tx_handler(qp, qp->cb_data, cb_data, len);
    ...
}

Concurrently, ntb_transport_free_queue() blindly zeroes qp->tx_handler and
qp->cb_data:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    qp->cb_data =3D NULL;
    qp->rx_handler =3D NULL;
    qp->tx_handler =3D NULL;
    ...
}

Because there is no synchronization protecting the execution of the DMA tas=
klet
and the teardown clearing of these pointers, can the tasklet evaluate
qp->tx_handler as non-null, but then dereference a subsequently null
qp->tx_handler, or pass a null qp->cb_data pointer to the network callback?


[Severity: High]
This is a pre-existing issue, but does ntb_process_tx() leak the SKB?

If a transmitted packet length exceeds the maximum frame size, ntb_process_=
tx()
invokes qp->tx_handler() with NULL instead of the original packet buffer:

drivers/ntb/ntb_transport.c:ntb_process_tx() {
    ...
    if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
        if (qp->tx_handler)
            qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
    ...
}

Because the network callback exits early if data is NULL, it fails to free =
the
SKB:

drivers/net/ntb_netdev.c:ntb_netdev_tx_handler() {
    ...
    skb =3D data;
    if (!skb || !ndev)
        return;
    ...
}

Furthermore, ntb_process_tx() returns 0 to the caller, preventing the netwo=
rk
stack from freeing it on failure.


[Severity: High]
This is a pre-existing issue, but does the uninitialized qp->last_cookie de=
feat
DMA synchronization during queue teardown?

ntb_transport_free_queue() attempts to wait for pending TX DMA transactions:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    dma_sync_wait(chan, qp->last_cookie);
    ...
}

However, ntb_async_tx_submit() drops the DMA cookie instead of assigning it=
 to
qp->last_cookie:

drivers/ntb/ntb_transport.c:ntb_async_tx_submit() {
    ...
    cookie =3D dmaengine_submit(txd);
    if (dma_submit_error(cookie))
        goto err_set_unmap;

    dmaengine_unmap_put(unmap);
    dma_async_issue_pending(chan);
    return 0;
    ...
}

Could the TX synchronization wait evaluate either 0 or an unrelated RX cook=
ie on
the TX DMA channel, leading to premature termination of in-flight TX DMA
transfers?


[Severity: High]
This is a pre-existing issue, but are pending TX queue entries and their
associated payloads permanently leaked when the DMA engine is terminated?

During queue teardown, dmaengine_terminate_all() is called:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    dmaengine_terminate_all(chan);
    ...
}

This aborts any pending or active DMA descriptors. The driver relies entire=
ly
on DMA completion callbacks to return entries to qp->tx_free_q and to invoke
the client network teardown logic.

The teardown routine then only cleans up entries present in the idle lists:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    while ((entry =3D ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
        kfree(entry);

    while ((entry =3D ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
        kfree(entry);
    ...
}

Will this permanently leak active entries and their corresponding client pa=
yloads
if transactions are in-flight during module unload or link down events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817053519.4135=
287-1-den@valinux.co.jp?part=3D1
