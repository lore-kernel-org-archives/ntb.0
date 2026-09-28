Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7F4E9C05
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610854; cv=none; b=IIfZ9Lr5QIyIv54y+t/PhmDZhujAodjbtXlymuBWlY9WYMwVYorQjjRb0qR/titxejG2pW/2C0lsNxMTlluvXwtzWCZIqXQyM4axaGCyzfqK/dYzW68KNMTdqx6nO1GLL1v6hlZDePco6qnFIYiqQKhlIiejAjg+1pDdoi9WTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610854; c=relaxed/simple;
	bh=b6CfX98w1yPsiuaz7juFFUMA+Gjkdpddvnfr6xPSo1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rj9tEah7ZoKNXj/P4OHNwbztYtusGIhw3i1oGWINnmltXlbxEWFp22keM03v9kkhwsGgnOnPNWcsn1cLJXx5dE/H8+qdHgLG/3r4KEsdJVXuvUpT1yuNLLyPCtyhN0fhU4aSEffaI7HNn6/m/J177Xbtu0LGnUGmkMr3rDwrNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duMJZV4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duMJZV4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783AD1F000FF;
	Mon, 28 Sep 2026 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610850;
	bh=w32BwfmA3j10Aj8SqPwK/ZGR6fclV7AfXPdhMupeqVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duMJZV4gtUlHfkiQC5Jp3VHPXzvFiMJ4e9eP6Ys4Phg09KUlIbXekg+K+CtqMlSw4
	 Z549tmVXq5VfQ5aSRFRCmY72lmSuf78Pg1GYUTAjOetshmRFCZynEJq9meZHU2jCQx
	 5bn7hSaT2FYQJ6ymSy1Evo2fb959CE3sp+ZoYaftZGmolN6hQwhLEINTj29acblUuA
	 9rEBdwvc07AWXp0WCGTRZFSxYHC//YieyO0CLIrVZKf9ROCPGFHnE8PJgpPFhg1mmg
	 3HQurZXoNNyS5ButGkP5hc391OoVARtDEAmlRVYvb9r0jf+QCUCQcRNBBF+sPD2g9s
	 gaoqYEOhb8PIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/15] NTB: ntb_transport: Wait for RX completions
 before resetting a QP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260928152550.3354675-12-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 15:54:10 +0000
Message-Id: <20260928155410.783AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ntb_transport: unbounded wait in ntb_qp_link_cleanup() can deadlock
--

commit a765c073e53bc7d3e624d4540c20299c1d832801
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Wait for RX completions before resetting a QP

This commit adds a wait loop to ntb_qp_link_cleanup() to ensure the rx_post=
_q
is fully drained before tearing down the connection. This prevents memory
windows from being freed while they are still actively in use by the DMA
hardware on systems that lack proper terminate and synchronize operations.

Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9f71af97a8ef9..8f1acf44bb53c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -960,6 +967,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport=
_qp *qp)
>  	disable_delayed_work_sync(&qp->link_work);
>  	ntb_transport_set_qp_active(qp, false);
>  	tasklet_kill(&qp->rxc_db_work);
> +	/*
> +	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
> +	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
> +	 *
> +	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
> +	 * its MW accesses before removing each entry under ntb_rx_q_lock.
> +	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
> +	 * can be submitted.
> +	 */
> +	while (!ntb_transport_rx_idle(qp))
> +		fsleep(1000);

[Severity: High]
Could this loop wait indefinitely and cause a deadlock?

If a pending RX DMA operation never completes due to a wedged DMA engine,
hardware fault, or dropped interrupt, ntb_complete_rxc() will never be call=
ed
to remove the entry from rx_post_q.

Since the caller of this function, ntb_transport_link_cleanup(), acquires
nt->link_event_lock prior to calling ntb_qp_link_cleanup(), an unbounded wa=
it
here could permanently deadlock the NTB link state machine and result in a
hung task.

Would it make sense to add a timeout mechanism to this wait?

> =20
>  	ntb_qp_link_down_reset(qp);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928152550.3354=
675-1-den@valinux.co.jp?part=3D11
