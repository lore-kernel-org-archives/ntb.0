Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCD374A01
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792186; cv=none; b=ot2Port5LodvZp5ksbV8zDeoAOgTLPxyGxwcqtqNCDw4BkPwyk7yp7r372wygKmg2oRcJ7VsuibUdni11qeBQld99PjrF0fjyRSqaPxbppLvPdQNWuaFH6I4o0OZ1jiG3rZh7bxggO2AGrbHTqDGbudnSvT70454rnh0e4kn+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792186; c=relaxed/simple;
	bh=B4XbskkKBEvUKHAV7lPPOQDaBCc1xnkdyM4f+R7E1oM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W0SZi46mkh6DRokhFukoJZSg8tZu5pCN4ICAJe6wXg+UN9VM9DOitxpjj2cOVus6oFdgnw/ZrK676+fbDvvy0ikr6hS02fjn2NDI/6w2VTypq6TDDhSKXJeuS8ZwjQx9K/FoOwsWJ/CbguIPPrX248Dmx/Cl1TCLVcOfzF9uaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2Z9k93i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2Z9k93i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D25A1F00A3A;
	Mon,  7 Sep 2026 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792183;
	bh=u0Z3ilaus5HwHA2rHlw3oO1de42cLYH9z4g/dH3WZM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2Z9k93izuzR67JeR4ti/MWWk3AduKHdHMPYsZSC6WtwxV4fkqVoJ7IFQ7InQ9kiX
	 S0NG2pBs1xtTn1BZ1tWhfHajFKKx64S7H2Nio/FIu31CAft7Ymo08F/xjy/X2WmFC+
	 9ZwDbvm2GRnD73klghjtxj0Et3FpMHrSLJabD3h0J3s4Vl0PxALjYLlUpLayUU3TBG
	 iIugcnGuGqEobIbspzD69N+yoUtcNicOlq/SJsWAqojdBT1+TruJ6a48r6mBXTZ9xd
	 +21voAqfB/WAEUrHmOn8wd/Fyx8hZHwJbGJi6eYfDFeOatlKONtLe1pn3L9TYydC+7
	 91E+MMb1vBSYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] NTB: ntb_transport: Clear link state before QP
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-8-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:43:02 +0000
Message-Id: <20260907144303.3D25A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Coding Pattern Violation: Mixing guard() and goto-based cleanup

Pre-existing issues:
- [High] Memory Ordering Race leading to lost wakeups
- [High] Data Race in ntb_qp_link_cleanup allowing concurrent execution
- [High] DMA Memory Corruption due to unterminated transactions
- [High] Missing read memory barrier (dma_rmb) when reading payload after c=
hecking DESC_DONE_FLAG
- [High] Stale Data Transmission due to missing flush on link down
--

commit 3aa5fe6a4883f5e1056224f4eb903786b4edfe5a
Author: Koichiro Den <den@valinux.co.jp>

    NTB: ntb_transport: Clear link state before QP cleanup

    Cleanup leaves the transport link marked up after releasing its MWs, al=
lowing
    client link-up requests to start QP link work prematurely. Clear link_i=
s_up
    before cancelling QP work and releasing MWs. Additionally, ensure QP li=
nk
    work returns if the transport went down after it was queued.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 411017873a83b..4c0a29693ac23 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -990,6 +990,8 @@ static void ntb_transport_link_cleanup(struct ntb_tra=
nsport_ctx *nt)
> =20
>  	guard(mutex)(&nt->link_event_lock);
> =20
> +	WRITE_ONCE(nt->link_is_up, false);
> +
>  	qp_bitmap_alloc =3D nt->qp_bitmap & ~nt->qp_bitmap_free;
> =20
>  	/* Pass along the info to any clients */

[Severity: High]
This is a pre-existing issue, but does this cleanup routine allow concurrent
execution?

Looking at ntb_transport_link_cleanup(), it calls ntb_qp_link_cleanup() on =
all
active QPs, and then synchronizes cancellation using cancel_work_sync():

drivers/ntb/ntb_transport.c:ntb_transport_link_cleanup() {
    ...
    for (i =3D 0; i < nt->qp_count; i++)
        if (nt->qp_bitmap_alloc & BIT_ULL(i)) {
            struct ntb_transport_qp *qp =3D &nt->qp_vec[i];
            ntb_qp_link_cleanup(qp);
            cancel_work_sync(&qp->link_cleanup);
        }
    ...
}

If the ntb_qp_link_cleanup_work() worker is concurrently executing, it will
also invoke ntb_qp_link_cleanup(). Since no lock synchronizes
ntb_qp_link_cleanup(), it can execute concurrently across threads. This cou=
ld
lead to data races when resetting QP indices and cause duplicate concurrent
calls to the client's event_handler, potentially corrupting the client driv=
er
state.

[Severity: High]
This is a pre-existing issue, but is it possible for active DMA transaction=
s to
corrupt freed memory here?

