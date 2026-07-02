Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C6370ACF
	for <ntb@lists.linux.dev>; Thu,  2 Jul 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976594; cv=none; b=GwWDH36Zl4AFJSV71oZ/LxTmeuD8lbxrGmy159z0VHZ/wLGx38JRRbI4ya/vnx88C0H9zoZyhw1YPboUOu9gSF7PE9H7mva0gNKLgzYd4JOeXqNsGEMUpuy2w2wT/k1GxfC+JlO2HOiMq60JPwUYYz6itD0+4ix6FMfmoohl/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976594; c=relaxed/simple;
	bh=orFI67TjtunNB+yLYLGHQsAnQ/fri0Wem5R2q0uG4Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YgX56aLN8GiRdjH9iriOYrxXknSyD4TxPS77q8qtZ2FUFfBYf+h/G3RqbC7y1fGsueSqCdoYjdOf8SqF4Zf4XtFzkb+fwK3raq6Sue2Ds9SlBLRye7BdhD+Jizm5d6I7gajwDjpwhvlFI9tV+rxDle1sfrkZbZe7PQBEmTkhPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlAitSgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlAitSgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5601F000E9;
	Thu,  2 Jul 2026 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976592;
	bh=+1YLujOUE0ZrA+jPDzVCuo/oH5QrVR6gY8P7ecJ0AhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlAitSgCdpdNnaZ4jVrfvT8O4tcABK6Q3GhBzZlpA2SYGcTDpL1zj2xiC8uW/+AXh
	 fsVSC08OJOhm8EZn4VJ74t9mhc5f5Yp5TlUAypFIE5/IT5Bt1rMPlPUHngSWXKpTiY
	 j6msANCZ8KC5k2wt41KnhMDDuRvHNGzJymhCZolu+h6oWZ/zDciBXr0T1lDzlFo6Us
	 rqVKtfZWSQD9ZxT6xV8mLH+Mxp6vbBQuru3Hzkt56DtOkyElVDwVLT78hAKN/fA4vn
	 0WB/HiyUuGDkhiQjEED8lUwIn4XlgTXUGejG9uUgrSO7ENt3RfbcdzKWjYSSMbOmkO
	 JgdX8GiDlJ3hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ntb: epf: fix PCI resource cleanup on init error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shashwat Agrawal" <shashwatagrawal473@gmail.com>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260702070628.19840-1-shashwatagrawal473@gmail.com>
References: <20260702070628.19840-1-shashwatagrawal473@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:16:31 +0000
Message-Id: <20260702071632.3C5601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver reads scratchpad counts and offsets directly from untru=
sted device MMIO memory without validating them against the mapped BAR size=
, allowing a malicious PCI device to cause out-of-bounds memory accesses.
- [High] Off-by-one error in `ntb_epf_mw_to_bar()` allows out-of-bounds arr=
ay access.
--

commit b593a66e63f557a346bb27a3a7845733ec998c5b
Author: Shashwat Agrawal <shashwatagrawal473@gmail.com>

ntb: epf: fix PCI resource cleanup on init error path
   =20
After pci_request_regions() succeeds, failures from setting the DMA
mask or mapping BARs jumped to a path that only called
pci_disable_device(). This left PCI regions claimed and BARs already
mapped with pci_iomap() were not unmapped. This patch releases regions
on those failures and unwinds iomaps in reverse order.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index c47607d4f8a7f..b42fb5f9fa75d 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
[ ... ]
> @@ -699,7 +699,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  						ndev->barno_map[BAR_PEER_SPAD], 0);
>  		if (!ndev->peer_spad_reg) {
>  			ret =3D -EIO;
> -			goto err_pci_regions;
> +			goto err_ctrl_map;
>  		}
>  	} else {
>  		spad_sz =3D 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>  		spad_off =3D readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
>  		ndev->peer_spad_reg =3D ndev->ctrl_reg + spad_off  + spad_sz;

[Severity: High]
This is a pre-existing issue, but does this code properly validate the
scratchpad count and offset before using them?

Looking at ntb_epf_init_pci(), the untrusted NTB_EPF_SPAD_COUNT and
NTB_EPF_SPAD_OFFSET values are read directly from device MMIO and added to
ndev->ctrl_reg without being validated against the mapped BAR size.

A maliciously large count or offset from the endpoint device could cause
spad_sz and peer_spad_reg to far exceed the PCI BAR size.

Later, ntb_epf_init_dev() trusts NTB_EPF_SPAD_COUNT as an upper bound, mean=
ing
clients iterating over this count with ntb_epf_peer_spad_read/write() will
dereference an out-of-bounds pointer.

This allows a maliciously controlled remote endpoint to cause unmapped or
arbitrary physical memory access, leading to a kernel panic or memory
corruption.

>  	}
> =20
>  	ndev->db_reg =3D pci_iomap(pdev, ndev->barno_map[BAR_DB], 0);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does ntb_epf_mw_to_bar() have an off-by-o=
ne
error in its bounds checking?

Looking at ntb_epf_mw_to_bar():

	if (idx < 0 || idx > ndev->mw_count) {
		dev_err(dev, "Unsupported Memory Window index %d\n", idx);
		return -EINVAL;
	}

	return ndev->barno_map[BAR_MW1 + idx];

The bounds check incorrectly permits idx =3D=3D ndev->mw_count.

If an NTB client driver requests an operation using this maximum index,
BAR_MW1 + idx will evaluate to a value exceeding the size of the
ndev->barno_map array.

Returning a garbage BAR number here and passing it to pci_resource_len() or
pci_resource_start() causes an out-of-bounds array access, potentially
returning arbitrary attacker-controlled offsets that lead to a kernel crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702070628.1984=
0-1-shashwatagrawal473@gmail.com?part=3D1
