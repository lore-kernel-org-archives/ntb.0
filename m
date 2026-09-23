Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9653A88A;
	Wed, 23 Sep 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180934; cv=none; b=Td5hrtAuBunrlGqZ9YNRXrruBbaTu8MlfXkZIzaowpN9Mb7OFAXrM9WgX+IFrVqlWz+hVZWZTxTgoN4DiNL/7C0YZaPkLElm95ouSy4qmnCCMUSV7bPHlERiUC2FtnqMEpKD1MQ/ufyYWVeBrNUSbTMpRbL0Fqlm6SiGDOpRhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180934; c=relaxed/simple;
	bh=Z8p8Wm2xdAphrZUsy6RFbsjq4D92MeSzFbQyw6a0Nco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i7Cz/W5l8WXHIVtbiUbSqD8bXQHgjguuHjdWc7FLtVa0zQsWDO2iin3RNpQKvJjwox6L7eRAu8dXh/1dA9Djl30hZoh+WeEsdSHMXDfDFStOdPXcFCucDajFc1+tXTADOPqCCAhlURz3d6Nv/TD/ncA/scRpAXy1WdldFnVsf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGy5+Gpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGy5+Gpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C4E1F000FF;
	Wed, 23 Sep 2026 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180933;
	bh=jwy/PaUGy+jQbxjsb/+93p0iRrGbTudfGIuuQqDA8Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGy5+GpijB+fINSb5C3duTydR9B7O9wQlbo9YwNiFl21Pppi1edI9cQW8t6aUCYis
	 4ocWiyo1L2d9elmTR3zkW9PNGekGCuz2vMiiAQf/URbwVhlBqHjd9vk5+kQ/wc8iZa
	 XNero1SJB+mG62VVEUyDzM4IVW/6kn1YdmVDulyncT9oxcZy9Ec5tzBYCv2mBx7R+c
	 fDm4PScAszVgMAKdxBKEMTx5U0NSngGTZDY5Lzwdjns251PNP25KmtelbWyuUxR6Bb
	 AE4NKnlv5kDeZkDKdYjbN66qlt8bNve28zii1dNGpqM9qEPbAQ0e2fvlQWcw1FM772
	 MTK5j1Mp5nm5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] dmaengine: replace dma_maxqp() with
 dmaengine_maxpq() taking struct dma_chan *
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: ntb@lists.linux.dev, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260923-dmaengine_prep_dma_pq-v2-9-32ed65b8a9b4@nxp.com>
References: <20260923-dmaengine_prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com>
 <20260923-dmaengine_prep_dma_pq-v2-9-32ed65b8a9b4@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:28:52 +0000
Message-Id: <20260923162852.D2C4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] dmaengine: stale kernel-doc parameter for dmaengine_maxpq()
- [Low] dmaengine: stale comment references to dma_maxpq in ioat/prep.c
--

commit cf2513640f8224536d6e477b79237784cd551e0e
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: replace dma_maxqp() with dmaengine_maxpq() taking struct dma_cha=
n *

Replace dma_maxpq() with dmaengine_maxpq(chan, flags) as a channel-based
API, consistent with the convention of other dmaengine_*() helpers that
take struct dma_chan * rather than struct dma_device *.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 63f40b8fd3009..34fd3bb32f86e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1706,7 +1706,7 @@ static inline unsigned short dma_dev_to_maxpq(struc=
t dma_device *dma)
>  	return dma->max_pq & ~DMA_HAS_PQ_CONTINUE;
>  }
> =20
> -/* dma_maxpq - reduce maxpq in the face of continued operations
> +/* dmaengine_maxpq - reduce maxpq in the face of continued operations
>   * @dma - dma device with PQ capability

[Severity: Low]
Does this kernel-doc comment need to be updated to document the new 'chan'
parameter instead of the removed 'dma' parameter? The mismatched names will
cause kernel-doc validation tools to emit warnings.

>   * @flags - to check if DMA_PREP_CONTINUE and DMA_PREP_PQ_DISABLE_P are =
set
>   *

[ ... ]

> @@ -1719,8 +1719,10 @@ static inline unsigned short dma_dev_to_maxpq(stru=
ct dma_device *dma)
>   * In the case where P is disabled we only need 1 extra source:
>   * 1/ {01} * Q : use Q to continue Q' calculation
>   */
> -static inline int dma_maxpq(struct dma_device *dma, enum dma_ctrl_flags =
flags)
> +static inline int dmaengine_maxpq(struct dma_chan *chan, enum dma_ctrl_f=
lags flags)
>  {

[Severity: Low]
Are there plans to update existing comment references to dma_maxpq() in oth=
er
drivers as part of this refactoring?

For example, there are stale references in drivers/dma/ioat/prep.c inside
__ioat_prep_pq_lock() and __ioat_prep_pq16_lock() that still refer to the
old dma_maxpq function name.

> +	struct dma_device *dma =3D chan->device;
> +
>  	if (dma_dev_has_pq_continue(dma) || !dmaf_continue(flags))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dmaengine_=
prep_dma_pq-v2-0-32ed65b8a9b4@nxp.com?part=3D9
