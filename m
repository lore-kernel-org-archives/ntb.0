Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7931EE7B7
	for <ntb@lists.linux.dev>; Sat, 15 Aug 2026 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764574; cv=none; b=mhI24hSHZ5OhEwiuD+F7ezSGXIrTWz2X+FUJhS7brsziwzoq93SpENZR3q65asQW3kklLtTHr8TyUB+eWNEW+vyfkAYXU2d+OYcaNGrvnG8D2eBveoFbGV/W9kH31N7vwJ1ZskyIfjw+kO73c/eCRz5SHXpvj+9G2R2Zje2YrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764574; c=relaxed/simple;
	bh=sFTqbajX142ladAasqrSNRDEPRzcGeE3AFaTokLdYnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glqJ75w2kHI1FHeaF75OULnfBYhIgHt41OpRVOJqikaE6jYZKcSWmURpurfUvGFsdxlgDmi1q/P0Ik+7dinJyP5ANstm6qexhkj+ut0Li+qEl5msUZVhv00e0BO9ooDHUMSDnjHM8SElFOjxfGlm4PEra+yTe4DCMQDJWlNd3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIwfjODk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIwfjODk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06B91F00A3A;
	Sat, 15 Aug 2026 03:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786764573;
	bh=OffKB2estcxg8x9iLCKf6gBJ4f4vN3CmS9K0hqWTgCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QIwfjODkZjYuUWqQehASSvqAO8WD/KZTFX0rC2SpbxV2FTb+z7GLMv4m/AcVuodNp
	 ZQFVSidRS4jhmFmZutCbdiYlKAuy8ZhwpHag0nCG/NpZg74XpxM2B+IqoktleM8ljn
	 ls+hgjYT5IBOwvSqzvUbybbCLFFZTS+mltC5R9xRMegRrQ2mldVtUCxNVy5oTxqtWZ
	 p1/SGU8noXqjaXRoTq3obhVsOAhf8oHDU+qFsRSG5QttWzRyVaID5vmbjCplEl455L
	 s+HLp4w9wHXFr7m2xMH2Meab2Vq4ExIUj3cpfQPSoGhqHybR6Ms2JdGowQbYm6Jgxf
	 /bOwOUj/vF4jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL
 across NTB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260814032913.3558500-3-den@valinux.co.jp>
References: <20260814032913.3558500-1-den@valinux.co.jp>
 <20260814032913.3558500-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 03:29:32 +0000
Message-Id: <20260815032932.C06B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition during link teardown leaves `peer_csum` flag incorr=
ectly enabled for subsequent connections, leading to dropped packets.
--

--- Patch [2]: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PART=
IAL across NTB ---
commit 361f3725205633c095fdcdcc524204c1da6ec87e
Author: Koichiro Den <den@valinux.co.jp>
Subject: net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

This commit introduces CHECKSUM_PARTIAL metadata across the NTB link to
improve throughput and reduce CPU usage on trusted PCIe fabrics. It
advertises checksum support in every frame and falls back to software
checksumming until the peer capability is observed. TX and RX checksum
features remain disabled by default.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 5c7fe6883cb93..b9a78ff695c87 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
[ ... ]
> @@ -108,6 +125,8 @@ static void ntb_netdev_event_handler(void *data, int =
link_is_up)
>  	struct net_device *ndev;
> =20
>  	ndev =3D dev->ndev;
> +	if (!link_is_up)
> +		WRITE_ONCE(dev->peer_csum, false);
> =20
>  	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
>  		   ntb_transport_link_query(q->qp), q->qid);
[ ... ]
> @@ -151,8 +170,21 @@ static void ntb_netdev_rx_handler(struct ntb_transpo=
rt_qp *qp, void *qp_data,
>  	}
> =20
>  	skb_put(skb, len);
> +	if (meta & NTB_NETDEV_META_CAP_CSUM)
> +		WRITE_ONCE(dev->peer_csum, true);

[Severity: High]
Could a race condition occur during link teardown that leaves peer_csum
incorrectly enabled?

If the NTB link goes down, ntb_netdev_event_handler() clears dev->peer_csum.
However, if the RX tasklet is concurrently processing a straggler packet
sent before the link went down, ntb_netdev_rx_handler() will execute and
unconditionally set dev->peer_csum to true when it sees the capability bit.

When a new connection is established, dev->peer_csum would not be reset. If
the new peer is an older driver that does not support checksum offload, the
local driver might incorrectly skip software checksumming and send packets
with CHECKSUM_PARTIAL. Would this cause the older peer's networking stack to
see invalid checksums and silently drop the packets?

> +
> +	if (meta & NTB_NETDEV_META_CSUM) {
> +		u16 csum_start =3D (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MA=
X;
> +		u16 csum_offset =3D meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
> +
> +		if (!skb_partial_csum_set(skb, csum_start, csum_offset))
> +			goto rx_drop;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814032913.3558=
500-1-den@valinux.co.jp?part=3D2
