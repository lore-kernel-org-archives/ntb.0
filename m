Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7F393DE0
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015235; cv=none; b=ie81t7TTD3ysKcSWOcYgDoEI+pli3YVeigIlagRIwxapWua8pKgqUnS6yhOKVDgHaiSmTEjqidH2x5QeXIge0VDlXzWEqJZ/wTQ/j3LXpf9Xkx8WNf6kD37GyC6XKq/wAkAsXYh7oq5huOANbvdua6Qf5o+wVPBP+vq/uDPx0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015235; c=relaxed/simple;
	bh=LAfJAs1QrUJod+4zjhOV9/niuCIxTZBkDnD0phA798o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uMn/8BuwjjWB+4SZj3C6gMNAtexZBlN4whu4FPzF7DUW1mOIWsZaGZCTPXkudW+bsDZoRC85BLcQl0yLJpw9hHbDVDKw+i2OgyX/jWXfqINOhY1UvO5vN3WppTA+Ks/K6+UhFBaYNEd5KQ3tPvrg/a+cCqdMoVKJ4dvtjtYd1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFNuSQee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFNuSQee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F3A1F0089A;
	Thu, 10 Sep 2026 04:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789015225;
	bh=rm3PQZIiWK9Ay506Pd/gJQAH2I2JV+oNvnJfz3iIx4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFNuSQee8S0uHHgrm4Ld35GXtKIb91CI9/ue69ZmIdKCCLpZk/9Lew1WpMqI0RU/m
	 pnpBHh0gZEjHuaIIds/9jYhimp2L05P3dPj2YuSOcRVYuGMLmDCQ7QxfrEg0JwoHUg
	 SrAk4ZFV0pGL9eE05CrjM7SODq4etp0c1pIsD+ZTHCO4S3U9R7GvIsTUlpeiVzotgb
	 hw5KuFmjvsgjJcRdCAkV+Xj3Aszwa4eGrlnG2yYA36f+4+pucRvI3rCIkVnVLgfj57
	 y9Hq/4KzOq6N0UrvmLiXk46VurPd3krb36ztnvlUcfEqB0vxYMpS1R65N6JRcVRjyY
	 HKUv2A9PpMdPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-14-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:40:24 +0000
Message-Id: <20260910044024.F0F3A1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless access to `remote_rx_info` can lead to Use-After-Free=
 during link down.
- [Critical] Pending TX transactions and DMA operations are not flushed on =
link down, causing data corruption across link sessions or PCIe AER faults.
- [High] Aborting link setup on error path `out1` leaves the remote peer wi=
th an initialized `VERSION` scratchpad, desynchronizing the link state and =
potentially causing PCIe AER faults.
--

commit a2ff2a79d68e6714fb4cb53e3787e5e3e60a479e
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Abort link setup on QP MW allocation failure

This patch updates ntb_transport_link_work() to abort link setup if QP memo=
ry
window allocation fails. It ensures that the worker does not publish a QP w=
ith
only a partially initialized memory-window state.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on s=
ize of ring size")
Cc: stable@vger.kernel.org

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 096be87e5ede9..c1e3a077c45ec 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1152,7 +1152,9 @@ static void ntb_transport_link_work(struct work_str=
uct *work)
>  	}
> =20
>  	for (i =3D 0; i < nt->qp_count; i++) {
> -		ntb_transport_setup_qp_mw(nt, i);
> +		rc =3D ntb_transport_setup_qp_mw(nt, i);
> +		if (rc)
> +			goto out1;

[Severity: High]
This isn't a bug introduced by this patch, but does jumping to out1 here
leave the remote peer with an initialized VERSION scratchpad?

Earlier in ntb_transport_link_work(), readiness is signaled to the remote p=
eer:

    ntb_peer_spad_write(ndev, PIDX, VERSION, NTB_TRANSPORT_VERSION);
    /* Query the remote side for its info */

If ntb_transport_setup_qp_mw() fails, the error path cleans up local
translations but returns immediately without rescinding the version scratch=
pad:

out1:
    for (i =3D 0; i < nt->mw_count; i++)
        ntb_free_mw(nt, i);

    /* if there's an actual failure, we should just bail */
    if (rc < 0)
        return;

Could this leave the peer stranded in an invalid 'up' state, transmitting
memory-mapped I/O that hits unconfigured BARs and generates PCIe AER faults?

>  		ntb_transport_setup_qp_peer_msi(nt, i);
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but can lockless access to remote_rx_info
lead to a use-after-free regression during link down?

The ntb_transport_tx_free_entry() function reads the pointer locklessly:

drivers/ntb/ntb_transport.c:ntb_transport_tx_free_entry() {
    struct ntb_rx_info *remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
    unsigned int head =3D qp->tx_index;
    unsigned int tail;

    if (!remote_rx_info)
        return 0;

    tail =3D remote_rx_info->entry;
    ...
}

When the link goes down, ntb_transport_link_cleanup() invokes ntb_free_mw()
to free the DMA memory window:

drivers/ntb/ntb_transport.c:ntb_free_mw() {
    ...
    for (i =3D num_mw; i < nt->qp_count; i +=3D nt->mw_count) {
        nt->qp_vec[i].rx_buff =3D NULL;
        WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
    }

    ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
    dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
                   mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
}

Since the memory is freed immediately without waiting for concurrent readers
or an RCU grace period, could a reader preempted after reading the non-NULL
pointer dereference it after it is freed?

[Severity: Critical]
This is a pre-existing issue, but are pending TX transactions and DMA
operations properly flushed on link down?

When the link goes down, ntb_qp_link_cleanup() waits for RX to idle and res=
ets
the QP state:

drivers/ntb/ntb_transport.c:ntb_qp_link_cleanup() {
    ...
    while (!ntb_transport_rx_idle(qp))
        fsleep(1000);

    ntb_qp_link_down_reset(qp);
    ...
}

However, it does not appear to synchronize, wait for, or cancel the TX offl=
oad
thread. The background thread can continue processing old packets:

drivers/ntb/ntb_transport.c:ntb_tx_memcpy_kthread() {
    ...
    list_for_each_entry_safe(entry, tmp, &local_list, entry) {
        list_del(&entry->entry);
        offset =3D qp->tx_mw + qp->tx_max_frame * entry->tx_index;
        ntb_memcpy_tx_on_stack(entry, offset);
    ...
}

Could delayed transactions from the old session execute and copy their
payloads to the remote memory window at their old tx_index, potentially
causing data corruption on the remote peer or PCIe AER faults if the
remote memory window is unmapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D13
