Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839751DF75B
	for <ntb@lists.linux.dev>; Fri,  8 May 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272277; cv=none; b=FjMUc+JXb1GJsHyAiwlPf0/4D3ETmxowu6f5x6kcoiS8awraoiNjj/XCMdbFHcEqGmGqIAy2GQPqaI9BWR9HE26nNHASy5UveSReo+89E4CYT/mneEC3djhZchGoNOPtmFWiaKeTRo0LAuNwyWAPb3hYksExZW+94Su9Yo34iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272277; c=relaxed/simple;
	bh=rdR9Zlyy3Tn7QJlr+httRb7kaC5Eilw2yzFdFMkeYMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hHiVppJo+Cblt1sMNa7ch0rBkJJqKm7mmNcCrBf1+KwSs3WtKfdTLmeEJaPiqP35gmIHu/JjRM+8rFm2jaFz9jkC2dXXF+/eBbBvEEwtoazLexjIAlnFaZBPtH4wlv+wtKGDlOVWoAlocWyWUMbEqZQjLNxuw3NHGfpbxomROzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u66ujydN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u66ujydN"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260508203113euoutp01a5651d8fee804a4137a669791645f2df~tsTYUA1Bf0221402214euoutp01b
	for <ntb@lists.linux.dev>; Fri,  8 May 2026 20:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260508203113euoutp01a5651d8fee804a4137a669791645f2df~tsTYUA1Bf0221402214euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778272273;
	bh=UTu/eorxGUlBka/r2okP5EobnTrz/P+IwSkOw5M6dCw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=u66ujydN9d9WhwULfFjubY0SHQUnXwIrYs4jxEo1Y2f3+610fvYTwa9F+GQjnReDS
	 balPr3omA5e3vRSZPF9VJen6bB1edBiGnH3GOm7dEGfPOYRYqkRBpUwdXS2CeMOzsC
	 Sd0Dn4AQLAQJCic89/VzGArFskVy+j8iqWMTAGtY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260508203112eucas1p1219853ee1c786b780fa13736c5e5446d~tsTXNIsBx2004020040eucas1p1s;
	Fri,  8 May 2026 20:31:12 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260508203112eusmtip1a0c0cac4f470ebcd6bbeade345afdd99~tsTW1NZEq2637826378eusmtip1v;
	Fri,  8 May 2026 20:31:12 +0000 (GMT)
Message-ID: <9b3b0d1f-39ca-439b-9102-0b4aeb5066aa@samsung.com>
Date: Fri, 8 May 2026 22:31:11 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 0/6] Add DMA attributes tracking
To: Dave Jiang <dave.jiang@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Allen
	Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <8881f9e2-431a-48d0-a778-c75014689192@intel.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260508203112eucas1p1219853ee1c786b780fa13736c5e5446d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567
X-EPHeader: CA
X-CMS-RootMailID: 20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567
References: <CGME20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567@eucas1p1.samsung.com>
	<20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
	<de72ecd7-05a1-4ef8-ad4d-de9b6c7f6774@samsung.com>
	<8881f9e2-431a-48d0-a778-c75014689192@intel.com>

On 08.05.2026 18:20, Dave Jiang wrote:
> On 5/8/26 1:50 AM, Marek Szyprowski wrote:
>> On 01.05.2026 08:35, Leon Romanovsky wrote:
>>> The DMA API expects that callers use the same attributes when mapping
>>> and unmapping. Add tracking to verify this and catch mismatches.
>> I would like to merge this to dma-mapping-for-next, but I have a question about ntb
>> patches - Jon, Dave, Allen: do You plan to take them (either to the fixes or to the
>> -next) or do You want me to take them together with dma patches?
> Please go ahead and take them together. Thanks!

Applied all patches to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

