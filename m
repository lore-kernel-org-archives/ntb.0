Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16877381E97
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014975; cv=none; b=NuhgKt0Url1yMDQ2UNiCuLCChtBFv5M+j0y8tW37B+bkxnAGi6ACRMK+WWysA5YGP1N11veDmPwIihE3fC7xx6DSaM08G/OucNJjxWe7BQAWuGxwUcUNRsp7S/Um5bjwpBGJquzii9RuOBIFp9w117TX/gDroNzY9OCYforAQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014975; c=relaxed/simple;
	bh=e35GuYu2WIx7k5wSc+znt84nql8G/EDFPTUkgoZSSTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duWcoI3KNwd5Scf1OeqU/M5VtFiBNJWBgi8HPEuJecB9m61zdPlWbX7tJlYNrGgOvAof2WucxUVHAfQerrJ/TtfPv+DrIvEYSMyWiL0e6+KIwrA5nm6HrnI0nvPhqizGbceLqcAIaB96ATIxehUtxLkDvEtdmxT2LJsnrMQ3DTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj7Eaxqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj7Eaxqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8FD1F000FF;
	Thu, 10 Sep 2026 04:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014974;
	bh=IcoyZj7tzZw9106mx5Uh+dgqYCsYY4wrQweUAeG26pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rj7EaxqnqCX8hSV5hchLZEejDO4DIbDvfODvq+7NvfzyKVGa9N1S+pFltOAm4OjuR
	 ZHd7w/tzxCJ7CBfynAvm7DFR3tYph3d219+5WbtDnbe9GLpAd7CrLSAyBElxPNG1ry
	 HSamAy0OjXBfC+vR7vQgFX5+CsAPOz8DqACncSvvtHIcS855umiSif9an+lGXqovGh
	 adG16U9rYzgimX1/lzqJdQpaZKlEitzihueJ/PGl9PmPqCPUbOcfSfnD4BA6DLic7V
	 ZGLBWj1CT1nh6T6yVk4BH8jBZlrrZx7R/loPHNqc6oher1HR24zyZ2UpWCzMM3B4EF
	 CIbfOnmQz98Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-15-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:36:13 +0000
Message-Id: <20260910043613.CE8FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails=
 to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT =
DMA.

Pre-existing issues:
- [Critical] Double-fetch of `hdr->len` from shared memory allows buffer ov=
erflow via TOCTOU race.
- [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue st=
ate corruption.
--

commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
Author: Koichiro Den <den@valinux.co.jp>
Subject: NTB: ntb_transport: Remove clients before freeing transport resour=
ces

Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
is still bound. This patch reorders the teardown process to unregister
clients before freeing resources, intending to fix unsafe memory accesses
during intensive TX loads.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index c1e3a077c45ec..f24555b38d1b5 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *=
self, struct ntb_dev *ndev)
> =20
>  	debugfs_remove_recursive(nt->debugfs_node_dir);
> =20
> -	ntb_transport_link_cleanup(nt);
> -	cancel_work_sync(&nt->link_cleanup);
> -	cancel_delayed_work_sync(&nt->link_work);
> +	/* Stop transport work before clients release their QPs. */
> +	disable_delayed_work_sync(&nt->link_work);
> +	disable_work_sync(&nt->link_cleanup);
> +
> +	ntb_bus_remove(nt);

[Severity: Critical]
By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
introduce a DMA use-after-free regression?

Calling ntb_bus_remove() first prompts client drivers to free their QPs via
ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
without polling:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
	while ((entry =3D ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
		kfree(entry);
	}
    ...
}

Because IOAT DMA engines could still be actively copying into those buffers,
freeing them allows the hardware DMA engine to write to freed kernel memory.
Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
call to ntb_transport_link_cleanup().

[ ... ]

> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_=
qp *qp)
> =20
>  	if (hdr->len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"receive buffer overflow! Wanted %d got %d\n",
>  			hdr->len, entry->len);
>  		qp->rx_err_oflow++;
> =20
>  		entry->len =3D -EIO;
>  		entry->flags |=3D DESC_DONE_FLAG;
> =20
>  		ntb_complete_rxc(qp);
>  	} else {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"RX OK index %u ver %u size %d into buf size %d\n",
>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
> =20
>  		qp->rx_bytes +=3D hdr->len;
>  		qp->rx_pkts++;
> =20
>  		entry->len =3D hdr->len;

[Severity: Critical]
This is a pre-existing issue, but is there a time-of-check to time-of-use
race condition in this bounds check on hdr->len?

Since hdr points to a payload header located inside a memory window writable
by the remote NTB peer (shared memory), hdr->len is read directly from
shared memory twice (once for the bounds check, once for the assignment).

Can a remote peer swap hdr->len to a much larger value immediately after
the bounds check but before the assignment, bypassing the bounds check and
causing a buffer overflow when copied?

[ ... ]

> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
>  ntb_transport_create_queue(void *data, struct device *client_dev,
>  			   const struct ntb_queue_handlers *handlers)
>  {
[ ... ]
>  	free_queue--;
> =20
>  	qp =3D &nt->qp_vec[free_queue];
>  	qp_bit =3D BIT_ULL(qp->qp_num);
> =20
>  	nt->qp_bitmap_free &=3D ~qp_bit;

[Severity: High]
This isn't a bug introduced by this patch, but could this read-modify-write
of nt->qp_bitmap_free lead to queue state corruption?

The qp_bitmap_free bitmask is modified here using non-atomic bitwise
operations without holding any lock. It is also modified concurrently during
driver unbind:

drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
    ...
	qp->transport->qp_bitmap_free |=3D qp_bit;
    ...
}

Since these are exported functions called by NTB client drivers, could
concurrent probe and remove operations race and lose bit updates, leading
to a leaked queue or two clients being assigned the same queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D14
