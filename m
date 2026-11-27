Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746299;
	b=P9mko5t4Jh4Y68vHXaVlurqytQnA3VPqfcJzItWqp1cX52Jy3MGzcSRnpikl7utvPAGj
	 H6XTDxOhefWEBq9OB3wYi+Ig+hc03fO0VwkmjWdm6Hiqv888SQV7GXGWHDkhGXQ/x7Ziu
	 RF29qORs66DBZl0eCtDt9mh8BD3EFWYNWkUH5+7s/qLlz9YsBxO/EvzfFZCYXeVlAtUdh
	 97Gy/WbkC/GKNKlRSZ1KDUZ2WUJFNrYHxZ9DUvLK0TF2kdTeI5m13z7hTzt5HJDbL5FHJ
	 vMrmw3TklsSeb5GaXdFnFWNJqXxmKygr5OQMRAKFhe+2KwXMnfBvz8m0wDcB1orM/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ddebaQtihzYY25Wx7xLrikdrlTn/YxdiwcYjAPYMTCI=;
	b=qAOm8xTtaa+VjlBkF84/kl7qjtBJDQsXH7Vi3xRUsWsGy3oWVaTVH1Qm0utZIbhfkdfR
	 0A9TSkiM5fM5E2ltLfBjBsgKKqr1S45E1lxpHr/Jgg405N+mltUQZ9SABaslJyKCCIIKd
	 f+NQgcPUN73abHqLhivooAwjq3dwiH8iSFAnZl5pm+hRbr83AxjLb/3R1Ae6J4Unh7KwU
	 FMl/WoCWCdSRZZqeN/0OahER4EXWn5S0ywyX52HI0vo2EscBxXYxI/y2P/eOCoo85zKh9
	 QjeFTSC8iH3SLxEd4RRxRQH+CLNCNz7FmlGIw0jhbSesYV2AsHB6FOwa1arxQx0rHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cm4pKtzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE92606A31C
	for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cm4pKtzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1099C1F00893;
	Fri, 27 Nov 2026 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795746298;
	bh=ddebaQtihzYY25Wx7xLrikdrlTn/YxdiwcYjAPYMTCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cm4pKtzpbtBx/0IwdHo/qsxBpbsxU3qpk8Q5wLSVamQ7XwcOV0kZBnCQbx8A1PXUM
	 AQmeTXXutyftosuEUyh4v/XtaTkoRiroIrGFVqVYZDs8OFJHzbg5rZcadkODAnHTCI
	 3XPtlMwdTsuHYw8mfXhJh0Xb2y6os3z6BjUTOPatpbpE7d+5ADtbvvxQMcZzZii2OU
	 iC+Se9nPwGHqIIvnJHKwUvYcq1Wi54TAsMGVPojNOHMcJXXCIkXMK1syG11D0roIhG
	 jh/Z4PEpohsUC8PbPmgiW4e1abK7IDuud7kP1bJJMs2fPdgvc94HCG9xS0/ZubgqRE
	 KpW0oQA+bzNNA==
Message-ID: <sashiko-outbox-236450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20261127020533.2481725-14-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
 <20261127020533.2481725-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 02:24:57 +0000
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ntb_transport: ntb_free_mw() frees MW without synchronizing
  remote_rx_info
--

commit 6c932f2e3a5a220eb89ffa33367cf59f97e380ad
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Clear QP pointers when freeing an MW

This commit clears rx_buff and remote_rx_info in ntb_free_mw() for all QPs
using a memory window before freeing its backing buffer.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index fa53fcb87bad5..be1ae3789da1d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -782,10 +782,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *n=
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
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
>  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
>  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);

[Severity: Medium]
Can concurrent lockless accesses to remote_rx_info still race with
dma_free_attrs() here and trigger a use-after-free?

ntb_free_mw() clears remote_rx_info with WRITE_ONCE() and immediately frees
mw->alloc_addr without waiting for readers or writers that already loaded a
non-NULL remote_rx_info pointer via READ_ONCE().

For example, ntb_transport_link_down() runs without nt->link_event_lock
when a client closes or changes MTU:

CPU0                                    CPU1
ntb_transport_link_down(qp)
  if (qp->link_is_up)
    ntb_send_link_down(qp)
      msleep(100)
                                        ntb_transport_link_cleanup(nt)
                                          ntb_qp_link_cleanup(qp)
      ntb_qp_link_down_reset(qp)
        rri =3D READ_ONCE(qp->remote_rx_info)
                                          ntb_free_mw(nt, num_mw)
                                            WRITE_ONCE(qp->remote_rx_info,
                                                       NULL)
                                            dma_free_attrs(...,
                                                           mw->alloc_addr,
                                                           ...)
        rri->entry =3D ...  <-- use-after-free write

The same race applies to lockless readers in ntb_transport_tx_free_entry()
(called from ntb_netdev_tx_timer() or TX completion handlers, which
ntb_qp_link_cleanup() does not stop) and ntb_qp_debugfs_stats_show().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127020533.2481=
725-1-den@valinux.co.jp?part=3D13
