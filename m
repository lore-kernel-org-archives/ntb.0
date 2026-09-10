Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE139A806
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014472; cv=none; b=ERVJkngp5ob2dr90YMDhVyuiTocivY7r1hTR62IbljEAoFq+kS/ruYpqB5I3G5qcwf/57uifNPPBOmzlIuEvdk3XRyEWaETsKzk9mP7I3lj9gS6NbFPqDy0lm7qg45j35iuab6CR1YphwPvQr6m2o6wz0t2Y1Ij4L+Re8aiQcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014472; c=relaxed/simple;
	bh=PGI+NoWC6Nuh+OwL1uO27Us8871k8w2PhzAbyObbCEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGGG+NKnxOb17JTA18gkUBpEOajijfjWhQuGayjkyplofIVZMsZPO95hMevX5GsFvKiSsbV0oPtZVzlg1m2WVhBodUYXBTVem99hH9OssGC6gz15R02OkghVZA2pgUfyLn0rEs3H4rrHxZIRANwVbM2e7RaKjuS72AkdxAVVa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRTgVNvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRTgVNvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244561F000FF;
	Thu, 10 Sep 2026 04:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014471;
	bh=fgCifLE2oVKBt9nxwEuiurTlRItT9AonUws7h/OnS7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRTgVNvQj1TulbfIebmaCqxUDy8JxgPyYa/3XyDITOm3pSFsl6Fk5OolT+vBU00/C
	 Waekcie8fFOOLI8lJfUsM7H8XTr5GJi2t0tF9zqivISHAySwP5CFFb694+IhBhjmgx
	 EcjfG0fvMQmE4GAiNhhnG9/F/wKsrafAPJL+un/Ld78nbBPamn+qu/zb7oKJ5Bv0YX
	 DMgPMQQBiJ9JALqBxnYJeNZu0I7rEHPjw2aIw44Ij/3kNDICxHrf11jH1rd/gzc75P
	 w+4MsBcWjkmhxc+x5jnXkx1+kliTLb7NNewXGK8Ahtvm+DhB5OHgMfofLKWXWLT5Bv
	 wPujfsqaBcV5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] NTB: ntb_transport: Clear link state before QP
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-7-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:27:50 +0000
Message-Id: <20260910042751.244561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing read memory barrier in ntb_process_rxc() allows out-of-ord=
er reads of packet headers and payload.
- [High] ntb_qp_link_work() and ntb_transport_link_down() incorrectly echo =
the peer's QP link state back to the peer instead of transmitting the local=
 state.
--

commit c193be6a6eafe61af2db594c3da12d870adbadab
Author: Koichiro Den <den@valinux.co.jp>
NTB: ntb_transport: Clear link state before QP cleanup

This commit clears the transport link state before QP cleanup to prevent
subsequent client link-up requests from starting QP link work prematurely.
It also ensures QP link work returns if the transport went down after it
was queued.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 1332d53bcfe7d..8dd1770aaaf15 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -1142,7 +1144,9 @@ static void ntb_qp_link_work(struct work_struct *wo=
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
This isn't a bug introduced by this patch, but do ntb_qp_link_work() and
ntb_transport_link_down() incorrectly echo the peer's QP link state back to
the peer instead of transmitting the local state?

When the local side brings up a QP, ntb_qp_link_work() reads the local
scratchpad via ntb_spad_read(). Because the peer writes its state to our
local scratchpad, this reads the peer's state. It then ORs its own QP bit
into this value and writes it back to the peer via ntb_peer_spad_write():

	val =3D ntb_spad_read(nt->ndev, QP_LINKS);

	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));

This same flawed echo logic applies in ntb_transport_link_down(), echoing
the peer's state back to the peer:

	val =3D ntb_spad_read(qp->ndev, QP_LINKS);

	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));

Is this echo loop intentional, or does it corrupt the independent QP link
state management by causing the peer to incorrectly believe that the local
side has brought up QPs that the peer itself brought up?

[Severity: High]
This is also a pre-existing issue, but is there a missing read memory
barrier in ntb_process_rxc() that allows out-of-order reads of packet
headers and payload?

In drivers/ntb/ntb_transport.c:ntb_process_rxc():

	if (!(hdr->flags & DESC_DONE_FLAG)) {
		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
		qp->rx_ring_empty++;
		return -EAGAIN;
	}

	if (hdr->flags & LINK_DOWN_FLAG) {
		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");

Is a dma_rmb() required after validating the DESC_DONE_FLAG to ensure
subsequent memory reads (like hdr->ver, hdr->len, and payload) are not
reordered before the flag check completes?

If the CPU speculatively reads hdr->ver, hdr->len, or the payload data befo=
re
the DESC_DONE_FLAG check is retired, and the DMA transfer hasn't fully arri=
ved
at the CPU cache yet, could stale data be processed, leading to data
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D6
