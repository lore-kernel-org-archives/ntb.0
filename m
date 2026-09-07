Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E222EEE91
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792179; cv=none; b=qvCHgEgCDJTp4xORLxy8h6AMQ9QoJvp+5e/L78x4CD29PlhQBQDTTyC3TwtfOxrN2FWaw+ZlkjZSLQjZoU3k/8yCFXrxV+3kZj70IpTsCOAoEaO9mbqsrg/uh2AJ6U/G2XrgrkzjOPsP9lXCUP0KdcVEFa/s/F+f8k2rPI9aGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792179; c=relaxed/simple;
	bh=NRprnKOzX4XF3qLw7TYsMC+6fGp/KIZ5b2S8ssg/E8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9FEZVd3Jad3O+r3mqwkIZ5XPoh3kFvkTt/4UTo0qm87Z+1PPJ+9GXvTK0ZP9TDRsk3OXRagTQZr+2n2jdBDis2c/cq76xyph8sUFqqImwVxEmxNClzLlbrZ4pOVuORH0362ohMmFHdDAO6/MFE5yfYWjRQp5jY7AIVDYC42JYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuC/+m/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuC/+m/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767281F00A3A;
	Mon,  7 Sep 2026 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792177;
	bh=Ws7bwAXQ4/Y4za/ZtGiU6Lkw3OZomDIqX08q6VSQhbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PuC/+m/Dax64t1KzlB5ZHf1malSFGzp9bKiuDm55o9v4K6kBBWoBUN1cSKP2bedhA
	 8sWVW/QQxQUWUxQAAMatQxHpWh01mGYOlWEhV2Yz90EFWagFQw3qLFghRIXctT/mre
	 ixlaRXkDfw8NPj2lXbSyyRTQSqHJQHe1pDoHg/i+Ve/C4ESdQyWRQCC6mg0q23i/kp
	 GRQFWihoa1mmsN7nxL+OQq9Dh4POZ9jX1JSfooETS9SUekyyNPpxaiRHCuwYqLc8w4
	 lI3XcyPNH2QzyT0H7vu4IbWk6U/SDrloOEwmBwjhJFDxIkSRuCqtXqjR9I9aATpjLn
	 HnhEQaDiqb2Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-5-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:42:57 +0000
Message-Id: <20260907144257.767281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unsynchronized nullification of `qp->rx_buff` introduces a determi=
nistic NULL pointer dereference in the asynchronous DMA callback.

Pre-existing issues:
- [High] The memory window (MW) DMA buffer is freed without terminating act=
ive RX DMA engine transactions.
- [High] Incomplete fix: The nullification of `qp->remote_rx_info` is inher=
ently racy, leaving a Use-After-Free vulnerability unresolved.
- [High] If `max_num_clients` is specified and the peer NTB device has 0 me=
mory windows, `ntb_transport_probe()` will crash with a division by zero.
- [High] `ntb_transport_free()` manually frees `nt->qp_vec` before the `dev=
m`-managed MSI IRQ handler is unregistered, leading to a severe Use-After-F=
ree.
--

commit 53bf2d568bcd99aba1ed7af64d8882df388ff574
Author: Koichiro Den <den@valinux.co.jp>
Subject: NTB: ntb_transport: Clear QP pointers when freeing an MW

The commit updates ntb_free_mw() to clear rx_buff and remote_rx_info pointe=
rs
for all QPs using a memory window when it is freed. This is intended to
prevent a use-after-free scenario where link-down reset routines write to
freed memory through stale remote_rx_info pointers.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 944d38c7efd3f..763e4bb175a3a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -764,10 +764,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *n=
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

[Severity: High]
Does this code race with asynchronous DMA callbacks?
If ntb_rx_copy_callback() executes concurrently for a completed or aborted
DMA transfer, it appears to unconditionally use rx_buff without a null
check. Could this lead to a null pointer dereference in ntb_memcpy_rx() when
it calculates the offset from this newly cleared pointer?

> +		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does nullifying this
pointer leave a Time-of-Check to Time-of-Use race unresolved?

If a concurrent thread in ntb_transport_tx_free_entry() locklessly
reads remote_rx_info and checks it for null, could this thread be
preempted, allowing ntb_free_mw() to nullify the pointer and free the
memory?

Would the preempted thread then dereference the freed pointer
when it resumes?

> +	}
> +
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
>  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
>  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);

[Severity: High]
This is a pre-existing issue, but is the memory window DMA buffer freed
here without stopping active RX DMA engine transactions?

If the link goes down and ntb_transport_link_cleanup() calls ntb_free_mw(),
the active DMA engine is neither paused nor terminated. Could this
allow the hardware to continue reading from or writing to the physical
pages after they've been returned to the system allocator?

[ ... ]

Looking at ntb_transport_probe():

> 	if (max_num_clients && max_num_clients < qp_count)
> 		qp_count =3D max_num_clients;
> 	else if (nt->mw_count < qp_count)
> 		qp_count =3D nt->mw_count;

[Severity: High]
This is a pre-existing issue, but if the peer NTB device provides 0 memory
windows (so nt->mw_count is 0), and max_num_clients is specified, does
this override qp_count and bypass the safety check against nt->mw_count?

Since ntb_transport_init_queue() uses the QP_TO_MW macro:

> #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)

Could this result in a deterministic division by zero during module probe?

Looking at ntb_transport_free():

> 	kfree(nt->qp_vec);
> 	kfree(nt->mw_vec);
> 	kfree(nt);

[Severity: High]
This is a pre-existing issue, but does ntb_transport_free() manually free
nt->qp_vec before the devm-managed MSI IRQ handler is unregistered?

Since ntb_transport_setup_qp_msi() allocates the IRQ using a devm-managed
function tied to the parent device:

> 		qp->msi_irq =3D ntbm_msi_request_irq(qp->ndev, ntb_transport_isr,
> 						   KBUILD_MODNAME, qp,
> 						   &qp->msi_desc);

Could an interrupt fire after kfree(nt->qp_vec) is executed during unbind,
causing ntb_transport_isr() to access freed memory and corrupt the tasklet
list when scheduling qp->rxc_db_work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D4
