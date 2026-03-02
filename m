Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13154425CC3
	for <ntb@lists.linux.dev>; Mon,  2 Mar 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470332; cv=none; b=cz1dhVwpKBasGhsUkkdAsP4Jua15BZVR578vP+QcmSZrXyxSC9fP0+MLZbKmKoYp5nGtoBM7Zk/Nh9jI9XSeWx7Eo+2AfHHq33TsCkidi1cGqgv17+yTOZ3iZ47BLKVOkCWan4KfJ0w24GgQGCZ9o+KLd0qCVgg2OK6SPXGkwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470332; c=relaxed/simple;
	bh=C8Dbe5uYyVD+vmGFPFiFLdwjWX5QpoGMFvRHJlgWZ48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3GfdNfmvRUGwLsI68pI+fve7i8nU+8ydw/Of9OknG1iSSVziXGHf/fqqcOU3Vex+3cRzI4qrHNUfggXDM41Zd+oNcYIHDTT+uG6bKigN53ZnVOeC/8JZ+FN/IvbG0PTNjswC4zHvXbMUPAEpe+nZW/sOo28BMdU569p9qMZewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hmtk9y0u; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hmtk9y0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772470331; x=1804006331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C8Dbe5uYyVD+vmGFPFiFLdwjWX5QpoGMFvRHJlgWZ48=;
  b=Hmtk9y0u1dsacW1R/NYY1gSHCL8oVFoCLMApqIjArReMCnmNPTLGlW6K
   kWMGSFbkPCpcHwAY3Bw6q699IYZ94vrttviUogWTp5EZteLWxROK4EcJ0
   ZHaFhB2u+T+ME5AC94XVG4xW6TOeR4L6d3g2OZvyxSk34J+iteSU25Wlo
   NJ/St4W84ChFjKav2QYmBbBuFLh/vMtUvXBouhvEjJODoARdyuvTirEbQ
   3imfseEtjdbWGO8g0Xsa/a7GoLs5i9bk9tV21uMHdCDHep16z2yFTIRSS
   ZwKx9gfu7M6Ox6doB2JLoTvRYI6+tn2TxmV4M6AZRLjiTjLITgbZg7X6W
   g==;
X-CSE-ConnectionGUID: XSzNa27IRL6voyZ5fy9Tgg==
X-CSE-MsgGUID: jKVRHQ+URySYLs4PiU5f4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84124640"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84124640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:52:11 -0800
X-CSE-ConnectionGUID: PzfMRIKFTlOe2stRhsGxng==
X-CSE-MsgGUID: 9AodBT6ATb2koycD1NHfPQ==
X-ExtLoop1: 1
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:52:09 -0800
Message-ID: <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
Date: Mon, 2 Mar 2026 09:52:08 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260302144522.750620-1-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302144522.750620-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/2/26 7:45 AM, Koichiro Den wrote:
> Some NTB implementations are backed by a "virtual" PCI device, while the
> actual DMA mapping context (IOMMU domain) belongs to a different device.
> 
> One example is vNTB, where the NTB device is represented as a virtual
> PCI endpoint function, but DMA operations must be performed against the
> EPC parent device, which owns the IOMMU context.
> 
> Today, ntb_transport implicitly relies on the NTB device's parent device
> as the DMA mapping device. This works for most PCIe NTB hardware, but
> breaks implementations where the NTB PCI function is not the correct
> device to use for DMA API operations.

Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
physically contiguous allocation of rx ring buffers"). As you can see it
tries to get around the issue as a temp measure. The main issue is the
memory window buffer is allocated before the dmaengine devices are allocated.
So the buffer is mapped against the NTB device rather than the DMA device.
So I think we may need to come up with a better scheme to clean up this
issue as some of the current NTBs can utilize this change as well.

The per queue DMA device presents an initialization hierarchy challenge with the
memory window context. I'm open to suggestions.  

DJ

> 
> This small series introduces an optional .get_dma_dev() callback in
> struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
> callback is not implemented, the helper falls back to the existing
> default behavior. Drivers that implement .get_dma_dev() must return a
> non-NULL struct device.
> 
> - Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
>              ntb_get_dma_dev().
> 
> - Patch 2/2: Switch ntb_transport coherent allocations and frees to use
>              ntb_get_dma_dev().
> 
> No functional changes are intended by this series itself.
> 
> A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
> (drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
> separately to the PCI Endpoint subsystem tree. That will enable
> ntb_transport to work correctly in IOMMU-backed EPC setups.
> 
> Best regards,
> Koichiro
> 
> 
> Koichiro Den (2):
>   NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
>   NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
> 
>  drivers/ntb/ntb_transport.c | 14 +++++++-------
>  include/linux/ntb.h         | 23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 

