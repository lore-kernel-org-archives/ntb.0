Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F143A75BD
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014051; cv=none; b=gHbQWwErAiTrpdi6ZgSIxw4usJcMVX9gS09/aQRls3o7GHsfDGnCUun7LMaFB4LPg4qJUw8lxdwsTKMuGWm82lJYt7R+j55OztwxYcHmynbFzK8Jx9JYrerjcT88X9HTwfi74y1Ayzs3k95/sFeTqUNQaBZUXyCEpuZ+SBmBuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014051; c=relaxed/simple;
	bh=F4Xul9GY9BPZveJXYlFCK7cWv/NmUhA3Fa+Ba9A3R1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QlylRbBevoGJnVJWhh5S4Ji9pGVa8vJmy5SEWUlE8K8DYkPqMUEkCo6kFqJsTR+DsJezOJB4xqOiRJ0F8afFjuXI0bVOP1FG0er/NL2kbXbOdkkhC8+LWPLYcrsiLihTt2UvLDiqJrv6VFAN4RhdMMl/YpnCCPcuur6r8qeM3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFaHxlu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFaHxlu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4B31F00898;
	Thu, 10 Sep 2026 04:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014050;
	bh=dYILdNUeg6kq2TKeJJcbAhFTaeAItMUkbqpZKq+ylgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFaHxlu6rHx+ybjqK1gGfKgy9v4KDkGuSPpIomMN94VNd9UTaRgMCfhK2RnRfWs6M
	 cVrAS/LLDeonEHqzPo7qtOBzAKYUO2fKkFQA6uLVqeKqoY8FH/AS0XOKgrrSiFxBmM
	 yfuZ0foSxXcT274ELukVt7BUbW+UMo4TR9XncgLtI5RDxHxFrcHwKHKxZZh2dogJH3
	 kGSjR0zTmaAJqRoMbIxzd/8ai3QaSQjC5Reisbqb15eqhISFRDGZNE1HJcm+aY+iQ/
	 KEvOvxzohP/JxEDh2b8dTbGQOCCP0//j5A3b/mjzJRt4C85cB5I/gLtZqJPt9LE0jq
	 UF/nrV8QSsn6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] NTB: ntb_transport: Remove the device debugfs
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260910040836.3792333-2-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:20:49 +0000
Message-Id: <20260910042049.DF4B31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Loop variable `i` is overwritten by the `qp_count` loop, causing m=
emory window leaks or out-of-bounds accesses during probe error teardown.
--

commit e2e5dc4d368c4e6164af2b078e3c55f77a078a4c
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Remove the device debugfs directory

This commit ensures the device debugfs directory is removed during teardown
and probe failure. This prevents -EEXIST errors and missing queue statistics
files on module rebind.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..3389d6ca9ebd2 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *s=
elf, struct ntb_dev *ndev)
>  err3:
>  	ntb_clear_ctx(ndev);
>  err2:
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
>  	kfree(nt->qp_vec);
>  err1:
>  	while (i--) {
>  		mw =3D &nt->mw_vec[i];
>  		iounmap(mw->vbase);

[Severity: High]
This is a pre-existing issue, but does this error path use the correct
value for 'i' to unmap memory windows?

Earlier in ntb_transport_probe(), 'i' is used to map up to 'mw_count'
windows:

    for (i =3D 0; i < mw_count; i++) {
        ...
        mw->vbase =3D ioremap_wc(mw->phys_addr, mw->phys_size);
    }

However, 'i' is subsequently overwritten when initializing queues:

    for (i =3D 0; i < qp_count; i++) {
        rc =3D ntb_transport_init_queue(nt, i);
        if (rc)
            goto err2;
    }

If probe fails during queue initialization or later, this cleanup loop uses
the overwritten value of 'i' (representing qp_count) rather than mw_count.

If qp_count < mw_count, the excess memory windows are leaked. If=20
qp_count > mw_count (which can occur if max_num_clients bounds qp_count
larger than mw_count), this loop will read out of bounds of nt->mw_vec and
pass invalid pointers to iounmap().

Additionally, does ntb_transport_free() have a similar leak?

It uses the capped nt->mw_count to free windows:

ntb_transport_free() {
    ...
    for (i =3D nt->mw_count; i--; ) {
        ntb_free_mw(nt, i);
        iounmap(nt->mw_vec[i].vbase);
    }
}

This limits unmapping to nt->mw_count, which will leak any excess windows
that were mapped during probe if mw_count was originally greater than
nt->mw_count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040836.3792=
333-1-den@valinux.co.jp?part=3D1
