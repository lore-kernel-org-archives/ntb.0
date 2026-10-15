Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7C3EE1FD;
	Thu, 15 Oct 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080123; cv=none; b=LuIv8qTzZP4JX8yDtgPkropTwd5VjjJpW1cpvD/229pXoejGYPAHwRBoTaXj1tBwmO4Wug9qq+IDuhx31haHI8U3Z8QQK+2gw0Gs2V0U0NGMUugDMjfbUX+o6yYDnReIcDSF8EzeEtpTQtitUvPFcrwLTEe20CBFgfe/ehrS/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080123; c=relaxed/simple;
	bh=BTOK9vXAg3zQmXUiiSRp1YtyGpunQSP+db8xwV+IB0k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z9ittyGhGXk/RfkRgkQ1uG9H7+mNWrCKE9ErHU4BPj2Ifn5WyXIWC5+PvAAcgaJdmBsT9cPoICmev3CBcSYAqbBd1sz2NLLcA0hB/j7oebs3ZfdA8/ngPlFpwljas0YL7/ydjcntpXEUbux/TcHSe1my6NBxkl1hZYTTT5uFSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7alJtNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7alJtNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1536F1F000C4;
	Thu, 15 Oct 2026 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080104;
	bh=ivICA12CVWDkze/GfK1rZrgcrk2uBHiti4UZuSeAH1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7alJtNPqavbdEPwIVttXVrewZnFmRcd6/DzWiFlWR0l9l5nHu1JrC2mTfIbQP0eR
	 jPzyQJkxVGsnblZiRm+pbtryCmSoUn4szrZ7U1ODnRlllZNZkEzQNEXoUNnnwgysNd
	 2nNks0McKW82wKZsp7+czCzJZySSYdCUKxV7MRUegSJK9OCaEWyBXJklXl/kzTMBzJ
	 DidR6xH27TiKdi/DKhd08EpNratfwmM33f9Z4IcTCR6qR15O+lCkeGddy4E0L7Dtsb
	 bnMUbCJizb6Mc+Fn4cFwcx6YyEE61su8haafp1dVJVbYevDspkMm75S70VJsyBMUgK
	 najT5dM9EW+tw==
Message-ID: <sashiko-outbox-173122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: change dmaengine_get_unmap_data()
 first arg to dma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OkRNQSBHRU5FUklDIE9GRkxP?=
 =?utf-8?b?QUQgRU5HSU5FIFNVQlNZU1RFTQ==?= <dmaengine@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0Ok5UQiBEUklWRVIgQ09SRQ==?= <ntb@lists.linux.dev>
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261015155118.3063149-1-Frank.Li@oss.nxp.com>
References: <20261015155118.3063149-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:01:43 +0000
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dmaengine: Mismatched DMA device used for mapping and unmapping
- [High] dmaengine: NULL pointer dereference in dmaengine_get_dma_device() =
during mv_xor probe
--

commit 811fe2fcd19af9f3eb46610a12e2d1dc77b628e0
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: change dmaengine_get_unmap_data() first arg to dma_chan

This commit modifies dmaengine_get_unmap_data() to accept a dma_chan
instead of a device pointer, automatically resolving the correct DMA device
for the channel. It updates various callers in the crypto, NTB, and DMA
test subsystems to match this new signature.

Link: https://lore.kernel.org/dmaengine/20260923-dmaengine_prep_dma_pq-v2-0=
-32ed65b8a9b4@nxp.com/
Link: https://lore.kernel.org/imx/b40fa0d7-fbd0-4ee8-b99c-781d08c18838@inte=
l.com/T/#t

> diff --git a/crypto/async_tx/async_memcpy.c b/crypto/async_tx/async_memcp=
y.c
> --- a/crypto/async_tx/async_memcpy.c
> +++ b/crypto/async_tx/async_memcpy.c
> @@ -39,8 +39,8 @@
>  	struct dma_async_tx_descriptor *tx =3D NULL;
>  	struct dmaengine_unmap_data *unmap =3D NULL;
> =20
> -	if (device)
> -		unmap =3D dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
> +	if (chan)
> +		unmap =3D dmaengine_get_unmap_data(chan, 2, GFP_NOWAIT);

[Severity: High]
Will this create a DMA API mapping mismatch for systems with per-channel IO=
MMUs?

The updated dmaengine_get_unmap_data() now sets unmap->dev using
dmaengine_get_dma_device(chan). If the channel supports a per-channel IOMMU,
this correctly resolves to the channel's specific device.

However, the memory mapping calls later in async_memcpy() still use the par=
ent
device:

unmap->addr[0] =3D dma_map_page(device->dev, src, src_offset, len,
                              DMA_TO_DEVICE);

When the operation finishes, dmaengine_unmap() will attempt to unmap the
memory from unmap->dev (the child IOMMU device), while it was mapped to
device->dev (the parent device). This asymmetry can cause stranded IOMMU
mappings and invalid unmap page faults.

A similar mismatch appears in drivers/ntb/ntb_transport.c in
ntb_async_rx_submit(), which maps using device->dev instead of resolving
through the channel.

[ ... ]

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -789,7 +789,7 @@
>  		goto out;
>  	}
> =20
> -	unmap =3D dmaengine_get_unmap_data(dma_chan->device->dev, 2, GFP_KERNEL=
);
> +	unmap =3D dmaengine_get_unmap_data(dma_chan, 2, GFP_KERNEL);

[Severity: High]
Does this introduce a NULL pointer dereference during device probe?

In the mv_xor driver, mv_chan_memcpy_self_test() is called during driver
initialization via mv_xor_channel_add(). This happens before the channel
is fully registered with the DMA core.

At this point, the channel's sysfs device pointer chan->dev is not yet
allocated. When this patch changes the call to pass dma_chan instead of
dma_chan->device->dev, the implementation of dmaengine_get_unmap_data() will
call dmaengine_get_dma_device(chan).

Looking at include/linux/dmaengine.h:

static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
{
        if (chan->dev->chan_dma_dev)
                return &chan->dev->device;
        return chan->device->dev;
}

This unconditionally dereferences chan->dev, which is NULL during the
self-test, preventing the mv_xor driver from loading.

>  	if (!unmap) {
>  		err =3D -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015155118.3063=
149-1-Frank.Li@oss.nxp.com?part=3D1
