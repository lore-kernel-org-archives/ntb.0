Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4A4EC646
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792423; cv=none; b=KtT1ZtVFI7u2gthOy89o7yMkIQT1FV6WQLZx6rrDKJvoKWJ6DC/v07Lk0m/9sXW3GCQ9ZUST4IHb/fheE5l+3zuwXbPbmUuMynzhsZuxj+uqm60DxtQsqqs41dpFca/qDeHFMkgoEOdKfyXqnVOFvtZZE05fbeBNbglH8aeFvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792423; c=relaxed/simple;
	bh=OSIfhh/GOlFzAgWvAcBwjyf9UhLgUSPOnlu7ch26ouU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KeBY0ytAhugzR94CalUoSogvK9VK/6ogQQp3jFsqnQuijZ8Vua7tqvildyzBB19URpjHn6HCNYcsWBBrVln7XF9lNsbX1Ras5EfPK5gEPyxfWugkBscDQXAfm4RSwcJaOCoXRF0+b9UyjpOR7MpTX+UUij7GmSdbpJA2w4G29Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkcEcjN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkcEcjN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702E41F00A3A;
	Mon,  7 Sep 2026 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792421;
	bh=XzGfxqkQsFJiUjlefX1kezoTW/np8RGVEkBhg6HwwHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkcEcjN9mWFC6O4G65Fc84SMGftflLEmaWyfnbfVSJjbdUzN/uniIsPWOEBpvhqBw
	 ZkGBJmfoL7uDWT45NPXOLUkbI4OSt9eQeKzVbDAjwZ0aVY5FJUrxMjGBY9y7Lk/g6u
	 zFa31HJC9i+xr2ygbS0DNv5KS/gz8l8BLgn47D1l2CKC/P4NsYa+8FGsGhY12vi+fk
	 dDTsoNZpKQoN0XKWzOIKtiO65Vkuh83wj4acBCxwE5TsRLUWqbkkf5fzW4e99+o0XN
	 M2dPWl+3GdR+jVtiRrDlIVh8OiteRP+5F+kjGCyY85eH4wPLUIJuHRpSy72D7Fwyz/
	 SQ5OgEVU89ihw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] NTB: ntb_transport: Publish link state after QP
 setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-7-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:47:00 +0000
Message-Id: <20260907144701.702E41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Store-Load memory ordering race between `nt->link_is_up` and `qp->=
client_ready` allows both threads to miss link scheduling, potentially dead=
locking link establishment.

Pre-existing issues:
- [High] Workqueue teardown race leading to Use-After-Free during `ntb_tran=
sport_free()`.
- [High] Missing minimum size validation for memory windows causes an integ=
er underflow when calculating tx_size and rx_size, leading to massive out-o=
f-bounds MMIO writes and kernel heap memory corruption.
--

commit 07de6dd89d3b67c6e867804f1d8d493ce3b736ff
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Publish link state after QP setup

This commit delays publishing the transport link state until all QPs' MW and
peer MSI states are set up. It uses a release store for link state publicat=
ion
and acquire loads before queuing QP link work to avoid premature execution.

Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index c8e7fc774b4fd..411017873a83b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1102,16 +1109,19 @@ static void ntb_transport_link_work(struct work_s=
truct *work)
>  			goto out1;
>  	}
> =20
>  	for (i =3D 0; i < nt->qp_count; i++) {
>  		ntb_transport_setup_qp_mw(nt, i);
>  		ntb_transport_setup_qp_peer_msi(nt, i);
> +	}
> +
> +	/* Publish the link only after every QP has been set up. */
> +	smp_store_release(&nt->link_is_up, true);
> +
> +	for (i =3D 0; i < nt->qp_count; i++) {
> +		struct ntb_transport_qp *qp =3D &nt->qp_vec[i];
> =20
>  		if (qp->client_ready)
> -			schedule_delayed_work(&qp->link_work, 0);
> +			ntb_transport_schedule_qp_link(qp, 0);

[Severity: High]
Does this code have a Store-Load memory ordering race that could lead to a
deadlock?

In this thread, ntb_transport_link_work() performs a release store to
nt->link_is_up, followed by a plain load of qp->client_ready.

Meanwhile, ntb_transport_link_up() performs a plain store to qp->client_rea=
dy,
followed by an acquire load of nt->link_is_up via
ntb_transport_schedule_qp_link():

drivers/ntb/ntb_transport.c:ntb_transport_link_up() {
    ...
    qp->client_ready =3D true;
    ntb_transport_schedule_qp_link(qp, 0);
    ...
}

Since neither smp_store_release() nor smp_load_acquire() provides a full
memory barrier (Store-Load ordering), is it possible for both threads to de=
lay
their stores in the CPU store buffer? If this happens, both threads could r=
ead
false and miss the wakeup, leaving the link permanently inactive.

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a use-after-free race during
workqueue teardown?

Looking at ntb_transport_free(), the delayed work is canceled before the
hardware events are neutralized:

drivers/ntb/ntb_transport.c:ntb_transport_free() {
    ...
    ntb_transport_link_cleanup(nt);
    cancel_work_sync(&nt->link_cleanup);
    cancel_delayed_work_sync(&nt->link_work);

    qp_bitmap_alloc =3D nt->qp_bitmap & ~nt->qp_bitmap_free;

    /* verify that all the qp's are freed */
    for (i =3D 0; i < nt->qp_count; i++) {
        qp =3D &nt->qp_vec[i];
        if (qp_bitmap_alloc & BIT_ULL(i))
            ntb_transport_free_queue(qp);
    }

    ntb_link_disable(ndev);
    ntb_clear_ctx(ndev);
    ...
}

If a hardware link event fires between cancel_delayed_work_sync() and
ntb_clear_ctx(), the interrupt handler could requeue the work item. After
ntb_transport_free() finishes freeing the context, couldn't the requeued wo=
rk
execute and dereference the freed memory?

[Severity: High]
This is a pre-existing issue, but does this code lack minimum size validati=
on
for memory windows, leading to a potential integer underflow?

In ntb_transport_init_queue(), the tx_size calculation unconditionally subt=
racts
the size of the struct:

drivers/ntb/ntb_transport.c:ntb_transport_init_queue() {
    ...
    tx_size -=3D sizeof(struct ntb_rx_info);
    ...
}

Similarly, in ntb_transport_setup_qp_mw():

drivers/ntb/ntb_transport.c:ntb_transport_setup_qp_mw() {
    ...
    rx_size -=3D sizeof(struct ntb_rx_info);
    ...
}

If tx_size or rx_size is less than 4 bytes, this will underflow. For tx_siz=
e,
setting the max_mw_size module parameter to a small value could trigger an
underflow. For rx_size, if a remote peer advertises a window size that
truncates to 0, could it underflow and lead to out-of-bounds MMIO writes
or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D6
