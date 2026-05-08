Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB9372B4B;
	Fri,  8 May 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257217; cv=none; b=EQ84kY4cf6/cOngusqFlQVpukIckAzTSxUIiUKHbquJ2wvoP5Wz1x/wUvFHOiz0MQ8r30IRT5lPJwyKeQ0dAYwd0Rf5zWHy8Qck3btC29ta6d6BsWaMfsrqXeCTnwg9sTHY4CMcrQUezeWCatSbdczO36C8DkSc8MeBcqBNtSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257217; c=relaxed/simple;
	bh=aFYtQc33skw3M1hEMq0k5DG/e1OddKKBL3Bo8hmK8VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVAms5gBZktxbJ91KaYzjE6aZ4PSNMqsBkuUHhZC6JLdLTYBfxGXRkDjcrfWGbIkUD+9zDP7ZU2PLdRC/qG4N4jkzzcyom3cP+WcMdRVA3jjsaJI49Vx75q8pVfxlNiKqbdyxu8+Xh3zz2lftfVxUZntGw9OG3mlh9UMf+3ix+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=estwLOG/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="estwLOG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778257215; x=1809793215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aFYtQc33skw3M1hEMq0k5DG/e1OddKKBL3Bo8hmK8VY=;
  b=estwLOG/wnhBL0f/UZMTRLBLru3d+RgeP1O3VDmnCvHQrHKEF/QFZcJQ
   ei2yt35qctDHJkyMI44swBNHRG6XpNYNv233qOStb5zIRsxMNbNRhZRUZ
   WgOfgWQtEL8r+Zbx8xegeYw9eh5N0eTVfsX65ONNyCiimzCvBx2pMn0f7
   Xg8XMx5QJvY9sKQj/H5dnT0Tpsg5RiAADYA8rQ0AWzOZo9V03EDtKF/iV
   kHEswJW1Y2HhRwJIq1amzQB9v9a3f95i8FZvQMn6lTTc5YCUy4P4b/Nd7
   68LMCUX4JZaVVwqRsFWYHB21qIJflWY6iGFcNgio9nzDhULwh/C3AClTa
   g==;
X-CSE-ConnectionGUID: 9OyJN3uASAGKgWETFPfhOA==
X-CSE-MsgGUID: jAHavv1rSs+6ABHaZZ4UJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82850465"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="82850465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 09:20:14 -0700
X-CSE-ConnectionGUID: S2tBuvy1SaqPr5ZK1AfWyQ==
X-CSE-MsgGUID: HQyGzF8iRM+e/RUypZu0gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="237044413"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.44]) ([10.125.111.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 09:20:14 -0700
Message-ID: <8881f9e2-431a-48d0-a778-c75014689192@intel.com>
Date: Fri, 8 May 2026 09:20:12 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add DMA attributes tracking
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
References: <CGME20260501063531eucas1p1019e81b1904fc7f0811b3c50cbbf9567@eucas1p1.samsung.com>
 <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <de72ecd7-05a1-4ef8-ad4d-de9b6c7f6774@samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <de72ecd7-05a1-4ef8-ad4d-de9b6c7f6774@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/8/26 1:50 AM, Marek Szyprowski wrote:
> On 01.05.2026 08:35, Leon Romanovsky wrote:
>> The DMA API expects that callers use the same attributes when mapping
>> and unmapping. Add tracking to verify this and catch mismatches.
> 
> I would like to merge this to dma-mapping-for-next, but I have a question about ntb
> patches - Jon, Dave, Allen: do You plan to take them (either to the fixes or to the
> -next) or do You want me to take them together with dma patches?

Please go ahead and take them together. Thanks!

> 
> 
>> Thanks
>>
>> ---
>> Changes in v2:
>> - Split original patch to be a series
>> - Added all unmap flows
>> - Skipped DMA attributes which exist only in map path
>> - Added ntb patch
>> - Link to v1: https://protect2.fireeye.com/v1/url?k=70e722e7-116c37d7-70e6a9a8-000babffaa23-c39f7f9efe32c6a2&q=1&e=c79241ff-9ff4-40ae-8e29-753dd9d59f23&u=https%3A%2F%2Fpatch.msgid.link%2F20260323-dma-attrs-debug-v1-1-6275228ca300%40nvidia.com
>>
>> ---
>> Leon Romanovsky (6):
>>       ntb: Store original DMA address for future release
>>       ntb: Use consistent DMA attributes when freeing DMA mappings
>>       dma-debug: Remove unused DMA attribute parameter
>>       dma-debug: Record DMA attributes in debug entry
>>       dma-debug: Feed DMA attribute for unmapping flows too
>>       dma-debug: Ensure mappings are created and released with matching attributes
>>
>>  drivers/ntb/ntb_transport.c | 10 +++---
>>  kernel/dma/debug.c          | 87 +++++++++++++++++++++++++++++++--------------
>>  kernel/dma/debug.h          | 25 ++++++-------
>>  kernel/dma/mapping.c        | 10 +++---
>>  4 files changed, 85 insertions(+), 47 deletions(-)
>> ---
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> change-id: 20260323-dma-attrs-debug-85e282d6f3bb
>>
>> Best regards,
>> --  
>> Leon Romanovsky <leonro@nvidia.com>
>>
>>
> Best regards

