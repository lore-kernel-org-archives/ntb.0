Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF576388E46
	for <ntb@lists.linux.dev>; Thu, 16 Jul 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221621; cv=none; b=CYg/GDbC7lm6EoKvkZpIitbwsqETkXVixTkZAnb6G+A5/+xLZ4vxF3QjbIv7TVXImU1KFgzpdFsbsvyLVoL1uow83Yyt2hohfoRo0KyPXrAR/VjgKv+Oib9ESA8dJ/VGCFFH4nlAw7xcANt2EYBEnDB2/FRqVvmZlLKz0T3xi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221621; c=relaxed/simple;
	bh=ylbiRpB0bKUma6fW+PSmfSqMJt5dqgG64aEQ4L2HMi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aqT8jhYpt0VfuiFmAEhLvzGJmj5fn71Ug4Ber984SP2CIm1KS43hVUrFWIOMtgSOaaWpmbnLkp6wS4pds8o89IaIdfGua6kTrpGDpeu6mEaEId+HJjvcR/NRi/nUhW1o7DOQSLoynrvs9xNgq20c8CBeulsJEgbC8MebFlMiz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxP2iC35; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxP2iC35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784221619; x=1815757619;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ylbiRpB0bKUma6fW+PSmfSqMJt5dqgG64aEQ4L2HMi0=;
  b=kxP2iC35noUE84PthxeaWBWGJm4M8WlcT9XhBr4VVWFZpbF7NS1QrGQW
   vp1ObSeZL49RVDRYeh+5OS6/opHdsk+Bp91K3HmmJJSiXdlvZwsvsEoY7
   LrWNfAgVHfF82c3xB0B6hZGJP+Va9NmL2Xz5vtd4tDacunKcYMOGBe7sq
   50z4HeCPSgQhDNpSI6zjBE61RWN3nG5WzGbj2sPCT+WTxXCugzZ/wQEKv
   QgVJ8ES+/vpXenzyMlPWwtvHVmKecRBRLvzxarOmBhSb++5ChuvF5CaAQ
   cCcACJhZelBwKBs+a9caRZm7Q6OtY5BpAAYnKOANS1vds7gZFMxo0Epas
   g==;
X-CSE-ConnectionGUID: KUvipBp2SkiHjMmSEtE/7A==
X-CSE-MsgGUID: GD5lzPwfRSiyoxG/FvoCdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84915239"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84915239"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:06:58 -0700
X-CSE-ConnectionGUID: aQBnh3/OQM6IacXHe0L2EQ==
X-CSE-MsgGUID: V311wo1jTACWAqhMvtBZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260152931"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.15]) ([10.125.109.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:06:57 -0700
Message-ID: <de865a3b-7c09-4b50-94cd-dd2c10e1d2ce@intel.com>
Date: Thu, 16 Jul 2026 10:06:56 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: idt: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20260716032547.181804-1-panchuang@vivo.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260716032547.181804-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 8:25 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index f27df8d7f3b9..6793f7d4fc62 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2141,10 +2141,8 @@ static int idt_init_isr(struct idt_ntb_dev *ndev)
>  	/* Set the IRQ handler */
>  	ret = devm_request_threaded_irq(&pdev->dev, ret, NULL, idt_thread_isr,
>  					IRQF_ONESHOT, NTB_IRQNAME, ndev);
> -	if (ret != 0) {
> -		dev_err(&pdev->dev, "Failed to set MSI IRQ handler, %d", ret);
> +	if (ret != 0)
>  		goto err_free_vectors;
> -	}
>  
>  	/* Unmask Message/Doorbell/SE interrupts */
>  	ntint_mask = idt_nt_read(ndev, IDT_NT_NTINTMSK) & ~IDT_NTINTMSK_ALL;

