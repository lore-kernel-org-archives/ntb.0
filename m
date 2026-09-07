Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B547AF57
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792312; cv=none; b=KgCfXtkiCZLR5u+4wlKP2/fawZg+RQQD873jRDv9R4m2eKrHTLF4wYuP6oF+cspE5LLBG4wXDrzvu1wXFTvY2FOMXRdlivVHFPt7ZAlzvBSUWJMV0G8secGSGFzEYIjEM5YzTCo7Ix0vwLhRfMhyl9HLZwBOCO6fRMLfQyJIi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792312; c=relaxed/simple;
	bh=uYctbL40dbqUgEhqpNniPZUVUA0CDUGbKDzA6wVItf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OhaTTphJoaWX2gQ+kmem8RqwnQoNYvDWX0cqF3k4+/cEkl5PsKylaSZJgy18JXmeroZI8iyMu5maMo/IEOqmeYexqeBA72/mw9cz/TMeB9LAglPQa4SKFAVwcYGy7OGd1EyahM/LD3xd6nUb1BKRfj+PrOyk/Hnwm8+/rNK9Bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7jEQ8ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7jEQ8ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F241F00A3A;
	Mon,  7 Sep 2026 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792310;
	bh=1sigNkhAzlz1VcYqjkjKcem0yI/nD3pXkTjdK343BMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a7jEQ8dsZfrFbxvOLKb75HVpEfX4DTH/Soz+NN/LHLu+9Bl9n0gCX0+54+AzTKRDI
	 aptBZhAWKtmjz1r2GdCyBXmjXXNt2MxnbNQLdg4gIpvCcXLCbQ6A18u9q3HzDdC46/
	 wEQN4VmdPo7BSCFJ3ebZkv9JVR+PW5r2zdz4YRSGS8+5kxZjY1ML1dLbiVvu279PYZ
	 76Y+tCLsz/X18KyNQMzkKiUV/JVNjH88gpp+gXi+Z9rdYNEV2hBwhZvLwwu5LeWAif
	 55BHvGSU33W4n+CxpyQiFmrWCSHfOTJvKPFQdxMR+oAtGYRwXS87pDGzuCbMVoZ26w
	 /LWe/TNl31Jkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-6-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:45:09 +0000
Message-Id: <20260907144509.C0F241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in ntb_transport_free() leading to use-after-free i=
f a link event fires during removal.
--

commit 64264af94da292ce3428824a7efe28f3ad839b17
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Avoid deadlock when cancelling link work

This commit prevents a deadlock in ntb_transport_link_cleanup by
conditionally cancelling link work outside of the link_event_lock.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -973,6 +973,15 @@ static void ntb_transport_link_cleanup(struct ntb_tr=
ansport_ctx *nt)
>  	struct ntb_transport_qp *qp;
>  	u64 qp_bitmap_alloc;
>  	unsigned int i, count;
> +	bool cancel_link_work;
> +
> +	scoped_guard(mutex, &nt->link_event_lock)
> +		cancel_link_work =3D !nt->link_is_up;
> +
> +	if (cancel_link_work)
> +		cancel_delayed_work_sync(&nt->link_work);
> +
> +	guard(mutex)(&nt->link_event_lock);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this work
cancellation, I noticed a potential race condition in ntb_transport_free()
that could lead to a use-after-free.

In ntb_transport_free(), the background works are cancelled, but this happe=
ns
before the hardware is stopped from generating link events via
ntb_link_disable() and ntb_clear_ctx():

	ntb_transport_link_cleanup(nt);
	cancel_work_sync(&nt->link_cleanup);
	cancel_delayed_work_sync(&nt->link_work);

	qp_bitmap_alloc =3D nt->qp_bitmap & ~nt->qp_bitmap_free;

	/* verify that all the qp's are freed */
	for (i =3D 0; i < nt->qp_count; i++) {
		qp =3D &nt->qp_vec[i];
		if (qp_bitmap_alloc & BIT_ULL(i))
			ntb_transport_free_queue(qp);
	}

	ntb_link_disable(ndev);
	ntb_clear_ctx(ndev);

	ntb_bus_remove(nt);

	for (i =3D nt->mw_count; i--; ) {
		ntb_free_mw(nt, i);
		iounmap(nt->mw_vec[i].vbase);
	}

	kfree(nt->qp_vec);
	kfree(nt->mw_vec);
	kfree(nt);

If a hardware interrupt triggers a link event during this window, can the
callback ntb_transport_event_callback() reschedule the just-cancelled works?

If so, would ntb_transport_free() then proceed to free the nt context via
kfree(nt), leaving the requeued work to execute against freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D5
