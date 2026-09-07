Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218B4C0424
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791910; cv=none; b=iLTh9Wd+b/uGJVmqQvl7EVAD7IP/vV2J+FkhXu4YLz0uLbRBiQx+IwKSkOQMqft82X6jIszE/Xg24ISjpSUSwhlki+7R4GcC1QD3NAsWlD6g1dLByBiAzSTWvA1Kc+4op6Fvu0GFXjyFzqgl18OTNCrL73bsVPGkCrvQTqRgRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791910; c=relaxed/simple;
	bh=73CYl4FUijO8qllRUFR3MjVs8bP05y9EQpwVI9nYtrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmg8OTuCA3dhMI73VGjNQctSYec0ZI9e1RiQdMNobLypxA4ftga6NXCRBcqAXk1daGaMKT1+xM6To3bv908M31+KsfGn0IXnyQYMNCBEdNLsqtoW6cP9BIJthJggRnXgaEZmJyQfgdkMsLV0mVkJY5xIZtTYrJoevJpYN+XHUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwgSPO2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwgSPO2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDE91F00A3A;
	Mon,  7 Sep 2026 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788791905;
	bh=ju1GapmFGaN7F8XEJHdX6Yh6FG4hBuJXa1NIGEw00gI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwgSPO2/2SsZmTzrwe7t7kcxTjcfw/GXAdx01IC/Xi9zvNT9HGSGCgDrRz8Wm+D1v
	 +/oJQG7Zu1nCyNuRrpDeb6d2Mq8edpx74nUx5wCvQBSXtPin7MXIu7mhjNGiGq3BWt
	 MnhuRvF+DBSdChHjLvhbyuOu1ZzkzbyJA2OoqIeh4z3ftKNoTbTZ23YYQVy9Pqn6bJ
	 HNpv4Facu9cpCB6XuxuB4p/1hRM6wBXZWewlQwiwGY08YPd5AGSUZq5kwcwICStMgW
	 6/+Xtq1DyW4o9Je9Ht3HY43qWqqBjBccYi81ujuvHgJiMkrp+lv36RDJuO229jpPuT
	 LSOUjScvBIdiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-4-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:38:24 +0000
Message-Id: <20260907143824.DFDE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless NULL check of `qp->remote_rx_info` is insufficient to pro=
tect against concurrent memory window teardown, leading to Time-of-Check to=
 Time-of-Use (TOCTOU) UAF/WAF vulnerabilities.
--

commit af53bb9020271a62d936b961c8c9d17ee66f2b23
Author: Koichiro Den <den@valinux.co.jp>
NTB: ntb_transport: Prepare remote RX info accesses for MW teardown

This commit attempts to protect against concurrent memory window teardown
by adding lockless READ_ONCE()/WRITE_ONCE() and NULL checks for
qp->remote_rx_info during debugfs reads, link down resets, and TX free
entry calculations.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 55a20ae9a85e6..944d38c7efd3f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -514,7 +515,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file =
*s, void *v)
>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
> +	if (remote_rx_info)
> +		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless NULL check
fully protect against use-after-free here?

If a thread executing ntb_qp_debugfs_stats_show() reads qp->remote_rx_info
and passes the NULL check, but is then preempted before dereferencing it:

Thread 1
ntb_qp_debugfs_stats_show()
    remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
    if (remote_rx_info)

Thread 2
ntb_qp_link_cleanup()
    ntb_free_mw() clears pointer and frees backing DMA memory

Could Thread 1 then resume and dereference the locally cached pointer,
accessing freed memory?

[ ... ]
> @@ -917,9 +920,12 @@ static void ntb_qp_link_context_reset(struct ntb_tra=
nsport_qp *qp)
> =20
>  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  {
> +	struct ntb_rx_info *remote_rx_info;
> +
>  	ntb_qp_link_context_reset(qp);
> -	if (qp->remote_rx_info)
> -		qp->remote_rx_info->entry =3D qp->rx_max_entry - 1;
> +	remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
> +	if (remote_rx_info)
> +		remote_rx_info->entry =3D qp->rx_max_entry - 1;

[Severity: High]
This is a pre-existing issue, but does this write expose a similar window
for a write-after-free?

If remote_rx_info is checked for NULL, but the backing memory is freed by
ntb_free_mw() before the assignment to remote_rx_info->entry, could this
corrupt reallocated memory?

[ ... ]
> @@ -2487,8 +2493,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
> =20
>  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
>  {
> +	struct ntb_rx_info *remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
>  	unsigned int head =3D qp->tx_index;
> -	unsigned int tail =3D qp->remote_rx_info->entry;
> +	unsigned int tail;
> +
> +	if (!remote_rx_info)
> +		return 0;
> +
> +	tail =3D remote_rx_info->entry;

[Severity: High]
This is a pre-existing issue, but is the lockless NULL check in
ntb_transport_tx_free_entry() sufficient to prevent a use-after-free
read during network TX?

Similar to the debugfs read, if this is called from the network fast path
(for example, ndo_start_xmit() calling ntb_transport_tx_enqueue()) and the
pointer is cached locally, could a concurrent link state change that frees
the DMA memory cause the subsequent dereference at remote_rx_info->entry
to access freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D3
