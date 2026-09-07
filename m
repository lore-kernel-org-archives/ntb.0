Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A83D667D
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791774; cv=none; b=mBmdpYwrRn1krdjr38WTa3dtGQxAcgOkFJicA6UfYayTZ6AIIbt2l4FzFPIzUK7sLpQzelyh4L57Fr2TrPjTlpeM2zVeH4dXNkdjjEs7OTZ/4l33rAnQO44IVsxjHNrF31qkSHP6RbxKzkdP5IqLJMVUviB3EgIUJYb4iUFWYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791774; c=relaxed/simple;
	bh=tm30OBxDXT+t9wKC47q6iGewbXcTo4fXFQmJJY8L2zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfALue6Tf4Ablm2gR5AwNkcDb2Saao4jHMhdPwwFFaXF/gn4oszuF/O1xM6dJJ0ZAfbYi9Fmp3o1IxbcH2mBSUDaBtuxceOeOL9A7obpSNQTYhHxA26ZHkle+tHTIl25LMOvh1F3Nk31ufh4C1XiHNm94TrKoLjgH0ZJLExRsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOawywIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOawywIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFC1F00A3A;
	Mon,  7 Sep 2026 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788791768;
	bh=W9XBD6ebjq7ygW9qkoiz4ddX2qMgoiX3W5a9LFr2PQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOawywICZrSBQE9r+6q+XJ2ATkGfKOs69bKFwNp/Wm58ee68UUz7R6yYB0YKIXldt
	 us1QZ7ZdylgAUJjd6aqmJ9UDR7DS7UEbReQiV9OyUFa3y1JsoM7/d15CWDDPM49STu
	 viUYHWDkBkM9ct1lqPiEiZHSeswcIszev0bcR3niTS3iWpThKOXuBMrLrMP/KFF8v+
	 IA5gNP7ZDbipDknEOurSsZ3qEGDq6Gf2Cc68ps6dPvXW94HReQ3KKwXnAmx3XjpUda
	 fRQlKN+w+zyN4jBo/kpYgkHIfZrlYHbJVeH+dMZq4FYvc8YJrrPPvEbZDWmusr9ecq
	 Lc6eu5GG0zi3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] NTB: ntb_transport: Remove the device debugfs
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-2-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:36:07 +0000
Message-Id: <20260907143607.E0AFC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error handling path in `ntb_transport_probe()` incorrectly reu=
ses the loop variable `i`, leading to an out-of-bounds `iounmap()` or a mem=
ory leak of mapped memory windows.
- [High] Use-after-free of `ntb_transport_ctx` due to cancelling background=
 works before disabling new events in `ntb_transport_free`.
- [Medium] Incorrect dma_cookie_t used for waiting on TX DMA channel comple=
tion during queue teardown.
- [Medium] Memory windows are leaked because `ntb_transport_probe` allocate=
s and maps `mw_count` elements but `ntb_transport_free` only unmaps `nt->mw=
_count` elements.
--

commit ffb52cafc91341d83b6fc4fe8bccc851bdb97f57
Author: Koichiro Den <den@valinux.co.jp>

    NTB: ntb_transport: Remove the device debugfs directory
   =20
    ntb_transport_free() removes QP debugfs directories but leaves the
    device directory. On rebind, debugfs_create_dir() fails with -EEXIST
    and QP statistics files are not recreated. Module unload masks this
    by removing the entire debugfs tree.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..3389d6ca9ebd2 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *s=
elf, struct ntb_dev *ndev)
>  err3:
>  	ntb_clear_ctx(ndev);
>  err2:
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
>  	kfree(nt->qp_vec);
>  err1:
>  	while (i--) {

[Severity: High]
This isn't a bug introduced by this patch, but does this loop correctly
unmap the memory windows if probe fails?

In ntb_transport_probe(), 'i' is used to map memory windows up to
'mw_count', but then 'i' is reused as a loop index to initialize
'qp_count' queue pairs.

Since 'qp_count' can be clamped incorrectly and end up greater than
'mw_count', if an error occurs and execution falls through to 'err1',
'i' now represents the failed queue pair index (or 'qp_count'), rather
than 'mw_count'.

Could this cause an out-of-bounds read on nt->mw_vec if qp_count >
mw_count, or a memory leak if qp_count < mw_count?

>  		mw =3D &nt->mw_vec[i];
>  		iounmap(mw->vbase);
>  	}
>  	kfree(nt->mw_vec);

[ ... ]

> @@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *s=
elf, struct ntb_dev *ndev)
>  	u64 qp_bitmap_alloc;
>  	int i;
> =20
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
> +
>  	ntb_transport_link_cleanup(nt);
>  	cancel_work_sync(&nt->link_cleanup);
>  	cancel_delayed_work_sync(&nt->link_work);

[Severity: High]
This is a pre-existing issue, but does cancelling the link works here
leave a race window for a use-after-free?

The background works are cancelled here, but ntb_clear_ctx(ndev) isn't
called until further down in ntb_transport_free().

If a hardware link event occurs in this intermediate time window,
ntb_transport_event_callback() can still be invoked by the NTB core,
which re-schedules nt->link_cleanup or nt->link_work.

Since ntb_clear_ctx() doesn't cancel pending workqueue items, could the
rescheduled work execute after 'nt' is freed?

> =20
>  	qp_bitmap_alloc =3D nt->qp_bitmap & ~nt->qp_bitmap_free;
> =20
>  	/* verify that all the qp's are freed */
>  	for (i =3D 0; i < nt->qp_count; i++) {
>  		qp =3D &nt->qp_vec[i];
>  		if (qp_bitmap_alloc & BIT_ULL(i))
>  			ntb_transport_free_queue(qp);

[Severity: Medium]
This isn't a bug introduced by this patch, but does
ntb_transport_free_queue() wait on the correct DMA cookie?

When tearing down the queue, ntb_transport_free_queue() calls:
    dma_sync_wait(chan, qp->last_cookie);

However, qp->last_cookie only tracks RX submissions because
ntb_async_tx_submit() ignores the cookie returned by dmaengine_submit()
and doesn't update it.

Since last_cookie tracks RX submissions (or is uninitialized), does this
wait have any effect on the TX channel? Could this lead to premature
termination of in-flight TX transactions?

> -		debugfs_remove_recursive(qp->debugfs_dir);
>  	}
> =20
>  	ntb_link_disable(ndev);
>  	ntb_clear_ctx(ndev);
> =20
>  	ntb_bus_remove(nt);
> =20
>  	for (i =3D nt->mw_count; i--; ) {
>  		ntb_free_mw(nt, i);
>  		iounmap(nt->mw_vec[i].vbase);

[Severity: Medium]
This is a pre-existing issue, but does this loop correctly unmap all the
allocated memory windows?

In ntb_transport_probe(), 'mw_count' memory windows are allocated and
mapped. Later in the probe function, nt->mw_count is clamped to a smaller
value if scratchpads are limited.

When ntb_transport_free() tears down the transport, it loops only up to
nt->mw_count.

Doesn't this permanently leak the remaining (mw_count - nt->mw_count)
mapped IO windows and resources?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D1
