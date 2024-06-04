Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5933F6
	for <ntb@lists.linux.dev>; Tue,  4 Jun 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518976; cv=none; b=aQNt+Q6dD12MLuq20rSa4eyUixnx5p6IWgUSfCz47WEp/S6HXkhFv6hq/WFSXeAOdAB/LxPOU2kP/DlcHqHK4Q7bm/MhCKOUjChl/UEXqAKULhjLOZD8khde0AwIBcHdIGvBPZ0AUquJtq7PxkwAp+4hdgGLveEuIjwccXv8vB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518976; c=relaxed/simple;
	bh=FMPpNGMi/lMxA4uS86Bn5VWLA65Vzu+GKKtxRsaupeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IK6jqd42eusUboUXCqWwsayJlBnEUPKfWnPQNupAD7WH6ukrqFEPJAN7gEU3pT4VAAwYg34jfNlQNpFGgyz/EKPDkcBJs7qadvij+cP6iDAJqe5JTjrJSbRvNEIie1b/Jbx3iymZ7jesEGIvbFMAMwUj8rRQKZ1WOMRnp0xDemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h289sLcA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h289sLcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717518975; x=1749054975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FMPpNGMi/lMxA4uS86Bn5VWLA65Vzu+GKKtxRsaupeA=;
  b=h289sLcAgyoMKcgIIwNC8Ww2umQeEoDivLhS6znxr9XvQxhzl7Tud022
   rlgi4Tf1kV8+HiA+InxyJvy89xKnURNxtWDziRF7q/dzeIyeTqJ3QbdSd
   UzaCPDubzO9iL4lMiXWvVVEIsLfbtwVDNyjnXq2tstgYDOSoGAxCY9dme
   at2m8h2lCnAixM9/pBCQbma0+kdpC3DgEuCwMnMA8LJ1nJy0ielQc3Im4
   JEpPYkdNBZourAVLmNT19m03eNRjuUY/PShjVcYtF5LfdbmpL8NPehtrY
   3HrYQIExE1WKLZ1r7Juy4J7aIn841E4xpPGEnYRjXjSW1eW9HEd7lGt6z
   A==;
X-CSE-ConnectionGUID: pXA0X6WnQtCVQ3zVAp6hQQ==
X-CSE-MsgGUID: YFTPknwQSnqTIVjQ/SIHeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17922068"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17922068"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:36:14 -0700
X-CSE-ConnectionGUID: VfpRM9E+T0OXp/Hj/k/pDQ==
X-CSE-MsgGUID: gNPtBpG7TdKmcY3Vd7r+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37172634"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.247]) ([10.125.108.247])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:36:14 -0700
Message-ID: <9e3aa299-2a2a-43b1-97b4-7e4c58c7e5e5@intel.com>
Date: Tue, 4 Jun 2024 09:36:12 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on ntb: Adding Skylake Xeon NTB support
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, linux@yadro.com
References: <686c55cc658564e8f37147e0d6d5ab62bb8372af.camel@maquefel.me>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <686c55cc658564e8f37147e0d6d5ab62bb8372af.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 5:16 AM, Nikita Shubin wrote:
> Hello Dave!
> 
> I have a question about NTB_HWERR_MSIX_VECTOR32_BAD, i hope you can
> clarify a bit:
> 
> We are moving "link status down by one" indeed:
> 
> ```
> intel_ntb_intvec_write addr=0xef idx=31 value=0x1f size=1
> intel_ntb_intvec_write addr=0xf0 idx=32 value=0x20 size=1
> ...
> intel_ntb_intvec_write addr=0xf0 idx=32 value=0x1f size=1
> ```
> 
> So basically Link now shares interrupt with DB 31, however doesn't this
> make 31 DB unusable, as we are clearing it with 0x180000000 in
> gen3_poll_link() ?
> 
> May be we should avoid using it by providing correct db_valid_mask ?
> 
> Some thing like:
> 
> ```
> if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
>     ndev->db_valid_mask &= ~ndev->db_link_mask;
> ```
> 
> in gen3_init_ntb() ?

Yes. That sounds reasonable. Patch welcome :) 
