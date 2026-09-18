Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B963BB138
	for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742405; cv=none; b=UTF/IkkqgeXCGKRtm+cFPXxlUAmurz4NKV4kF4LhugdYhU8/OFlJX5KV617vzdGtuZvzef1ldTx9WFNybb8qQd+/+Jnl661dcm/+9T7sJNdg5Hp2ZeNFpieB+CqMuSS2BhW69TFEn1nL0X1GMhhw3W56WYZaIAMd7f+XVgx0oGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742405; c=relaxed/simple;
	bh=LD7Gn+l13o8KP8NkpDzNwxYuJT4oXLFaVfeQock/lgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHxDvrYkFBr3kb/S0mflkExhrCY+goVC/bnv5aMQmkczBea8VXhH520xpbG3/pEuVI5MUMUTTntilV4eBq+PxNFaUf+VHcIJCgLes3JGwpNgTVRVq/GWWKbSZFCDyVm9sQJ8Ju628ErDYoUh/wg7bUjSIewrIMnBTAUvdWXdOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EV3CHUJB; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EV3CHUJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789742403; x=1821278403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LD7Gn+l13o8KP8NkpDzNwxYuJT4oXLFaVfeQock/lgc=;
  b=EV3CHUJBDZk+TLwzhd8vXRudT4Ow2JO55rqSrEKo3GRKF7/kNdk288C3
   pQ9nx/h5fC+MoYh+o/Ew1CiQY9EywTkD17/Hq9FclsAcwc+jb02k9rFa8
   qoYaB/TkLSXuuAdUPXkT8g2WqsXPUPbbX2Hm82Ch1CVvAfwfKzBQ2xWJn
   nvCB4L2VBRAe1RlN9lM0uACBmbfyEaKQfCrsksIqK9H7LXOIlDeGmwIFe
   5EsdVc8xoLv3ZnXt5rociriq12Mz2SnszwvCitl7O7r7FueVssSYZTs5o
   3p4I8gJKNlzCysJBuZ/7CpnpyoOvW7IZYcVEFxvnG5V8IljGTQhahn+8c
   g==;
X-CSE-ConnectionGUID: pN9IK9j0QKq593TBlDWCHQ==
X-CSE-MsgGUID: eV/wazxsSP+TTKSkQ0aLYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="752225"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="752225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:40:03 -0700
X-CSE-ConnectionGUID: 90GNM71TRpW5OEvzUZPXLQ==
X-CSE-MsgGUID: j/AO54DlTL+xs1QxFZUaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="299533352"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:40:02 -0700
Message-ID: <e9bf9ac4-9b13-4ae8-ae9c-949b33d63da5@intel.com>
Date: Fri, 18 Sep 2026 07:40:01 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: Use %p for pointer formatting
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, ntb@lists.linux.dev
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
References: <20260918103914.XRVeXpwB@linutronix.de>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260918103914.XRVeXpwB@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 3:39 AM, Sebastian Andrzej Siewior wrote:
> Since commit ad67b74d2469d ("printk: hash addresses printed with
> %p") pointers are hashed by default and the behaviour can be controller
> by `hash_pointers' boot argument.
> The policy on %p is to not introduce new ones.
> Removing %pK makes it possible to remove its handling from the library.
> 
> The usage here is restricted to debugfs and testing.
> 
> Use %p instead %pK.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/test/ntb_perf.c | 4 ++--
>  drivers/ntb/test/ntb_tool.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..c4c572c754f18 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1222,7 +1222,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>  			test_bit(PERF_STS_LNKUP, &peer->sts) ? "up" : "down");
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> -			"\tOut buffer addr 0x%pK\n", peer->outbuf);
> +			"\tOut buffer addr 0x%p\n", peer->outbuf);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
> @@ -1240,7 +1240,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>  		}
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> -			"\tIn buffer addr 0x%pK\n", peer->inbuf);
> +			"\tIn buffer addr 0x%p\n", peer->inbuf);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tIn buffer size %pa\n", &peer->inbuf_size);
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 06881047f5bcd..63d830924ae91 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -666,7 +666,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 inmw->pidx);
>  
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Window Address \t0x%pK\n", inmw->mm_base);
> +			 "Window Address \t0x%p\n", inmw->mm_base);
>  
>  	off += scnprintf(buf + off, buf_size - off,
>  			 "DMA Address    \t%pad\n",
> @@ -899,7 +899,7 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
>  	}
>  
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Virtual address     \t0x%pK\n", outmw->io_base);
> +			 "Virtual address     \t0x%p\n", outmw->io_base);
>  
>  	off += scnprintf(buf + off, buf_size - off,
>  			 "Phys Address        \t%pap\n", &map_base);

