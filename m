Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AD381EA9;
	Wed, 23 Sep 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181176; cv=none; b=g6GuVe/4PiyuaNNw1Lt9t6Q8u2X+Uz/cWcSgnfjFHajPfMjcLimc72kf9IHqXL4cw7Nblq6vecy3TeXbepcvW1Pr2+QNsAqhH92z3eqX8RFMImAjCUZ2k2NwJfgUrpmSEVvJ08YV4cHCvZL/WW943lW9lB7W+Ii8vhZDSTMvYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181176; c=relaxed/simple;
	bh=wjF49XOonDau7MXl7nFZY+E2Uz7vF2fBcUBLLPSy1v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hYl3so2yV3hXKrva3nC3SzHZgupPOIyEKkWDT0tqrNQx2hCzhyi5+WHNPvu6B6pniv7EUn7/HyW1MZkmGmrtTvLWm+4E0a1T7lS+nt6uyLboVh19FY+a5ajKzRfSPPVBai4qWAwCxzTf5JcT7WzIjNqGaIfTMcDjbiyHNeOaCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7lz95iL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7lz95iL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156D71F000FF;
	Wed, 23 Sep 2026 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181174;
	bh=lwKwjUC/awiaVqVtD3fcUdEqr6iR+XjYIY3rgAsPXsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7lz95iLzV2n9MEYY57lAkWVZ3VABZTj29BV2IBylzlWZvp/VQQzgU5gp0+Afa0t0
	 eUW/LCNYv93VYuJqEN+9TNILhWHey29VpARYmJhRSam1z3hZc6DIcMy00ZhcWI6W54
	 Hzx3g3riIuxytcRh2A055OkbucgJeglcnQBS0QBNaQ9ovSthp2QFU7eFXWNXtZk0EU
	 /q+wL9NoN+v6+N90a7nJUVlctx03HbOEnzBvpZa7bwHUufSXoim1CL7lN86XTM10Lb
	 rV5wg0PVGsqduAh7jIXLtFciqwrbX4uhVNqSMG2JvXhIGwKF4SYvyach0fwDNApci2
	 MPOGxTYvRHydg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] dmaengine: change dmaengine_get_unmap_data()
 first arg to dma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, ntb@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260923-dmaengine_prep_dma_pq-v2-8-32ed65b8a9b4@nxp.com>
References: <20260923-dmaengine_prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com>
 <20260923-dmaengine_prep_dma_pq-v2-8-32ed65b8a9b4@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:32:53 +0000
Message-Id: <20260923163254.156D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dmaengine: NULL pointer dereference in mv_xor self-tests due to un=
initialized chan_dev
- [High] dmaengine: DMA device mismatch for mapping and unmapping in NTB an=
d mv_xor drivers
--

commit ddb68198d418b187ac31a8ab8dc1644ae5ebab5d
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: change dmaengine_get_unmap_data() first arg to dma_chan

Replace the struct device *dev argument with struct dma_chan *chan so calle=
rs
do not need to reach into the dma_device internals to obtain the device
pointer. The implementation now derives the device via
dmaengine_get_dma_device(chan), which correctly handles the per-channel
IOMMU mapping case.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index c4e0dce3ca64e..dec01b6264d7a 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -794,7 +794,7 @@ static int mv_chan_memcpy_self_test(struct mv_xor_cha=
n *mv_chan)
>  		goto out;
>  	}
> =20
> -	unmap =3D dmaengine_get_unmap_data(dma_chan->device->dev, 2, GFP_KERNEL=
);
> +	unmap =3D dmaengine_get_unmap_data(dma_chan, 2, GFP_KERNEL);

[Severity: High]
Does this cause a NULL pointer dereference on initialization?

The driver mv_xor runs self-tests like mv_chan_memcpy_self_test() during
probe before calling dma_async_device_register().

