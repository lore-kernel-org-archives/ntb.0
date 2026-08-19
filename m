Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF63EC699
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183275; cv=none; b=sili6m/N30G6PlDUkrDJW59koLpRtg70HLZZsUSNlB3wOA2zB7Qbxg/U8XkB404+NafuNAp33Bz5VzNvIu+h+7gv0orJew6KC3IfpNxjB9+aAmWyHZAGjlDcvpxRVxP2/rTIsZtlWmiz2swSmls9jqZc/O3fio6AsBKjGsJFYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183275; c=relaxed/simple;
	bh=4tMDkGPYNi52mkKDE1yfVghndM3yCKfKaln+ytFgDnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R08fUP6WP3S3qU+CRTIzDhtSn1ARBD13RjyNRES1xY6KWczkn9m5hj+v4ze+QS3bBWwsLEyOS1J55rtcWWDhEUXvpzlzxnhVneYTQwdSE56ICWFa0KxehLvqqJdJt2pjaKeUGi8coIqlWPkKALeKge9em25YaPEmjk/Q8Pi1jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaomZ+Aj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaomZ+Aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787183273; x=1818719273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tMDkGPYNi52mkKDE1yfVghndM3yCKfKaln+ytFgDnk=;
  b=FaomZ+AjfPWm1tuaZMDu/XEAxwQgcGq1ggO2YqJpICc31zsOzNxBcTze
   SoOtEFtQWsxmND5TfJbJJ4HhByH3bdzkhg9oTNLRz92SGAKrVsnsWB/cR
   8cw+8e/yjcgDojqJyBKUcYFrAMn64JrtJpM1RYZnYKK0HcUZjJLrVfeO/
   PO2A2yO9k5Rxwys+CDrJ5XpfL1N6WXYOkAYsU28vR6hY5Xk4A930Yv8gn
   D6e6N2MQ6xzyBG8WbtYHog0sUpMFx/WPRdecwAwK/QSlGtw9a5I2NfCDh
   nYkxnrlQXcSxQq7XOBVgeXm2s/HnOaxTCMAm64iB/wCo0j97G32vlJDKM
   g==;
X-CSE-ConnectionGUID: 3bPev4qYSjGzgE5D8v7hjQ==
X-CSE-MsgGUID: SdWlYORxSeuSB8MQBOFRTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105094484"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="105094484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:47:52 -0700
X-CSE-ConnectionGUID: zildpLGlR0C6V35H3pIq/g==
X-CSE-MsgGUID: hmYD/LK/Qzm1k0uN88GUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="262449133"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:47:50 -0700
Message-ID: <274faae6-fe48-4310-8deb-4b57c5c01f7c@intel.com>
Date: Wed, 19 Aug 2026 16:47:48 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] NTB: ntb_transport: Reject oversized TX buffers
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-5-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817053519.4135287-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 10:35 PM, Koichiro Den wrote:
> ntb_process_tx() handles an oversized buffer by calling tx_handler()
> with a NULL data pointer and returning success. ntb_netdev therefore
> neither frees the skb in its completion callback nor takes its enqueue
> error path, leaking it.
> 
> Reject oversized buffers in ntb_transport_tx_enqueue() before acquiring
> a queue entry and return -EMSGSIZE. The caller retains ownership of the
> buffer, and the preceding netdev patch frees the skb when enqueue
> returns this permanent error.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Previously posted at:
> https://lore.kernel.org/r/20260810165136.2292436-3-den@valinux.co.jp/
> 
> I moved the fix here because it addresses a pre-existing issue
> independently of that feature series. I also moved the size check before
> the tx_free_q lookup so -EBUSY cannot mask -EMSGSIZE.
> ---
>  drivers/ntb/ntb_transport.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4bdd81edcb87..f9caa1a653c5 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1955,15 +1955,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
>  		return -EAGAIN;
>  	}
>  
> -	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
> -		if (qp->tx_handler)
> -			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
> -
> -		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> -			     &qp->tx_free_q);
> -		return 0;
> -	}
> -
>  	ntb_async_tx(qp, entry);
>  
>  	qp->tx_pkts++;
> @@ -2356,6 +2347,9 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  	if (!qp->link_is_up)
>  		return -ENOLINK;
>  
> +	if (len > qp->tx_max_frame - sizeof(struct ntb_payload_header))
> +		return -EMSGSIZE;
> +
>  	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
>  	if (!entry) {
>  		qp->tx_err_no_buf++;

