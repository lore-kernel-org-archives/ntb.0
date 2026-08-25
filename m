Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3056306B08
	for <ntb@lists.linux.dev>; Tue, 25 Aug 2026 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626662; cv=none; b=FAfSezg+pBoKk91QD2zPX2hDHyyUyZ4zWDnsgy/FeKmCgv42m6uLd/a8Jd184ih1eAn+cszGdwKDevTUar6rBDfIvKixj17b6SpQY3kx1AyQYt28rdIA0lySuylgMvoCe0C/tLezwzL4J/FNZKa4JAZ/AJkwNN5ENb1bCmb91GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626662; c=relaxed/simple;
	bh=LkMiSftniiJwlUwpfilNvIcpRpj/AcxAbgLOAdsONKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdhtGik3NVqSqUaafEvVxGFKp+9Dc7XMCaGvuGA/FR8Vs1v6iZ/tSq0mH5k/El3guI1gu5JKG9qkPB1zya1OEpeEecBvq5cqAXu+pjXrhD7cQqU+741ig8BfTal+h4sna/a+IJ/1ZM/PrcyAIh4vjIfzdNfiWsuP8qD20FpkJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avd/ANCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avd/ANCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF271F00A3A;
	Tue, 25 Aug 2026 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626660;
	bh=sYmTIqEnZxbiYxJ/fHXXgeUyq4gWaySFCK/vbRvCi1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avd/ANCMCZ8MEjjerLuF0w8VYLY5/e4UarciHwelKc6ctX7MiJ4zTJxF6n9Qff7PN
	 IYvbAIDY6G5ikarfj9pvFyBaqHBdJfXQUzbH+9LlHA1kIckf4vfCd5hjvmRBWn1/Dc
	 0SctyxKO8ZHy9au5YMX39mt5Zr5K7e6EGGCkfh44KAtlbGzn0DKn96ATjvyPLYt9cV
	 QoLXFJ4aTNua1jTnkEwxWHIkaGNsti/HwgEMVWvAPmbNW4nQ0K/SvYcVlgH/LyQ+IT
	 anW5QuuFs2A/HyCRrpP+ggRh22KQhpsLfwzUMOI2ek5YB4Wu6fIGlcyS20orhUQvBr
	 EIyplLW96f/HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: ntb_netdev: Fix statistics races
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260824025720.3520288-1-den@valinux.co.jp>
References: <20260824025720.3520288-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:57:39 +0000
Message-Id: <20260825025740.5AF271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pending RX and TX entries are leaked because their associated SKB =
buffers are not freed when the transport queue is destroyed.
--

--- Patch [1]: [PATCH net] net: ntb_netdev: Fix statistics races ---
commit fc558d0a991ec95505df001446270417159e2eaf
Author: Koichiro Den <den@valinux.co.jp>

net: ntb_netdev: Fix statistics races

ntb_netdev updates shared net_device stats from per-QP RX and TX callbacks.
This commit shifts the driver to use core-managed per-CPU dstats. It also
tears down transport queues from ndo_uninit before the core frees dstats.

> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 9c171697e7620..6a1e58d5d7d67 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
[ ... ]
> @@ -427,7 +428,19 @@ static int ntb_netdev_change_mtu(struct net_device *=
ndev, int new_mtu)
>  	return rc;
>  }
> =20
> +static void ntb_netdev_uninit(struct net_device *ndev)
> +{
> +	struct ntb_netdev *dev =3D netdev_priv(ndev);
> +	unsigned int q;
> +
> +	for (q =3D 0; q < dev->num_queues; q++) {
> +		ntb_transport_free_queue(dev->queues[q].qp);

[Severity: High]
This is a pre-existing issue, but does calling ntb_transport_free_queue()
leak the SKBs attached to pending packets?

Looking at ntb_transport_free_queue() in drivers/ntb/ntb_transport.c,
it cleans up pending items from the queues like this:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    while ((entry =3D ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
        dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
        kfree(entry);
    }
    ...
}

It frees the entry, but it doesn't seem to free or return the attached
client buffer (entry->cb_data). Since ntb_netdev uses cb_data to store
allocated SKBs, does this unconditionally leak any in-flight packets
when the queue is destroyed?

> +		dev->queues[q].qp =3D NULL;
> +	}
> +}
> +
>  static const struct net_device_ops ntb_netdev_ops =3D {
> +	.ndo_uninit =3D ntb_netdev_uninit,
>  	.ndo_open =3D ntb_netdev_open,
>  	.ndo_stop =3D ntb_netdev_close,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824025720.3520=
288-1-den@valinux.co.jp?part=3D1
