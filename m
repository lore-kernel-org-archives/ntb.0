Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8022BAA9
	for <ntb@lists.linux.dev>; Thu, 16 Jan 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042281; cv=none; b=S7Xx4GxW9j40rlJCFjc5di4CtdAdimTSw/I7/lMcTK8xh1bBs1FH2+GFFdPB6SRaHb6c9onqv7dNE0E9kpNZjIBZmOwy5yj/csRPL9Y+PD6IOrynAgdLzXYEbyTsYM58rcWkUcgqGDGtS6ce6WIqCCGVFKXXf10Sn2Tf+boNYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042281; c=relaxed/simple;
	bh=9rzhZQZ8LC//4VRBaWlrG+BtsnENotusOXh7L0ZGNMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw0ltGnYW+31FtT2V4FKKgtiMQA3snmh/JvmGVUCxkFhc5tfoFRkLRMS9pM/4N78/rbswv0PrnwrB2vijqmCLc+wIwHsJ7WyEGDKA1Z4FkftJMORmt0ZfgvbFShlFavwUAUX0F0wAKT1nIBj2gNorCjMGdJ5G6aLETiiQeW8hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBi6FGOZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBi6FGOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042278; x=1768578278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rzhZQZ8LC//4VRBaWlrG+BtsnENotusOXh7L0ZGNMg=;
  b=CBi6FGOZXsAQq2KfKAEB7hDgMrl2vtf1fksl4z5dyDQddZaBHKXXn9qx
   NwgANx8bjzloQIt4ahCNkx/Y3F12ODVN4T4iknKUPk8YDzGBHzRl3+1PR
   CKAhzb1VwNs/MqMRWMoBZhmCYl8BybBwQdjTJVFDV8Vw4L7btwmg3BNig
   2/wLwGbM/2ydoRv6YxEpIXhnroYk4s29zZwjS5/adcOEE1V8VYD/x6MR7
   8sfdET96O3T5Y4rHF7kCOIu0IPgwo64g5HQ0idCFFjyNeGcPuP1TV30AM
   cKC3LyF6nPJk3Y9URXaZ5nnRDdOWe34bG9PaSPTL4FBYQjcIrxDYKWTXB
   w==;
X-CSE-ConnectionGUID: avaaVGlvRtqqb2ExEctasQ==
X-CSE-MsgGUID: /zyfKBNlTMW707XBJXDMxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54981292"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54981292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:44:38 -0800
X-CSE-ConnectionGUID: xwgRM87GTSa6mfFMnA4lbw==
X-CSE-MsgGUID: 1KyErYCmScSpFqo0VXSf2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110648730"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.109.66]) ([10.125.109.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:44:36 -0800
Message-ID: <a8b2695d-7bdc-4da0-883d-5a73a7c553ff@intel.com>
Date: Thu, 16 Jan 2025 08:44:36 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: use 64-bit arithmetic for the MSI doorbell mask
To: Fedor Pchelkin <pchelkin@ispras.ru>, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Logan Gunthorpe <logang@deltatee.com>,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250115182817.24445-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250115182817.24445-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 11:28 AM, Fedor Pchelkin wrote:
> msi_db_mask is of type 'u64', still the standard 'int' arithmetic is
> performed to compute its value.
> 
> While most of the ntb_hw drivers actually don't utilize the higher 32
> bits of the doorbell mask now, this may be the case for Switchtec - see
> switchtec_ntb_init_db().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
> 
> Fixes: 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

LGTM. Should be using the BIT() macro to begin with. 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index a22ea4a4b202..4f775c3e218f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1353,7 +1353,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	qp_count = ilog2(qp_bitmap);
>  	if (nt->use_msi) {
>  		qp_count -= 1;
> -		nt->msi_db_mask = 1 << qp_count;
> +		nt->msi_db_mask = BIT_ULL(qp_count);
>  		ntb_db_clear_mask(ndev, nt->msi_db_mask);
>  	}
>  

