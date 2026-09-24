Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484B385D79
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265661; cv=none; b=d6HqRKr38ACO67MYqvEr3C7zh94xOESR+QY332u6Ed41sO8nS6hqYCDnls+0SlRuuXOBdtHpmcikEYi27Aa1nL1w6506RTD6YScmzYQk9TTdQ5a0m6YmcVc0TzDn+3GqjjwjxsqD+TeE7Zs2DoylaZIItS4QAyjB+9MzYY7IY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265661; c=relaxed/simple;
	bh=9u/ll/zHy5qD5t7Tw1PhsKMfqspn3/oOobU2WmocDjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMeItAete/JGvVhL40DD2FV3prZc6SBQhIzR0AupefJdoCuSGC/+ha2rWCXb5xF0ajfHWeL2nyEFLFjXyrnxkMALoU+dYrCpMi6YPXpKrwnhk13xy94XKpMI5E7dR/RZhM3M5pRyrXwcryRAJAqpq14VofS9m6p1JHTbA9adCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZzyiOhV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZzyiOhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265660; x=1821801660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9u/ll/zHy5qD5t7Tw1PhsKMfqspn3/oOobU2WmocDjc=;
  b=NZzyiOhVxJFhpGdEEAzd84gPb0FYUH3ikx2KLoOLCN37tK16G9dl/Fql
   qHmHJlal2bJ4aTHgfr0BoOEPCZe7SVV4qQtZ+MVCPqDV3EbQvgDus3MAT
   A0g4/gtMuhqtqFGWMpYDa7dIBgETtVtuGKtGbxttSAOLAFw/NxoVBhpEx
   RuhUxBromHSNSgTTlWdFrGT/e9mqCVzz+E0nL6Jm4QRr2ZbGoDZHZaPkE
   b/X9x00RRMEZ560byDLAPkzQTqkwnpY/Q1eM9jwrv2sQ7RROn0nl01JDD
   tvi1sPbawIryqpeNTaaZSu+S69TvzxhsV9UkixwqPJo6mo+UEOpOeK1ER
   w==;
X-CSE-ConnectionGUID: 8+DJcea7SquBmjJ6x6n+1A==
X-CSE-MsgGUID: eOjY3FOMTP6nbl3O7QKAOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93540031"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93540031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:00:59 -0700
X-CSE-ConnectionGUID: Lz5QqlYjTh6M08o4Iqjmug==
X-CSE-MsgGUID: mA/zBoFMRCmnMfgVJtdRBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274251620"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:00:57 -0700
Message-ID: <471868ae-a77a-44ea-84ab-faed73a13b12@intel.com>
Date: Thu, 24 Sep 2026 09:00:56 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-14-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-14-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
> but the link worker ignores that error. The worker can consequently
> publish a QP whose memory-window state is only partly initialized.
> 
> Abort on the first QP setup error and release the MWs through the
> existing error path instead of publishing the transport link.
> 
> Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - No changes.
> 
> Originally submitted as part of the direct TX/RX series v1:
> https://lore.kernel.org/r/20260810165136.2292436-2-den@valinux.co.jp/
> 
>  drivers/ntb/ntb_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 096be87e5ede..c1e3a077c45e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1152,7 +1152,9 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	}
>  
>  	for (i = 0; i < nt->qp_count; i++) {
> -		ntb_transport_setup_qp_mw(nt, i);
> +		rc = ntb_transport_setup_qp_mw(nt, i);
> +		if (rc)
> +			goto out1;
>  		ntb_transport_setup_qp_peer_msi(nt, i);
>  	}
>  

