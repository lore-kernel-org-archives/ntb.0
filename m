Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62C4C6F09
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610188; cv=none; b=Q0dtA/BHXIYYIycGcIepDKkSuVFzCK+M/88FZ0i+RczyhoT3n+27du9xUXuYDd26rS+yvdsjIcGBzQikznCuSCV+Ohmvrreojk497HuZItVFMjN7LDiTkCpzaZjmfTxluKyjmtwsyKp+lfJdYLnOUXIixtYMPuD0rbPeoq4bd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610188; c=relaxed/simple;
	bh=rA/np+43wOekMrVrRua3zevGFpzTpAUhUQScecaYuy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVlG4w27yYHodGQUSpZs2FkJuHf8kwf8KvWK+ZefwcjcBZDhJwh95RaSdDsOq2Ng7/u6Bwjxk2d1qKWalFFtbqVhN+jw0d17rADi71+BOAGPoEZMV7pxcoJOIZ71YnphniMW3i7Ffn5sUFjpVlbWCjjTOMwHC0Lj6Chh/WfY0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfAWrZEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfAWrZEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C352F1F000FF;
	Mon, 28 Sep 2026 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610186;
	bh=MMMWMt7kR5Q1bfiSfdKBzdQ4D6vVMbJhJXfFJJY6420=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EfAWrZEcueYEr+1xw026HdMJGUDPWYB851+v/BiwpfNORTFoL02d+Abjb+aJhSONo
	 B/vSAihKLWMPXrgABfd6I3uZ81EonqS3lFI3OEVoRa66NP69PU9f/cugKlxszRHSpt
	 EQqmtsz62S3KyIK8li1byNH5ZFmsY0X5IB8JvebL5wqxWL9bVRyH/8aI90Gd8HOOEw
	 UKdVAXfhCxldgNUp8HHkmfPR0N8udIelxzDCylmbQdy/yhpIjYOlgCb7Cmq3Pv1v8x
	 3d8lalpZdCunwLUu9rhULrmJaxLKquSK7HfbGw/lJxCWB8afgJmQO/SiKWuERCArz2
	 6M0tJtBVJ0xSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/15] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260928152550.3354675-5-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 15:43:06 +0000
Message-Id: <20260928154306.C352F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ntb: TOCTOU race in link cleanup permanently breaks link
--

commit 8d90bddbec3eab6d6adeb7ec37e857cc536bb4d5
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Avoid deadlock when cancelling link work

This patch moves the conditional cancellation of the link work outside of
the link_event_lock to avoid a deadlock when ntb_transport_link_work()
retries. QP cleanup and MW release are kept under the lock.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -962,6 +962,11 @@ static void ntb_transport_link_cleanup(struct ntb_tr=
ansport_ctx *nt)
>  	u64 qp_bitmap_alloc;
>  	unsigned int i, count;
> =20
> +	if (!atomic_read(&nt->link_is_up))
> +		cancel_delayed_work_sync(&nt->link_work);
> +
> +	guard(mutex)(&nt->link_event_lock);

[Severity: High]
Does moving the lock to after the cancellation check create a race condition
where the link state can become permanently broken?

If the hardware link flaps quickly, ntb_transport_link_cleanup() can be
queued, followed by ntb_transport_link_work(). When
ntb_transport_link_cleanup() evaluates the condition here, it might skip
cancellation or cancel an old work item, and then wait for the mutex.

The newly queued ntb_transport_link_work() could then win the lock,
establish the link, and drop the lock. Afterward,
ntb_transport_link_cleanup() acquires the lock and unconditionally tears
down the newly established QPs. Because the hardware link is already up,
no further interrupts will arrive to restart the software link, leaving
it unresponsive.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928152550.3354=
675-1-den@valinux.co.jp?part=3D4
