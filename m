Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DD442B32;
	Thu, 27 Aug 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828884; cv=none; b=qFfsj+EAx+KaRhToER7F02yX2sHC/aBUVoFpzwm+sNnA72m1zOLvSC0ncVgTpZ7wBgkyMnPBPFNdMAkYimmWyIQnD5Z0bAAmpiZO8LnGT8bDWopnpqd47D63sa2SX/KPqXzovx4erddt10B/ZZWZ00qH26e59I+GA2IJb/09xpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828884; c=relaxed/simple;
	bh=O22VJuhGXOTgWv/l2ZC2p7ISxbGc5tpE+G6HABsIDBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+khFZQC1r5hBWn5nYWkcafqu4u0WyE2d5MkqTxQ1YjjPO/wxtj9vXhO9Nu0yKlQS+gmgmaLDE/2HPuKXOTCvL5w2l/5oZn8Ldsp3Nd5mXhLtERKYBRGC+L6Dycqp016vkr0/i6a1ojfP6w7WO1vyqoQ+F6HEiqvDClgto+aBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+NqZ3Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+NqZ3Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D84E1F000E9;
	Thu, 27 Aug 2026 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828872;
	bh=ne5SKLEArSFnDAV2wNCmzkMcMvDa8wG6YWzRj++MCxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V+NqZ3SajKcP2z3mKJKVZ2PuK9PMFyFFHXLCo6/MJkjrt/QmM4U6H9We4bUp5of3m
	 r6rULx16dUOnNerIQBBFpWfBSIF8/fu8KJcSXDcV918Nds7PpWQDdirEQN6BhjXYBR
	 NBwCzvBpzu3WPp7NxTRvq3w92b1Ko4SKNHmKl4t3kNRdAlKfrJiSXV9QMsr5sI0Wte
	 DYZ1P1d/vSzFnyq9SWbsRVcWhSNGRIe09RBqY09Ss3Z01PQ4MVUfL981Z2/4gI5Axh
	 1WZRpA1FJ0iuG4V3WTYgv3Z8BDmGVxxO/6tcyKONgTe70tUw9/iggcLPFq4LXhO25E
	 XQgH8MX8xPgYA==
Date: Thu, 27 Aug 2026 12:07:49 +0100
From: Simon Horman <horms@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev
Subject: Re: [PATCH net] net: ntb_netdev: Fix statistics races
Message-ID: <20260827110749.GE396647@horms.kernel.org>
References: <20260824025720.3520288-1-den@valinux.co.jp>
 <20260825025740.5AF271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825025740.5AF271F00A3A@smtp.kernel.org>

On Tue, Aug 25, 2026 at 02:57:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Pending RX and TX entries are leaked because their associated SKB buffers are not freed when the transport queue is destroyed.
> --
> 
> --- Patch [1]: [PATCH net] net: ntb_netdev: Fix statistics races ---
> commit fc558d0a991ec95505df001446270417159e2eaf
> Author: Koichiro Den <den@valinux.co.jp>
> 
> net: ntb_netdev: Fix statistics races
> 
> ntb_netdev updates shared net_device stats from per-QP RX and TX callbacks.
> This commit shifts the driver to use core-managed per-CPU dstats. It also
> tears down transport queues from ndo_uninit before the core frees dstats.
> 
> > diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> > index 9c171697e7620..6a1e58d5d7d67 100644
> > --- a/drivers/net/ntb_netdev.c
> > +++ b/drivers/net/ntb_netdev.c
> [ ... ]
> > @@ -427,7 +428,19 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
> >  	return rc;
> >  }
> >  
> > +static void ntb_netdev_uninit(struct net_device *ndev)
> > +{
> > +	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	unsigned int q;
> > +
> > +	for (q = 0; q < dev->num_queues; q++) {
> > +		ntb_transport_free_queue(dev->queues[q].qp);
> 
> [Severity: High]
> This is a pre-existing issue, but does calling ntb_transport_free_queue()
> leak the SKBs attached to pending packets?

FWIIW, as a pre-existing issue I lean towards this being out-of-scope
for the patch under review. And, rather, a topic for possible follow-up.

> 
> Looking at ntb_transport_free_queue() in drivers/ntb/ntb_transport.c,
> it cleans up pending items from the queues like this:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>     ...
>     while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
>         dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
>         kfree(entry);
>     }
>     ...
> }
> 
> It frees the entry, but it doesn't seem to free or return the attached
> client buffer (entry->cb_data). Since ntb_netdev uses cb_data to store
> allocated SKBs, does this unconditionally leak any in-flight packets
> when the queue is destroyed?
> 
> > +		dev->queues[q].qp = NULL;
> > +	}
> > +}
> > +
> >  static const struct net_device_ops ntb_netdev_ops = {
> > +	.ndo_uninit = ntb_netdev_uninit,
> >  	.ndo_open = ntb_netdev_open,
> >  	.ndo_stop = ntb_netdev_close,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260824025720.3520288-1-den@valinux.co.jp?part=1
