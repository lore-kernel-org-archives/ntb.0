Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C783AC0C3
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792659; cv=none; b=adz/KD40eI/4i7jvZ7y0GmFa6e+xKZ2buoYcR6LpSQx9xlaCQrhTekVrClBCd0CJCQ0LT214jwX7WgZyQY/jTqoibdPTxjyhYB+c8A0TKJ0c6gMbJYuuHD8zDV+5rrcMBAP6tLCvg6vbzWq7cMghw3CD8SZO7rJew/Wx8xItr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792659; c=relaxed/simple;
	bh=wRffHJKDKV+cZm/QdL+A4W1UNOMG5FI2cccJG2EFoC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqNCb5kZf90f6Eaq2QTW3MAYJ9WoyodM4OxozjMoxJvCD+nRoUtpDiqlSm/6m13glgox4KNS3x7dNLKuC8XCODehx7v+MCrs2jSnFAoWe80eggPrcYJAtH1/J72yuTBjduFu5UnJIpv8ZXjeAAE/3CCcdJ7kK1vVB2uWliPujbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4F34wVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4F34wVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D177D1F00A3A;
	Mon,  7 Sep 2026 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792655;
	bh=RelK6FUB0T2F1NE0gLYvbhVFSZEjqvMKtJqxxRdePOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d4F34wVMq1KUxl3xwS2aqnufRfSD1cX+5gSbXFX7DVDzrZrRfNYUGWbVa0RxLuJL/
	 lsh6B3CDT7IiW9nTMQIgtZNjetRwFy5OIfke0Gx8QOHnAnFq5OC5W+5JvB06XEi5rk
	 krVV8v3vv7IlBlNHuhsIHv4Rfkv4W6159b0M/pziod6FVWnyqN8Wtfh5r8NDBYFXgr
	 g31GoN/k+zU8HklPLKUEEYoKmfRwYIf7czDWUmqf6DSxzua5+3EaC4EvAlGrDZfewo
	 rnCvuah+5HjHoO9E4OinBgMl08c9dxu2E0BjsdQO2ZSlCDdEXSxpxtq6EdGd/JL0qO
	 GXI5mAY2u/Irg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] NTB: ntb_transport: Stop QP work before freeing a
 queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-10-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:50:53 +0000
Message-Id: <20260907145054.D177D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ntb_transport_free() cancels work items before clearing context, w=
hich can cause a use-after-free if the hardware triggers a link event durin=
g shutdown.
- [High] Data race between `ntb_transport_link_cleanup` and `ntb_transport_=
free_queue` causes invocation of a NULL or freed event_handler.
- [High] Using the deprecated `dmaengine_terminate_all()` fails to wait for=
 running DMA callbacks, causing a race with list draining and freeing.
- [Medium] Unallocated queues leak rx_free_q memory entries when the module=
 is unloaded.
- [Medium] Memory leak of TX queue entries if DMA transfers are aborted dur=
ing teardown.
--

commit 252961726612772103a0f740acf1bbca22443e1c
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Stop QP work before freeing a queue

This commit cancels the link cleanup and delayed link work items before fre=
eing
a queue pair (QP) to prevent use-after-free issues. It transitions to using
disable_work_sync() and enable_work() to stop workers instead of just
canceling them.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index a902fce4ba602..d009bb5bb54bb 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -2209,6 +2214,10 @@ void ntb_transport_free_queue(struct ntb_transport=
_qp *qp)
> =20
>  	pdev =3D qp->ndev->pdev;
> =20
> +	qp->client_ready =3D false;
> +	disable_work_sync(&qp->link_cleanup);
> +	disable_delayed_work_sync(&qp->link_work);
> +	qp->link_is_up =3D false;
>  	qp->active =3D false;
> =20
>  	if (qp->tx_offload_thread) {
[ ... ]
> @@ -2256,8 +2265,6 @@ void ntb_transport_free_queue(struct ntb_transport_=
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
This is a pre-existing issue, but there appears to be a data race when clea=
ring
these handler pointers in ntb_transport_free_queue():

    qp->cb_data =3D NULL;
    qp->rx_handler =3D NULL;
    qp->tx_handler =3D NULL;
    qp->event_handler =3D NULL;

These pointers are cleared without holding any locks. If the physical link
goes down at the same time, the workqueue executes ntb_qp_link_cleanup(),
which checks qp->event_handler. Since ntb_transport_free_queue() clears
its allocation bit at the very end of the function, could the cleanup worker
race and call the event handler with a NULL pointer, or use qp->cb_data as
context after the client has freed the backing memory?

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential leak of TX queue
entries in ntb_transport_free_queue() during DMA teardown:

    /* Try to be nice and wait for any queued DMA engine
     * transactions to process before smashing it with a rock
     */
    dma_sync_wait(chan, qp->last_cookie);
    dmaengine_terminate_all(chan);

If dma_sync_wait() times out or fails, dmaengine_terminate_all() will abort
pending transfers without invoking their completion callbacks. Since the TX
entries aren't tracked on a pending list like RX (where rx_post_q is proper=
ly
tracked and freed), will these bypassed entries be permanently leaked?

[Severity: High]
This is a pre-existing issue, but also in ntb_transport_free_queue() regard=
ing
the DMA teardown:

    dma_sync_wait(chan, qp->last_cookie);
    dmaengine_terminate_all(chan);
    dma_release_channel(chan);

Using the deprecated dmaengine_terminate_all() fails to wait for running DMA
callbacks on other CPUs. Since a callback like ntb_rx_copy_callback() could
be running concurrently (e.g. in a tasklet) and accessing entries while
ntb_transport_free_queue() proceeds to drain and free the rx_post_q and
rx_free_q lists, could this lead to a use-after-free or list corruption?
Should we be using dmaengine_terminate_sync() instead to guarantee callbacks
have finished?

[Severity: High]
This is a pre-existing issue, but I noticed something in ntb_transport_free=
()
that might cause a use-after-free:

drivers/ntb/ntb_transport.c:ntb_transport_free() {
    ...
    cancel_work_sync(&nt->link_cleanup);
    cancel_delayed_work_sync(&nt->link_work);
    ...
    ntb_link_disable(ndev);
    ntb_clear_ctx(ndev);
    ...
}

If ntb_link_disable() triggers a hardware link down interrupt, and
ntb_clear_ctx() hasn't been called yet to unregister callbacks, the ISR
could invoke ntb_transport_event_callback(), which reschedules
nt->link_cleanup:

        schedule_work(&nt->link_cleanup);

Since nt is freed shortly after with kfree(nt), wouldn't the scheduled work
item remain on the workqueue and dereference the freed memory when executed?

[Severity: Medium]
This is a pre-existing issue, but there appears to be a memory leak related
to unallocated QPs during module unload.

When the link comes up, ntb_transport_setup_qp_mw() allocates entries for a=
ll
QPs up to nt->qp_count, regardless of active client allocations:

        for (i =3D qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
                entry =3D kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
                ...
                ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
                             &qp->rx_free_q);
                qp->rx_alloc_entry++;
        }

However, during teardown, ntb_transport_free() only explicitly frees
allocated QPs:

        /* verify that all the qp's are freed */
        for (i =3D 0; i < nt->qp_count; i++) {
                qp =3D &nt->qp_vec[i];
                if (qp_bitmap_alloc & BIT_ULL(i))
                        ntb_transport_free_queue(qp);
        }

By deliberately skipping unallocated QPs during cleanup, won't their
populated rx_free_q lists be completely leaked when the driver executes
kfree(nt->qp_vec)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D9
