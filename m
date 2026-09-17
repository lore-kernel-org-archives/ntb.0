Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C773DDB09;
	Thu, 17 Sep 2026 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678186; cv=none; b=hFqXEq0NEhpG6PQrzaWmNRiCu/cyugxxYoX2BNI5fcD7U0fS6DQ939rVpX5v8jJDHQexm9cK6NDqbdmdRGnxzBO3XQ+RaTDef6P9mdExrFFZ0Xyj97xtXqQzCWwQAQrKKJI2hL8taHORFjlqUuDJO8xOdWOykL4CifWnDi6Mtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678186; c=relaxed/simple;
	bh=vJCN1XJNs2Tt8Hc27J9hy7xk+diFvlUMOvAq4pZ7dt0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIGMp1DsqRjs2ATRAmMpUJjGXdUNvf7/3NUvt28ZEOXv6reS27UL2BOYLoReoJ0K/Hp0zHAluffa2IVeDdb07C2nWp3EQ7x1xLkppq1IZwnxRe6cBi1XPnovI4Xeb8/QTGHCsfSO4YNBswC1lf53inPgroCghWl67hN2q5v1cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGKzKARr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGKzKARr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14411F000FF;
	Thu, 17 Sep 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678185;
	bh=sn0BxPjxJRy+HArYfK89UWKs5sHmsq9iMvlW1kAKslM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GGKzKARrdR6bW1h46XSNlrhq0YJ+UJ7u06x+l8f4EJzuvXI79IFHfs2Y7k9iKiwMh
	 blab66nB2ZYM4qg6TScuXfgt8+0dPSrwN6hw7dcjRGFk7gDFjDe7gF65ugiPKoVoTv
	 7FtxZ9ZcZT+hpymHIrY5IwmZqS82gA7k47gGzPy/s2tIIvsioHsxUVQrLm3YnH8FOH
	 cbA3AcmssXmalGmefyHwsjwsg0lMOgVb5ru2+EtbhbWDm3yjoxxeFNdqusalbQKZy/
	 7UAmqmg40pwjLJxcp+7UnZcqqjfT8ERE9UT+HiA/SHGTzKdJqBLX6xEf4Mh8X0Ee35
	 8bRnWz4LaqO5Q==
Subject: Re: [PATCH net-next v4 04/10] NTB: ntb_transport: Keep local QP link
 requests separate
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:49:44 +0000
Message-ID: <178967818413.22033.10005578790804788261@kernel.org>
In-Reply-To: <20260914084838.2158249-5-den@valinux.co.jp>
References: <20260914084838.2158249-5-den@valinux.co.jp>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] A cleared QP up-request can be re-asserted by the QP's own
  link_work, leaving a closed QP advertised as 'up' in the peer's…

--

NTB: ntb_transport: Keep local QP link requests separate

This moves the local QP up-request bitmap out of the local scratchpad into
a new nt->up_request field, serializing the read-modify-write and the peer
QP_LINKS write under a new nt->up_request_lock. The bitmap is cleared in
ntb_transport_link_cleanup() so each QP re-advertises after reconnecting.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index b69e8ac8047df..0b47285ef48b6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1113,6 +1119,21 @@ static void ntb_transport_link_work(struct work_struct *work)
>  				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
>  }
>  
> +static void ntb_qp_up_request(struct ntb_transport_qp *qp, bool up)
> +{
> +	struct ntb_transport_ctx *nt = qp->transport;
> +
> +	guard(spinlock)(&nt->up_request_lock);
> +
> +	if (up)
> +		nt->up_request |= BIT(qp->qp_num);
> +	else
> +		nt->up_request &= ~BIT(qp->qp_num);
> +
> +	/* Update the peer's view of our requests. */
> +	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, nt->up_request);
> +}
> +
>  static void ntb_qp_link_work(struct work_struct *work)
>  {
>  	struct ntb_transport_qp *qp = container_of(work,
> @@ -1126,7 +1147,7 @@ static void ntb_qp_link_work(struct work_struct *work)
>  
>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
>  
> -	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
> +	ntb_qp_up_request(qp, true);

[Severity: Medium]
The up/down decision is still made by the caller outside up_request_lock,
so the last writer wins.  Can a closed QP end up advertised as up again
here?

ntb_qp_link_work() calls ntb_qp_up_request(qp, true) unconditionally, with
no test of qp->client_ready, while ntb_transport_link_down() clears the bit
first and only cancels the worker in the qp->link_is_up == false branch:

drivers/ntb/ntb_transport.c:ntb_transport_link_down() {
	qp->client_ready = false;

	ntb_qp_up_request(qp, false);

	if (qp->link_is_up)
		ntb_send_link_down(qp);
	else
		cancel_delayed_work_sync(&qp->link_work);
}

So with qp->link_is_up true, a queued or in-flight qp->link_work can run
after the clear and re-set BIT(qp->qp_num) in nt->up_request, republishing
it to the peer's QP_LINKS.

There is also a repeating path through the cleanup worker:

drivers/ntb/ntb_transport.c:ntb_qp_link_cleanup_work() {
	ntb_qp_link_cleanup(qp);

	if (nt->link_is_up)
		schedule_delayed_work(&qp->link_work,
				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
}

nt->link_is_up is set false only in ntb_transport_probe(), so after the
peer's LINK_DOWN payload is consumed (ntb_process_rxc() -> ntb_qp_link_down()
-> schedule_work(&qp->link_cleanup)) the QP's link_work keeps re-arming every
NTB_LINK_DOWN_TIMEOUT and keeps re-advertising a QP whose client already went
down.  Once that happens, is there any remaining publisher that would clear
the bit again short of a transport-wide cleanup?

The peer would then declare its side of the QP up and transmit into a queue
whose client is closed, and those frames get dropped.

Would it be more robust to exclude qp->link_work unconditionally (cancel or
flush before clearing), or to evaluate qp->client_ready inside
ntb_qp_up_request() under up_request_lock, rather than only making the
read-modify-write atomic?

For reference, the later patch in this series ("NTB: ntb_transport: Exchange
client capabilities at link-up") adds

	if (!smp_load_acquire(&qp->client_ready))
		return;

before the ntb_qp_up_request(qp, true) call and moves the
cancel_delayed_work_sync() ahead of the clear, which removes the repeating
cleanup-worker path.  A worker that already passed that client_ready load
can still publish the bit after ntb_transport_link_down() cleared it when
qp->link_is_up is true, since that branch skips the cancel.

>  	/* query remote spad for qp ready bits */
>  	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);

[ ... ]

> @@ -2412,16 +2434,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
>   */
>  void ntb_transport_link_down(struct ntb_transport_qp *qp)
>  {
> -	int val;
> -
>  	if (!qp)
>  		return;
>  
>  	qp->client_ready = false;
>  
> -	val = ntb_spad_read(qp->ndev, QP_LINKS);
> -
> -	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));
> +	ntb_qp_up_request(qp, false);
>  
>  	if (qp->link_is_up)
>  		ntb_send_link_down(qp);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914084838.2158249-1-den%40valinux.co.jp
