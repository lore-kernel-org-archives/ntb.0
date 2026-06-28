Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FD305057
	for <ntb@lists.linux.dev>; Sun, 28 Jun 2026 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782636241; cv=none; b=Q9b5MHciFGiA/nG9vkNVs0V5sqlxhLeU9LmwvmJKh2PBHJbVn8Fx3IbUEj+mr6hqdKXzwxmI9Bpz6A4VZbIGn7Mpoaikb4KHh5K7PykOI+eY0MGm8k4MzuJkKYv4rWX/XH4aJDlo3Tzts+ih0gNJky3gEbhUaEP1mV3t2WN+8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782636241; c=relaxed/simple;
	bh=N0RXrkIAVmGoW23XHEHCHbp2nVbFXkAG/2Voac+kDEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BDmZbmREqHAoCdkAE+uaWbOVRbtF0Ls6JafrM9PZckzMbRi8cN7ldvedKG8J6VipvmAvossea27BcrC6xNesVc2vua3eWjp6/fid57OviL33VGHMv/G7peoFgyZ2laZLaA8QM1d8shZ8U5xQFiTGm0cqoRDZbPA0hoYD1ttcA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amVucJdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amVucJdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095991F000E9;
	Sun, 28 Jun 2026 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782636240;
	bh=tOI3GxEH7EB7pmn60ufrDKggiONJ62csPDv5FxllteU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amVucJdQ0StVQCu/x/nz/WSx1thswSxFMaX1PPCdelyBOtHfG5lFxQ92zE9tFOgJ4
	 ivIPlOIcID4yb1RWQf3c4ktKP2Q5XpS5hmpXfkcr2JNgwiy339hC/4vdUSgnBNu7Lo
	 KGgjpUP06FVNkE7XitYKiOXdidwd/f6p1hTLshaAbAhle+LK3sYkOoE78JBZlTls11
	 1n38bbOY8zTd60Vofk9RthdcD5ZhU7ivvttWxtNK71/u5/Cjr9JvajiRwLTP1tdbeD
	 k6RJw36H55LItrvX86qZNXasHWwyTEq79zKOjAkB7URWJRZA+hxWqM0tIlcuGDjdHC
	 pNpmxsos8UwOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260628083301.9781-1-vulab@iscas.ac.cn>
References: <20260628083301.9781-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 08:43:59 +0000
Message-Id: <20260628084400.095991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a call to a non-existent function `dmaeng=
ine_desc_put()`, which breaks the build, based on a flawed understanding of=
 the original code's fallthrough behavior.

Pre-existing issues:
- [High] The original error path for a failed `dmaengine_submit()` successf=
ully frees the `unmap` object via fallthrough but leaves a dangling pointer=
 in the DMA descriptor, risking a double-free or use-after-free.
- [High] The DMA abort fallback in `ntb_rx_copy_callback` uses the globally=
 advancing `qp->rx_index` instead of the entry-specific index, causing data=
 corruption.
--

commit eef44bc86f40d9c6ef1b2ad54cbff8007792501a
Author: WenTao Liang <vulab@iscas.ac.cn>

ntb: fix tx descriptor leak on dmaengine_submit failure

This commit attempts to fix a perceived kref leak in the ntb transport
when dmaengine_submit fails. It replaces a call to dmaengine_unmap_put
with dmaengine_desc_put in both the rx and tx error handling paths.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1572,7 +1572,7 @@ static int ntb_async_rx_submit(struct ntb_queue_ent=
ry *entry, void *offset)
>  	return 0;
> =20
>  err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> +	dmaengine_desc_put(txd);

[Severity: Critical]
Does this function exist in the dma engine api? I am unable to locate
dmaengine_desc_put in the tree, which might cause a compilation failure.

[Severity: High]
This is a pre-existing issue, but the original fallthrough behavior properly
balanced the unmap kref.

If dmaengine_submit fails, execution drops into err_set_unmap. In the origi=
nal
code, the fallthrough correctly freed the unmap object, but it left txd->un=
map
pointing to the freed memory. If the dma provider later reclaims the
unsubmitted descriptor and calls dma_descriptor_unmap on it, wouldn't it
dereference and double-free the dangling pointer?

>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:

[ ... ]

> @@ -1896,7 +1896,7 @@ static int ntb_async_tx_submit(struct ntb_transport=
_qp *qp,
> =20
>  	return 0;
>  err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> +	dmaengine_desc_put(txd);

[Severity: Critical]
Similar to the rx path, is dmaengine_desc_put available to be called here?

[Severity: High]
This is a pre-existing issue, but the tx path shares the same dangling poin=
ter
risk as the rx path. When dmaengine_submit fails, the unmap object is freed
via fallthrough, but the descriptor still retains the pointer. Could this a=
lso
lead to a use-after-free or double-free if the dma provider cleans up the
descriptor?

>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:


While reviewing this file, I noticed a separate issue in the rx abort path:

[Severity: High]
This is a pre-existing issue, but does ntb_rx_copy_callback use the correct
index when a dma transfer aborts and falls back to a cpu copy?

In ntb_rx_copy_callback:

ntb_rx_copy_callback() {
    ...
    void *offset =3D qp->rx_buff + qp->rx_max_frame * qp->rx_index;
    ...
}

Because qp->rx_index is globally shared and increments immediately after
packets are submitted, it might advance significantly before the asynchrono=
us
abort callback executes. Doesn't this cause the fallback copy to write data
into the wrong packet frame, potentially corrupting the payload?

Could this calculation use the constant, packet-specific entry->rx_index
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628083301.9781=
-1-vulab@iscas.ac.cn?part=3D1
