Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8114E80B5
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611486; cv=none; b=HQogL0l1ylpYSEzcjlZJuV2nV/pnq6i8ZaOC8hmGQxc6YKHW2scHv1ayG8Vdvmq3wt1Z7ow63lX/XI1YEp8SgbCsJAOz4sTfy1US+Ai5PayFYxmTsn9Y93MOAHDqz9qo0lJyoyB0eYr2rIfNcBJmgOtCBKtcp2kRigOdnGMh55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611486; c=relaxed/simple;
	bh=30xx3dJgQjIqQnqvUP3bBwLBbNp2P+YzMEgPQY5PX1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YS36Bp75Jv0NFf2Il+nHVNkdH7qj9nPHmqdEGIebZgB3BV16diA1PMjKVRq31uflvfGW2esmI4jSp/F34V7CBYRIkpll5msmmTjnziXTD3yqcr1dWsf3zAJGFhnNRT0KSbU3glrbbaKchgg/IOiYQDUZaoW21JQxum2Jo8E1q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROZ5K1OE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROZ5K1OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F31C1F000FF;
	Mon, 28 Sep 2026 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790611484;
	bh=fl5saHi3xxMYCjXJe4XoD7vaL7gsfUns4ln+vfaAev0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROZ5K1OEJJjnhjVJYnAHz2wnYHIGasgIER+AdpyZONjgBHkuy+rSUZrCqKN8+e1Ig
	 4ikZdI1WKqXDb5CxcNYcY2vVD3rpUQxitih/m0N5be0atLqk7lYmsHYxGLW9HHAEWM
	 oTrhJSqjiRDdD+d4YQxB7YtR+vFHdvNTRBf+FxOy3yoDb/BzoNESflA1V6K9NA/DII
	 Gf8e6M8HOprTFQ95rYxMDMXKzW6hdGrRg0LXsSyXJg6DZvgWMZD4tngFIQDLmxHhlQ
	 j9G6Mbu+5T5/G+MIdGcmpxSsh1c1pqZFtxi89PUokd0hG+YvhoM7lC3LCPaHcEzYXP
	 cdYpFvo9YFb7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/15] NTB: ntb_transport: Remove clients before
 freeing transport resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260928152550.3354675-16-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-16-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:04:43 +0000
Message-Id: <20260928160444.4F31C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ntb: use-after-free and DMA memory corruption in teardown due to b=
ypassed wait loop
--

commit 51bc5e4115a3fe5b0d9105d1dfb2a458cfc0b016
Author: Koichiro Den <den@valinux.co.jp>
NTB: ntb_transport: Remove clients before freeing transport resources

This commit fixes a tear-down order issue where transport resources are
freed before unregistering clients. It modifies ntb_transport_free to
disable transport work and call ntb_bus_remove earlier. It also reorders
the transport link cleanup after queue freeing to prevent setup during
removal.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index af7f240479f4e..eef3a214d91a0 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
[ ... ]
> @@ -1497,11 +1499,10 @@ static void ntb_transport_free(struct ntb_client =
*self, struct ntb_dev *ndev)
>  			ntb_transport_free_queue(qp);
>  	}
> =20
> +	ntb_transport_link_cleanup(nt);

[Severity: High]
Does this reordering inadvertently skip the DMA synchronization wait loop?

When ntb_transport_free_queue is called in the loop above, it frees the
queues and marks them as free by updating the bitmap:

void ntb_transport_free_queue(struct ntb_transport_qp *qp)
{
        ...
        qp->transport->qp_bitmap_free |=3D qp_bit;
}

Then, when ntb_transport_link_cleanup is called immediately after, it
evaluates the allocated queues using the updated bitmap:

static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
{
        ...
        qp_bitmap_alloc =3D nt->qp_bitmap & ~nt->qp_bitmap_free;
       =20
        for (i =3D 0; i < nt->qp_count; i++)
                if (qp_bitmap_alloc & BIT_ULL(i)) {
                        qp =3D &nt->qp_vec[i];
                        ntb_qp_link_cleanup(qp);
                        ...
}

Because the queues were just marked as free by ntb_transport_free_queue,
qp_bitmap_alloc evaluates to zero. This completely bypasses the loop that
calls ntb_qp_link_cleanup.

Bypassing ntb_qp_link_cleanup skips the critical DMA wait loop:

while (!ntb_transport_rx_idle(qp))
        fsleep(1000);

Without this synchronization, entries in rx_post_q are freed in
ntb_transport_free_queue while the hardware might still be actively
accessing them via DMA. Could this lead to a use-after-free or memory
corruption when ntb_rx_copy_callback later asynchronously executes and
operates on the freed queue entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928152550.3354=
675-1-den@valinux.co.jp?part=3D15
