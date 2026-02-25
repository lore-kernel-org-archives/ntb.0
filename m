Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C23D333E
	for <ntb@lists.linux.dev>; Wed, 25 Feb 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038067; cv=none; b=qO299Hzl15kyNoEA+CXW4jdJgnV3HOnIk0inVlmhCplMUCV8+0CUljO64Y0LdBYsHyXoQIw+hK2/ir/Bpr8x0Vo751vCfT511k0HFY3mgKle9g7OIGYhkjING4rmMR5lUbdMopNAZLcWGSqOtQtapqaQm4U6QmhMXdQgQ6j6iMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038067; c=relaxed/simple;
	bh=Ww7jBXJpFuUjgO2c/UkPWNS73bT08e3YJt0wwVSjjDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDGChWx84iMBD26/ApjBZ8GL0/wDFTQYa+2i25Cfw9GeXtzByTXRV4iO67Ldcpg7J2jJW99KltTKFhq9hXc9O3wW3k94xjcrWNyBOynqhFrSY02Yr38fNLkR7aUbqc/2UECXydHjViba7r9gzEI+ukizwr96i4xxu0ImS7U8IzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT/cA+t0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT/cA+t0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772038065; x=1803574065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ww7jBXJpFuUjgO2c/UkPWNS73bT08e3YJt0wwVSjjDM=;
  b=OT/cA+t0CRFyuu26pds2fGEOZFhosYvwQbTOIYpsTVZtJypovBLRZS03
   UsxYkZStiFvfWrtIGw/E65EhrHRDgiqubaiKFu61N3GggpeoSmMkbJF9S
   wf7xeQCq5Zln6yIXRiF33hipJnaPhX429rtcjDmibF/Uq4yB4tBJoPxH9
   DNYWpNZq5YjS+o5UhavALrxQ4NSQZKmnchnnYPJ33dQNNtOHHnQ/VII/h
   CEaPagrCNCPUR/OpVFXXziF25Ul44XoBXGCLJN7O/N9cS6csHxh2ikYba
   OcG+0AudUfWoCZwO/TxtuEj2XDLW93HlPGRpBBq+fja0hPubLfQdEe1qj
   A==;
X-CSE-ConnectionGUID: G19VmrKVRru2xMTqzdrk7g==
X-CSE-MsgGUID: sDlrLj7oS7eTd7y5Cegq4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="98552757"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="98552757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:47:44 -0800
X-CSE-ConnectionGUID: D4OKonMzS0OuYauDIlGuAA==
X-CSE-MsgGUID: B1ez37z+RhK0joDrepZ6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215506610"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:47:43 -0800
Message-ID: <8ff7a843-bc0d-4ee0-b1d4-94d31e071fcd@intel.com>
Date: Wed, 25 Feb 2026 09:47:43 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-8-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-8-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> ndev->db_count includes an unused doorbell slot due to the legacy extra
> offset in the peer doorbell path. db_valid_mask must cover only the real
> doorbell bits and exclude the unused slot.
> 
> Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index bce7130fec39..ee499eaed4f3 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		return ret;
>  	}
>  
> -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> +			NTB_EPF_MIN_DB_COUNT);
> +		return -EINVAL;
> +	}
> +
> +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;

I would suggest adding a comment in the code for why this is for future readers.

DJ

>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>  

