Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA593DD87F
	for <ntb@lists.linux.dev>; Wed,  9 Sep 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966691; cv=none; b=Gxifa4d3rXUn31zM9WdpiNewEcg2jZI7o5D/ZUpamklB0ANM9GWXYBORH1QYADU01TBXnMb5LtJW7l8K2V3McaY6SCJiY0gJ4l2W3/Bmpy0zG5m8jMWjJqJgLAabCOAkXmI205/SDXCYcP7ofumiSf1bfFjgS1L3aWDwRdJ4Tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966691; c=relaxed/simple;
	bh=PKamnqAUFVh4pPE1s3usuRTUmbgs3EuUo1qW230OBnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hoxWv0O4mP+bN8a+ZlSubIvLGsqz/yyNio7ZcaqmtKduROJMfcnIJ05ahH6QKHiNkH+KfqlNZZmbYu+nxWJVaRXFLf7vLj6yJMchigigREI4/p1gMxBKdHv/fes9trQaOMGpPwNztR9GyphGJeXJDPZy9G5Kos8Omma9b8Mu4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiXl97Io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiXl97Io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3E71F00A3A;
	Wed,  9 Sep 2026 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966688;
	bh=Mcc0tAHTZos39RcbxQJxHsMmtFM3no6oC/Qn4w5OyP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiXl97Ion7esqBLRpCVTeRA0MBadYXV40lvPzJ0ayD9vUKRsvNuGLUW+JOaDHhNSM
	 dMRxfPniIEF9JdtxksWOXoHQUBt3WgzJ7R+3uOynW8RGhKeXJw5MQGH/qgWcJN93Nt
	 EcAwWqjj+QiUkzRzMhMYTxA0tsLzrvHp1kI9Bau3TjEfuGjm8kGgLQ3+FLDK8Ygcsp
	 D5TVAaFjRsw2HFynvmoU0CLlR0N3sz33UsPTGZO9JAFcV+w1kESnresbaXP1BkDlNP
	 IY3xrrOP2Kueo3VfFQlfNT2wI9z+Oqp4EaiJTiNuwTgC/E/rmtM9d+3ghJrgzrTmLT
	 QGCjPn6TvTHsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] NTB: ntb_msi_test: Cancel setup work on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260909145554.704036-1-fanwu01@zju.edu.cn>
References: <20260909145554.704036-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:11:28 +0000
Message-Id: <20260909151128.BD3E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Interrupt Storm / Hardware State Machine Violation due to incorrec=
t teardown ordering

Pre-existing issues:
- [High] Use-After-Free of `msi_desc` due to late removal of debugfs files
- [High] Data Race / Use-After-Free in `ntb_msit_db_event()` and `ntb_msit_=
dbgfs_trigger()`
- [High] Out-of-Bounds Memory Access in `ntb_msit_db_event()`
- [High] Buffer Overflow via Mutable `num_irqs` Module Parameter
- [High] NULL Pointer Dereference in `ntb_msit_desc_changed()` / `ntb_msi_w=
rite_msg()`
--

commit 2afad66772e5fa9c2078f36f9787cff1b0e7d42e
Author: Fan Wu <fanwu01@zju.edu.cn>

NTB: ntb_msi_test: Cancel setup work on remove

The MSI test client queues setup_work from the link event callback, but
ntb_msit_remove() never cancels it. This commit quiesces the callbacks and
drains the work in ntb_msit_remove() before tearing down the resources to
prevent a use-after-free.

> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_t=
est.c
> index f52d409ba6d29..72695d5601957 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -391,13 +391,15 @@ static void ntb_msit_remove(struct ntb_client *clie=
nt, struct ntb_dev *ntb)
>  	int i;
> =20
>  	ntb_link_disable(ntb);
> +	ntb_clear_ctx(ntb);
> +	cancel_work_sync(&nm->setup_work);
> +
>  	ntb_db_set_mask(ntb, ntb_db_valid_mask(ntb));

[Severity: High]
Does moving ntb_clear_ctx() before ntb_db_set_mask() create a race window
where context callbacks are removed, but hardware doorbell interrupts are
still unmasked and can fire?

If a doorbell interrupt occurs from the peer NTB device right after
ntb_clear_ctx() but before ntb_db_set_mask(), the core NTB interrupt handler
will ignore it because ntb->ctx_ops is NULL.

Since the doorbell callback is never executed, the hardware doorbell bits a=
re
not cleared. Because the interrupt is often level-triggered, could this res=
ult
in the unhandled hardware interrupt continuously firing and causing an
interrupt storm?

