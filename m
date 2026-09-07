Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5884CA790
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791885; cv=none; b=JZOV2wnynW32Es4IlP9+H4mojcG2r+qD2tVU+DHKjK5gjagsv6dKWEZeYDcM+eBdnr0Cw3eHz3MvJ8sMWWQFDV0SSS/ryFMPTuwA8Nn7OFrGPOBEGDPeQbEAoU0b8al00crSdvHZZP12C9Gad0z9FaNivZGDm3gtFd/wYRGFIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791885; c=relaxed/simple;
	bh=R5bJPQsa8YenBnLJcDET230Hb5u2w/9VbxyvOeYjkeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=POirEOw8VLUtIsk7XoypTi1rHBaTDaEUfJYuTk7YH4xglnz0AbCaz8jp+j3A9le+WcJ/sDEWInRuLKtGSbPUtee3lmADpFfI0dk2E7ptGHemH+mRi7QQRqqMjEpWNCGEJo3771pTdxxXx6pdDsyOQ+6hu6wkb8iqvoKv51w7K8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfapts66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfapts66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AF41F00A3A;
	Mon,  7 Sep 2026 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788791879;
	bh=vklcMcnTvBTWS2PwFDPR0DtnSSNb9EbheCL94nYza3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wfapts66/AoV5dOQMy3hU5jovo7guducsT2D22jZjCHghIUDtvgCJxEYQhTabcjpM
	 9R4PxH21YD5sxsRv29/Z4h4O7mpbYvSVyddHtWRrWU7AlsPkr5/Lzbrvyjl6d/W8ks
	 P4szit+By40uRJfmEFxHIVb/ocvwYb1nV+/7X2aDxXGGam70qCa80R77F3HM63WGIl
	 vYWgyhv3/G4MfYwUO+4uoh+ch7Hw5zOfYUGdk+xfzHKrR8nrMxVz/dFUOV8Bffp1po
	 AJ8MapFnMDtDxA/rjvfTLTOXFv2X+AKD/wFpcWXYzrEaCqbtBXvKRVi29rtOm+Azvk
	 FSRPjFAsML00w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] NTB: ntb_transport: Start TX offload thread after
 queue setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-3-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:37:58 +0000
Message-Id: <20260907143759.16AF41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential DMA mapping leak on the error path because DMA address 0=
 is treated as invalid.
- [High] Concurrent accesses to `nt->qp_bitmap_free` are not synchronized, =
which can lead to QP assignment corruption.
- [High] Leaked queue entries and dangling pointer usage when stopping TX o=
ffload thread in ntb_transport_free_queue.
- [Medium] Unprotected modification of qp->tx_bytes and other statistics.
--

commit 7bd9e932183752e71eddb3f2bc51cf46a03b501b
Author: Koichiro Den <den@valinux.co.jp>
Date:   Mon Sep 7 14:24:20 2026 +0000

    NTB: ntb_transport: Start TX offload thread after queue setup
   =20
    ntb_transport_create_queue() starts the per-QP TX offload thread before
    DMA mappings and queue entries are allocated. If later setup fails, the
    error path returns the QP to the free bitmap without stopping the
    thread. A retry can then reinitialize its waitqueue while the old thread
    is still waiting on it.
   =20
    Start the thread after queue setup.
   =20
    Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' modul=
e option")
    Signed-off-by: Koichiro Den <den@valinux.co.jp>

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3389d6ca9ebd2..55a20ae9a85e6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct devi=
ce *client_dev,

[Severity: High]
This isn't a bug introduced by this patch, but does this function have a ra=
ce
condition when modifying the shared bitmap?

If multiple client drivers invoke ntb_transport_create_queue() concurrently,
they might observe the same free_queue bit:

