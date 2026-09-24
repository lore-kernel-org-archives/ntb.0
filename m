Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D63F9278
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264719; cv=none; b=dnRrQsI65nP3iuavxCKC+Id0ToFxt4KioX8uPswPRQ5mCbw4RXSMceJHNjLZ3IxT7OfyMZ0LGqYKGELCqIC+FMmTi48aUhZSAXgndvDIxJCKmH8yVr0khh/hb4xtIPgbute9AE0yScnKe7c1aKfRlicWOSLZIv2ob58oNmbRGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264719; c=relaxed/simple;
	bh=tYYN3HkgBmhv4NEVJUvy7LkElRNn2gPQFsErOxv2ycU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWlTfMhruj5/R+/NMgFlAqU23fFN+kCAEvuQWaKCZEHBfewazFiHzEVwo00/ca+VH5KqwuKHvODk+tt4uKjvxMOCC7H4EqVwBFA8bSMvwqTYrsS07RhtnjpFqrLi1X99ZlTWpMQ0xujcosRor5SN59oJ3eJMlQOx8os3knfm0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKrfpCL5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKrfpCL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790264717; x=1821800717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tYYN3HkgBmhv4NEVJUvy7LkElRNn2gPQFsErOxv2ycU=;
  b=nKrfpCL5HyRXOcwg0fReDRqvkOGqwxpCval4SV+C573xycTMZcqM9/Kj
   1rHZ8BOx4nBO2wikaHBOW0TQD32CIOKYwoXg7Nz95m9GJ4ruqitRvGD+p
   AYTZOql2Dx0FCXxAfY5rBKWYXV9lhiT7Y0qh9WRShhZ7GMX8maB3PPe4s
   +cKuQALBSvBVbLcDSeg3WBcwUpNWvVT0lI+fS86S2ykr4uQY1R/+U0D6i
   xFWYCd2YDtsgPPRLMZmC29Czcohp03rBscaeSmJNG0T4jxEwgQcIa2qt5
   iN2wRY0eRObxftEkI9Dy/dcRZGLOasX6LfAC5ocKUR+azNxByqYgzOB/n
   Q==;
X-CSE-ConnectionGUID: JU+xvgUzSMi7UfWCtdOdmg==
X-CSE-MsgGUID: vgc2+aaQTgKOl6ap/dXspA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108534482"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="108534482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:45:15 -0700
X-CSE-ConnectionGUID: qy4upAdtTQ6IjPYq5n3fnQ==
X-CSE-MsgGUID: LCsNzMjzSCu2t/gq7xLNBw==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:45:14 -0700
Message-ID: <7dda9068-c6c1-422b-a102-d7f87cc5570c@intel.com>
Date: Thu, 24 Sep 2026 08:45:12 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] NTB: ntb_transport: Clear link state before QP
 cleanup
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-7-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> Cleanup leaves the transport link marked up after releasing its MWs.
> A subsequent client link-up request can therefore start QP link work
> before the transport has been set up again.
> 
> Clear link_is_up before cancelling QP work and releasing the MWs.
> Have QP link work return if the transport went down after it was
> queued.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - No changes.
> 
> Note: this is a reworked version of my earlier, withdrawn patch:
> https://lore.kernel.org/r/20260717061223.2203863-1-den@valinux.co.jp/
> 
>  drivers/ntb/ntb_transport.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 1332d53bcfe7..8dd1770aaaf1 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -977,6 +977,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  
>  	guard(mutex)(&nt->link_event_lock);
>  
> +	WRITE_ONCE(nt->link_is_up, false);
> +
>  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
>  
>  	/* Pass along the info to any clients */
> @@ -1142,7 +1144,9 @@ static void ntb_qp_link_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt = qp->transport;
>  	int val;
>  
> -	WARN_ON(!nt->link_is_up);
> +	/* Pair with the link publication in ntb_transport_link_work(). */
> +	if (!smp_load_acquire(&nt->link_is_up))
> +		return;
>  
>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
>  

