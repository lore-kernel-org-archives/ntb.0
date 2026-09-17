Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8203B42F8;
	Thu, 17 Sep 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678188; cv=none; b=ULRLdWtbdGrE688cXiczrExmyBN+Il+xBt5hp6cNoQYbnlYEQWg7J1utYUP7yBMoDN/UBlOmMLzOlgnEFNoZesFwk9lY+SMQvYtW6WHOV4GjhOwdSd6njbXkD+M8LoA7xaazt/5JXhRNfT4NSJIVetSPGXSGxeKZNmb1PteApcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678188; c=relaxed/simple;
	bh=tTFIVzo3wniIu8Z2wpv6DmbN/8jvS/hm+B/9SFZ3KZk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=runxV9bFPNx1r6iEfecsjphV4WgAbppLA4d8XSNv8k7WKpK0ZU3k0A1faZ7eTfLdmbJDzwgQiVTRDIoiwvjfk9DlX/CYvFcBolTXtDtcyYJF9FOvBwxrw6UCrTUwa+dn04W4LQZYgZUosVN8mg8mDIZdMvYiUd6F/BegveBNllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETVsHVeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETVsHVeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4711F00893;
	Thu, 17 Sep 2026 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678186;
	bh=wtuwf62d42eJbjJWtM8cCglfuBrbo9skp+wiejo0grU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETVsHVeVFyponBNgnONTiTW1MDnEuEHmAeUVtjAukMllq6phoJvAXYL8Aya3V39ZV
	 kV/Nm1c1fjE1J5xg2PYGLjDW8yW/PJ+dUcSpV6SwfUS/fUX4an+LO13GbJKt8njapr
	 H3O6DNYWpvB2fWj4qY3FU2gqiqx8bImXDcGM5Rh5uc3WWmvLRhoPlq8NhE1r5TF+or
	 s2m9XwHQYB5LkDkXDN1voyCXW//oxA76vzxUnxAbYsEiUwFKelKN9mrLyoBfUDq/7j
	 +QAIwpm2umOlMTT7ViRyNbbNdrjOV7ckerPaGkuMLiwmpq0iMIktRR7UhWuQFPfvw5
	 rvNQrRuTYXlrA==
Subject: Re: [PATCH net-next v4 05/10] NTB: ntb_transport: Exchange client
 capabilities at link-up
From: netdev-bot+sashiko@kernel.org
To: den@valinux.co.jp
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:49:45 +0000
Message-ID: <178967818546.22033.425184334690767326@kernel.org>
In-Reply-To: <20260914084838.2158249-6-den@valinux.co.jp>
References: <20260914084838.2158249-6-den@valinux.co.jp>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 0

- [Medium] ntb_transport_link_down() withdraws the per-QP capability word
  *before* it withdraws the QP readiness bit, which is the inverse of…
- [Medium] ntb_transport_link_down() can be raced by a queued/running
  ntb_qp_link_work() that re-publishes exactly what link_down just…

Pre-existing issues:
- [High] ntb_transport_free_queue() never synchronously cancels
  qp->link_cleanup, so that work — or the qp->link_work it re-arms — can…
- [Medium] Store-buffering race between ntb_transport_link_up() and
  ntb_transport_link_work() can leave qp->link_work permanently…

--

NTB: ntb_transport: Exchange client capabilities at link-up

The patch adds an opaque 31-bit per-QP capability word that is exchanged
through one spare scratchpad per QP during QP link setup, with bit 31 used
as a validity marker.  The capability value is handed to the client with
the link-up event, and ntb_transport_link_up() grows a local_caps argument
which ntb_netdev passes as zero for now.

A few questions below about the withdrawal ordering and about
synchronization against ntb_qp_link_work().

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 0b47285ef48b6..ea89eb336472a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -937,7 +942,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  	ntb_qp_link_down_reset(qp);
>  
>  	if (qp->event_handler)
> -		qp->event_handler(qp->cb_data, qp->link_is_up);
> +		qp->event_handler(qp->cb_data, qp->link_is_up, 0);
>  }
>  
>  static void ntb_qp_link_cleanup_work(struct work_struct *work)

[Severity: High]

This isn't a bug introduced by this patch, but while reading the
qp->link_cleanup path: can this work item outlive the QP?

ntb_qp_link_down(), called from ntb_process_rxc() on LINK_DOWN_FLAG in the
rx tasklet, only queues it:

static void ntb_qp_link_down(struct ntb_transport_qp *qp)
{
	schedule_work(&qp->link_cleanup);
}

