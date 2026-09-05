Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A37314B63
	for <ntb@lists.linux.dev>; Sat,  5 Sep 2026 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585723; cv=none; b=peRR5jYpUpgj5kMAZhU68/VpMC+zp7W3fs9RddiMz+bdesEOES7P7qaiX6WJ9r3J1Ihn+1xSGCobisSC9SE+ltk+7ruxvbemr6QtDZew9dTk0Tv7qC4lrePbOQPwSl7OukwBFfOR155+z9eCGzsP1F+5wxRS9gnoSCSVRL9dCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585723; c=relaxed/simple;
	bh=8u2Y4yEprtwYj3XqWHaFK+lWAY/q3lDRs6vnreXpJoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGraZaDPiw41NLB8UFJmnifFb2yKTk0JUvohp1pJFpVRodpd6cYwHTdAHFnvJpQfOmImMsnjuirdX1MnlCR5x9Rt9fGaQos0oaqTJLa5J/aQKNWGYs48PEH96l9NVWILOBUKeQbwLOZ3RPuKk1VmUtohN5RwV5a+/IYD55R+E3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5aToWPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5aToWPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54B1F00A3E;
	Sat,  5 Sep 2026 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788585721;
	bh=ArEKm+4uJ0WrCts7BdQjgyyvqTVAomKDyLxitT/T0Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5aToWPv++w0EI18MSegOBroFmOJhVLd4LtHta14njCUmIH/dQOpgGeqZLE28tWAa
	 wVgcOSFTGyLdKdl81NzPRktNIHLWHljroS/jt2LTm8E6pYw4+lrMPK0oG7r/T6Qvw2
	 N3eh2y00X+lAVxTaDvYohuuVJX+gN0NKg04oYsj9GOLJgLuO7oFfYpevt0rarbgOwq
	 RwFhK/p5DW+No3/u/UxCdNQYRijYzJOVrGOvA4j76e1eRPANIDLABbF7v/zoIKKk4o
	 6N4XATy6qJlTkcYJwR0H5/pcZxcxgM/PeRSeXemptVfqtKGXh5VljI+tgd0ByPNG3N
	 gO+2uSUBWZvfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/4] NTB: ntb_transport: Use little-endian
 shared fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260904052134.2970111-3-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 05:22:01 +0000
Message-Id: <20260905052201.8B54B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Permanent RX queue stall on version mismatch error.
- [High] Missing bounds check against `rx_max_frame` allows an attacker-con=
trolled peer to trigger an out-of-bounds read of kernel memory.
- [Medium] The queue size calculations do not guarantee that `rx_size` and =
`tx_size` are appropriately aligned, leading to unaligned MMIO writes and c=
oherent memory accesses.
--

commit 8632f1194f420fac4999a48cdd0e2e9e59e54697
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Use little-endian shared fields

ntb_transport writes payload headers and the RX ring tail with
iowrite32(), but reads peer-written copies from coherent memory as native
integers. The values are therefore byte-swapped when read on a big-endian
system.

Mark the shared fields as __le32 and convert coherent-memory accesses
accordingly. Read hdr->ver and hdr->len once so their checks and later
uses see the same values.

Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/r/20260818064951.7EA231F000E9@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 74f4f8c1c7be8..3f497a62673fd 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_trans=
port_ctx *nt,
>  		qp->rx_alloc_entry++;
>  	}
> =20
> -	qp->remote_rx_info->entry =3D qp->rx_max_entry - 1;
> +	qp->remote_rx_info->entry =3D cpu_to_le32(qp->rx_max_entry - 1);

[Severity: Medium]
This isn't a bug introduced by this patch, but the local receive buffer sli=
ce
size rx_size is calculated earlier in ntb_transport_setup_qp_mw() as:
=20
	rx_size =3D (unsigned int)mw->xlat_size / num_qps_mw;
=20
If num_qps_mw does not cleanly divide the window size, the resulting rx_size
can be unaligned.
=20
Does this misalign the qp->remote_rx_info pointer which resides at the end
of this buffer, as well as the frame boundaries qp->rx_max_frame? If so, on
strict architectures, could the unaligned READ_ONCE() and iowrite32()
accesses to the payload headers and shared fields trigger an alignment faul=
t?

> =20
>  	/* setup the hdr offsets with 0's */
>  	for (i =3D 0; i < qp->rx_max_entry; i++) {

[ ... ]

> @@ -1623,21 +1626,23 @@ static int ntb_process_rxc(struct ntb_transport_q=
p *qp)
>  	}
> =20
>  	dma_rmb();
> +	ver =3D le32_to_cpu(READ_ONCE(hdr->ver));
> +	len =3D le32_to_cpu(READ_ONCE(hdr->len));
> =20
>  	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> -		qp->qp_num, hdr->ver, hdr->len, flags);
> +		qp->qp_num, ver, len, flags);
> =20
>  	if (flags & LINK_DOWN_FLAG) {
>  		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
>  		ntb_qp_link_down(qp);
> -		hdr->flags =3D 0;
> +		hdr->flags =3D cpu_to_le32(0);
>  		return -EAGAIN;
>  	}
> =20
> -	if (hdr->ver !=3D (u32)qp->rx_pkts) {
> +	if (ver !=3D (u32)qp->rx_pkts) {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"version mismatch, expected %llu - got %u\n",
> -			qp->rx_pkts, hdr->ver);
> +			qp->rx_pkts, ver);
>  		qp->rx_err_ver++;
>  		return -EIO;
>  	}

[Severity: High]
This is a pre-existing issue, but if the received payload header version do=
es
not match the expected qp->rx_pkts in ntb_process_rxc(), the function
increments the error counter and returns -EIO without clearing the
DESC_DONE_FLAG or advancing qp->rx_index.

Since the caller aborts processing upon the error, the next time the queue =
is
processed, it will attempt to process the same packet at the same index, fa=
il
the version check again, and return -EIO.

Can this lead to a permanent stall of the RX queue until the link is
physically reset?

> @@ -1652,10 +1657,10 @@ static int ntb_process_rxc(struct ntb_transport_q=
p *qp)
>  	entry->rx_hdr =3D hdr;
>  	entry->rx_index =3D qp->rx_index;
> =20
> -	if (hdr->len > entry->len) {
> +	if (len > entry->len) {

[Severity: High]
This isn't a bug introduced by this patch, but this bounds check in
ntb_process_rxc() only validates that the received length len fits within t=
he
client-provided buffer (entry->len).

Because entry->len is derived from the local memory window size
(tx_max_frame), it can be larger than the receive frame size (rx_max_frame)
negotiated by the peer.

If a malicious peer provides a large length that is greater than the
negotiated rx_max_frame but still less than entry->len, could this bypass t=
he
check and cause ntb_memcpy_rx() or ntb_async_rx() below to copy memory
out-of-bounds from the qp->rx_buff DMA region, leaking adjacent kernel memo=
ry
to the network stack?

>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"receive buffer overflow! Wanted %d got %d\n",
> -			hdr->len, entry->len);
> +			len, entry->len);
>  		qp->rx_err_oflow++;
> =20
>  		entry->len =3D -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904052134.2970=
111-1-den@valinux.co.jp?part=3D2
