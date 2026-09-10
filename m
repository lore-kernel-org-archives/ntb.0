Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD0396B76
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014214; cv=none; b=F7mBjAO+KFtIf23HeKbwzR7TKcK5lGsrQ74ypAMiDlnFXXB4UAIE6dQ1mYmVtiX5ZvSCLhhooRB3GB4TrVIGqVNhbDsmtwP/jVjKB35Z/t1NAKaHIF16vDXyd6DvyhgTWZuTlodnbgJWfHSWI8AmFD+asMRs7K8ntLHIsbJ/dWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014214; c=relaxed/simple;
	bh=39Dld4HNK+BXpcw5xEpCmSX9PUidcdlVAvE87xa+F3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ur1xI4mrhcqT+djsFhe+HvrqXAC/zERTAg3MqeoGpjJe4L7pAXY+gwLuaXeGIVCs+Hg1W/EH6v/UkkTZpQBPX1vT+L7sWx5INNjxnVhfe5/FD7QUiEKnwbXGDdDMxxKcrsK04NgUqvvWQHag5myAJc31kfhYuToEEagnjHEF85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiGx877M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiGx877M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892FA1F00893;
	Thu, 10 Sep 2026 04:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014212;
	bh=yIuJSzIIjH8dO8A7XqCzWARW4IoqQoWJL6a6T5VbnBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OiGx877MX5RWnhyluvJNq6tfeUH8VquMiaAHTnGcESuESupI+eFKCj7wMg3AGW6Wn
	 ARnzriLV6yUXybbWXoeN6tVGpHrCub/N+AIa861PQyrRlSRPOXHFMV/WXJc1hk3cUO
	 F7ZkhKQ4m1nbHiwLKN4RN3ouDmGwNPrI0WiBc2xZ7CAiTUksPY4YaYNA4z99ptL5M+
	 2k1TS9tJ6TIv7YSCvlaCj/Le9OGdaRqNWaj3tFdm6+hrer+McxvW1sjIpfkHe8r6Ai
	 oMjh9rDL/v9McFPiMKJsgHu1lC3W0ZK/ULQ36V0ITosKshMtUZPCxCC2KepHIhvlAi
	 4NnkxaM8iT+EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-4-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:23:32 +0000
Message-Id: <20260910042332.892FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping `link_event_lock` around `cancel_delayed_work_sync()` int=
roduces a race condition that can permanently tear down a successfully esta=
blished link.

Pre-existing issues:
- [High] Separate work items for link-up and link-down events can execute o=
ut of order, leading to a permanent link failure.
--

commit d67dbc659b034b7a703fc35d72b81082c61a2ecd
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Avoid deadlock when cancelling link work

This commit changes ntb_transport_link_cleanup() to cancel the link_work
delayed work item outside of the link_event_lock. This avoids a deadlock
where a retry in link_work blocks on the lock held by the cleanup function.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 55a20ae9a85e6..c77b173dca01f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -960,6 +960,15 @@ static void ntb_transport_link_cleanup(struct ntb_tr=
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
Does dropping the link_event_lock around cancel_delayed_work_sync() create a
race condition that could permanently tear down the link?

If a hardware link flap occurs, ntb_transport_event_callback() can queue bo=
th
link_work and link_cleanup. If link_cleanup executes, it evaluates
!nt->link_is_up under the scoped_guard, drops the lock, and calls
cancel_delayed_work_sync().

During this unlocked window, a pending link_work can acquire the lock,
successfully establish the NTB link, set nt->link_is_up =3D true, and compl=
ete.

When link_cleanup reacquires the lock, it unconditionally destroys the QPs
and MWs that were just successfully established, without re-evaluating the
link state.

Can we re-check the link state after reacquiring the lock to prevent this
permanent link failure?

[ ... ]

As an additional observation regarding the event handling:

drivers/ntb/ntb_transport.c:ntb_transport_event_callback() {
...
	if (ntb_link_is_up(nt->ndev, NULL, NULL) =3D=3D 1)
		schedule_delayed_work(&nt->link_work, 0);
	else
		schedule_work(&nt->link_cleanup);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does using separate work ite=
ms
for link-up and link-down events allow them to execute out of order?

Since link_work and link_cleanup are queued to the global workqueue as
distinct work items, rapid hardware flapping (DOWN then UP) can queue both
simultaneously.

If they execute out of order, or if link_cleanup executes last and cancels =
an
un-run link_work, the software state could be torn down permanently even
though the physical hardware state is UP.

Could a single work item or a state machine handle both events to enforce
ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D3
