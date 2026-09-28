Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB74E66CE
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608959; cv=none; b=flcOuqOET9I8gCfM2nz1csG7ZOH5NpejJw/iJ3kYKsNAxW3UW2w1etdRj2Ta0ww+PGawxVGiC1wosePN9AzGJ1Gx/ocZlQ3Tt5joKF2L3WrZi8d+y35gG20T9p9PTR9kQdLau7dpv6b/NYGXAbMbDssPHxaJoKYGEcLrT0IQD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608959; c=relaxed/simple;
	bh=epB5TBUW1zB5SEcLjdZT7p/4M1HPpDsRXf3ppGpfiiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atfqk6ESBNQR86XwWJPDlGuxz80VUAzN+A/wA0LShd5P3Ge9e9Z+4As+5jtaS2x+Dg0eZ0+4RKVDy8FUaGb5MikgSW7MEvOSpEwC8i9Fii4V9sDeTcoTtkoi0j0ZIcnG/lZAdNDhCaEuGZbtRatTV80LrR2twwvrsATNz1HXUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbuNsDB6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbuNsDB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790608958; x=1822144958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=epB5TBUW1zB5SEcLjdZT7p/4M1HPpDsRXf3ppGpfiiM=;
  b=LbuNsDB6aVCYyZct4BtlTSbg5A4/fWcwtXS8WvPFiZBoHdsuq63eRwPW
   l539j32z/SpjnKpiui+z0KWpzhPcbnOZcfMryMPPboglJZaNF0KvEti4J
   +Z8cp2GDxkJCuYkHte7veW7yiM4e2Ff09O9GG2Y4UXMriWpenND/CXKpG
   IPGxVSxF3p7gzbua6fPbvcFikNHf5/qd+/qC/ueV97t3MBxdlVZkauSP3
   Zin0V72v5BDh9eTvQxagpO/tE2A3DYF5LuZEp7AmWGVoESIUZXgG7LzJa
   YH7OLAKpQ7tjj7UM27RXmy9fqW9v3QS7kG2Gffh+pLMQKFgEauIso4vOY
   w==;
X-CSE-ConnectionGUID: 1Lb7Vz4BT5qQbs2HtZo9+g==
X-CSE-MsgGUID: bNKNFvomSW64pqKVCdKkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90362920"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90362920"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:22:36 -0700
X-CSE-ConnectionGUID: oTF1UL8DSCy7IwbqmmQ4ZA==
X-CSE-MsgGUID: jDGLJWVNTrWzC6kZoDSmEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275115684"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:22:35 -0700
Message-ID: <82407c03-e208-41b9-a9ca-6a5bbe60f3a7@intel.com>
Date: Mon, 28 Sep 2026 08:22:33 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-12-den@valinux.co.jp>
 <11a47b77-b140-46df-bee6-3484e18ad62e@intel.com>
 <879429f5-b209-49ef-be1c-184eb7d5783b@intel.com>
 <hkrizcxjisnrkedwzycnkvhxynncgj66oj7crozf5ynuz4ys6c@7i7tixcnt2oa>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <hkrizcxjisnrkedwzycnkvhxynncgj66oj7crozf5ynuz4ys6c@7i7tixcnt2oa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 1:51 AM, Koichiro Den wrote:
> On Thu, Sep 24, 2026 at 08:57:49AM -0700, Dave Jiang wrote:
>>
>>
>> On 9/24/26 8:56 AM, Dave Jiang wrote:
>>>
>>>
>>> On 9/9/26 9:08 PM, Koichiro Den wrote:
>>>> The next patch clears remote_rx_info when freeing its MW.
>>>> ntb_transport_tx_free_entry() and debugfs stats reads can run during
>>>> link cleanup, so make them handle a NULL pointer.
>>>>
>>>> The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
>>>> to prevent compiler-induced tearing, and retain the read value so
>>>> the NULL check and dereference use the same pointer.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Probably should take a look at the sashiko raised issue.
> 
> I looked into it and thought we might as well fix the TX/MW teardown race too.
> In fact, with patch 14, transport removal stops netdev TX and its timer before
> freeing MWs, but ordinary link-down cleanup doesn't wait for them.
> I gave this a try locally, but it all ended up being quite a rework..
> 
> So for this series, I'd just drop WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp))
> from ntb_async_tx().
> 
> The caller already checks for space. Clean-up can clear remote_rx_info before
> this second check, which now returns 0 and trips the WARN. The WARN doesn't stop
> TX anyway.
> 
> This won't fix the existing lifetime race, but it does remove the new warning
> Sashiko pointed out. I'd leave the broader fix for separate work. Still,
> returning 0 when we see a cleared pointer seems at least better than
> dereferencing a stale one.
> 
> I'm planning to send v3 with this one-line deletion, but if you have a better
> idea, please let me know.

Nope, this is fine.