drivers/ntb/ntb_transport.c:ntb_transport_create_queue() {
    ...
    free_queue =3D ffs(nt->qp_bitmap_free);
    if (!free_queue)
        goto err;
    ...
    free_queue--;
    qp =3D &nt->qp_vec[free_queue];
    qp_bit =3D BIT_ULL(qp->qp_num);
    nt->qp_bitmap_free &=3D ~qp_bit;
    ...
}

Because these modifications to nt->qp_bitmap_free are done without holding =
any
locks, can this lead to assigning the same queue pair to multiple clients?

[Severity: High]
This is a pre-existing issue, but does the error path in this function leak
the DMA mapping?

If dma_map_resource() succeeds but returns 0 (which is a valid DMA address =
on
some architectures), and a subsequent setup step fails, the error path does
this:

drivers/ntb/ntb_transport.c:ntb_transport_create_queue() {
    ...
err1:
    ...
    if (qp->tx_mw_dma_addr)
        dma_unmap_resource(qp->tx_dma_chan->device->dev,
                           qp->tx_mw_dma_addr, qp->tx_mw_size,
                           DMA_FROM_DEVICE, 0);
    ...
}

Since 0 evaluates to false, the mapping is skipped and leaked. Should this
check against DMA_MAPPING_ERROR or use a dedicated boolean flag instead?

>  	qp->tx_handler =3D handlers->tx_handler;
>  	qp->event_handler =3D handlers->event_handler;
> =20
[ ... ]
>  	dma_cap_zero(dma_mask);
>  	dma_cap_set(DMA_MEMCPY, dma_mask);
> =20
[ ... ]
> @@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct devi=
ce *client_dev,
[ ... ]
> +	init_waitqueue_head(&qp->tx_offload_wq);
> +	qp->tx_offload_thread =3D NULL;
> +	if (tx_memcpy_offload) {
> +		qp->tx_offload_thread =3D kthread_run(ntb_tx_memcpy_kthread, qp,
> +						    "ntb-txcpy/%s/%u",
> +						    pci_name(ndev->pdev), qp->qp_num);
> +		if (IS_ERR(qp->tx_offload_thread)) {
> +			dev_warn(&nt->ndev->dev,
> +				 "tx memcpy offload thread creation failed: %ld; falling back to inl=
ine copy\n",
> +				 PTR_ERR(qp->tx_offload_thread));
> +			qp->tx_offload_thread =3D NULL;
> +		}
> +	}
> +
>  	ntb_db_clear(qp->ndev, qp_bit);
>  	ntb_db_clear_mask(qp->ndev, qp_bit);

[Severity: High]
This isn't a bug introduced by this patch, but does the offload thread clea=
nup
in ntb_transport_free_queue() leave a dangling pointer?

When the thread is stopped, the pointer is set to NULL after the thread exi=
ts:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    kthread_stop(qp->tx_offload_thread);
    qp->tx_offload_thread =3D NULL;
    ...
}

If a concurrent DMA transaction aborts before the DMA engine is fully
terminated, ntb_tx_copy_callback() might evaluate ntb_tx_offload_enabled():

drivers/ntb/ntb_transport.c:ntb_tx_offload_enabled() {
    return tx_memcpy_offload && qp && qp->tx_offload_thread;
}

Because the pointer is still non-NULL until kthread_stop() returns, the ent=
ry
is added to tx_offl_q.

Since the thread is dead, it will never process the queue, and the underlyi=
ng
client data buffers (like network socket buffers) will be permanently leaked
when tx_offl_q entries are subsequently cleaned up.

[Severity: Medium]
This is a pre-existing issue, but does ntb_tx_copy_callback() have unprotec=
ted
modifications to statistics?

drivers/ntb/ntb_transport.c:ntb_tx_copy_callback() {
    ...
    qp->tx_bytes +=3D len;
    ...
}

When a high volume of traffic triggers concurrent increments from multiple
contexts (e.g., DMA callbacks and the Tx offload kthread), can this 64-bit
statistic suffer from data races or torn updates on 32-bit platforms without
locking or u64_stats_sync protection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D2
