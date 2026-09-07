Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C03BB124
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792648; cv=none; b=pjVhE/nKLZbf5IbL+crhS7GQyav5uoiyMsO2DXeMwKLyRzyOS2owcd4w3m3/D0nWdaTl5umlZyTsYYSAAO0tXX8YxnlBDeV6+v1fxn7UDUrs1QiTJAEKOFYHPQkoSQ/o1j+avpNSNw/gKddVbwPUWALdF2GlT24Q7IyqwS+V/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792648; c=relaxed/simple;
	bh=v3ery34BxqPD62rsnoJj18JHtB7GTPQLPxayMfio9Ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tL6zv3cM6fZ/XoxpeZvsj3PJc+yg0x7rTPDBt/EqP+NkNuCrb0py9VU9GNgBSe3+77gzwUgAtS5bqsXQ4+6+Swvb4sPM0bSrSRwzflJ1cCotegJG/b7vv1bSJlNlDdF6gh2/DutdUvsubh5O19/a1ZfwpEuUi9gUV3NtamAsn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4BlrLFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4BlrLFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E71F00A3A;
	Mon,  7 Sep 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792643;
	bh=3f5XSnx5BqR1Tz2h82nJCD0TMtdNGeKPar4ohy0r0DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4BlrLFCIqqBlQDWEtIIYnYw106OAF1NOpGhn453O/jkKzoGxJvXbaP0E5rgSbA2W
	 Wu+5k9aUP3AQZtjvVBUM7dLehtJjvpfNl4dPAloI4ILdUSnCLRBa/caoWD0TsQnnYm
	 fEZm7D3MVe69I0ELbPLbwnSWoyg3YZOS4HpdaiaC2NNRpVSMf8ciKbOX1XZwKvHhzw
	 EgRvyQ2Hi0o3ameN8X28lpvxQyB+LDn+XciyocO+ZfIeu3mrPfNQduPcMlbEiwniGE
	 QHiC0iV24k+/LqE3j3Ia9BtoIvAhrSIoqCZBqoSQJeJN6DCygpyE7ScdMxb6H/NcCP
	 zNeeDky2AGa6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] NTB: ntb_transport: Drain RX tasklets during link
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-12-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:50:42 +0000
Message-Id: <20260907145043.762E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In-flight RX DMA transfers are not drained during link cleanup bef=
ore freeing Memory Window (MW) buffers, leading to DMA Use-After-Free, Read=
-After-Free, and potential information leaks.
--

commit 0ffb444fbfb867ed6e5c68ad186229e763417ba5
Author: Koichiro Den <den@valinux.co.jp>
NTB: ntb_transport: Drain RX tasklets during link cleanup

This commit modifies the queue pair link cleanup process to explicitly drain
and kill the receive tasklet. It temporarily disables the queue pair link
work to prevent concurrent reactivations while resetting the queue pair.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -969,11 +969,16 @@ static void ntb_qp_link_cleanup(struct ntb_transpor=
t_qp *qp)
> =20
>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
> =20
> -	cancel_delayed_work_sync(&qp->link_work);
> +	disable_delayed_work_sync(&qp->link_work);
> +	ntb_transport_set_qp_active(qp, false);
> +	tasklet_kill(&qp->rxc_db_work);

[Severity: High]
This isn't a bug introduced by this patch, but while we are draining the
tasklet here, does this code still leave in-flight RX DMA transfers active
when the memory window is subsequently freed?

When a link down event occurs, ntb_transport_link_cleanup() calls
ntb_qp_link_cleanup(), which now successfully kills the rxc_db_work tasklet.
However, it does not appear to wait for or terminate pending DMA transfers =
on
qp->rx_dma_chan. After this function returns, ntb_transport_link_cleanup()
proceeds to call ntb_free_mw(), which returns the physical memory to the
system via dma_free_attrs().

If the hardware DMA engine is executing asynchronously, couldn't it
continue reading from or writing to this freed physical memory, potentially
causing a DMA use-after-free or data leak?

Furthermore, when the DMA asynchronous transfer completes, the
ntb_rx_copy_callback() function could be invoked:

ntb_rx_copy_callback() {
	...
	offset =3D qp->rx_buff + qp->rx_max_frame * qp->rx_index;
	...
}

Since ntb_free_mw() sets qp->rx_buff to NULL, could this result in a NULL
pointer dereference? Additionally, on success, ntb_complete_rxc() attempts
to write to entry->rx_hdr, which points into the now-freed memory window,
which could cause a software use-after-free.

Is it possible we also need to drain or explicitly terminate the DMA channel
transfers before resetting the link context and returning?

> +
>  	ntb_qp_link_down_reset(qp);
> =20
>  	if (qp->event_handler)
>  		qp->event_handler(qp->cb_data, qp->link_is_up);
> +
> +	enable_delayed_work(&qp->link_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D11
