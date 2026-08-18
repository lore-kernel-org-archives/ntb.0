Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBE33ADB3
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035793; cv=none; b=cGVlrdsbROzWYey8svxj5OtEtsWvA27YYcGcvTBWt6m2AXpOEuOsj4zgPP/o89snO6Q9KntEjY4SvkyqWoDPiERPTUvMxEwRvjyAmYJ/Foefwdccudz5FE+3eyh0MwR8TeO+mQU/EDV4nhh5k5mXDbTt1RhcF4FSBNOSbtmTyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035793; c=relaxed/simple;
	bh=da5n14xrVZBsVV5r7Zjuhxjb/xygFVlGpLRJ1wQ6xo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3vDnxAomQp6q1+JjxiWdBFTYUexDaLGzGOKniufuYAGYmIkwa7+/0czYvJPzpVrARXDTunfvqaokY1idA/J26ovaiwYIo3pdARwrf05JE3WvOraEuIA4LIAx3NI1Otxg6gox6IBoJ5hsdHlphMhzUUPW6w5YARzmMnKsD0DLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEp4Blkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEp4Blkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA231F000E9;
	Tue, 18 Aug 2026 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787035791;
	bh=ULxj/zg6Gws/yzhV6sy0++8IYz27C26IuTYyQLyEtB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEp4BlkxdMEAmMUKOc6EqGtc2WCq2OGMYT0CmVo57yEd6guu3UG2qUKvmRvMTrK5L
	 1F3yjyHTcsFxKNAjl/ZHdFG/fCNl8EVxB669waQmqxFh8iFMojjyNNf204pwHp2pxv
	 SVRTtsN3J6hQM7O6IJd7GNI/5xSgWvq9kSD+hwitpzNnQJukWQRecGh1U9UOcpge85
	 Ld25EVlv1F4K8Em9A6Nq/1WFmUgwZKNsvigpXjKvHtgUbWyrt9eDKfLgjAqdrd6X/U
	 2KObV7lQTNnIhOvOBMjmSHdKVj8AYpg7huhyP+B/6dgs6c38tyE/wqag3r7mVCj9s0
	 Qhl71urbCWC+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/4] NTB: ntb_transport: Use little-endian
 shared fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817064916.13278-3-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:49:51 +0000
Message-Id: <20260818064951.7EA231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite error loop on packet version mismatch in ntb_process_rxc.
- [High] Missing READ_ONCE() for `hdr->len` can lead to a double-fetch vuln=
erability, allowing a malicious peer to bypass length checks.
--

--- Patch [2]: [PATCH net-next v2 2/4] NTB: ntb_transport: Use little-endia=
n shared fields ---
commit 1e93f678e1d03757c62cfd1f9dcbe502878847d8
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Use little-endian shared fields

This commit marks the shared payload headers and RX ring tail as __le32 and
converts the accesses to coherent memory using cpu_to_le32() and le32_to_cp=
u()
respectively. This fixes byte-swapping issues when the shared fields are re=
ad
on big-endian systems.

Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index d458a8b1de114..967a5ad381646 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -1609,13 +1610,15 @@ static int ntb_process_rxc(struct ntb_transport_q=
p *qp)
>  {
>  	struct ntb_payload_header *hdr;
>  	struct ntb_queue_entry *entry;
> -	unsigned int flags;
>  	void *offset;
> +	u32 flags;
> +	u32 len;
> +	u32 ver;
> =20
>  	offset =3D qp->rx_buff + qp->rx_max_frame * qp->rx_index;
>  	hdr =3D offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
> =20
> -	flags =3D READ_ONCE(hdr->flags);
> +	flags =3D le32_to_cpu(READ_ONCE(hdr->flags));
>  	if (!(flags & DESC_DONE_FLAG)) {
>  		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
>  		qp->rx_ring_empty++;
> @@ -1623,21 +1626,23 @@ static int ntb_process_rxc(struct ntb_transport_q=
p *qp)
>  	}
> =20
>  	dma_rmb();
> +	ver =3D le32_to_cpu(hdr->ver);
> +	len =3D le32_to_cpu(hdr->len);

[Severity: High]
This is a pre-existing issue, but missing READ_ONCE() for hdr->len could
lead to a double-fetch vulnerability.

Since hdr->len is located in DMA-coherent memory shared with the peer,
reading it without READ_ONCE() allows the compiler to rematerialize the read
later in the function (e.g., when setting entry->len =3D len).=20

Could a malicious peer exploit this TOCTOU race by increasing hdr->len after
the bounds check passes, causing an out-of-bounds copy into the host's RX
buffer? Should we use READ_ONCE() for hdr->ver and hdr->len as we do for
flags?

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

[Severity: High]
This is a pre-existing issue, but does returning here cause an infinite
error loop?

If a remote peer sends a packet with a wrong sequence number (so
ver !=3D qp->rx_pkts), ntb_process_rxc() returns -EIO without clearing
DESC_DONE_FLAG or advancing qp->rx_index.

Would this cause the host to repeatedly process the same stalled descriptor
on every subsequent tasklet execution, permanently stalling the RX queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817064916.1327=
8-1-den@valinux.co.jp?part=3D2
