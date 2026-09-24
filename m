Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108824A1E1F
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264449; cv=none; b=rJYFayqfeANPX1xFNzbiDSOlHU8/J/oNITCS7xxiv2779MPve4hh9rUk3ujtrAu1pEGX22kqGsv0JW6rArSuZ8apVI1N+X/M7+5KirLD1uxXAq+eVU98aWUZus0evc1PX3M+8fPr+I9u7gtI9JlHk4vxZDtXWgKvYHlD+tlVAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264449; c=relaxed/simple;
	bh=ebRN482VVZQBFZDNJ/BItFu5AC3xieWcbgywBhgRNu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sf2PG3sXYdQUTn0j+rpanFB0fnp1tj0a0taNCtSjElMg4XrC7xG7RV4NL0WnK1YsLIMqj/5UKS0eK0bwKhXZ2WbTetWGaS1LzMmwBI1VjJLp4B3/+Oj1isPw9BA9zWAsjDNCXyGqRfhcMl2UL+ocnM/umKt2qjkpibLf3S7SfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kn/KW8RO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn/KW8RO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790264447; x=1821800447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ebRN482VVZQBFZDNJ/BItFu5AC3xieWcbgywBhgRNu4=;
  b=kn/KW8ROnlqAvXS4z1h3Cr6EpfaJwYOh8OSOXo/2h5EK/EfyeixSO+rQ
   YAXATLjefTBy2CpU81F7w+eH8IMT7vooOPhpczEtHM4ak2LWntJLL77Ca
   gQzaVmRkq7nITyzRt3reNZtv2HiiPTXXF8OS483VRS/FkHm6DFNhrAW7p
   O/JiUD6Kfd1ry/KWdLazk7bLq2ipmloWkPjgZHoSGNj07lRhueG6X3NG/
   o8CZFdeXOoG/qE8GTV5XwEmkoPGrYxiVDOx/NkiaoQeHFHgvhm+EQnGXb
   gcRuP8CxRCLE6298uw6dtBH1EaKwqwyt1hvKzzt3sGh6byyvp+1B9qDel
   w==;
X-CSE-ConnectionGUID: c9A1NTq2SgOsFX9PJI23Dg==
X-CSE-MsgGUID: 3hrYInQhR/qGc2n8YIHrJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89902430"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89902430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:40:46 -0700
X-CSE-ConnectionGUID: FrCd/KBDSEitB6yIqXSZ8Q==
X-CSE-MsgGUID: a9jAGTrlSrCkUCokoUS5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272193812"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:40:46 -0700
Message-ID: <171b1c57-1588-4f39-8f49-f2445fe74a82@intel.com>
Date: Thu, 24 Sep 2026 08:40:45 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] NTB: ntb_transport: Publish link state after QP
 setup
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-5-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_transport_link_work() marks the transport link up before setting
> up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
> can then queue QP link work, which may enable RX and notify the client
> before setup finishes.
> 
> Publish link_is_up with a release store after setting up all QPs,
> and use acquire loads before queuing QP link work.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index c77b173dca01..75d4a2e021f4 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -922,6 +922,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
>  }
>  
> +static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
> +					   unsigned long delay)
> +{
> +	struct ntb_transport_ctx *nt = qp->transport;
> +
> +	/* Pair with the link publication in ntb_transport_link_work(). */
> +	if (smp_load_acquire(&nt->link_is_up))
> +		schedule_delayed_work(&qp->link_work, delay);
> +}
> +
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  {
>  	struct ntb_transport_ctx *nt = qp->transport;
> @@ -941,13 +951,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_qp *qp = container_of(work,
>  						   struct ntb_transport_qp,
>  						   link_cleanup);
> -	struct ntb_transport_ctx *nt = qp->transport;
>  
>  	ntb_qp_link_cleanup(qp);
> -
> -	if (nt->link_is_up)
> -		schedule_delayed_work(&qp->link_work,
> -				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	ntb_transport_schedule_qp_link(qp,
> +				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
>  }
>  
>  static void ntb_qp_link_down(struct ntb_transport_qp *qp)
> @@ -1089,16 +1096,19 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			goto out1;
>  	}
>  
> -	nt->link_is_up = true;
> -
>  	for (i = 0; i < nt->qp_count; i++) {
> -		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> -
>  		ntb_transport_setup_qp_mw(nt, i);
>  		ntb_transport_setup_qp_peer_msi(nt, i);
> +	}
> +
> +	/* Publish the link only after every QP has been set up. */
> +	smp_store_release(&nt->link_is_up, true);
> +
> +	for (i = 0; i < nt->qp_count; i++) {
> +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>  
>  		if (qp->client_ready)
> -			schedule_delayed_work(&qp->link_work, 0);
> +			ntb_transport_schedule_qp_link(qp, 0);
>  	}
>  
>  	return;
> @@ -1146,9 +1156,10 @@ static void ntb_qp_link_work(struct work_struct *work)
>  
>  		if (qp->active)
>  			tasklet_schedule(&qp->rxc_db_work);
> -	} else if (nt->link_is_up)
> -		schedule_delayed_work(&qp->link_work,
> -				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	} else {
> +		ntb_transport_schedule_qp_link(qp,
> +					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	}
>  }
>  
>  static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> @@ -2392,8 +2403,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>  
>  	qp->client_ready = true;
>  
> -	if (qp->transport->link_is_up)
> -		schedule_delayed_work(&qp->link_work, 0);
> +	ntb_transport_schedule_qp_link(qp, 0);
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_link_up);
>  