Later in ntb_transport_link_cleanup(), it frees the backing DMA memory:

drivers/ntb/ntb_transport.c:ntb_transport_link_cleanup() {
    ...
    for (i =3D 0; i < nt->mw_count; i++)
        ntb_free_mw(nt, i);
    ...
}

ntb_free_mw() calls dma_free_attrs() without ensuring the DMA channel is
stopped. Prior to this, ntb_qp_link_cleanup() kills the RX tasklet with
tasklet_kill(&qp->rxc_db_work), but does not terminate active DMA engine
transactions (e.g., via dmaengine_terminate_all()).

If a DMA transfer was previously submitted, could it continue asynchronousl=
y in
hardware, writing into the freed memory pages and leading to IOMMU faults or
memory corruption?

[Severity: High]
This is a pre-existing issue, but does resetting the link context leave sta=
le
data in the transmit queues?

When the link goes down, ntb_qp_link_down_reset() is called:

drivers/ntb/ntb_transport.c:ntb_qp_link_down_reset() {
    ...
    ntb_qp_link_context_reset(qp);
    remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
    ...
}

The QP context and indices (like qp->tx_index) are reset to 0, but pending
entries in qp->tx_offl_q or other transmit queues are not flushed. These
pending entries already have their entry->tx_index populated with old index
values from before the link dropped.

When the tx_offload_thread processes them, could it write the data to the
old, stale index locations instead of starting correctly at index 0, causing
the remote receiver to hang or receive out-of-sequence packets?

[ ... ]

[Severity: Medium]
Does ntb_transport_link_work() mix scope-based guard macros with legacy
goto-based error cleanup?

The cleanup.md documentation explicitly mandates that usage of "goto" and
cleanup helpers must never be mixed in the same function.

drivers/ntb/ntb_transport.c:ntb_transport_link_work() {
    ...
    guard(mutex)(&nt->link_event_lock);
    ...
        rc =3D ntb_set_mw(nt, i, val64);
        if (rc)
            goto out1;
    ...
out1:
    for (i =3D 0; i < nt->mw_count; i++)
        ntb_free_mw(nt, i);
    ...
}

This function uses guard(mutex)(&nt->link_event_lock) at the beginning, but
continues to use goto out1; and goto out; for error handling and legacy cle=
anup
paths. Does this violate the established architectural cleanup pattern?

[ ... ]

> @@ -1149,7 +1151,9 @@ static void ntb_qp_link_work(struct work_struct *wo=
rk)
>  	struct ntb_transport_ctx *nt =3D qp->transport;
>  	int val;
> =20
> -	WARN_ON(!nt->link_is_up);
> +	/* Pair with the link publication in ntb_transport_link_work(). */
> +	if (!smp_load_acquire(&nt->link_is_up))
> +		return;
> =20
>  	val =3D ntb_spad_read(nt->ndev, QP_LINKS);
> =20

[Severity: High]
This is a pre-existing issue, but does this Dekker's algorithm pattern lack=
 a
full memory barrier, potentially leading to lost wakeups?

In ntb_transport_link_work(), nt->link_is_up is stored and qp->client_ready=
 is
read:

drivers/ntb/ntb_transport.c:ntb_transport_link_work() {
    ...
    smp_store_release(&nt->link_is_up, true);

    for (i =3D 0; i < nt->qp_count; i++) {
        struct ntb_transport_qp *qp =3D &nt->qp_vec[i];

        if (qp->client_ready)
            ntb_transport_schedule_qp_link(qp, 0);
    }
    ...
}

Concurrently, ntb_transport_link_up() stores qp->client_ready and reads
nt->link_is_up:

drivers/ntb/ntb_transport.c:ntb_transport_link_up() {
    ...
    qp->client_ready =3D true;
    ntb_transport_schedule_qp_link(qp, 0);
    ...
}

Inside ntb_transport_schedule_qp_link(), it checks
smp_load_acquire(&nt->link_is_up). Because smp_store_release() allows
subsequent loads to be reordered before the store, and smp_load_acquire()
allows preceding stores to be reordered after the load, both threads can re=
ad
false for the counterpart flag.

Could this result in a lost wakeup where the QP link fails to initialize?

[ ... ]

[Severity: High]
This is a pre-existing issue, but is a read memory barrier required after
checking the DESC_DONE_FLAG?

In ntb_process_rxc(), the descriptor's done flag is read from the DMA-mapped
memory to verify packet completion:

drivers/ntb/ntb_transport.c:ntb_process_rxc() {
    ...
    if (!(hdr->flags & DESC_DONE_FLAG)) {
        dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
        qp->rx_ring_empty++;
        return -EAGAIN;
    }
    ...
}

However, there is no dma_rmb() issued after observing the flag. Could this
allow the CPU to speculatively read the subsequent header fields (e.g.,
hdr->ver, hdr->len) and the payload buffer before the done flag read
completes, resulting in stale data being processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D7
