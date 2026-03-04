Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB44374E61
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643225; cv=none; b=f9biIrmhFGHwCYbYC9YPvfA6guVL0wGulghW7R8etdEViOyxET0qvqIgn5ArEEtKdjzw3FkFKZ7kfdj8i1eEcz8v0NF0709GWO+9QAfKnxwO/McjcXUof/ECuixVUN+p51Jh+qNOrrJYN6e2U93D5J+KuKJkT2upV2wWL4gTq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643225; c=relaxed/simple;
	bh=q/WrJOTGbgNzjFLKVnlXuI9iVhvYNt4xbEypM8ZZ+U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc5nXKGtEZGRtUnLaQu/tm+DWViU2a81+Jwc0kXNH8h6t3/1HOEJtS8rqSpnVnG5nNPNI3nylnXCSrttuC4jjaTollSn9I9z+LU+Hfj22pTPkXI/t74UMpbQhR2XtW2T5WenGRkjPWJ6VASVg0PU/Basf0KPHFR2vFojj9scqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQTo6TDS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQTo6TDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772643224; x=1804179224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q/WrJOTGbgNzjFLKVnlXuI9iVhvYNt4xbEypM8ZZ+U4=;
  b=mQTo6TDSaP8dT1oGQeGDTEGZwdzerGO6+HZUQqjCWwh8Gyy2CHplcfYA
   NQn2IJ7rWpbSvqFvO6TVnbuSebZm+PrmhyeyiH4nZ9KqnGRjqzXzF992z
   eWq2J79erp0uBOUzOt1sTfsC5X8MfjUxJpGdn8qLtlb6p5/HZpOUesoup
   ViJ1ZXucRbz9bh7P7bmXhyVGiJMrshNpeDmRbm6z6eQhCkZnJNoepgpiM
   WgLsuc+Wdq/FQfYlgJXWUVyimbezzkEOXNDIgCrNRoEtM+G9R3DRCl29i
   aXdkT0MA4MA6KBxvmTA/LZpds/RXuIoI3sEKyA1EpTPwJaBMj2FUbP/4O
   A==;
X-CSE-ConnectionGUID: JFQlsfDYRHKAFlO92ukhAA==
X-CSE-MsgGUID: aqT44ibtTa2pIXDmkMt42g==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77316185"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77316185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:53:44 -0800
X-CSE-ConnectionGUID: yjz47JwYTXKGMAJTh+VkZA==
X-CSE-MsgGUID: FE919MmbSnCnt/2qVvwFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="218365331"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:53:43 -0800
Message-ID: <b17c238b-3d0a-49b3-a012-a6e33766b8b0@intel.com>
Date: Wed, 4 Mar 2026 09:53:42 -0700
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
 <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
 <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/26 8:56 AM, Koichiro Den wrote:
> On Tue, Mar 03, 2026 at 08:42:53AM -0700, Dave Jiang wrote:
>>
>>
>> On 3/2/26 9:56 PM, Koichiro Den wrote:
>>> On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
>>>>
>>>>
>>>> On 3/2/26 7:45 AM, Koichiro Den wrote:
>>>>> Some NTB implementations are backed by a "virtual" PCI device, while the
>>>>> actual DMA mapping context (IOMMU domain) belongs to a different device.
>>>>>
>>>>> One example is vNTB, where the NTB device is represented as a virtual
>>>>> PCI endpoint function, but DMA operations must be performed against the
>>>>> EPC parent device, which owns the IOMMU context.
>>>>>
>>>>> Today, ntb_transport implicitly relies on the NTB device's parent device
>>>>> as the DMA mapping device. This works for most PCIe NTB hardware, but
>>>>> breaks implementations where the NTB PCI function is not the correct
>>>>> device to use for DMA API operations.
>>>>
>>>> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
>>>> physically contiguous allocation of rx ring buffers"). As you can see it
>>>> tries to get around the issue as a temp measure. The main issue is the
>>>> memory window buffer is allocated before the dmaengine devices are allocated.
>>>> So the buffer is mapped against the NTB device rather than the DMA device.
>>>> So I think we may need to come up with a better scheme to clean up this
>>>> issue as some of the current NTBs can utilize this change as well.
>>>
>>> Thanks for the feedback.
>>>
>>> I think there are two issues which are related but separable:
>>>
>>> - 1). Ensuring the correct DMA-mapping device is used for the MW translation
>>>       (i.e. inbound accesses from the peer).
>>> - 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
>>>       device ("double mapping").
>>>
>>> (1) is what this series is addressing. I think this series does not worsen (2).
>>> I agree that (2) should be improved eventually.
>>>
>>> (Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
>>> can be the same as chan->device->dev, in that case the double mapping could be
>>> optimized away. However, I undersntand that you are talking about a more
>>> fundamental improvement.)
>>>
>>>>
>>>> The per queue DMA device presents an initialization hierarchy challenge with the
>>>> memory window context. I'm open to suggestions.  
>>>
>>> In my view, what is written in 061a785a114f looks like the most viable long-term
>>> direction:
>>>
>>>     A potential future solution may be having the DMA mapping API providing a
>>>     way to alias an existing IOVA mapping to a new device perhaps.
>>>
>>> I do not immediately see a more practical alternative. E.g., deferring MW
>>> inbound mapping until ntb_transport_create_queue() would require a substantial
>>> rework, since dma_chan is determined per-QP at that stage and the mapping would
>>> become dynamic per subrange. I doubt it would be worth doing or acceptable.
>>> Pre-allocating dma_chans only for this purpose also seems excessive.
>>>
>>> So I agree that (2) needs a clean-up eventually. However, in my opinion the
>>> problem this series tries to solve is independent, and the approach here does
>>> not interfere with that direction.
>>
>> Fair assessment. For the series:
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for the review.
> 
> Once this looks good to Jon as well and gets queued in the NTB tree, I'll submit
> a small patch to PCI EP for vNTB (the real user of the interface), something
> like the following:
> 
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index be6c03f4516e..8aeacbae8b77 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1501,6 +1501,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
>         return 0;
>  }
> 
> +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> +{
> +       struct epf_ntb *ntb = ntb_ndev(ndev);
> +
> +       if (!ntb || !ntb->epf)
> +               return NULL;
> +       return ntb->epf->epc->dev.parent;
> +}
> +
>  static const struct ntb_dev_ops vntb_epf_ops = {
>         .mw_count               = vntb_epf_mw_count,
>         .spad_count             = vntb_epf_spad_count,
> @@ -1522,6 +1531,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>         .db_clear_mask          = vntb_epf_db_clear_mask,
>         .db_clear               = vntb_epf_db_clear,
>         .link_disable           = vntb_epf_link_disable,
> +       .get_dma_dev            = vntb_epf_get_dma_dev,
>  };
> 
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> 

Probably should include it with this series if it's small. Having the user with new code is usually preferred.

