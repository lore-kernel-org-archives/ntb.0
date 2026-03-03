Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A239890C
	for <ntb@lists.linux.dev>; Tue,  3 Mar 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552578; cv=none; b=ciDAXBR2WyX1Psf7TmYuyJdmXuiVJmjT5LDKtJMVlJhhmP+AAVRLuWxOJUi5t5gCgRnvT1P0sbSibE92n6lMD5Mv2rMguVoQpJ8xdhw+VGp5k1D6N3RKOlhdpLpehaVn7o4Hvr3oEqAxnNSxfg3ru7NQR6K+zlygxalHVe+sfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552578; c=relaxed/simple;
	bh=04yU8vbz97tG70PV4y5jJWzYBtBfuJmcJMlErvhJWSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+M3ftQfWYcOEjiWQi/8WM66gnL0xQ0iEn++LuOL9e7IG+n9WfpvctK7mVjStgU7SkUcNzJkA4Ws4aA+u5zSDFDQ96MPhxMo6wyrklQ8CayKfV8zM959j4T1H6cpKaUqP6mNMsDgC+ugp5t07tBaFQN+LvNHJFRtu2bGQwjFbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C31rYe8Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C31rYe8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772552574; x=1804088574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=04yU8vbz97tG70PV4y5jJWzYBtBfuJmcJMlErvhJWSk=;
  b=C31rYe8ZSAPyx6TcbSgr9S/M3XsSsLwpL+zvtncQlSd/lvkO9Y3A6cdA
   SvqEos4yv515PpMnMs9aVYGGtkfFTVkSpJC/wqzBP7HSRt2XVbpbB4s8i
   eOOO5gmdI9U1GYCHmK/A8ae2EWTPF5S2dzVjUss88NIms71i9bIxR7hW7
   YzrJjGAp9nDST+Bwd+fjZwV/OuWC1jpqImLY2L9ijG/eTp8BwjHnBhDuF
   2UtHDYCsdtPMuyRh0uyGk+V2XcJtifP2uRG1hfVoSVx4TTdEJslzZxVHR
   9WmIxoMVre5alxsxf42omMJ1tVoVZIbyVBIj0EdWB9VTJfmPNY1r0LH7G
   w==;
X-CSE-ConnectionGUID: vWDIv0D6QC6UwVTAN98Jig==
X-CSE-MsgGUID: nHtxiNM3Q4qyw3QTvd0CfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="83931940"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="83931940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:42:53 -0800
X-CSE-ConnectionGUID: 4nV6IvwBQuWp6M1vpHKntg==
X-CSE-MsgGUID: kpLnRzJBQzydJGA5hrl7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="218008367"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.145]) ([10.125.108.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:42:54 -0800
Message-ID: <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
Date: Tue, 3 Mar 2026 08:42:53 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260302144522.750620-1-den@valinux.co.jp>
 <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
 <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/2/26 9:56 PM, Koichiro Den wrote:
> On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
>>
>>
>> On 3/2/26 7:45 AM, Koichiro Den wrote:
>>> Some NTB implementations are backed by a "virtual" PCI device, while the
>>> actual DMA mapping context (IOMMU domain) belongs to a different device.
>>>
>>> One example is vNTB, where the NTB device is represented as a virtual
>>> PCI endpoint function, but DMA operations must be performed against the
>>> EPC parent device, which owns the IOMMU context.
>>>
>>> Today, ntb_transport implicitly relies on the NTB device's parent device
>>> as the DMA mapping device. This works for most PCIe NTB hardware, but
>>> breaks implementations where the NTB PCI function is not the correct
>>> device to use for DMA API operations.
>>
>> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
>> physically contiguous allocation of rx ring buffers"). As you can see it
>> tries to get around the issue as a temp measure. The main issue is the
>> memory window buffer is allocated before the dmaengine devices are allocated.
>> So the buffer is mapped against the NTB device rather than the DMA device.
>> So I think we may need to come up with a better scheme to clean up this
>> issue as some of the current NTBs can utilize this change as well.
> 
> Thanks for the feedback.
> 
> I think there are two issues which are related but separable:
> 
> - 1). Ensuring the correct DMA-mapping device is used for the MW translation
>       (i.e. inbound accesses from the peer).
> - 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
>       device ("double mapping").
> 
> (1) is what this series is addressing. I think this series does not worsen (2).
> I agree that (2) should be improved eventually.
> 
> (Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
> can be the same as chan->device->dev, in that case the double mapping could be
> optimized away. However, I undersntand that you are talking about a more
> fundamental improvement.)
> 
>>
>> The per queue DMA device presents an initialization hierarchy challenge with the
>> memory window context. I'm open to suggestions.  
> 
> In my view, what is written in 061a785a114f looks like the most viable long-term
> direction:
> 
>     A potential future solution may be having the DMA mapping API providing a
>     way to alias an existing IOVA mapping to a new device perhaps.
> 
> I do not immediately see a more practical alternative. E.g., deferring MW
> inbound mapping until ntb_transport_create_queue() would require a substantial
> rework, since dma_chan is determined per-QP at that stage and the mapping would
> become dynamic per subrange. I doubt it would be worth doing or acceptable.
> Pre-allocating dma_chans only for this purpose also seems excessive.
> 
> So I agree that (2) needs a clean-up eventually. However, in my opinion the
> problem this series tries to solve is independent, and the approach here does
> not interfere with that direction.

Fair assessment. For the series:
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Best regards,
> Koichiro
> 
>>
>> DJ
>>
>>>
>>> This small series introduces an optional .get_dma_dev() callback in
>>> struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
>>> callback is not implemented, the helper falls back to the existing
>>> default behavior. Drivers that implement .get_dma_dev() must return a
>>> non-NULL struct device.
>>>
>>> - Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
>>>              ntb_get_dma_dev().
>>>
>>> - Patch 2/2: Switch ntb_transport coherent allocations and frees to use
>>>              ntb_get_dma_dev().
>>>
>>> No functional changes are intended by this series itself.
>>>
>>> A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
>>> (drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
>>> separately to the PCI Endpoint subsystem tree. That will enable
>>> ntb_transport to work correctly in IOMMU-backed EPC setups.
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>
>>> Koichiro Den (2):
>>>   NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
>>>   NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
>>>
>>>  drivers/ntb/ntb_transport.c | 14 +++++++-------
>>>  include/linux/ntb.h         | 23 +++++++++++++++++++++++
>>>  2 files changed, 30 insertions(+), 7 deletions(-)
>>>
>>
> 