ntb_transport_free_queue() then does tasklet_kill(&qp->rxc_db_work) and
cancel_delayed_work_sync(&qp->link_work), but no
cancel_work_sync(&qp->link_cleanup), and marks the QP free:

	qp->transport->qp_bitmap_free |= qp_bit;

A link_cleanup queued just before the tasklet was killed can then run
ntb_qp_link_cleanup_work() after free_queue() returned and re-arm
qp->link_work:

	if (nt->link_is_up)
		schedule_delayed_work(&qp->link_work,
				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));

On transport teardown, ntb_transport_link_cleanup() only cancels per-QP
work for QPs still marked allocated:

	for (i = 0; i < nt->qp_count; i++)
		if (qp_bitmap_alloc & BIT_ULL(i)) {
			qp = &nt->qp_vec[i];
			ntb_qp_link_cleanup(qp);
			cancel_work_sync(&qp->link_cleanup);
			cancel_delayed_work_sync(&qp->link_work);
		}

so the released QP is skipped, and ntb_transport_free() then does
kfree(nt->qp_vec) with that work still pending.  Does this let the
pending link_cleanup/link_work dereference freed memory (the work_struct
list pointers, qp->transport, qp->ndev)?  Would adding
cancel_work_sync(&qp->link_cleanup) to ntb_transport_free_queue() close
this?

