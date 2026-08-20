Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3847F2FF
	for <ntb@lists.linux.dev>; Thu, 20 Aug 2026 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246755; cv=none; b=Rxc1rsVEnSB59gIRaPWC+JW5EH0FoaPBFIqm9vlycMkwOk3fLQb/YpAgEirihBKFGmUawgVpJaypf9u4CElfs9nC98fNn53Krkiw2NZHHJJMo+kCWPk+FYiFyix4qeeycyQln1DhgF+9Du4VqbkmIgNPcSvEqQ+Q+YAMlnUSWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246755; c=relaxed/simple;
	bh=RqZ39wZl3cbunuEqTk1HwpgkK7Qtelj+phVXCM33oYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iOzfIwrUcH87xyxtIOb3bSoruCTSVpWutwA85WWLKepKIYbARLxwwDI+LfPyGtRI4Fg8wmluwoX4gwkxKA3WbkT12VHLKckEZEneEKalEvlM4JjNthHQHsovMlpEQOnl3sZKn7BwKpesebqfiHNiQ35HwLXyiww7dlJU/fz4bRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me+NO8hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me+NO8hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7009F1F000E9;
	Thu, 20 Aug 2026 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787246753;
	bh=hMt2g8/QiR+kfJ7ZK1TBW0BBY+6TIrPI8MRMjfeC63k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Me+NO8hmQwwiWvBXPthmVMK3JynPI4Ay2GMJPSBCGHQw5ryAuucJMlYM9Cr7Jrkx7
	 ykC6o5Ts7Nm6IzK9PN186vRjlMKY1E9HxKvMlPHAZxgkCiaVZb9Y9iOxbXk5ZTWJ7r
	 hr7H2xwGrIqthqJttdxIQsMlqgutLRq+X5M7Xr32rVRffMM8aKOHiOa9yW+QT6cwfl
	 2xAb9CYSEeYgg278Ur1VHVVPrfKO6jjoCdK4CXXXLwXataJJ3Up2zPvWRLqlP959Lp
	 zyJG+g/OxA9bSNGuQbqfrg4KDCj2jCdqQBigXpQW1CWpVcYZFtc1zNmYYd6ApwFEum
	 iQPE1o3It03cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: ntb_netdev: Avoid double-accounting
 netif_rx() drops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260819172539.1450821-2-den@valinux.co.jp>
References: <20260819172539.1450821-1-den@valinux.co.jp>
 <20260819172539.1450821-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:25:52 +0000
Message-Id: <20260820172553.7009F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in NTB rec=
eive processing allows a malicious remote peer to cause a massive kernel he=
ap buffer overflow.
--

--- Patch [1]: [PATCH net 1/2] net: ntb_netdev: Avoid double-accounting net=
if_rx() drops ---
commit 002045303db9fc237bf287acbb8f01a9873c837d
Author: Koichiro Den <den@valinux.co.jp>

net: ntb_netdev: Avoid double-accounting netif_rx() drops

netif_rx() already accounts packets it drops in the core rx_dropped
counter. ntb_netdev counts them again as both errors and drops.
Leave netif_rx() drops to the core. Count the packet and bytes
unconditionally since it was received successfully by the driver.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 029a4a532a104..4e53b00f016b0 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -155,13 +155,9 @@ static void ntb_netdev_rx_handler(struct ntb_transpo=
rt_qp *qp, void *qp_data,
>  	skb->ip_summed =3D CHECKSUM_NONE;
>  	skb_record_rx_queue(skb, q->qid);
> =20
> -	if (netif_rx(skb) =3D=3D NET_RX_DROP) {
> -		ndev->stats.rx_errors++;
> -		ndev->stats.rx_dropped++;
> -	} else {
> -		ndev->stats.rx_packets++;
> -		ndev->stats.rx_bytes +=3D len;
> -	}
> +	netif_rx(skb);
> +	ndev->stats.rx_packets++;
> +	ndev->stats.rx_bytes +=3D len;

[Severity: Critical]
This is a pre-existing issue, but does this expose a time-of-check to
time-of-use issue during ntb receive processing?

Looking at ntb_process_rxc() in drivers/ntb/ntb_transport.c, hdr directly
accesses the shared memory window which the remote peer can write to via
pcie. A bounds check is performed, but then hdr->len is re-read directly
from the shared memory:

drivers/ntb/ntb_transport.c:ntb_process_rxc() {
	if (hdr->len > entry->len) {
		...
	} else {
		...
		entry->len =3D hdr->len;

		ntb_async_rx(entry, offset);
	}
}

Can the remote peer modify hdr->len to a massive value after the bounds
check passes but before the second read?

If so, this bypassed length is then passed to ntb_async_rx() and
subsequently to ntb_memcpy_rx():

drivers/ntb/ntb_transport.c:ntb_memcpy_rx() {
	void *buf =3D entry->buf;
	size_t len =3D entry->len;

	memcpy(buf, offset, len);
}

Could this cause memcpy() to overflow the skb data buffer? Should the
payload header values be copied to local variables using READ_ONCE() before
validation to prevent this?

> =20
>  	skb =3D new_skb;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819172539.1450=
821-1-den@valinux.co.jp?part=3D1
