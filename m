Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A5544D60;
	Wed, 23 Sep 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180818; cv=none; b=Zix9xKVFAUN1EwwlgkzSeNR2BOPP2oIcY30kTOwOKkVQskh4Vs7ZcOLQhk8YmX1aNlMkv5Msk1rVg70MUIrPKkQQetsy3qUUC4hixRAA2OOBmIEPIzwqpnf5tit8V0UCTfsf3tNfW+jJ2cvMK+g7ypfdQtUbzwHVAxbSAfF2/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180818; c=relaxed/simple;
	bh=ueN80UZhm/hU62r6zMH8b9b45c3YFKQUtGfkYvlyngY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1SEdRxyhfJkiom+NDLk3Nt2c7d0KI2EIIW1PBsR/jFV7818Kvfsfeo5cqUzSETXTM9gpaoGpXhgKYzEfMZ8E2djO17Oa0ABi+XcMWpsNBAYHP/Bm8pD5fRgwjp97V6mZ7wFo6MTJeP3SiCJh5/QNFGLID1L0AA5EWzmKneSB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVttJtQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVttJtQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB89C1F000FF;
	Wed, 23 Sep 2026 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180816;
	bh=syK5nSUalK/HfewRV9tW8b0gh96XmXBobtTNSxjiNz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVttJtQMLVQzkPmIPL1v+KOGecnF9Y1hglqScv4oe6UZR6fbUPd0QeXyiDtxXdYHj
	 ziYipjHHfOr8W2KMpKc0UZgpf6MAVHz5LNkE+VGj+KkOTgOx0zyDayL9j/RQIJdPcj
	 8ckSu/ZgE+LbDFzWtpjyAJK1ys0tfiCMAxF4m1E/KgzNc9ol9AvkdoN00ESnq8APAy
	 cikl0rNnqnMiR2EDaVgN5QsC4roJxCmkpAPo27QGawt9fDayOa0IEuyYbaKjXbDxHP
	 nA62HQZO+woYPcLFjBkAa4T+HRL2jg1tFdx4VDLdUiWPdkhQEFBSGw1vEz95K0q+od
	 FSZvrj2KqXQFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] dmaengine: add
 dmaengine_prep_dma_(pq|pq_val|interrupt|xor)() API
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260923-dmaengine_prep_dma_pq-v2-3-32ed65b8a9b4@nxp.com>
References: <20260923-dmaengine_prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com>
 <20260923-dmaengine_prep_dma_pq-v2-3-32ed65b8a9b4@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:26:55 +0000
Message-Id: <20260923162655.AB89C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dmaengine: incorrect enum flag names in dmaengine_prep_dma_pq_val()=
 doc
--

commit 8adba4cfb473c162862987f700f7acf2fd3dceaf
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: add dmaengine_prep_dma_(pq|pq_val|interrupt|xor)() API

This commit adds inline wrapper functions for several DMA engine prep callb=
acks,=20
standardizing them with existing helpers like dmaengine_prep_dma_memcpy().=
=20
It provides a clean public API that hides direct callback access and adds=20
proper NULL-checks.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c3a49a33307c6..6a187136f9493 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h

[ ... ]

> +/**
> + * dmaengine_prep_dma_pq_val - prepare a DMA PQ validation operation
> + * @chan: the channel to use for this operation
> + * @pq: array of two addresses holding existing P and Q parity buffers
> + * @src: array of source buffer addresses
> + * @src_cnt: number of source buffers
> + * @scf: array of scaling coefficients, one per source buffer
> + * @len: length in bytes of each buffer
> + * @pqres: output flags indicating P and/or Q check results (SUM_CHECK_P=
_VALID,
> + *         SUM_CHECK_Q_VALID)

[Severity: Low]
Are these the correct enum flag names? The codebase uses SUM_CHECK_P_RESULT=
=20
and SUM_CHECK_Q_RESULT, but this documentation block references=20
SUM_CHECK_P_VALID and SUM_CHECK_Q_VALID which do not appear to exist.=20
Could this comment be updated to match the actual enum values?

> + * @flags: DMA engine flags (e.g. DMA_PREP_INTERRUPT)
> + *
> + * Prepare a PQ validation transaction.  The engine recomputes P and Q f=
rom the
> + * source buffers and compares them against the existing parity stored a=
t @pq.
> + * The result of each comparison is reported through @pqres.
> + *
> + * Returns a descriptor on success, or NULL if the channel does not supp=
ort
> + * this operation or the request could not be queued.
> + */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dmaengine_=
prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com?part=3D3
