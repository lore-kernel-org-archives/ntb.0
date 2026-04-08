Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A612D3733
	for <ntb@lists.linux.dev>; Wed,  8 Apr 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662516; cv=none; b=lPHSqydA4T89IQlyVwefuL1TIz0D1U5UOs2WLEmyiRkHO1a7hC3qaA8fuWfsoeKS4z6X0hLV8tKWjPo90GwDgPIeTghvOd3cnRX4GQk+XJ7Z5ohijuc0QDHrCNQ1pqn9Z28ni4ksNm0gnsl7fkIvbLUC182qTiif7XHmgWYsF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662516; c=relaxed/simple;
	bh=9In2gmK/iT4rTJXbykeLaxuU0eu6e40xIwAWczqbluw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hq+XkhuPphLLv1Y7Cu8A4RxHu5VE4J8NceyaLwkU7QQ2gFuMD6AX4bnzBQwNBliLunCDU4JblcYPzIwrCyUiUWUQz5udHqEyDm2Cvye/A+YAXOGmwwL0dQeCoalkrKSvT1s/n6NoQgYFxXoxOdHHFsEiRGI60JGzFgSl2gVduik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4ZrEPS/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4ZrEPS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775662515; x=1807198515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9In2gmK/iT4rTJXbykeLaxuU0eu6e40xIwAWczqbluw=;
  b=Z4ZrEPS/2GyjQqwPQ3CWCuslMJJG8iqJvdx8dO39Lh3k6UqCjFeQ3+YI
   cBReUV7ZFvFoBtjk+7ykEepX/hQfiU4ZeuIE9yzRQ0APlCOA4En7JcMTp
   mZVNVLAeqlrKfTdWqUrhV+WEH2FXgl519EOgdsbeVIOy3SFFvxiRUojYH
   TEH6WhyJSWqSbF7iMYfb12oCDlyH+sDw40Yr4FVrr9wisO3kfh5H3vwMi
   BdG/TBNTq+E6qJV22asx4Q79+k30sdVXh/35H82I7ie/KKMJs8ZUQC3Pg
   /x03h/dwr4v5RbXE3UV4wq8CzuQ2bll0HeixKWSkd1C/wyeNyk2nGJNlk
   w==;
X-CSE-ConnectionGUID: lWUXVbTmRjKQvUTcfQ0/tg==
X-CSE-MsgGUID: 9+2zMTVOT02d7XbBCh1LAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94037589"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94037589"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 08:35:14 -0700
X-CSE-ConnectionGUID: broOo/FLTZqmmc3cQ+xf+g==
X-CSE-MsgGUID: vXlHN3oOT2SUOgDbfoYPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="223738830"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.185]) ([10.125.108.185])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 08:35:13 -0700
Message-ID: <f146e5ad-03f9-4264-96d9-90e17e255335@intel.com>
Date: Wed, 8 Apr 2026 08:35:12 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NTB: epf: log teardown command failures with error code
To: Alok Tiwari <alok.a.tiwari@oracle.com>, ntb@lists.linux.dev,
 lpieralisi@kernel.org, jdmason@kudzu.us, allenbh@gmail.com,
 bhelgaas@google.com
Cc: alok.a.tiwarilinux@gmail.com
References: <20260408055002.436349-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260408055002.436349-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/26 10:49 PM, Alok Tiwari wrote:
> ntb_epf_mw_clear_trans() initializes ret to 0 and never updates it, so it
> ignores failures from ntb_epf_send_command() and always returns 0.
> Capture the command status, return it to the caller, and log the MW index
> and error code on failure.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..0c8fc459eb7a 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -438,11 +438,11 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  	struct device *dev = ndev->dev;
> -	int ret = 0;
> +	int ret;
>  
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
>  	if (ret)
> -		dev_err(dev, "Failed to teardown memory window\n");
> +		dev_err(dev, "Failed to teardown memory window %d err %d\n", idx, ret);
>  
>  	return ret;
>  }

