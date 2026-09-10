Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517F396B76
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014182; cv=none; b=Gm4tkJWZWOpQC37MAp5oh/XyIwSTqAYY3AarB2oUv4Wun63HGfMglM2mRyN9MDYOAv1x3z32EJIVif7Vxua2VTJzHq88o6sqqpF11qwzab+KuPMw5ZUSk7jX1YgGH/MuoVy8M4Rl4+NWIzXtK1i2hgO7ua5T61fv4Xx/4onnFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014182; c=relaxed/simple;
	bh=LyYxPKk07QhQwr6YwqpNr0SpO4qleam1EBQ+iidVhX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kyJ5JZa/Y5lm7lNarnK7nZ91DyEs6KcCPK1yqBU0b2038hJcLiyQqrRMQQrTkG2vWdTws7Cw4BOuRH0US06cDbZqxdWzNaepM287Yx7+6tD9TZ/eZ4S5uxiLPqnH4IUq506FmrSxBkNNI+h4pbki4rGOHujQ2h/CnvFXweRpG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csv5KYqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csv5KYqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4A51F00893;
	Thu, 10 Sep 2026 04:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014181;
	bh=rtMGBzTUYPvuFu+EHuOzV3v1C/sfNzz1+HgkUJG+gdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csv5KYqn6Rwx4ocVSexaMXJlsgIqJAZB9RYUyHNovudTyYjLqdyr2XaYGaTXCy8of
	 sTpar7soTy0XpBPBmxVYXOSS7xARf9/NIoq7CqGrSTwkZGeDHC+R5KZ5x7ZXN9I10O
	 rMz+7rzeoFzOvsqXi9kZ51B/Ki0JHGd4HAV1uaYzhScNfzE4FpbX3XgKSjJr1Umqa5
	 QmuvBXjPkpKKTnL7idCc8nWAFOwAc1zt24cWLYPK8KWHiqmIrog8CWm9ts1kjidJlB
	 uD3+FeZP2CD52mhNqlrHui6iXeiDs+66hfyzdGsy8Vt7EFSeWuaGWMMXrrDmFZbeb4
	 C2ut69UAEm11Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during
 link cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-10-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:23:00 +0000
Message-Id: <20260910042301.1F4A51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race in ntb_qp_link_cleanup() on qp->event_handler leading =
to NULL pointer dereference or execution of unloaded module
--

commit c58f5dc864a1fc465af61fd23b23c2a8badd19e7
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Drain RX tasklets during link cleanup

This commit drains the RX tasklets during QP link cleanup to prevent them
from continuing to process the ring while the QP is reset. It uses
disable_delayed_work_sync() and tasklet_kill() before bringing down the QP
link, then re-enables the delayed work.

Cc: stable@vger.kernel.org

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 45d4365becac5..36797ea3ff45c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -956,11 +956,16 @@ static void ntb_qp_link_cleanup(struct ntb_transpor=
t_qp *qp)
> =20
>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
> =20
> -	cancel_delayed_work_sync(&qp->link_work);
> +	disable_delayed_work_sync(&qp->link_work);
> +	ntb_transport_set_qp_active(qp, false);
> +	tasklet_kill(&qp->rxc_db_work);
> +
>  	ntb_qp_link_down_reset(qp);
> =20
>  	if (qp->event_handler)
>  		qp->event_handler(qp->cb_data, qp->link_is_up);

[Severity: High]
This is a pre-existing issue, but is this check of qp->event_handler
vulnerable to a TOCTOU race with client driver unbinding?

Looking at ntb_qp_link_cleanup() called directly from
ntb_transport_link_cleanup_work(), it evaluates if (qp->event_handler)
without any transport-level locks.

Concurrently, if a user unbinds the client driver, ntb_transport_free_queue=
()
runs and nullifies these fields:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
    qp->cb_data =3D NULL;
    qp->rx_handler =3D NULL;
    qp->tx_handler =3D NULL;
    qp->event_handler =3D NULL;
    ...
}

If the nullification in ntb_transport_free_queue() happens after the
if (qp->event_handler) check but before the call in ntb_qp_link_cleanup(),
could this execute a NULL pointer or unloaded module code?

> +
> +	enable_delayed_work(&qp->link_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D9
