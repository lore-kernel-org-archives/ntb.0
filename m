Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18883CF209;
	Fri, 18 Sep 2026 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764805; cv=none; b=Jo+Uocm6Xy3MfKBQ3aAA0ncOVlZOPyhawzS0ebKszA7McIl91bO4uwWYm+xTEoGo7aNwVvWUWxfMQI6An9XfDKTULoi7tPFL1/ly64QQ+irSetPdBE2uLLs4Xp574iD9H7CQ+Igt8XANPlPIkLIqknPnzRESr/3hXNgrBViozqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764805; c=relaxed/simple;
	bh=JoCvPKPJK4XNl7dxKj1IY09gn9knFB52VA5Ub7t6zbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J063FYbJvDJstyil1Ob5JFCEdF2XRnjVNCIeE69J60eWKxU6b9VQF+DIAtofhMIwJemwoRBQsETuUf+WVzEfyU0km69bxRN+74j8p1p396v+93IIUFj3cAFyfuHR6r3eKfiDcneVoTSSXCHZhO8EVTFiZHNbFapiDtrGIbvR1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+FL7kE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+FL7kE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC7D1F000FF;
	Fri, 18 Sep 2026 20:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789764804;
	bh=Fk1yHms2nPlG5Gjc01L1ryL5ecMNq48D4MZBAMTwa70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+FL7kE8QZIOMcv4jM6TtrFa93Olbk3Q9qyemFnSZmirOMTrKUB+AmyFl36UH8eNl
	 i7BAq1d+6Mrxntul1habqmZ6gvkYs/JBtVKB34Bpe5LE+hdqdcD1zV/FUnk1n/bCw/
	 o4wvmB6pJMG1I2HWhGZLJFJ49tQJ+FpL24uqSeyZG3Era5lLC0WKGr93pEH8CmBRzy
	 bzSLypeASRw1vkWZ370aLhGx/K/shK+TaHirT1NIL9aZYuwtgCRPPsEHiM2ybgSzzH
	 VASeYL3RhwEp7xH3nTCnafCxCuMOhQbMTh1ekgelOGZyc2QFz7DhiOh29U2rbx4zyI
	 7aAdE0py25dzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] ntb: use dmaengine_get_dma_device() instead of
 chan->device->dev
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260918204152.2364336-1-Frank.Li@oss.nxp.com>
References: <20260918204152.2364336-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:53:23 +0000
Message-Id: <20260918205324.3CC7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ntb: missed replacing chan->device->dev in perf_dma_filter()
- [Low] ntb: commit message incorrectly mentions IIO instead of NTB
--

commit 00ad86ab4ff3c677b79412d332638c7a5186dbbe
Author: Frank Li <Frank.Li@nxp.com>

ntb: use dmaengine_get_dma_device() instead of chan->device->dev

This commit replaces direct chan->device->dev access with the proper
dmaengine_get_dma_device() accessor in NTB DMA consumers. It prepares
for making the DMA engine provider data structures private.

>     Replace direct dma_chan::device::dev access with the proper
>     dmaengine_get_dma_device() accessor in IIO DMA consumers.

[Severity: Low]
This isn't a bug, but the commit message incorrectly mentions IIO DMA
consumers instead of NTB DMA consumers.

> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..b936f15079df2 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
[ ... ]
> @@ -869,6 +869,7 @@ static bool perf_dma_filter(struct dma_chan *chan, vo=
id *data)
>  static int perf_init_test(struct perf_thread *pthr)
>  {
>  	struct perf_ctx *perf =3D pthr->perf;
> +	struct device *dma_dev;

[Severity: Medium]
Does this patch miss a replacement in perf_dma_filter()?

Right above this hunk, perf_dma_filter() still accesses chan->device->dev
directly:

drivers/ntb/test/ntb_perf.c:perf_dma_filter() {
    ...
    return node =3D=3D NUMA_NO_NODE || node =3D=3D dev_to_node(chan->device=
->dev);
}

Since the goal is to prepare for making DMA engine structures private by
abstracting chan->device->dev behind dmaengine_get_dma_device(chan), will
leaving this direct access cause a build failure once the structure is made
private?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918204152.2364=
336-1-Frank.Li@oss.nxp.com?part=3D1
