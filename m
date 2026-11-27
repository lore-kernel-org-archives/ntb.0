Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795746073;
	b=1XPAUhSKfp8tRqFfpGqsc3dy6UZzdmJG5lNUomsmSLeQySpaASgDMNi7M8qmA8ZcAhmZ
	 wsT49wvvKGIbSHsSVa1FuqQRGgvX82UNTck8yKN+7Rz7PYFuSrpz02097DMCC9qm149sg
	 YIJ04C8pL064PeWCI/+vQATklYWiI767KD8CZKccO7aC/vB4i+PVm2XexBl/JUK6h7vlh
	 aAWo9MJ21zqJ5GEuUISCg48MdV9kU2WQlBU3VCrwV9gBNqDCjRqGyTc7DIT0r5dFWFZop
	 +TzeNt8nAj5dL/woI9jnjFvVfxN/R2lvNPmRycaqkEUVqEU4VwtRWAkpQK/DcF4pnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vfxjZeCSa6LfhHU/gfWfG7y7AwEE6yzFHTJDnO9XO5U=;
	b=CsJStek4/YiJSRW870B+50hmxTCaLw+IjyxEg7BVkvKdYm6a0CYsTYURQIXex1wujfFP
	 n+TvZXRFFIXs4QDoTYfr7amQGL61p0jpKudNEEDdPutUaqjeDpRVI3PYa5uiQKjmIoXJh
	 Uo5RWKGkjLiA44gwh8TdnFgL04LAXJu2s9iu91DBoko3yt/aHGj5UGuPOCfdJUEp+LL/B
	 lQIGbLAfsxFQRXh753foeqP7mVM2J6+JngfObN1y9GtNkRVdLIrRGwXZR5GmVZuOy6fth
	 Z5OnkFUwCl7lM87bxNmZEOJxuiVVZfcsSp3qjr/yj0qj12aa+803WC/JiPzVW1yb69Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldnm7dYi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F5606A31C
	for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldnm7dYi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1369A1F00897;
	Fri, 27 Nov 2026 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795746073;
	bh=vfxjZeCSa6LfhHU/gfWfG7y7AwEE6yzFHTJDnO9XO5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldnm7dYil6LeauUMG0wzzKR4gcHPLxs7wOdhdA5oatm0mcCQVUQqGatk8TY9CBzZR
	 BCiSERjs4ymgv2+s/yvsfjOS9jg4uzo4G6PIj20PH9Mn6gOZp0jdjQRpdvsVO2BOYy
	 BSV6biV/jI3N9mhIKsbXi3leWuAXoGPLbjnnYBpRXDjnipdyJ98xKNtH9TsFz8eFS0
	 nkJXhAe57SaJ/yCspkMA6zr7mD0s22hvgcVdnPPXg/6Pc/n1d5gvM3qNpRMiTxcKc0
	 3/kiohKx3V7SwIuYXYPD6ieVmHARuGQN8QGVfhvbZqQxY/3Q5yjG2K1cbaUqAwNvfx
	 jJbVS/Kv5BZAA==
Message-ID: <sashiko-outbox-236448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20261127020533.2481725-13-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
 <20261127020533.2481725-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 02:21:12 +0000
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
- [High] ntb: TOCTOU use-after-free on remote_rx_info during MW teardown
--

commit 19817e05f16664b733ed390594b75eacca761094
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Prepare remote RX info accesses for MW teardown

This commit updates qp->remote_rx_info accesses to use READ_ONCE() and
WRITE_ONCE() and check for NULL in preparation for clearing remote_rx_info
during memory window teardown, and removes the redundant free-entry
warning in ntb_async_tx().

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 0c661558a5ebe..fa53fcb87bad5 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -2559,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
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
> =20
>  	return tail >=3D head ? tail - head : qp->tx_max_entry + tail - head;
>  }

[Severity: High]
Can ntb_transport_tx_free_entry(), ntb_qp_debugfs_stats_show(), and
ntb_qp_link_down_reset() still access freed DMA memory if ntb_free_mw()
runs between READ_ONCE(qp->remote_rx_info) and the dereference of
remote_rx_info->entry?

qp->remote_rx_info points into the inbound MW DMA buffer allocated in
ntb_alloc_mw_buffer() and freed by dma_free_attrs() in ntb_free_mw().
In the next commit in the series, commit "NTB: ntb_transport: Clear QP
pointers when freeing an MW", ntb_free_mw() clears qp->remote_rx_info
with WRITE_ONCE() and immediately frees the buffer without waiting for
concurrent lockless readers or writers to finish:

CPU0                                  CPU1
ntb_netdev_tx_timer()
  ntb_transport_tx_free_entry(qp)
    remote_rx_info =3D
      READ_ONCE(qp->remote_rx_info);
    if (!remote_rx_info)
                                      ntb_transport_link_cleanup_work()
                                        ntb_transport_link_cleanup()
                                          ntb_free_mw()
                                            WRITE_ONCE(qp->remote_rx_info,
                                                       NULL);
                                            dma_free_attrs(...);
    tail =3D remote_rx_info->entry;  <-- use-after-free

During runtime link-down cleanup, ntb_qp_link_cleanup() notifies the
client to stop the subqueue, but does not stop ntb_netdev_tx_timer() or
serialize against in-flight ntb_qp_debugfs_stats_show() reads or
ntb_transport_link_down() -> ntb_send_link_down() ->
ntb_qp_link_down_reset() writes.  Any caller delayed after loading a
non-NULL remote_rx_info will read or write the freed DMA buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127020533.2481=
725-1-den@valinux.co.jp?part=3D12
