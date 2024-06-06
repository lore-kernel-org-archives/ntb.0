Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF0224D1
	for <ntb@lists.linux.dev>; Thu,  6 Jun 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692141; cv=none; b=nI2Z+9lYvy7F8YpSkPYobpgGZi/y0lUjqNaDSiSRuBcsoM/bFPat08ml+B7ysfOl6ajezxNQlptANYX2nv3dmKCYfbtvU+Ys99htoRLtoWzimPJ2NoNp92z9wBJ/iL3rDpPW9S9/GzRB/cK3KpVka7tnxHfM5HohVq4GQMHflrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692141; c=relaxed/simple;
	bh=cWpzDaeOq4hbqXwXasp7bZKjFceO8AZcWZsT9YOGBX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcwFIBiMPtRbBRUJhSWBzppJzp1bt4zT6ZL/V/q1WbzJpy5WZnHZY/HI3vQ69wvmfwqddaCp2CbQAkhqSdcqUSnx8klYA1zkQ3uYpNkavlMAKBPD8GUio11ZkqZBd3LEDpi/zfmx2A/7XV3zf3V5leGo9SriY+Gt66lDO09aYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoQzvTM+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoQzvTM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692140; x=1749228140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cWpzDaeOq4hbqXwXasp7bZKjFceO8AZcWZsT9YOGBX0=;
  b=YoQzvTM+v2pfk0i0phXkf8Jde795ieG2TKPpravSV+TqtjEdEcStWRvL
   h+SlNXAuYdEdTUkTcB49VKcmEiCOkREqtVG7TlIH/QsB6lkdLHHAnjP3S
   mpxYdOIq9+rjORKhFiEk+hyQsNi9cwALsmdi8zUPUvInyVP4JTS40HIAv
   jQH/FiWgE3MGd+jtWSGmpG/BvT+V9/dw6zQnmldA75lueVWm8RTxRRkpG
   p3N2f3K2iA7KVBWtYgU6jgjq/FPOt7cbDWHjuc4WpSW2BXXui50ywSS3t
   ymveJ6JRw/rUVed054rE7dTnfN5Rqmcq8zwCROzvWU7q7eJT0wf2m1AOA
   g==;
X-CSE-ConnectionGUID: TvkbSEg/RtOSYoccdqIhuw==
X-CSE-MsgGUID: XByyJHQwQeiUtWM6QpFVbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14219752"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14219752"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:42:19 -0700
X-CSE-ConnectionGUID: 2ZvPuiBmR8CKGoCENhdyrg==
X-CSE-MsgGUID: A0TgiLWLRteTMIG6A7t1fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38708199"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:42:19 -0700
Message-ID: <b0b3b7f4-306c-4091-bf19-bf16d25c407c@intel.com>
Date: Thu, 6 Jun 2024 09:42:18 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: intel: Fix using link status DB's
To: n.shubin@yadro.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux@yadro.com
References: <20240606-ntb_intel_db_fix-v1-1-ba9033aea289@yadro.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240606-ntb_intel_db_fix-v1-1-ba9033aea289@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 1:15 AM, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> Make sure we are not using DB's which were remapped for link status.
> 
> Fixes: f6e51c354b60 ("ntb: intel: split out the gen3 code")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Thank you for the patch.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Hello Dave, sending a patch as planned.
> 
> Thank you for looking into this!
> 
> Link: https://lore.kernel.org/all/686c55cc658564e8f37147e0d6d5ab62bb8372af.camel@maquefel.me/
> ---
>  drivers/ntb/hw/intel/ntb_hw_gen3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index ffcfc3e02c35..a5aa96a31f4a 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -215,6 +215,9 @@ static int gen3_init_ntb(struct intel_ntb_dev *ndev)
>  	}
>  
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	/* Make sure we are not using DB's used for link status */
> +	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
> +		ndev->db_valid_mask &= ~ndev->db_link_mask;
>  
>  	ndev->reg->db_iowrite(ndev->db_valid_mask,
>  			      ndev->self_mmio +
> 
> ---
> base-commit: 2df0193e62cf887f373995fb8a91068562784adc
> change-id: 20240606-ntb_intel_db_fix-036299fabc48
> 
> Best regards,
