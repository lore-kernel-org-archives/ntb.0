Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9423ACA5E
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792342; cv=none; b=on+Wd8pTstYfV5dWDKV20yFYc6+6BRzIRdtylWjmjgd8U0YOeMNIhuvtS90G7Nfc5IJYHOxc5p59vT4u53gGsbaVg5JGbCS1Xx1tdfKzXUJ1eDWzn7SuJxsrvWHyDdvgJ0E1vUTGoVVWhoX14BTf7mZUyKaDyP7rPvnQKDy7l9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792342; c=relaxed/simple;
	bh=VM3iJ9zip2jtgvbX+IWlMZUnoPx92846Rj2p0CbxlWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUi/RxgKTHgNKUha7QjRqcw4FJvIhSlMx4cuMY+I7+AsmbTrsM7/qNTsPqFub4vA0r1gZI4WslpQ/up7t2bKodGykUX5XxwQZFClvjpxijN969vxZRCsKwJ1rWYARwcKfr14OraPvX/DfMzmW/cEXxFm6SNfV+jnGIh/z6p7f/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQmsoH5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQmsoH5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2131F00A3A;
	Mon,  7 Sep 2026 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792340;
	bh=vQZl/+jIVFYCx1xf8/uDMSbgXbZVVeM4EgV38xSDYpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQmsoH5kskDJx/mmtLYfAPBDy0ssYYgE20Il+aWZa5QodzXy259EmtkN64BXtnbLD
	 4vKykLY9PjzQTVjK+nxM6mIAX21S1WFkXyeCIkFlXgsHQW9GwgcbkvbhX79BuvwRzU
	 19QVAaXckCSfjekt+OfkK8biH2NhmevFTCiKM9M/pbomxii0AA11i6zs9tK3N2rYja
	 CJcsuJFRM+Ad7yXvTmUFr03e29FUpsCZpyr0p7vdqIq8YDZkBHO3Ko9lPnXPLI3FAu
	 NxH0p/bWx2vnNk3J46PhYL4clX2CStQCrgulGWevLQ6xWZz/Xe+deQBBnJhjVamjex
	 XC7vwoY/PtZmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260907142429.951930-9-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:45:40 +0000
Message-Id: <20260907144540.9C2131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious remote peer can cause an out-of-bounds read from the D=
MA memory window, leaking kernel memory to the local client.
- [High] Concurrent execution of `ntb_transport_tx_enqueue` and link teardo=
wn results in a Use-After-Free due to a TOCTOU race on `qp->remote_rx_info`.
--

commit 27f5fc7ad1e1740768bf860b20037b56b47da429
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Abort link setup on QP MW allocation failure

This commit fixes an issue in ntb_transport_link_work() where a failure in
ntb_transport_setup_qp_mw() is ignored. It updates the error path to abort
link setup and properly release the memory windows if an allocation fails.

Link: https://lore.kernel.org/r/20260810165136.2292436-2-den@valinux.co.jp/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4c0a29693ac23..a902fce4ba602 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could this allow a malicious
remote peer to cause an out-of-bounds read from the memory window?

In ntb_process_rxc(), hdr->len is read directly from the memory window
(which is writable by the untrusted peer). If the client's buffer size
(entry->len) is larger than the locally negotiated frame size
(qp->rx_max_frame), a malicious peer could specify a payload length up to
entry->len:

drivers/ntb/ntb_transport.c:ntb_process_rxc() {
...
	if (hdr->len > entry->len) {
...
	} else {
		qp->rx_bytes +=3D hdr->len;
		qp->rx_pkts++;
		entry->len =3D hdr->len;
		ntb_async_rx(entry, offset);
	}
...
}

Should hdr->len also be validated against the underlying frame buffer bounds
before initiating the memory copy?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code have a time-of-check to
time-of-use race condition that could lead to a use-after-free?

ntb_transport_tx_free_entry() is invoked by clients without a lock that
serializes against ntb transport link cleanup:

drivers/ntb/ntb_transport.c:ntb_transport_tx_free_entry() {
	struct ntb_rx_info *remote_rx_info =3D READ_ONCE(qp->remote_rx_info);

	if (!remote_rx_info)
		return 0;

	tail =3D remote_rx_info->entry;
...
}

If the link goes down concurrently, the asynchronous workqueue executes
ntb_transport_link_cleanup(), which calls ntb_free_mw() and frees the
underlying memory window while setting the pointer to NULL. Since there is
no synchronization between the READ_ONCE check and the dereference of
remote_rx_info->entry, could the memory be freed in that tiny window and
result in a use-after-free read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907142429.9519=
30-1-den@valinux.co.jp?part=3D8
