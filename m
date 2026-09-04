Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4180480DC3
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523915; cv=none; b=PUbQuqXo8UjbnmVkzuZg4fL9JtbPD+zPiAe9paYMZsYuKQGbvVma6Hw3r/VP114PepoFHZp5ws+sAJxxguLkwtJxfPkh9g3m9QmOJHvToliwO7T2U11NC8gqIb34AAItXYIDvl40lZOwDsTyKjCTiwa0Dttea0Gymxbe18D+mB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523915; c=relaxed/simple;
	bh=qKheNCUnYqcb1Yp5f/Yo4Ejd+mPXH13cej8b6tFbg/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lS8nKWbq1D6uUptheYeIVoRWAWhras2tZEQPsVUze3sup1iqrOUvj0rJgSBQta30P/hU83gobUhuwdRJRZ6pe/WIcz9gy9fT2TXpIsX2y+END64jwHvSnvZtT8LV0zRvroz5hc/ZfJOpI1u+l7VPFtjJQgYH/Ipsz1gLvHMvAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fImt/8Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fImt/8Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4A1F00A3D;
	Fri,  4 Sep 2026 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788523913;
	bh=dds+qI7A0dMxybKCzebNPGO9/xo/d3Mq7c5jUacjyd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fImt/8WqDSwWGH4FokEddhiB2BHcdg4v2i3VAGcogwkarvpcjwieLLxfqJDuyNyzO
	 mcUslv3d/eISlOQEwn6OxMNtjB9c9V1n1CKw8yJP+GJNDzC2tnK7OzDJRQKOhaaSsd
	 D5fAsQYIJKUc0Wda2NPJvYNYZa5OSatHDaXfi20TnOEKj2P3St47cHJwlVf3gGCti9
	 kzjxT2Hgin/DMseIv1WlRyovGfdo9D9IMCKcG79o0+gTStNO4S3f7Q3qVk2la2CKS6
	 d3uBSSdFFNYTU/uMezPypEsEJATsHiXOashHyxPOXr+UWkvZi6a8tkzGIgOmZOmaiE
	 C0Bbx0r95Bl/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ntb: fix typo "atleast" in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260904115534.11165-1-hemanth.selam@gmail.com>
References: <20260904115534.11165-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:11:52 +0000
Message-Id: <20260904121153.66F4A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing bounds v=
alidation of transport MTU and memory window sizes leads to division by zer=
o or memory corruption.
- [High] This problem wasn't introduced by this patch, but an ignored error=
 return from queue setup leaves queues in an uninitialized state, leading t=
o memory corruption.
--

commit 33255de034b5213460a8b9b93908f62b983e3d06
Author: Hemanth Selam <hemanth.selam@gmail.com>

ntb: fix typo "atleast" in comments

Correct "atleast" to "at least", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt. Only touches comments, no
code changes.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfaa..f64e65b1d9019 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -611,7 +611,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_trans=
port_ctx *nt,
> =20
>  	qp->remote_rx_info =3D qp->rx_buff + rx_size;
> =20
> -	/* Due to housekeeping, there must be atleast 2 buffs */
> +	/* Due to housekeeping, there must be at least 2 buffs */
>  	qp->rx_max_frame =3D min(transport_mtu, rx_size / 2);
>  	qp->rx_max_entry =3D rx_size / qp->rx_max_frame;

[Severity: High]
This isn't a regression introduced by this patch, but missing bounds
validation of transport MTU and memory window sizes leads to division by ze=
ro
or memory corruption here.

If the remote peer configures a memory window size smaller than
sizeof(struct ntb_rx_info), subtracting this from the unsigned rx_size (just
before this block) causes an integer underflow, leading to wild out-of-boun=
ds
pointer arithmetic.

Additionally, if the transport_mtu module parameter is set to 0, or if
rx_size / 2 is 0, qp->rx_max_frame becomes 0. Does this cause a division
by zero kernel panic on the very next line?

[Severity: High]
This is a pre-existing issue, but does ntb_transport_link_work() ignore the
-ENOMEM error returned later in this function?

ntb_transport_setup_qp_mw() allocates queue entries and returns -ENOMEM on
failure, skipping important state resets like setting
qp->remote_rx_info->entry and zeroing payload headers in qp->rx_buff.

It appears the caller, ntb_transport_link_work(), unconditionally ignores
this return value and activates the queue:

ntb_transport_link_work() {
    ...
    ntb_transport_setup_qp_mw(nt, i);
    ntb_transport_setup_qp_peer_msi(nt, i);
   =20
    if (qp->client_ready)
        schedule_delayed_work(&qp->link_work, 0);
    ...
}

Could this result in ntb_transport_rxc_db() processing uninitialized memory
as payload headers and performing an out-of-bounds memcpy in ntb_memcpy_rx(=
)?

>  	qp->rx_index =3D 0;
> @@ -1195,7 +1195,7 @@ static int ntb_transport_init_queue(struct ntb_tran=
sport_ctx *nt,
>  	tx_size -=3D sizeof(struct ntb_rx_info);
>  	qp->rx_info =3D qp->tx_mw + tx_size;
> =20
> -	/* Due to housekeeping, there must be atleast 2 buffs */
> +	/* Due to housekeeping, there must be at least 2 buffs */
>  	qp->tx_max_frame =3D min(transport_mtu, tx_size / 2);
>  	qp->tx_max_entry =3D tx_size / qp->tx_max_frame;

[Severity: High]
This is a pre-existing issue, but identical vulnerabilities exist on the
transmit queue setup path.

If tx_size is smaller than sizeof(struct ntb_rx_info), does it underflow?
And if transport_mtu or tx_size / 2 is 0, does this result in a division by
zero kernel panic when calculating qp->tx_max_entry?

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904115534.1116=
5-1-hemanth.selam@gmail.com?part=3D1
