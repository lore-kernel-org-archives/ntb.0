Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE73AEB2D
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014714; cv=none; b=X2ZEzadA+HAlLlQ48/kla+aai2fryGJkqmqE800Q04/OstanfIvooZX6WKwcdpLE9QCNWUwrOIJRI6g81poBDuMXUHsv94S4jPudo8kAI/nSTO0slFZSjgH7E7y4eBy+HHqqg459awYSP12JGAiIxIGWLFt+kAZQJ6sgiLcknP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014714; c=relaxed/simple;
	bh=uhynkTXG66uWX7nyNHCc9n9THZcxcJIMkwEeh2vthq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdV7Ezj1sbd6nf/7L8rntl1XfqamLLc5uTDHtRo4DUatTci6aiE2Cf0OOUSkEbeFKqea1wm03k9J9JUWVB2+hdBrB8OKqx976fwv/1w+fPF3EkEA5/JNPo7EycD4qPxADd2qdGSdcOssL4RnIZYNDbWijzoC841JsdHkUW6J6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRdglYcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRdglYcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2EE1F000FF;
	Thu, 10 Sep 2026 04:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014712;
	bh=EZMXKNOXRUbP+9F5pBT75R/vchbJEj7uoolupsjawzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRdglYcs+JkcOOMFVEVlpOQ1W0EOCEY8fteiZ140x6TUnEhHMUOz2jU3+YBoL+GUZ
	 zOQItAJslsksUw/HYLKZ1pr9Dc3LTJROok/ZhrQ/j+FO+7RlpMYaqO/zLnnKOQsMkx
	 oZjcQBzObc3LaC6GTfOaAX6TMJ+Fc9Z/YeM1xQkI4DIRN34Ib81mnmUxqN5wCkcpDL
	 7thrZ23xfRIyH2B7NwI5MT7WHz2hEYFiLgVHI5My9P5onoXZ2Z0Lso7AAY3aF6Utgl
	 H/sxwqpCYnlI8V+9Pjv35Ls2cIaRSgkvrAPhRwu128wHMlcrhdJ/KE8yTymbxu+zA1
	 foJrnP9mhrtzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-12-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:31:52 +0000
Message-Id: <20260910043152.9C2EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Returning 0 from `ntb_transport_tx_free_entry()` when `remote_rx=
_info` is NULL can trigger a spurious `WARN_ON_ONCE` in `ntb_async_tx()`.

Pre-existing issues:
- [High] Lockless Time-of-Check to Time-of-Use (TOCTOU) race leading to a U=
se-After-Free on `remote_rx_info` during Memory Window (MW) teardown.
--

commit 82666f622eff311c2e1a37c138e32f49823001fc
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Prepare remote RX info accesses for MW teardown

The commit uses READ_ONCE() and WRITE_ONCE() for remote_rx_info to handle
lockless accesses during link cleanup and MW freeing. It also adds a NULL
check before dereferencing the pointer.

Cc: stable@vger.kernel.org

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 7ccba2c04f548..b949f36a4f2d9 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -489,6 +489,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
>  static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  {
>  	struct ntb_transport_qp *qp =3D s->private;
> +	struct ntb_rx_info *remote_rx_info;
> =20
>  	if (!qp || !qp->link_is_up)
>  		return 0;
> @@ -516,7 +517,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file =
*s, void *v)
>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	remote_rx_info =3D READ_ONCE(qp->remote_rx_info);
> +	if (remote_rx_info)
> +		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);

[Severity: High]
This is a pre-existing issue, but does checking the pointer for NULL
actually prevent a use-after-free here?

If a reader thread reads a non-NULL pointer and gets preempted, a concurrent
link-down event could trigger ntb_free_mw(), synchronously unmapping and
freeing the DMA memory.

When the reader resumes, wouldn't dereferencing its local remote_rx_info
pointer result in a use-after-free on kernel DMA memory since the underlying
Memory Window (MW) is no longer valid?

[ ... ]

> @@ -2558,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
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

[Severity: Medium]
Could this new return path trigger a spurious WARN_ON_ONCE in ntb_async_tx(=
)?

In ntb_process_tx(), the code verifies ntb_transport_tx_free_entry() space
before executing ntb_async_tx(). If a concurrent MW teardown sets
qp->remote_rx_info to NULL right at this moment, the secondary check inside
ntb_async_tx() would hit this new return 0 path.

Since it evaluates to zero unexpectedly, would this trip the WARN_ON_ONCE
even though there was no actual queue exhaustion or invalid usage?

> +
> +	tail =3D remote_rx_info->entry;

[Severity: High]
This is a pre-existing issue, but is it possible for a time-of-check to
time-of-use (TOCTOU) race to occur here during Memory Window (MW) teardown?

Just like in ntb_qp_debugfs_stats_show(), if a concurrent link-down event
frees the MW after the NULL check but before this dereference, wouldn't
this lead to a use-after-free?

> =20
>  	return tail >=3D head ? tail - head : qp->tx_max_entry + tail - head;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D11
