Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BC3B9609
	for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676403; cv=none; b=hZXOcm/dxbmKJXPoA8tT5SCZN9bFOTpZVYUjCYGByJyO9Vucafy2pUOBUNw5sDvSzTd7vlTujKDAuomI3ix5BXj0TnsDn733OcS72PpKz6UUKyNykg7xNMDW0vB9FuXvoPyyWLsrz0vL1vyJPJjs549bgWKtEI21gdWzJ4mi6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676403; c=relaxed/simple;
	bh=RFCeHO245U+8njJknw5qYZfSbXGH8eJzzpTIJVHBseI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZc3UBEJ2J7wcrOjLvLKWITh4e9D/jSm2PZK46NVmf/WeRNV2RYOP7QRmaVoas20nh0NCMwtpfWbcxfRHfJ2gLU1BfuoWX3E0kHeXV+ZsnU429CIcsLwmRfpFLZGGFoLsXxbZfasLaUjUjJ4RuUGKgtwNRoObXFOd2rMX3M6cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fnifmsk+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fnifmsk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773676397; x=1805212397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RFCeHO245U+8njJknw5qYZfSbXGH8eJzzpTIJVHBseI=;
  b=Fnifmsk+BJ+MWfklElB2zTd26Pr/Mfoz0pshakGEqk8CNeuxz0ISuTVh
   M2UEu3QvhlPQGhkfMef918IV99xNXoZgvZPJjVOSWDzxSAIH257Vvb4NN
   O0f1VnSe5DoAet0KPRQOzDEtjxDJEqlFZqV36yRTwahluOYQVh0jCTrRh
   oTORXXA7L+281jxF9E6Mtw+Edh9/0eeZ/v3072wFX+6fMwNxyUcqFYGFP
   Gcb/RX770ZTr8ram8lu8P21kLHBkB2AzCqICKvI1aHU43C9Ts25GRPQqC
   KDnpEMtq3MZs5m5/BjeyBn4qkoOFjkELKCV+cK05kDXseL59jTss88yRX
   A==;
X-CSE-ConnectionGUID: oFv9AhVlSPS9yyieSJad5A==
X-CSE-MsgGUID: 794Vd2+aTJOEtxpA4wIcIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74585871"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74585871"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:52:58 -0700
X-CSE-ConnectionGUID: 8B/+cPsTRY2JMvKtViM4rg==
X-CSE-MsgGUID: q5xLZ4WXTfyvzJA0ht/Tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217769834"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:52:56 -0700
Message-ID: <8d1304ad-c123-43f3-b007-1b89d5490c5b@intel.com>
Date: Mon, 16 Mar 2026 08:52:55 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>, jdmason@kudzu.us
Cc: allenbh@gmail.com, davem@davemloft.net, kuba@kernel.org,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260315203345.13657-1-rayfraytech@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260315203345.13657-1-rayfraytech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 1:33 PM, Oskar Ray-Frayssinet wrote:
> Add missing SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license of this file.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..3890074b26c9 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  /*
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
>   *   redistributing this file, you may do so under either license.

