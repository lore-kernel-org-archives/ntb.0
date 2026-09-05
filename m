Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B632B989
	for <ntb@lists.linux.dev>; Sat,  5 Sep 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585723; cv=none; b=PakYPelV1/raqvsBjvD6hMN+/7WcSB3M8cfhMymCB/QJOAg4sQC2LYKiBzRoSPkDdT6031CO0if2GVGXRIxKV11j0qyQHkEHC18tGsXaC81+3T3La4JP9sGgnojSFROFQDRooYn4aFvNCQ+CFmXrkrJCh08ut4CKCXGY2zf1Vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585723; c=relaxed/simple;
	bh=XzGK9TtP+Nl6n4DC3OVRdBIDop8Xeduh4TjFj7O2TFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GKE/r2ioWKMqaKeooToYM5I+iAlCY0pYuXIV4xXws60ikrt+RWTKSzWjliB0X2gkZypltMiRr0bvgfOFHxU705GQPPbD9gIfR28xfGcdzGkTvalMwScWN5/a3KDadmlGhfvJAfQxnN+3gimK54dL/JNS8GrlPZ0VD9UmlX3h4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJzcEIp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJzcEIp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C24D1F00A3F;
	Sat,  5 Sep 2026 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788585722;
	bh=Y7+shWP6mLZFVFCmr4o0N3LcGk8ufqZN/54pzdToUzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJzcEIp8IZtJhBDyafvR5vQCMupUCmkylPHm+wjIO0lwve8CxgUyDovkFO9H+UZ0U
	 OekV091li0aKs4GAnNlReVvkJsArAqvts67m8ASOzPtqy/Jfekfsr14alzuAuqjwBd
	 sv8k5X7sjRplFDkMhhJnF6MY6bC2GTfPwBFo7dugYJwyDIqY37R6etWdbMFvW3Fap3
	 MKtnFXZ+fPCKCgXOS5zSgy11HLrCXSsojTZQvgphHj46+NyF3zAC3e622ArPUwijqU
	 wphRA9q8w4IvqNcQW1A2UrqQO//hDyXhWCh6pANRswFhsRQ40GMoZlFzcHTeIPuE9g
	 4Ju0AAnBDNe5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/4] NTB: ntb_transport: Add per-payload
 client metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260904052134.2970111-4-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 05:22:01 +0000
Message-Id: <20260905052202.4C24D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned frame sizes lead to unaligned I/O writes and memory read=
s of the payload header.
--

commit 91aff7efee260ec323eefdc5885fbc094f6643c8
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Add per-payload client metadata

This commit extends ntb_transport to carry 24 bits of opaque client metadata
alongside payload bytes. The metadata is packed into the upper bits of the
payload header's flags field and exposed via the transmit and receive
interfaces. It also adapts ntb_netdev to use the new interfaces without
metadata.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3f497a62673fd..197376376bff5 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1656,6 +1662,7 @@ static int ntb_process_rxc(struct ntb_transport_qp =
*qp)
> =20
>  	entry->rx_hdr =3D hdr;
>  	entry->rx_index =3D qp->rx_index;
> +	entry->flags =3D flags & DESC_META_MASK;

[Severity: High]
This is a pre-existing issue, but does the calculation of the frame sizes
guarantee 4-byte alignment for the payload header?

In ntb_transport_setup_qp_mw(), qp->rx_max_frame and qp->tx_max_frame are
calculated using rx_size / 2 and tx_size / 2 without forcing alignment.

This means the hdr pointer in ntb_process_rxc() can be unaligned when
reading flags:

drivers/ntb/ntb_transport.c:ntb_process_rxc() {
	...
	offset =3D qp->rx_buff + qp->rx_max_frame * qp->rx_index;
	hdr =3D offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);

	flags =3D le32_to_cpu(READ_ONCE(hdr->flags));
	...
}

Executing READ_ONCE() on an unaligned address can trigger alignment faults
(kernel panics) depending on the architecture.

Additionally, this unaligned frame size also leads to unaligned 32-bit PCIe
I/O writes in ntb_async_tx():

drivers/ntb/ntb_transport.c:ntb_async_tx() {
	...
	iowrite32(entry->len, &hdr->len);
	...
}

Unaligned memory-mapped PCIe addresses can trigger fatal hardware errors
(Unsupported Request). Can we ensure qp->rx_max_frame and qp->tx_max_frame
are properly aligned?

> =20
>  	if (len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904052134.2970=
111-1-den@valinux.co.jp?part=3D3
