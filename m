Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889A6BB5B
	for <ntb@lists.linux.dev>; Sat, 15 Aug 2026 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764574; cv=none; b=e/LFfDtkU0YWSf1gRvqumtB7SspKMSxo/thcfqvDr+zL5zG/LcEBMAWveT/+9MJsSz3teMC/CpdI+83MP/Q7dBV9t1lujfIFs9Q7D1y/yZ1v/8kfpPz4iiRO4FsujLBic9RObKPH85Mv+ZHSjZM2pMeMbJZkssjRt4Rz4Yl/w2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764574; c=relaxed/simple;
	bh=NMd4lk7sRLzeUn0fi/SetwNZEDYcIiKwbcvfMtiyMGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqZCjYc2VfIOXC9c3yxVjK487RJNJcevddum+rk+7H0PWXH+LXpS7XDm0IyePWN6yZc0YnbVmHLQTS90+RykEJaTzht6+0b09Dx+m05PSoGL/LBkQUrAYQIQIpWHdsR9Vy3KX1+U9xsAo0t03ni4H+7wYRON/dVsCp/TIlQq8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khV+tvq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khV+tvq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151F11F000E9;
	Sat, 15 Aug 2026 03:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786764572;
	bh=zQoeZoNbMZmF0r1+2arq7wsMpOZK1f7oeXzJq75FXXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khV+tvq0y2Ol/Z4qz+nfId4vRX3A4HV/zk4i2K0h6PcbfVFizhKmzIPgBxH2mwz2w
	 2gLDKHCPgu3yssk1DU2tjWzRq2OY5FIm7bBoxkoIYtY3WAaed5LEz0MR+NUZmpI4Dg
	 T2irWnK1fkWN9f+MnwLng36H6F+6j4XP3Ws1CpbDK2DqCemRSJ5lXFfiL7KhkYtaUh
	 T6MWyiWcWmlguP0ezUBHLXtbXS2+0NaLYSdohWp7k0D1/UidIjtdLTAwkarQv/LU0I
	 sGx6HMDS3YbIJLBzrGkXz3YzQeszLJq771ZFNj9zSufCxDSwgO9kEwcsBxj52sjgip
	 MpK6MRYBAZ6WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] NTB: ntb_transport: Add per-payload client
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260814032913.3558500-2-den@valinux.co.jp>
References: <20260814032913.3558500-1-den@valinux.co.jp>
 <20260814032913.3558500-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 03:29:31 +0000
Message-Id: <20260815032932.151F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Oversized packets trigger a memory leak by passing NULL to the tx_=
handler, failing to free the SKB.
- [High] The RX descriptor polling path lacks a dma_rmb() barrier between c=
hecking the completion flag and reading the descriptor data.
- [High] The driver writes hardware descriptor fields using little-endian I=
/O accessors but reads them as native integers, breaking functionality on b=
ig-endian architectures.
--

--- Patch [1]: [PATCH net-next 1/2] NTB: ntb_transport: Add per-payload cli=
ent metadata ---
commit 581d6bed46f9b62bccae9a18ddae3275987b5c5b
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Add per-payload client metadata

This patch adds support for 24-bit per-payload client metadata in the NTB
transport payload header. It updates the transport enqueue and receive
handlers to pass this metadata without bumping the protocol version.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfaa..ea97460c118ad 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1647,6 +1653,7 @@ static int ntb_process_rxc(struct ntb_transport_qp =
*qp)
> =20
>  	entry->rx_hdr =3D hdr;
>  	entry->rx_index =3D qp->rx_index;
> +	entry->flags =3D hdr->flags & DESC_META_MASK;
> =20
>  	if (hdr->len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,

[Severity: High]
This is a pre-existing issue, but I noticed there may be a missing memory
barrier in ntb_process_rxc() when reading the descriptor.

The hardware writes the payload and the descriptor to host memory. The CPU
polls hdr->flags for DESC_DONE_FLAG, and then immediately reads fields like
hdr->ver and hdr->len.

Without a dma_rmb() after checking the flag, could weakly-ordered CPUs
speculatively fetch the descriptor fields or payload before the DMA transfer
actually commits to memory?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be an
endianness mismatch when reading these descriptor fields.

On the TX side, descriptor fields seem to be written using iowrite32(),
which implicitly performs a little-endian byte swap on big-endian CPUs.

However, in ntb_process_rxc(), they are accessed directly as native
integers (e.g., hdr->len). Won't this evaluate the little-endian bytes
incorrectly on big-endian architectures, causing version mismatches and
incorrect lengths?

[ ... ]

> @@ -2361,7 +2369,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_q=
p *qp, void *cb, void *data,
>  	entry->cb_data =3D cb;
>  	entry->buf =3D data;
>  	entry->len =3D len;
> -	entry->flags =3D 0;
> +	entry->flags =3D meta << DESC_META_SHIFT;
>  	entry->errors =3D 0;
>  	entry->tx_index =3D 0;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak during
TX when an oversized packet is enqueued.

If ntb_process_tx() detects a length overflow, it aborts transmission and
calls the transmit handler. However, it passes NULL instead of the original
buffer context to the handler:

ntb_process_tx()
    if (qp->tx_handler)
        qp->tx_handler(qp, qp->cb_data, NULL, -EIO);

Since ntb_netdev_tx_handler() explicitly checks if the skb is NULL and
returns immediately without freeing it, won't this leak the SKB if the
MTU check is bypassed or misconfigured?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814032913.3558=
500-1-den@valinux.co.jp?part=3D1
