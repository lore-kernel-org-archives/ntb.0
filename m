Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C927B323
	for <ntb@lists.linux.dev>; Fri, 22 Aug 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876750; cv=none; b=CxyUqIATdm4fyTKlpPsg53ubDEnjlfXeOHe95vPsxo8HvFR1TqULgIlu+FB2aca+6HppfatwRra7pFPlEPqELM39dVry3h8LqSfsG5xi7KTaVm4dTvH/mr0dB/bIfCuZ/birQ5mYSeh32fimOhZC6MoHbgWR4GZSwthlKJ4+EdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876750; c=relaxed/simple;
	bh=zfcK/Gf6lg7sXJvu3ncqrHkkygexGDCTdf3VcKQj2+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tl0qZMMZdSJykL7jxH9NXcuzzH7s9wrUkR4zskoTFe4tFBHKNHZDKB9GHZ8ildAl+htFGZ4Ubg2VUathgQVHhfXUa+jJaXTQcOOES6MpkZqDxfvimrsiSJLq9t6vdW6t+mnYnkvJAD5Ah/Vhw7EodzhB/2az7CD8NIMiBrRP1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPKeea8W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPKeea8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755876749; x=1787412749;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zfcK/Gf6lg7sXJvu3ncqrHkkygexGDCTdf3VcKQj2+g=;
  b=lPKeea8Wr48H3t7+JZ2IIEqP3Tz98B7S0cvM2/FvRCqDYGY7wkuLqkxz
   ObHD+m29gEXtPLcqOmkhyMfVdVmglWs4+SJKCxmvZVgaxdblvJkfhd9s6
   O9pBqiDhWDhVs6D9n+v+UuXKFa0Z/izDjSWG24EC2/lAX648TWlNrqTrc
   FQ/vDbwODGqJn230KOO5T2zUe/gTce33BHAKnooGQdLRBPo19q45vUaCa
   48+Bo2j0O7Q+93YgKPkmJj4z9zUgSiVdTnDl7MQiPfZXIZrtyWtBqxkGZ
   uvogtpDGIs1XkpszuWDICa9UFAIzAR8VdYZpB6kAeQXBqgnethZI2Js4d
   Q==;
X-CSE-ConnectionGUID: wsRb4TmdSoS9dniSZ/FRzQ==
X-CSE-MsgGUID: PS/Z3iFoSs6DFehx0o/zSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58047788"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58047788"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:32:29 -0700
X-CSE-ConnectionGUID: 64eD8hx0RWy9l7VDqmIO4A==
X-CSE-MsgGUID: 71pMfbsMSpONQhU1h+e2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169096081"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.119.220]) ([10.247.119.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:32:26 -0700
Message-ID: <c85a5b3e-569c-4356-935a-19fdd8248ff7@intel.com>
Date: Fri, 22 Aug 2025 08:32:21 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: Add mutex to make link_event_callback executed
 linearly.
To: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <aKiBi4ZDlbgzed/z@didi-ThinkCentre-M930t-N000>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKiBi4ZDlbgzed/z@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 7:41 AM, fuyuanli wrote:
> Since the CPU selected by schedule_work is uncertain, multiple link_event
> callbacks may be executed at same time. For example, after peer's link
> is up, it is down quickly before local link_work completed. If link_cleanup
> is added to the workqueue of another CPU, then link_work and link_cleanup
> may be executed at the same time. So add a mutex to prevent them from being
> executed concurrently.
> 
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> ---
>  drivers/ntb/ntb_transport.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4f775c3e218f..902968e24c7a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -59,6 +59,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/mutex.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>  
> @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
>  	struct work_struct link_cleanup;
>  
>  	struct dentry *debugfs_node_dir;
> +
> +	/* Make sure workq of link event be executed serially */
> +	struct mutex link_event_lock;
>  };
>  
>  enum {
> @@ -1024,7 +1028,9 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt =
>  		container_of(work, struct ntb_transport_ctx, link_cleanup);
>  
> +	mutex_lock(&nt->link_event_lock);

Can you please use guard() instead? Should produce less code and not worry about calling all the unlocks.

DJ

>  	ntb_transport_link_cleanup(nt);
> +	mutex_unlock(&nt->link_event_lock);
>  }
>  
>  static void ntb_transport_event_callback(void *data)
> @@ -1047,6 +1053,8 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	u32 val;
>  	int rc = 0, i, spad;
>  
> +	mutex_lock(&nt->link_event_lock);
> +
>  	/* send the local info, in the opposite order of the way we read it */
>  
>  	if (nt->use_msi) {
> @@ -1125,6 +1133,7 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			schedule_delayed_work(&qp->link_work, 0);
>  	}
>  
> +	mutex_unlock(&nt->link_event_lock);
>  	return;
>  
>  out1:
> @@ -1132,10 +1141,13 @@ static void ntb_transport_link_work(struct work_struct *work)
>  		ntb_free_mw(nt, i);
>  
>  	/* if there's an actual failure, we should just bail */
> -	if (rc < 0)
> +	if (rc < 0) {
> +		mutex_unlock(&nt->link_event_lock);
>  		return;
> +	}
>  
>  out:
> +	mutex_unlock(&nt->link_event_lock);
>  	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
>  		schedule_delayed_work(&nt->link_work,
>  				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));

