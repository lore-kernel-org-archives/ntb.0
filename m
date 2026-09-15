Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E9469854
	for <ntb@lists.linux.dev>; Tue, 15 Sep 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462214; cv=none; b=GhdumQjr0OdFSl2IObAZ/Rpjk9D1O3fFeuKO9Mr0xeedFuX0GmqOUa/YvTM8wB/mGperrhRbPsPuRmkPdMEFShDblBk7ACTrCnZKHdDJvBT6Z0ysTR+EjAUYYnkGLFBHnT+7nQi8UfDrWYRbV9RWJwLc6oJXlfl7DN7JtdXTsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462214; c=relaxed/simple;
	bh=jH0uXS5VwOVp26Cn8TUA9/DtMT3J77CGj7bqwe0hCfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnxuvq+q0qprvZ/BZb06Z2roCr7BYz2qMlwm9FwdBDAGvmN0iMl8HrWgxIYpIOZQ4h3AmXpo4K3psz76r46L46Amwsxt2ylWicWSYO3aohd7jJhGXXkAAfDSuW57fHtCyX5r2ePeLgTqUDtYmf+IkSQ+VWP3icEcItQg/70hmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYLmzR7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYLmzR7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C8E1F000FF;
	Tue, 15 Sep 2026 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462213;
	bh=DEkz21/OUXMExu6a8NeFl5LuZqUMJowyOaHphe/mCW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYLmzR7q9fdvGFqHiNAhJY4siYA6KROQNSQ+15b6BS71q/L8h0VlyDUjL47UL+q6h
	 9MgQNTP7xrifz6MXIejRgMbn/iKnK4iz7QuvF8f/dQ3Jzznp6xz0XIbdOJged8ZDAP
	 yPpEvaXRdoQPDK9rGM+/tuAwEQtYDeVgusIj+T9Rh9sD+abBwr1KJ6Zb3g7T4voLJ6
	 xOds1V5900MPWOuCePUUn9tp3S/uBoGoaYSPv05eeZ9BB4ZQxpu2lerFAe6VB1m4+k
	 dTDHJtiBvxh9ohn3YB0CkxDVQ1KyMwS1yM9qr3TD6nLUeNBKbzQXFTU9UIot/ChQ1N
	 /PK9SKwsOJOMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 05/10] NTB: ntb_transport: Exchange client
 capabilities at link-up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260914084838.2158249-6-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:50:12 +0000
Message-Id: <20260915085012.E9C8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing write memory barrier (dma_wmb) between writing capabilitie=
s and advertising QP readiness leads to a race condition on weakly-ordered =
architectures.
--

commit b1a0deb57c0951e9f08d12fad27aa18c65b97771
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Exchange client capabilities at link-up

This commit updates the NTB transport to exchange 31-bit opaque=20
capabilities during QP link setup using scratchpads. The capabilities
are passed to the client along with the link-up event.

Link: https://lore.kernel.org/r/xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfk=
oxhiqws@n5luestlntzc/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 0b47285ef48b6..ea89eb336472a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -937,7 +942,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_=
qp *qp)
>  	ntb_qp_link_down_reset(qp);
> =20
>  	if (qp->event_handler)
> -		qp->event_handler(qp->cb_data, qp->link_is_up);
> +		qp->event_handler(qp->cb_data, qp->link_is_up, 0);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this cleanup path
contain a deadlock?

The transport cleanup work ntb_transport_link_cleanup_work() acquires
nt->link_event_lock and calls ntb_transport_link_cleanup(). That function
synchronously waits for nt->link_work via cancel_delayed_work_sync().
However, if ntb_transport_link_work() executes concurrently, its very first
action is to attempt to acquire nt->link_event_lock. This lock inversion
can deadlock the workqueues and hang the subsystem.

[Severity: High]
This is also a pre-existing issue, but is there a use-after-free risk
when a queue is freed?

If a client frees a queue using ntb_transport_free_queue(), the
qp->link_cleanup work is never cancelled. If the transport is subsequently
removed, ntb_transport_link_cleanup() only cancels works for currently
allocated QPs, skipping the one the client already freed. When the
transport then frees the nt->qp_vec array, the workqueue subsystem might
subsequently attempt to execute the pending link_cleanup work for the
freed queue, causing a use-after-free crash.

[ ... ]

> @@ -1141,10 +1146,19 @@ static void ntb_qp_link_work(struct work_struct *=
work)
>  						   link_work.work);
>  	struct pci_dev *pdev =3D qp->ndev->pdev;
>  	struct ntb_transport_ctx *nt =3D qp->transport;
> +	u32 peer_caps =3D 0;
>  	int val;
> =20
>  	WARN_ON(!nt->link_is_up);
> =20
> +	/* Pair with the release store in ntb_transport_link_up(). */
> +	if (!smp_load_acquire(&qp->client_ready))
> +		return;
> +
> +	/* Publish capabilities before QP readiness. */
> +	if (qp->caps_spad)
> +		ntb_peer_spad_write(nt->ndev, PIDX, qp->caps_spad,
> +				    READ_ONCE(qp->local_caps) | QP_CAPS_VALID);
>  	val =3D ntb_spad_read(nt->ndev, QP_LINKS);
> =20
>  	ntb_qp_up_request(qp, true);

[Severity: High]
Is a write memory barrier needed here between writing capabilities and
advertising QP readiness?

On weakly ordered architectures, the CPU or interconnect can reorder
consecutive memory writes. Without a barrier like dma_wmb(), the peer
might observe the readiness bit from ntb_qp_up_request() before the
capabilities land in memory-backed SPADs. The read side has a dma_rmb(),
but shouldn't the write side also need a dma_wmb() to guarantee order?

[ ... ]

> @@ -2439,12 +2480,17 @@ void ntb_transport_link_down(struct ntb_transport=
_qp *qp)
> =20
>  	qp->client_ready =3D false;
> =20
> +	if (!qp->link_is_up)
> +		cancel_delayed_work_sync(&qp->link_work);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does skipping work
cancellation here create a race condition?

If qp->link_is_up is true, we skip cancel_delayed_work_sync(). If
ntb_qp_link_work() happens to be executing concurrently and gets preempted
right after successfully checking client_ready, the concurrent link_down
will set client_ready to false and clear the SPADs. When ntb_qp_link_work()
later resumes, it will overwrite the cleared SPADs with valid capabilities,
corrupting the teardown state.

> +	/* Stop advertising capabilities before withdrawing QP readiness. */
> +	if (qp->caps_spad)
> +		ntb_peer_spad_write(qp->ndev, PIDX, qp->caps_spad, 0);
> +
>  	ntb_qp_up_request(qp, false);

[Severity: High]
Similar to the link-up path, is a dma_wmb() needed here?

Without a write barrier, the peer could observe the withdrawal of QP
readiness before the capabilities are actually zeroed out in the SPADs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914084838.2158=
249-1-den@valinux.co.jp?part=3D5