>  	ntb_msi_clear_mws(ntb);
> =20
>  	for (i =3D 0; i < ntb_peer_port_count(ntb); i++)
>  		kfree(nm->peers[i].msi_desc);
> =20
> -	ntb_clear_ctx(ntb);
>  	ntb_msit_remove_dbgfs(nm);

[Severity: High]
This is a pre-existing issue, but does freeing the msi_desc array before
removing the debugfs files expose a use-after-free?

Because the debugfs files are created with debugfs_create_file_unsafe(), the
VFS does not protect concurrent file operations against debugfs removal.

If user-space reads or writes to the debugfs trigger file concurrently with
module removal, could ntb_msit_dbgfs_trigger() dereference the freed msi_de=
sc
array?

[Severity: High]
This is a pre-existing issue, but is there a data race and use-after-free
between ntb_msit_db_event() and ntb_msit_dbgfs_trigger()?

ntb_msit_dbgfs_trigger() locklessly dereferences peer->msi_desc. Concurrent=
ly,
ntb_msit_db_event() can be invoked in interrupt or work context and blindly
re-allocates nm->peers[peer].msi_desc:

drivers/ntb/test/ntb_msi_test.c:ntb_msit_db_event() {
    ...
		kfree(nm->peers[peer].msi_desc);
		nm->peers[peer].msi_desc =3D desc;
    ...
}

Because there is zero locking protecting this shared array across these
functions, can this cause kernel memory corruption?

[Severity: High]
This is a pre-existing issue, but does ntb_msit_db_event() have an
out-of-bounds memory access when handling physical port numbers?

ntb_msit_db_event() directly uses the set bit index in peer_mask as the arr=
ay
index (peer) for nm->peers[peer]:

drivers/ntb/test/ntb_msi_test.c:ntb_msit_db_event() {
    ...
	for (peer =3D 0; peer < sizeof(peer_mask) * 8; peer++) {
		if (!(peer_mask & BIT(peer)))
			continue;
        ...
		kfree(nm->peers[peer].msi_desc);
		nm->peers[peer].msi_desc =3D desc;
		nm->peers[peer].num_irqs =3D irq_count;
    ...
}

The nm->peers array is sized strictly to ntb_peer_port_count(ntb), which is
typically 1 in a 2-port topology. If the bit index (which is the sender's
physical port number) is 1, does accessing nm->peers[1] result in reading
out-of-bounds memory and subsequently calling kfree() on a junk pointer?

[Severity: High]
This is a pre-existing issue, but does ntb_msit_setup_work() have a buffer
overflow vulnerability due to the mutable num_irqs module parameter?

The global num_irqs module parameter is defined with 0644 permissions,
allowing runtime modification. The nm->isr_ctx buffer is allocated once
during probe using the initial num_irqs value.=20

drivers/ntb/test/ntb_msi_test.c:ntb_msit_setup_work() {
    ...
	for (i =3D 0; i < num_irqs; i++) {
		nm->isr_ctx[i].irq_idx =3D i;
    ...
}

If a privileged user increases num_irqs at runtime, and a link up event
triggers ntb_msit_setup_work(), could it dynamically iterate over the array
up to the new global num_irqs and write far past the bounds of nm->isr_ctx?

[Severity: High]
This is a pre-existing issue, but is there a NULL pointer dereference in
ntb_msi_write_msg() and ntb_msit_desc_changed()?

In ntb_msi_write_msg(), dr->ntb->ctx is read locklessly and passed directly=
 to
the desc_changed callback:

drivers/ntb/msi.c:ntb_msi_write_msg() {
    ...
	if (dr->ntb->msi->desc_changed)
		dr->ntb->msi->desc_changed(dr->ntb->ctx);
    ...
}

ntb_msit_remove() invokes ntb_clear_ctx(), setting ntb->ctx =3D NULL. The I=
RQ
descriptors remain active because devres cleanup happens much later in the
device teardown cycle.=20

drivers/ntb/test/ntb_msi_test.c:ntb_msit_desc_changed() {
	struct ntb_msit_ctx *nm =3D ctx;
	int i;

	dev_dbg(&nm->ntb->dev, "MSI Descriptors Changed\n");
    ...
}

If a concurrent MSI write event happens simultaneously with device removal,
could ntb_msit_desc_changed() receive a NULL context pointer and
unconditionally dereference it?
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909145554.7040=
36-1-fanwu01@zju.edu.cn?part=3D1