Because this patch changes dmaengine_get_unmap_data() to call
dmaengine_get_dma_device(chan), it unconditionally dereferences
chan->chan_dev. Since chan->chan_dev is allocated inside
dma_async_device_register(), it is NULL when the self-tests run.

Could this also lead to a device mismatch for DMA mapping?

Later in mv_chan_memcpy_self_test(), dma_map_page() still explicitly uses
dma_chan->device->dev instead of tracking with the new unmap device logic:

drivers/dma/mv_xor.c:mv_chan_memcpy_self_test() {
    ...
	src_dma =3D dma_map_page(dma_chan->device->dev, virt_to_page(src),
			       offset_in_page(src), PAGE_SIZE,
			       DMA_TO_DEVICE);
    ...
}

Mapping memory using one device pointer and unmapping it via a different one
violates the DMA API contract, which can lead to IOMMU faults and memory
leaks on platforms where the channel uses a separate device.

> @@ -927,7 +927,7 @@ mv_chan_xor_self_test(struct mv_xor_chan *mv_chan)
>  		goto out;
>  	}
> =20
> -	unmap =3D dmaengine_get_unmap_data(dma_chan->device->dev, src_count + 1,
> +	unmap =3D dmaengine_get_unmap_data(dma_chan, src_count + 1,
>  					 GFP_KERNEL);

[Severity: High]
Will this also trigger the same NULL pointer dereference here since it
runs during probe before registration?

It also has the same mapping mismatch issue where dma_map_page() explicitly
calls out dma_chan->device->dev instead of using the new unmap device logic.

[ ... ]

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..e1cb55890d72b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1532,7 +1532,7 @@ static int ntb_async_rx_submit(struct ntb_queue_ent=
ry *entry, void *offset)
>  	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
>  		goto err;
> =20
> -	unmap =3D dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
> +	unmap =3D dmaengine_get_unmap_data(chan, 2, GFP_NOWAIT);

[Severity: High]
Is there a device mismatch for DMA mapping here as well?

While unmap now uses dmaengine_get_dma_device(chan), ntb_async_rx_submit()
still explicitly maps memory using the parent device:

drivers/ntb/ntb_transport.c:ntb_async_rx_submit() {
    ...
	unmap->addr[0] =3D dma_map_phys(device->dev, virt_to_phys(offset),
				      len, DMA_TO_DEVICE, 0);
    ...
}

This mismatch between the mapping device and the unmapping device can lead
to IOMMU faults and memory leaks.

> @@ -1872,7 +1872,7 @@ static int ntb_async_tx_submit(struct ntb_transport=
_qp *qp,
>  	if (!is_dma_copy_aligned(device, buff_off, dest_off, len))
>  		goto err;
> =20
> -	unmap =3D dmaengine_get_unmap_data(device->dev, 1, GFP_NOWAIT);
> +	unmap =3D dmaengine_get_unmap_data(chan, 1, GFP_NOWAIT);

[Severity: High]
Does this suffer from the same mapping mismatch?

The dma_map_phys() call just below this still maps memory using the
parent device (device->dev).

[ ... ]

> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..5fea36432ba92 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -809,7 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	dst_vaddr =3D dst;
>  	dst_dma_addr =3D peer->dma_dst_addr + (dst_vaddr - vbase);
> =20
> -	unmap =3D dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
> +	unmap =3D dmaengine_get_unmap_data(pthr->dma_chan, 1, GFP_NOWAIT);

[Severity: High]
Might this also create a device mismatch for DMA mapping?

In perf_copy_chunk(), dma_dev is locally initialized to
pthr->dma_chan->device->dev, and used for dma_map_page():

drivers/ntb/test/ntb_perf.c:perf_copy_chunk() {
    ...
	unmap->addr[0] =3D dma_map_page(dma_dev, virt_to_page(src),
		offset_in_page(src), len, DMA_TO_DEVICE);
    ...
}

This maps memory using the parent device but unmaps it using the new
per-channel unmap device logic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dmaengine_=
prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com?part=3D8
