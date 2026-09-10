Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEB3AB262
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014408; cv=none; b=pL+bIl1ftS76YlUf4lr6ykeZb8hxnRL1dLx6/XkQLLtZaN449wLcDhEIC7qdbVvMqphHs8+GGTDdbqVmxqFrJdZKbmh7JqE/eH2LTuD1hGUKgjF8KJHcveOUeYJ5PgxkEhEY5j+Py9WEcYxzkvcS4HkX7hQEWPjd9+X+YIZPqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014408; c=relaxed/simple;
	bh=TlCILghAJfRprldy7naj6/P73bEwtqpHjEkVm/LiF70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkJXbdX86bgRMZuXG443+oU7EHiYU8qzGuZKgs2wpetA/l+RC8vNSUel6avzVCi+1stqJi9iNm+lleN9aikW24AfgA0ud2nMRjibq8qc9NPRJevknDsbxQpL7e+7V1xVB9+oXtELsj4eROkPox0zZ7d4PP6b52JWn519aW/O45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A69FkA6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A69FkA6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4711F000FF;
	Thu, 10 Sep 2026 04:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014405;
	bh=PmgonTyQxbXN++l6WUMTowR7GWKr1mGsWUPcgYOFSDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A69FkA6C8pDr/S781pG+0lDBLeiD5VYHs/ViOKExQKlhu0awMoXb4Jgy1/rR9xF5q
	 nbsekcGUQFzsE9ZyHr4ffy4HLmpyx+85biCe1EoXptkjjkYAt4ABrnHErDWQBNDWTR
	 D7F0t3mcnnnhU9wBjUlVoUHByUGggk6ibD3iwqN8XNT9nCZ8vVgXq6yFOBZtDsAyyx
	 b7MWNXGP9s14RQYijm43yxeE12Z7YxvCUbKQGgnDAs6u+rjSrRHK0VmHePzTS4Uyf8
	 DrMrKT6jWZeofjPDwlsOy3UztTkspW8Osjh6KmvmXcPToKFLDSFUuDjzWHedZDj/UF
	 qovdXapYITT8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-6-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:26:44 +0000
Message-Id: <20260910042645.7B4711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between `ntb_qp_link_work` and `ntb_transport_link_=
down` causes spurious link-up and breaks queue teardown synchronization.
- [High] Missing `dma_rmb()` after checking `DESC_DONE_FLAG` allows specula=
tive reading of stale DMA data.
--

commit 99af086b145ca7c747420cbf914a391c3b3216f2
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Avoid losing QP link-up requests

ntb_netdev_open() can call ntb_transport_link_up() while the transport
worker is completing setup on another CPU. Concurrent transport setup
and a client link-up request can both read the other's flag as false and
leave QP link work unqueued. The QP then stays down until another link
event or client link-up request.

Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 75d4a2e021f4e..1332d53bcfe7d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_s=
truct *work)
>  	/* Publish the link only after every QP has been set up. */
>  	smp_store_release(&nt->link_is_up, true);
> =20
> +	/*
> +	 * Prevent both sides from missing each other's flag. Pairs with
> +	 * the barrier in ntb_transport_link_up().
> +	 */
> +	smp_mb();
> +
>  	for (i =3D 0; i < nt->qp_count; i++) {
>  		struct ntb_transport_qp *qp =3D &nt->qp_vec[i];
> =20
> -		if (qp->client_ready)
> +		if (READ_ONCE(qp->client_ready))
>  			ntb_transport_schedule_qp_link(qp, 0);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does the check for
qp->client_ready in ntb_qp_link_work() safely prevent a spurious link-up if
the client simultaneously tears down the link?

If CPU 1 calls ntb_transport_link_down(), clearing qp->client_ready and
calling cancel_delayed_work_sync(&qp->link_work):

drivers/ntb/ntb_transport.c:ntb_transport_link_down() {
	...
	if (qp->link_is_up)
		ntb_send_link_down(qp);
	else
		cancel_delayed_work_sync(&qp->link_work);
}

Could CPU 0, executing ntb_qp_link_work() concurrently, fail to see
qp->client_ready as false before writing to the remote SPAD and firing the
link-up event handler?

drivers/ntb/ntb_transport.c:ntb_qp_link_work() {
	...
	if (val & BIT(qp->qp_num)) {
		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
		qp->link_is_up =3D true;
	...
}

This sequence bypasses the client's teardown intent, and forcing the link
back up after teardown may lead to use-after-free or data corruption.

[ ... ]

> @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp=
 *qp)
>  	if (!qp)
>  		return;
> =20
> -	qp->client_ready =3D true;
> +	WRITE_ONCE(qp->client_ready, true);
> +
> +	/* Pairs with the barrier in ntb_transport_link_work(). */
> +	smp_mb();
> =20
>  	ntb_transport_schedule_qp_link(qp, 0);
>  }

[Severity: High]
This is a pre-existing issue, but does ntb_process_rxc() need a dma_rmb()
barrier after checking DESC_DONE_FLAG?

When processing received packets, the done flag is checked:

drivers/ntb/ntb_transport.c:ntb_process_rxc() {
	...
	if (!(hdr->flags & DESC_DONE_FLAG)) {
		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
		qp->rx_ring_empty++;
		return -EAGAIN;
	}

	if (hdr->flags & LINK_DOWN_FLAG) {
	...
}

Without a dma_rmb() here, can weak memory architectures (like ARM64 or
PowerPC) speculatively fetch subsequent header fields and payload data
(such as hdr->ver or hdr->len) before the flag check completes, leading to
processing stale DMA data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D5
