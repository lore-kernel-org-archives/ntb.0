Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75557396B76
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014188; cv=none; b=MbZeOWIgbvy08jeOnQnuyrhvyYQ/aFCEe8ivQxt8ea7PXWMmEqHWoFhGyzVP/+fdVO+GbeHA0KPPI0irFJy/vDFRuqB7smavKtHuJJdgthdEpR6n6EN1KCnwfrusQn3D56wglPF+ZyDagVW69Uo72cNSklW9jIK8j+q5rGZAdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014188; c=relaxed/simple;
	bh=mTJt5YGpvketP/dpJFeiS2qsdLqIdTn6Z1QmVH6Gx54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLWR17lFZaviVfFmvD2QrZ/Oiv/DyIWdi1tssGoHWwUY2uIIqssSakPyuceC8wykhR/LXrp/lk1UrPwwuBbLoW8Drry+nq67958ZuhI0ZJ48xjUq/kIAVz4z5xU3fGPhK+fh6etGAixh3prclr8o8PVTK4ZQUgimu4VF/TaXsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyD1k8vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyD1k8vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECB01F00893;
	Thu, 10 Sep 2026 04:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014187;
	bh=fGefCZhNbuvGF7XAC2q0grUGcY4LVYlxySVCdCjB0U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OyD1k8vv5xfoRTCbmvN9QLeqdlXKQhtANmG3AtKBGA8NOLa/7OzFxTauDKFu4BP3S
	 V5kPj6+74lzaIa7/2wpWZNDEDDiegUj1z04Fq6iM6oJY2ssvZaH61TBV4C5oXdm5vQ
	 S5TrH1rcppLIQndgcMO58b+PtnZotUZPA9drp+EEmHaS0p6IxIbpQcPoBNOxrzmKoC
	 j2oKVEu9kZ8MLoIU26Dn91gn2Np1BGHt7NeXRU/7ggZErsnhQsmzH8wKGOpwFxX9Zg
	 GH87orsMtuCJEVrMrdQKqtMbuJ1fLLriuBHcNyiXV+69qBJQFXZ/nHLOxShvZh9B4R
	 jL6HCNz6FZLTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] NTB: ntb_transport: Stop QP work before
 freeing a queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-8-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:23:06 +0000
Message-Id: <20260910042306.CECB01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] Data race on `qp->client_ready` due to missing `WRITE_ONCE()` barri=
er.

Pre-existing issues:
- [High] Concurrent execution of global link cleanup and queue freeing caus=
es a TOCTOU NULL pointer dereference or UAF of the client event handler.
- [High] Missing `dmaengine_terminate_sync()` causes potential Use-After-Fr=
ee of `ntb_queue_entry` by pending DMA callbacks.
- [High] Lockless read-modify-write of `nt->qp_bitmap_free` allows concurre=
nt queue allocations to race and corrupt state.
- [Medium] DMA mapping is leaked on error paths if the mapped address is ex=
actly 0.
--

commit 5792da2527dba6f7348b49cf7d71537d78957df9
Author: Koichiro Den <den@valinux.co.jp>
Date:   Thu Sep 10 04:08:29 2026 +0000

    NTB: ntb_transport: Stop QP work before freeing a queue

This patch disables and waits for qp->link_cleanup and qp->link_work to
finish before freeing queue resources in ntb_transport_free_queue(). It also
delays enabling these works until queue creation succeeds to prevent tasks
from running concurrently with teardown or setup.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 8dd1770aaaf15..e5599c7ca93f2 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -2155,6 +2157,9 @@ ntb_transport_create_queue(void *data, struct devic=
e *client_dev,
>  		}
>  	}
> =20
> +	enable_work(&qp->link_cleanup);
> +	enable_delayed_work(&qp->link_work);
> +
>  	ntb_db_clear(qp->ndev, qp_bit);
>  	ntb_db_clear_mask(qp->ndev, qp_bit);

[Severity: High]
This is a pre-existing issue, but earlier in ntb_transport_create_queue(),
does the lockless allocation of transport queues allow concurrency issues?

    free_queue =3D ffs(nt->qp_bitmap_free);
    if (!free_queue)
        goto err;
    free_queue--;
    qp =3D &nt->qp_vec[free_queue];
    qp_bit =3D BIT_ULL(qp->qp_num);
    nt->qp_bitmap_free &=3D ~qp_bit;

Could multiple concurrent clients probe and hijack the same transport queue
index, corrupting the bitmap?

[Severity: Medium]
This is a pre-existing issue, but does the error path in this function leak
the DMA mapping if the mapped address is 0?

In ntb_transport_create_queue(), the cleanup code checks:

    if (qp->tx_mw_dma_addr)
        dma_unmap_resource(qp->tx_dma_chan->device->dev, ...);

Since 0 can be a valid DMA address on some architectures, and
dma_map_resource() returns DMA_MAPPING_ERROR on failure rather than 0,
would treating 0 as invalid bypass unmapping and permanently leak it?

[ ... ]
> @@ -2200,6 +2205,10 @@ void ntb_transport_free_queue(struct ntb_transport=
_qp *qp)
> =20
>  	pdev =3D qp->ndev->pdev;
> =20
> +	qp->client_ready =3D false;

[Severity: Low]
Is there a data race on qp->client_ready?

Since ntb_transport_link_work() concurrently reads this flag using
READ_ONCE(), should this plain store be updated to use WRITE_ONCE() to
prevent compiler caching or tearing?

> +	disable_work_sync(&qp->link_cleanup);
> +	disable_delayed_work_sync(&qp->link_work);
> +	qp->link_is_up =3D false;
>  	qp->active =3D false;

[Severity: High]
This is a pre-existing issue, but does queue teardown safely wait for
in-flight DMA callbacks to finish?

Further down in ntb_transport_free_queue(), the code calls:

    dmaengine_terminate_all(chan);

This stops new DMA but doesn't synchronously wait. If a callback like
ntb_rx_copy_callback() is executing concurrently:

drivers/ntb/ntb_transport.c:ntb_rx_copy_callback() {
    ...
    entry->flags |=3D DESC_DONE_FLAG;
    ntb_complete_rxc(entry->qp);
}

Could it access the entry after the queue teardown loops free it via kfree(=
),
causing a use-after-free? Should this use dmaengine_terminate_sync() instea=
d?

[ ... ]
> @@ -2247,8 +2256,6 @@ void ntb_transport_free_queue(struct ntb_transport_=
qp *qp)
>  	ntb_db_set_mask(qp->ndev, qp_bit);
>  	tasklet_kill(&qp->rxc_db_work);
> =20
> -	cancel_delayed_work_sync(&qp->link_work);
> -
>  	qp->cb_data =3D NULL;
>  	qp->rx_handler =3D NULL;
>  	qp->tx_handler =3D NULL;

[Severity: High]
This is a pre-existing issue, but is there a race condition between clearing
these handler pointers and ntb_qp_link_cleanup()?

When ntb_transport_free_queue() clears qp->event_handler (immediately below
this snippet):

    qp->event_handler =3D NULL;

ntb_qp_link_cleanup() can execute concurrently on a workqueue from a hardwa=
re
link down event:

drivers/ntb/ntb_transport.c:ntb_qp_link_cleanup() {
    ...
    if (qp->event_handler)
        qp->event_handler(qp->cb_data, qp->link_is_up);
}

If the handler is cleared between the check and the call, could this result
in a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D7
