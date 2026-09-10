Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F0395254
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014255; cv=none; b=ts1dIEkRMp/hv6ESV93cxI5+Pfi4wzKMccx0z7E0ZNP62gf68WQwfo+2nJCrHIRWRWaTjDM7VfFn3Px2lFeUISnB/YDkIhcFxKgxJ9LGKrDL+4JVVK4ouzgwvDumtTjmOthUzEh8rLMHoulqEt8QtTiIqIx3uHK7mAJ+YZJy40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014255; c=relaxed/simple;
	bh=WQ8+PXZWUwMOPg04a9zPfVpJp8/DoCZikVO+DBLf+JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=atgdIiXl7hXz8zWHfMVx3nMoLCRq9Hg62DW//br5zqrxv6G3U5BLYiERJvj8r/KCgi0x8qyqaZUWS5uz99OQzNkMxsUheXQO1KnD0QJcHItIbE8tTCBIUa+CsJAsi9dWg/bNXVKCV3AG61GF3ZpkbecLvOAIO0y8UNaA6h4BGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSlsCl6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSlsCl6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5026B1F000FF;
	Thu, 10 Sep 2026 04:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014253;
	bh=5+VkGlVN7r284N/BQlT2lBORoQQDWJYKnaaJbQS7+Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSlsCl6atjf7IVkkvl/l2LWtwuC8TzyWzIF+OdSXHF2EQduBetkwqpvm9Yn2ppl7j
	 PzDsFzTN4E99swxf8c+dPzYt1XsYSx6GPygUWIhT5L12l5pjFYY+XAgS0E0cEpOXy7
	 JOWaDeiZW2rJrJrsktWDqGPS2mtjyY1AG5wA2/cqucqKgY/Nf3CY0mBE5CpXGHH7IZ
	 k784h2tOITe82NCKDgCVQvNNvxCh87Ow8KtH4DN9yVTIZoHr6ZAh3EKQo9BFEyMhri
	 p94mZl2VQrG/cpzj0FO5GOqqNLVn7t+D9dJDt/VZhCec8rZfAma0Op8h05XcPFa9bP
	 X7yUEOLhMr6DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] NTB: ntb_transport: Wait for RX completions
 before resetting a QP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-11-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:24:12 +0000
Message-Id: <20260910042413.5026B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data corruption during fallback RX memory copy.
- [High] Use-After-Free of `ntb_queue_entry` elements during transport queu=
e teardown.
--

commit a2b0eba80182f98f6886cb72c908b76469b3615d
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Wait for RX completions before resetting a QP

This commit fixes a race condition where transport link cleanup can free a
memory window still in use by RX DMA. It adds a wait loop for the RX post
queue to become idle before resetting the QP.

Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 36797ea3ff45c..7ccba2c04f548 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -959,6 +966,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport=
_qp *qp)
>  	disable_delayed_work_sync(&qp->link_work);
>  	ntb_transport_set_qp_active(qp, false);
>  	tasklet_kill(&qp->rxc_db_work);
> +	/*
> +	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
> +	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
> +	 *
> +	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
> +	 * its MW accesses before removing each entry under ntb_rx_q_lock.
> +	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
> +	 * can be submitted.
> +	 */
> +	while (!ntb_transport_rx_idle(qp))
> +		fsleep(1000);
> =20
>  	ntb_qp_link_down_reset(qp);

[Severity: High]
This is a pre-existing issue, but does ntb_transport_free_queue() also need
this same wait loop to prevent a use-after-free?

When tearing down a queue, ntb_transport_free_queue() calls
dmaengine_terminate_all() and dma_release_channel(). However, as noted in t=
he
patch comment here, some DMA engines lack terminate/synchronize ops. The
cleanup routine then immediately frees the rx_post_q entries:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
	while ((entry =3D ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
		kfree(entry);
	}
    ...
}

If a DMA callback is pending or executing asynchronously while the queue is
being torn down, won't it dereference the freed entry pointer after
kfree(entry) is called?

[Severity: High]
This is another pre-existing issue, but can the fallback copy corrupt data
during a DMA error?

If a DMA transfer fails and ntb_rx_copy_callback() falls back to a software
copy, it calculates the offset using the globally incremented qp->rx_index:

drivers/ntb/ntb_transport.c:ntb_rx_copy_callback() {
    ...
		case DMA_TRANS_ABORTED:
		{
			struct ntb_transport_qp *qp =3D entry->qp;
			void *offset =3D qp->rx_buff + qp->rx_max_frame *
					qp->rx_index;

			ntb_memcpy_rx(entry, offset);
			qp->rx_memcpy++;
			return;
		}
    ...
}

Because qp->rx_index was already advanced to the next available ring buffer
frame when the transaction was originally submitted in ntb_process_rxc(),
won't this offset calculation point to the wrong frame and copy the wrong
payload? Should this calculation use the entry-specific index
(entry->rx_index) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D10
