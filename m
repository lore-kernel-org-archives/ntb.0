Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C8381AE2
	for <ntb@lists.linux.dev>; Fri, 29 May 2026 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081548; cv=none; b=UKsPU8JSBnn/LHc3mh/IVOwkqLwDi56EjeXvtSkdjLxUYShHteKQBQ/Ibhn07FwuBZQ2LJ+ZNK4g6XE8l/u/G1wea8+0t+1+3DvDV+ZVblvlz5oHZqr1+pVtgXP+wRuS/1F0wzlFhc373tZRIZqgJxPZoalbS1BVm+w4oVkT1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081548; c=relaxed/simple;
	bh=N9md+k5QMa0liFuDLoMTt7NFhaKuT6fJuI4IVVmzTxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9n9BKXTtKMTJPfpoPg/hZUUj57zxY1/bqZOUTIEVrIFdQCSHydqT3y+X+FhVLbfTt0gF6x+17D/5+9y+OR7RYyK8RVw5yh4t+cOWxzEkL+L9RjejvwxN8zUtghU33syD6hxJI5nxEoh6S3d7GAQte7KhJDTFtT1wh3mRHM2nEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyekDe8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyekDe8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71581F00893;
	Fri, 29 May 2026 19:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780081547;
	bh=BesGDrDxKKOAaCjurwtTT5iaD7ZeBkFjE3/1gva2cbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyekDe8BbPl3ziJ11eDBG2/mQgUzGaZGT05gyW8wYjMeR0PuSWySKh+4yoP+TsJYB
	 Pr1vYHAE/64ffObXkQkb/UwWj9uyLPco5q2peWVQEJwa8koSq32MbhuXLeNc5r5Tgl
	 Xr5DyhlR1mXXlbjBP1HJt2StKSLq49+G7Zcj/HsUvjaiOmp6AehD8zFp+iWvz9qAHq
	 30USZidjyku3g863KIXQrtcIlv9LHtSJFMUewjpOm4zAaCdm2zdMkyFlW8l4qwYksz
	 3B1x+5mVdiMmk8OmM1DE+C1qwnFvszcie9/TPOfyM5vI9NmuXCUHs6NMxmB353v5Vc
	 ifBIi/oPQfbWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] NTB: epf: log teardown command failures with error code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alok Tiwari" <alok.a.tiwari@oracle.com>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260408055002.436349-1-alok.a.tiwari@oracle.com>
References: <20260408055002.436349-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:05:46 +0000
Message-Id: <20260529190546.E71581F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] ntb_free_mw() ignores the return value of ntb_mw_clear_trans()=
 before freeing DMA memory, risking memory corruption if hardware teardown =
fails.
- [High] ntb_epf_mw_set_trans() completely ignores the return value of ntb_=
epf_send_command(), leading to silent failures during memory window configu=
ration.
- [High] Missing cleanup of previously requested IRQs in the error path of =
ntb_epf_init_isr(), causing a use-after-free crash on subsequent interrupts.
- [High] The host-to-EPF command protocol cannot recover from a timeout, pe=
rmanently desynchronizing the command state machine.
- [High] Doorbell bitmask and integer indexing mismatch in ntb_epf_vec_isr(=
) and ntb_epf_db_read(), violating the NTB framework protocol.
--

commit a6cd16ced6f6513467ba1eb8d60eb48cc645ec44
Author: Alok Tiwari <alok.a.tiwari@oracle.com>

NTB: epf: log teardown command failures with error code

This commit updates ntb_epf_mw_clear_trans() to capture the return value
from ntb_epf_send_command(). It logs the error code and returns it to the
caller if the teardown command fails.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index d3ecf25a51625..0c8fc459eb7a6 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -438,11 +438,11 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *n=
tb, int pidx, int idx)
>  {
>  	struct ntb_epf_dev *ndev =3D ntb_ndev(ntb);
>  	struct device *dev =3D ndev->dev;
> -	int ret =3D 0;
> +	int ret;
> =20
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ret =3D ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);

[Severity: Critical]
This isn't a bug introduced by this patch, but now that this function corre=
ctly
returns the teardown error, does the caller ntb_free_mw() need an update to
handle it safely?

drivers/ntb/ntb_transport.c:ntb_free_mw() {
    ...
    ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
    dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
                   mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
    ...
}

Could this risk memory corruption if the hardware teardown fails? If the
teardown command times out and the hardware window remains active, the remo=
te
peer might write into physical pages that have already been returned to the
allocator.

>  	if (ret)
> -		dev_err(dev, "Failed to teardown memory window\n");
> +		dev_err(dev, "Failed to teardown memory window %d err %d\n", idx, ret);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed ntb_epf_mw_set_trans() complete=
ly
ignores the return value of ntb_epf_send_command():

drivers/ntb/hw/epf/ntb_hw_epf.c:ntb_epf_mw_set_trans() {
    ...
    ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);

    return 0;
}

Could this lead to silent failures during memory window configuration? If
ntb_epf_send_command() fails due to a hardware timeout, returning 0 might
cause the framework to assume the memory window is ready and initiate DMA
operations over an unconfigured window.

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup of previously
requested IRQs in the error path of ntb_epf_init_isr()?

drivers/ntb/hw/epf/ntb_hw_epf.c:ntb_epf_init_isr() {
    ...
err_request_irq:
    pci_free_irq_vectors(pdev);

    return ret;
}

Does this leave dangling IRQ handlers? If request_irq() fails during the lo=
op,
merely calling pci_free_irq_vectors() without calling free_irq() for the
already registered handlers could result in a use-after-free crash on
subsequent interrupts, since the ndev structure will be freed.

[Severity: High]
This isn't a bug introduced by this patch, but does the host-to-EPF command
protocol permanently desynchronize on timeout?

drivers/ntb/hw/epf/ntb_hw_epf.c:ntb_epf_send_command() {
    ...
    if (WARN_ON(timedout)) {
        ret =3D -ETIMEDOUT;
        break;
    }
    ...
}

If a command times out and the host clears the status register without abor=
ting
the state machine, might the endpoint firmware still be processing it? When=
 the
firmware eventually completes, it could write COMMAND_STATUS_OK to the stat=
us
register, causing the next command sent by the host to instantly read this
stale status.

[Severity: High]
This is a pre-existing issue, but does the doorbell implementation violate
the NTB framework protocol by returning an integer index instead of a bitma=
sk?

drivers/ntb/hw/epf/ntb_hw_epf.c:ntb_epf_vec_isr() {
    ...
    irq_no =3D irq - pci_irq_vector(ndev->ntb.pdev, 0);
    ndev->db_val =3D irq_no + 1;
    ...
}

drivers/ntb/hw/epf/ntb_hw_epf.c:ntb_epf_db_read() {
    ...
    return ndev->db_val;
}

Does the framework expect a bitmask of triggered doorbells here? Setting
ndev->db_val =3D irq_no + 1 means a trigger on doorbell 2 results in a value
of 3, which the framework might misinterpret as doorbells 0 and 1. Also, do=
es
this direct assignment clobber previously pending doorbells instead of
atomically OR-ing them together?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408055002.4363=
49-1-alok.a.tiwari@oracle.com?part=3D1