> @@ -1141,10 +1146,19 @@ static void ntb_qp_link_work(struct work_struct *work)
>  						   link_work.work);
>  	struct pci_dev *pdev = qp->ndev->pdev;
>  	struct ntb_transport_ctx *nt = qp->transport;
> +	u32 peer_caps = 0;
>  	int val;
>  
>  	WARN_ON(!nt->link_is_up);
>  
> +	/* Pair with the release store in ntb_transport_link_up(). */
> +	if (!smp_load_acquire(&qp->client_ready))
> +		return;
> +
> +	/* Publish capabilities before QP readiness. */
> +	if (qp->caps_spad)
> +		ntb_peer_spad_write(nt->ndev, PIDX, qp->caps_spad,
> +				    READ_ONCE(qp->local_caps) | QP_CAPS_VALID);
>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
>  
>  	ntb_qp_up_request(qp, true);
> @@ -1154,12 +1168,26 @@ static void ntb_qp_link_work(struct work_struct *work)
>  
>  	/* See if the remote side is up */
>  	if (val & BIT(qp->qp_num)) {
> +		if (qp->caps_spad) {
> +			u32 caps;
> +
> +			/*
> +			 * Order the readiness read before the capability read
> +			 * for memory-backed SPADs.
> +			 */
> +			dma_rmb();
> +			caps = ntb_spad_read(nt->ndev, qp->caps_spad);
> +
> +			if (caps & QP_CAPS_VALID)
> +				peer_caps = caps & ~QP_CAPS_VALID;
> +		}
> +
>  		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
>  		qp->link_is_up = true;
>  		qp->active = true;
>  
>  		if (qp->event_handler)
> -			qp->event_handler(qp->cb_data, qp->link_is_up);
> +			qp->event_handler(qp->cb_data, qp->link_is_up, peer_caps);
>  
>  		if (qp->active)
>  			tasklet_schedule(&qp->rxc_db_work);

[ ... ]

> @@ -2409,15 +2443,22 @@ EXPORT_SYMBOL_GPL(ntb_transport_tx_enqueue);
>  /**
>   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
>   * @qp: NTB transport layer queue to be enabled
> + * @local_caps: Opaque client capabilities in bits 0..30, unchanged until
> + *              ntb_transport_link_down()
>   *
>   * Notify NTB transport layer of client readiness to use queue
> + *
> + * Exchange capabilities before reporting link-up through event_handler.
> + * Report zero peer capabilities for legacy peers or insufficient scratchpads.
>   */
> -void ntb_transport_link_up(struct ntb_transport_qp *qp)
> +void ntb_transport_link_up(struct ntb_transport_qp *qp, u32 local_caps)
>  {
>  	if (!qp)
>  		return;
>  
> -	qp->client_ready = true;
> +	WRITE_ONCE(qp->local_caps, local_caps & ~QP_CAPS_VALID);
> +	/* Publish local_caps before QP link work sees client_ready. */
> +	smp_store_release(&qp->client_ready, true);
>  
>  	if (qp->transport->link_is_up)
>  		schedule_delayed_work(&qp->link_work, 0);

[Severity: Medium]

This is a pre-existing issue, but since the ordering on these exact lines
is now being reasoned about: can qp->link_work end up never being
scheduled?

Here the store to client_ready is followed by a load of
qp->transport->link_is_up, and ntb_transport_link_work() has the mirrored
order:

	nt->link_is_up = true;

	for (i = 0; i < nt->qp_count; i++) {
		...
		if (qp->client_ready)
			schedule_delayed_work(&qp->link_work, 0);
	}

Both sides are store-then-load with no full barrier and no common lock
(nt->link_work holds nt->link_event_lock, which ntb_transport_link_up()
does not take), so both loads can return the stale value: the client sees
the transport link down and does not schedule, the transport worker sees
client_ready as false and does not schedule either.
ntb_transport_link_work() does not reschedule itself on that path, so the
QP stays down until an unrelated NTB link event.

The smp_store_release() added here only orders the local_caps store ahead
of the client_ready store and gives no store-to-load ordering.  Would an
smp_mb() on both sides, or taking a common lock around the flag and the
link_is_up test, be needed to close this?

> @@ -2439,12 +2480,17 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
>  
>  	qp->client_ready = false;
>  
> +	if (!qp->link_is_up)
> +		cancel_delayed_work_sync(&qp->link_work);
> +
> +	/* Stop advertising capabilities before withdrawing QP readiness. */
> +	if (qp->caps_spad)
> +		ntb_peer_spad_write(qp->ndev, PIDX, qp->caps_spad, 0);
> +
>  	ntb_qp_up_request(qp, false);
>  
>  	if (qp->link_is_up)
>  		ntb_send_link_down(qp);
> -	else
> -		cancel_delayed_work_sync(&qp->link_work);
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_link_down);

[Severity: Medium]

Is this the safe withdrawal order?  The up path in ntb_qp_link_work()
establishes "readiness implies a valid capability word" by writing the
capability word first and the QP_LINKS bit second, while here the
capability word is cleared before the readiness bit.

If the peer's ntb_qp_link_work() polls in that window:

peer ntb_qp_link_work()
	val = ntb_spad_read(nt->ndev, QP_LINKS);	/* our bit still set */
	...
	if (val & BIT(qp->qp_num)) {
		caps = ntb_spad_read(nt->ndev, qp->caps_spad);	/* already 0 */
		if (caps & QP_CAPS_VALID)			/* false */
			peer_caps = caps & ~QP_CAPS_VALID;
		...
		qp->link_is_up = true;
		qp->event_handler(qp->cb_data, qp->link_is_up, peer_caps);

the peer latches peer_caps as zero, sets qp->link_is_up and stops
rescheduling qp->link_work, so it never re-reads the capability slot and a
later re-advertisement is not observed.

In the common case where our qp->link_is_up was still false (we advertised
but the peer had not become ready yet), ntb_send_link_down() is not called
either, so nothing knocks the peer out of that state and peer_caps stays
zero for the rest of the session.

Would clearing readiness first and zeroing the capability word afterwards
avoid this, since the peer would then just retry?  The comment and the
commit message text "Write capabilities to the peer before advertising QP
readiness" plus "Withdraw advertisements on link-down" read as if the
withdrawal order here were the safe one.

[Severity: Medium]

Two questions about the synchronization against ntb_qp_link_work() in this
function.

The cancel now runs only when qp->link_is_up is false, but link_work can
be queued while qp->link_is_up is already true.  ntb_transport_link_work()
has no "already up" test:

	nt->link_is_up = true;

	for (i = 0; i < nt->qp_count; i++) {
		...
		if (qp->client_ready)
			schedule_delayed_work(&qp->link_work, 0);
	}

and ntb_qp_link_cleanup_work() re-arms it too.  Can that worker then undo
what this function just did?

CPU0 ntb_transport_link_down()
	qp->client_ready = false;		/* plain store */
	/* cancel skipped: qp->link_is_up == true */
	ntb_peer_spad_write(qp->ndev, PIDX, qp->caps_spad, 0);
	ntb_qp_up_request(qp, false);

CPU1 ntb_qp_link_work()		/* already past its client_ready check */
	ntb_peer_spad_write(nt->ndev, PIDX, qp->caps_spad,
			    READ_ONCE(qp->local_caps) | QP_CAPS_VALID);
	...
	ntb_qp_up_request(qp, true);
	...
	qp->link_is_up = true;
	qp->event_handler(qp->cb_data, qp->link_is_up, peer_caps);

After ntb_transport_link_down() returns, the peer would still see a ready
QP with a valid capability word, and the client receives a link-up event
after having asked for link-down (in ntb_netdev that re-wakes the subqueue
in the middle of an MTU change).

Second, qp->client_ready is cleared here with a plain store while
ntb_qp_link_work() now reads it with smp_load_acquire().  Should the clear
be a WRITE_ONCE() or smp_store_release() so the two accesses are paired,
and should the cancel be unconditional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914084838.2158249-1-den%40valinux.co.jp
