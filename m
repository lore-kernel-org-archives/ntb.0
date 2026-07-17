Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE653B4EAB
	for <ntb@lists.linux.dev>; Fri, 17 Jul 2026 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269835; cv=none; b=BoaQ1fR7DXVH2lJyW5iQfdw+uCKWV4lKewBTXdfwW3HeKryjcWGz2U8kHHUt37gceOt4vTtUC3VcHFxy97sAHbd0v14DO72L0LG8YyiKcZHADWGAd7AE9KQWqa+FKowcsVx/WM53teyqNgIKTlxM1VKwf0wlxkidd3KuB9CaJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269835; c=relaxed/simple;
	bh=VJYP8mbk07SYv0KWL9sTfo7vGz+XkGQasD/kIpeozMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfhNX6WA+TTn67LO77YChfOE5dV11qhoAgHDazXeEsC4uVxEmYw19ucDkertZS291zVNBZT2FvLA2BWN2cBG9ZBD1cgv+3ZP9a8HLBlJTv04xvdn3YJ0CqIBzly2OKJozRo34a5dx/f4Y/zgKM69CUkcgKloOo81O1G+bHMRdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OayTHdmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OayTHdmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E001F000E9;
	Fri, 17 Jul 2026 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784269828;
	bh=4URFLgEXikMZgQ+2ibikQH7UYDtJjNiDsjFt3jv14RI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OayTHdmyjfH2c4oCDMzYKnLRB27G5u5Ym4wRfIWST/ZXMH0ODVU09ini8oPI9ekoD
	 lNt/uvQDA5D4lf/bEtp12fuiAcUP86DUVU5eHZzJmuFS3Zq/WrmomZvYmiccwIV7Rm
	 yAT0GwmYrhGnlpLKqIQcxZRHfb/ntpXo33Ea1B3q48r5E+af9GNPU1rGcmoFHsTFz9
	 Py+i1EheqQTWPJOs0DhNe6EdUyNK+2kNFevdaTVatZMxP1jkX/MjQeX/3o5Sns28zN
	 uv2MXGKK9yOLBxQRnhgw+32GIouzbu144noHaxGypnSoI+BSTAcJUSbHrJqOeaKYjX
	 blikC5qEDa4yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] NTB: ntb_transport: Mark the transport link down on
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260717061223.2203863-1-den@valinux.co.jp>
References: <20260717061223.2203863-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:30:27 +0000
Message-Id: <20260717063027.D9E001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Calling cancel_delayed_work_sync(&nt->link_work) while holding the=
 nt->link_event_lock mutex causes an AB-BA deadlock.
- [Medium] Leaving nt->link_work pending when transitioning nt->link_is_up =
to false allows a race condition that incorrectly re-establishes the link.

Pre-existing issues:
- [Critical] qp->rx_buff is accessed by the rxc_db_work tasklet after the u=
nderlying memory window is freed.
- [High] Race condition in ntb_transport_free() allows concurrent double fr=
ee of DMA memory windows.
- [High] Incorrect teardown ordering in ntb_transport_free() allows backgro=
und works to be rescheduled after cancellation.
- [High] Silent packet drops in ntb_transport_tx_enqueue() return a false s=
uccess, leaking client buffers like sk_buff.
--

--- Patch [1]: [PATCH] NTB: ntb_transport: Mark the transport link down on =
cleanup ---
commit bd7368d1b1384a2ec346e8cb7ab08bf47c5b276c
Author: Koichiro Den <den@valinux.co.jp>
Subject: NTB: ntb_transport: Mark the transport link down on cleanup

This commit restores a missing state transition in the NTB transport driver.
It ensures the transport link state is marked as down during link cleanup,
preventing queue pair cleanup workers from retrying handshakes against a
down peer.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfaa..5b9fccd1383dd 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -974,6 +974,8 @@ static void ntb_transport_link_cleanup(struct ntb_tra=
nsport_ctx *nt)
> =20
>  	if (!nt->link_is_up)
>  		cancel_delayed_work_sync(&nt->link_work);

[Severity: High]
Can this synchronous cancellation cause a deadlock with the link work?

If ntb_transport_link_cleanup() is called from
ntb_transport_link_cleanup_work() which holds nt->link_event_lock:

ntb_transport_link_cleanup_work() {
    guard(mutex)(&nt->link_event_lock);
    ntb_transport_link_cleanup(nt);
}

And ntb_transport_link_work() attempts to acquire the same mutex as its
first operation:

ntb_transport_link_work() {
    guard(mutex)(&nt->link_event_lock);
}

Could this block indefinitely waiting for the mutex while the cleanup worker
waits for the work to finish? By resetting nt->link_is_up to false in the
new branch below, subsequent cleanups seem guaranteed to hit this path.

> +	else
> +		nt->link_is_up =3D false;

[Severity: Medium]
When setting the link down here, should we also cancel the delayed work?

If nt->link_work is already pending in the workqueue, could it execute after
this cleanup completes? If the remote peer hasn't processed its own link
down event yet, the work might read valid SPAD values and mistakenly set
nt->link_is_up back to true.

> =20
>  	for (i =3D 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to free the memory
windows while the rxc_db_work tasklet might still be running?

If a doorbell interrupt fires asynchronously, the tasklet executes
ntb_process_rxc() and accesses qp->rx_buff (a pointer into the freed memory
window) before the qp->active flag is checked.

Does this need to synchronize with or disable the tasklet before calling
ntb_free_mw()?


[Severity: High]
This is a pre-existing issue, but is there a race condition protecting these
memory windows during module removal?

ntb_transport_free() calls ntb_transport_link_cleanup() directly without
holding the nt->link_event_lock mutex. If a link event concurrently schedul=
es
ntb_transport_link_cleanup_work() (which does take the lock), could both
paths simultaneously enter ntb_free_mw() and trigger a double free when
calling dma_free_attrs()?


[Severity: High]
This is also a pre-existing issue, but does ntb_transport_free() cancel
background works in the correct order?

It calls cancel_delayed_work_sync() for the link works before calling
ntb_link_disable(ndev). If a hardware link interrupt fires in the interim,
ntb_transport_event_callback() will requeue the work items.

After the context is freed, could the newly queued works execute and access
freed memory?


[Severity: High]
This isn't a bug introduced by this patch, but does
ntb_transport_tx_enqueue() silently drop packets and leak client buffers?

When qp->link_is_up is false, it returns 0 (success) immediately:

ntb_transport_tx_enqueue() {
    if (!qp->link_is_up)
        return 0;
}

Callers like ntb_netdev_start_xmit() expect a non-zero return code on
failure. Since 0 is returned, the caller assumes the transport layer took
ownership of the buffer.

Because the packet is dropped and no callback will be fired, does this leak
the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061223.2203=
863-1-den@valinux.co.jp?part=3D1
