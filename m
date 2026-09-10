Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C33AAF57
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014755; cv=none; b=O74fgH0R5idCmtlKtxzTXemdNhtVWYoQINkql70X6GZAg1kZ8R0zPJ7VDMD4nyvtdvBUdHNJXDbGG8XY95IshO1eRi562xtf7H8rJfAxIcygGDLLblddhHNnqbjAXvvummazpUmmFGxrUO3/YUEYl1TmyXlVeJmbA4iYa1xgKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014755; c=relaxed/simple;
	bh=Zi7DPzpdf2TDwfbHa+bZsMy38ip9olQU/6r3w9pZRuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqTco/aDLj55yhNnEueTfsDnuUnPY7rqbF/X3GfFh6IUvRDju3AmqTiecJtDUebxka29jrOUxl2kRBZju2BTTWvR/k0gwifcWLcMYkMbeHDzaHnDKWxGdMR2Es0dnxrUClsRp1zlmr5QQhv9l/6/up6Vq1LxgoK5Ye/5WVrHrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6pvNdyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6pvNdyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D091F000FF;
	Thu, 10 Sep 2026 04:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014753;
	bh=dKIOklzjEwmMgLWdtw0m3FnYbsVzOE+vsOnp39/b4UQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6pvNdyUCRM8OYOZNTHCWNEW43+8z9PWomz/lUPWfluivrnmQN9vHZEY23uNq2plJ
	 /YnLY0meW+hAG1IwHmP/dG+vzMrk+Pt0z+JMDxdaZM5wP0Xa0ogXnQkjOivl7lgFeQ
	 e8zHfX4eWewQVHBuckTfQophr5lXdwZ5nQnr4FCC+F3JrcG/DutemUtGx6gqJ7DEw3
	 oFdnCHsFDlSIvxQC72UGiUIKut0b6+tTz3eB5o1x4iYEmIJjhcsz+A6lNVHRFxWhHJ
	 Vb8QgX7VZq9lTSl/2kXx6qY6jYtBLsDOZUQRWk6tz3RXdH8euIQlS45a39yZBOZdyB
	 8/uD6ojlQp9sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-13-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:32:32 +0000
Message-Id: <20260910043233.57D091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a serial Use-After-Free but leaves a concurren=
t TOCTOU (Time-Of-Check to Time-Of-Use) Use-After-Free unmitigated, as `WRI=
TE_ONCE()` does not protect concurrent readers from accessing freed memory.
--

commit 83701cf77653ce575ecc537dc3582d73e7b2ebcf
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Clear QP pointers when freeing an MW

This commit clears the rx_buff and remote_rx_info pointers for all QPs using
an MW when the MW is freed. This addresses a serial use-after-free where a
link-down event could cause ntb_qp_link_down_reset() to write to previously
freed MW memory.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index b949f36a4f2d9..096be87e5ede9 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -781,10 +781,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *n=
t, int num_mw)
>  {
>  	struct ntb_transport_mw *mw =3D &nt->mw_vec[num_mw];
>  	struct device *dma_dev =3D ntb_get_dma_dev(nt->ndev);
> +	unsigned int i;
> =20
>  	if (!mw->virt_addr)
>  		return;
> =20
> +	/* Drop references from every QP using this MW. */
> +	for (i =3D num_mw; i < nt->qp_count; i +=3D nt->mw_count) {
> +		nt->qp_vec[i].rx_buff =3D NULL;
> +		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this clearing mechanism leave a
concurrent Time-Of-Check to Time-Of-Use (TOCTOU) regression unmitigated?

While this patch addresses a serial use-after-free, WRITE_ONCE() does not
protect concurrent readers from accessing freed memory. If a client drops t=
he
link concurrently with a hardware link-down event triggering
ntb_transport_link_cleanup(), the client thread can fetch the remote_rx_info
pointer locklessly:

drivers/ntb/ntb_transport.c:ntb_qp_link_down_reset() {
	...
	remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
	if (remote_rx_info)
		remote_rx_info->entry =3D qp->rx_max_entry - 1;
	...
}

If the client thread is preempted after reading the pointer, and the cleanup
thread proceeds to free the memory in ntb_free_mw():

drivers/ntb/ntb_transport.c:ntb_free_mw() {
	...
	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
	...
}

When the client thread resumes, wouldn't it write to the freed DMA memory?

This same lockless TOCTOU vulnerability appears to be reachable on the
transmit hot-path in ntb_transport_tx_free_entry() and via debugfs in
ntb_qp_debugfs_stats_show().

>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
>  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
>  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D12
