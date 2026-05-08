Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7E31282C
	for <ntb@lists.linux.dev>; Fri,  8 May 2026 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230254; cv=none; b=i7wiiSndS/ovT2iHVb7B2cZo8dwBqdxqqZDUMluTAfDWMfZUQ3v5s3Ar9EHDtmcaqluuFI+e46XvVEr8KUXjj0zKgQahXAwiTAzDq47WDfLPlqV2eyjbCJR4+WQkubGX74fLWjNuXNxQCyw2Q2NLIF9nxrjaOqmjKjTugMOix0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230254; c=relaxed/simple;
	bh=8qMPbi0CgNlvKRpsWK/gTlYcRZWSww1khIC/8xq2UJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ay05OsqAuq8gqbl20ufvc3yZJJ3VIftIAbeQa3ZEy5f5nLpgBrDg5qpBl5bjRXy13s5b7K4DT7rqT4Cuk8JzV1q4ACElAaPT9MioMDTKwY97CeIte++1pSxEmQmFC4P4bf+RufykE4nNin3Vn5b5Ym9qgHFs8gDNet3vU78bWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=clSWB1B6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="clSWB1B6"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260508085044euoutp029a6f86d7a7dfdc6f5b08075c0e85df19~tivxTANBD0292302923euoutp02K
	for <ntb@lists.linux.dev>; Fri,  8 May 2026 08:50:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260508085044euoutp029a6f86d7a7dfdc6f5b08075c0e85df19~tivxTANBD0292302923euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778230244;
	bh=AqwrC47Qac3NC1nhCiPpqKL2SGYe4UWOPDl7Le9+Tdw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=clSWB1B6VHJGZI2gDJumUeX8ijKAuzc7OabpiHBW/d0ZmQCTPC6epjBmWHWomPl1F
	 1olRMj7NOCCjsfCjJDuJMXilmS9EIta01PQW90L4mVAOAyDcC7DqIEs/9dWDrRHp6h
	 E3FCfcUhmyWhbbUszbhR3A0DIkIDzeX3SajdFCSQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260508085043eucas1p2f3c76dbc7eb54ab2ddcf0674bb65b7ee~tivw3G3tj1242212422eucas1p2z;
	Fri,  8 May 2026 08:50:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260508085043eusmtip28c1259b3ca4f5219c7ee487779582698~tivwQYasq2427324273eusmtip2T;
	Fri,  8 May 2026 08:50:43 +0000 (GMT)
Message-ID: <de72ecd7-05a1-4ef8-ad4d-de9b6c7f6774@samsung.com>
Date: Fri, 8 May 2026 10:50:42 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 0/6] Add DMA attributes tracking
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe
	<allenbh@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260508085043eucas1p2f3c76dbc7eb54ab2ddcf0674bb65b7ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567
X-EPHeader: CA
X-CMS-RootMailID: 20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567
References: <CGME20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567@eucas1p1.samsung.com>
	<20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>

On 01.05.2026 08:35, Leon Romanovsky wrote:
> The DMA API expects that callers use the same attributes when mapping
> and unmapping. Add tracking to verify this and catch mismatches.

I would like to merge this to dma-mapping-for-next, but I have a question about ntb
patches - Jon, Dave, Allen: do You plan to take them (either to the fixes or to the
-next) or do You want me to take them together with dma patches?


> Thanks
>
> ---
> Changes in v2:
> - Split original patch to be a series
> - Added all unmap flows
> - Skipped DMA attributes which exist only in map path
> - Added ntb patch
> - Link to v1: https://protect2.fireeye.com/v1/url?k=70e722e7-116c37d7-70e6a9a8-000babffaa23-c39f7f9efe32c6a2&q=1&e=c79241ff-9ff4-40ae-8e29-753dd9d59f23&u=https%3A%2F%2Fpatch.msgid.link%2F20260323-dma-attrs-debug-v1-1-6275228ca300%40nvidia.com
>
> ---
> Leon Romanovsky (6):
>       ntb: Store original DMA address for future release
>       ntb: Use consistent DMA attributes when freeing DMA mappings
>       dma-debug: Remove unused DMA attribute parameter
>       dma-debug: Record DMA attributes in debug entry
>       dma-debug: Feed DMA attribute for unmapping flows too
>       dma-debug: Ensure mappings are created and released with matching attributes
>
>  drivers/ntb/ntb_transport.c | 10 +++---
>  kernel/dma/debug.c          | 87 +++++++++++++++++++++++++++++++--------------
>  kernel/dma/debug.h          | 25 ++++++-------
>  kernel/dma/mapping.c        | 10 +++---
>  4 files changed, 85 insertions(+), 47 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260323-dma-attrs-debug-85e282d6f3bb
>
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

