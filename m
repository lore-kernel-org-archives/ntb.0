Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9583603C2
	for <ntb@lists.linux.dev>; Wed, 18 Mar 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863505; cv=none; b=Dt7zjXj45lyQ+GwK8nrf4UJVTykEHQxcNs17CulU4N5oulGtbqmByt2FYErpOTCdfFAWPsBM07vBSuYNzCD3yw0w1TsB43KzsUvynL0bLRsev00YUu8ZSXlKSFKZsPlVQvgswMZz3UydBzmZEaSBs8xfhlG7UXkjTqNsOKhVgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863505; c=relaxed/simple;
	bh=4M4ASRtcvMdVvZ7JaHXHA7nhG6/L8AjsQ5TECcYimeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkQKBYNruMuauHzmckn9QOqCbJBrIevY21gpumccAM4mgoSwwO+JMNNnWGJrsP9dM6OCAKmfoCGL8JphGa/Ox9SuwpL2QAhv6d0JPKGkuAienU8/RbdbRTcTbc5OUX4SKpgPl/OCue/qcRBuhIsODNboyCp99Q31l5KZ0z+A8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3Rzl2a+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3Rzl2a+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773863503; x=1805399503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4M4ASRtcvMdVvZ7JaHXHA7nhG6/L8AjsQ5TECcYimeg=;
  b=W3Rzl2a+/PiIr5GB1jBM5cbQeFZipo+kU3cGPupUg3QJY85XPUz0M04t
   HZjqEyVWH/4YCjQaTwt1x2ak8PODLYO2aW+/jJ7BG9Ys92uazNKooac6T
   wx/3ytY1k+xJZMRpdLspthNfTkGSKQvlCtUw7Ls416LabP8WSZRa7TdcV
   b5bb7MjOShxWG5Q3yTc8Y9d0e5CQ3o40EcezYTkUHpsyK1K7kfCI/A5B8
   HD/SuKyN0AUOEQXQGnZsmc/SdmX8XPHTh/E+0xualYmTdxjLc13Vu1mie
   74fpOvXg2Rg6DALID3yZ1+VWxDOhKVHgsRc00eK/Y8ThCs13bwWJ3ebUK
   Q==;
X-CSE-ConnectionGUID: 6Y8xTA4ATLyiYLy4j78eJg==
X-CSE-MsgGUID: erGgcXh+TgqMYOhM71AIJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62498946"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="62498946"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 12:51:42 -0700
X-CSE-ConnectionGUID: LRQWud8NQRG4EmIttc0bYg==
X-CSE-MsgGUID: +VG7H+H7QF6rz7kJyShZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227688794"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 12:51:41 -0700
Message-ID: <d931ce45-b3c8-4cb7-80ec-7acadf26a22d@intel.com>
Date: Wed, 18 Mar 2026 12:51:39 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260304083028.1391068-1-den@valinux.co.jp>
 <wzv676qh2bahuptnzhhyywt2ihuz7xn2j7mcm6heqoweqz564v@mx66vyni2vyd>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <wzv676qh2bahuptnzhhyywt2ihuz7xn2j7mcm6heqoweqz564v@mx66vyni2vyd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 8:01 PM, Koichiro Den wrote:
> On Wed, Mar 04, 2026 at 05:30:26PM +0900, Koichiro Den wrote:
>> ntb_hw_epf handles doorbell interrupts using multiple MSI/MSI-X vectors.
>> This small patch series is to address two issues in the interrupt
>> setup/handler path:
>>
>>  1) ntb_epf_init_isr() does not unwind already requested IRQs when
>>     request_irq() fails part-way through the vector loop.
>>
>>  2) ntb_epf_vec_isr() calls pci_irq_vector() in hardirq context to
>>     derive the vector number. pci_irq_vector() performs an MSI domain
>>     lookup (msi_get_virq()) that takes a mutex, which can trigger
>>     "scheduling while atomic" splats.
>>
>> Patch 1 fixes the request_irq() unwind path.
>> Patch 2 caches the Linux IRQ number for vector 0 and uses it as a base in
>> the ISR, avoiding pci_irq_vector() from hardirq context.
>>
>> Both patches are Cc'd to stable (v5.12+).
>>
>> Best regards,
>> Koichiro
>>
>> Koichiro Den (2):
>>   NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
>>   NTB: epf: Avoid pci_irq_vector() from hardirq context
> 
> Jon or Dave,
> 
> Gentle ping on this series.
> I would appreciate it if you could take a look when you have a chance.

For the series, LGTM
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Best regards,
> Koichiro
> 
>>
>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.51.0
>>
>>

