Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258B4A8A25
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265106; cv=none; b=BppOg3sEwpwbJg7XfJHsWiCy+pj+ej8gjIN4B2Xi34Jt6fiOe2MmR6Ofrb9VTyuhAN5lVkTqsxSvJ5+13XZGg8wVmvytYEXQDvsdtJQWQNOyUucX4mQi35fjppYy2oSiEj2MQ60JkSV54/BpVw/vUdzURbBpUdWtF1IqV+NTfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265106; c=relaxed/simple;
	bh=2Bf0mnwdyo39EE6DxuV6NPKmxRXCmQpodPDRGJilOXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcwuIVHF1vOveH7z+e0MqAAq5lQjEnGeleV+fzu0Z6xQAAy8fTwL0Qt9Fqs34Kg9QatGEa450zW4LkDvHr5GoqaFyjFrNp2UY+eSRWlbGFAIpsmyWI1p/KlIuIjt0T2m6gUEDoOfCmc2E3Tn3c5FoQxljsPUR9kcZnfW7ym3uZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rvp5YwbN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rvp5YwbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265105; x=1821801105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Bf0mnwdyo39EE6DxuV6NPKmxRXCmQpodPDRGJilOXY=;
  b=Rvp5YwbNAaoY6DeGspxw9RaDMcXWWiZ7uo9jPzNA4JONgNFG0tY8w3kx
   gZS7G/iHLaKDS1gKgOYR4paQO8COl05RNVoWZNvOnBNfOY1va1Jey8Pl9
   Hy1yoIybVzEdRZYRLRS2qkKBtkvdW9A/zny8NrYCB+1k9GqIbsmAkrUch
   JhLmtmBe4BrrrIHESqksYjDL+4gDPq6n7IJfuRFsUMmJhchzefd2xaj/d
   c1igZitA/A2q0Lq0WWfBwJT28pT2KuG0X4QDedy9veydlx6T7Mn+qeNMp
   P6Rr63+NFbvDBMVLbCbexBXptLM+rsoJnke0R9EOppCxdm9Z45PD0QQvX
   A==;
X-CSE-ConnectionGUID: p/lKwASTRMOpC4bNUX8K+w==
X-CSE-MsgGUID: ogpdXLgXTmuaOE9udS23cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="102401304"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="102401304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:51:45 -0700
X-CSE-ConnectionGUID: kXNk3BixQg2FEKMjVKajOA==
X-CSE-MsgGUID: vkNNc1nRSACqZq3MM8Y9BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277454720"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:51:44 -0700
Message-ID: <6a0db9eb-c1b4-4545-8b12-2dd8326d664b@intel.com>
Date: Thu, 24 Sep 2026 08:51:42 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during
 link cleanup
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-10-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
> tasklet. The tasklet can still be processing the ring while cleanup
> resets the QP, and transport link cleanup can free the MW before the
> tasklet finishes.
> 
> Clear active under rx_sched_lock and drain the tasklet before resetting
> the QP. Temporarily disable QP link work so a concurrent client link-up
> request cannot reactivate RX during cleanup, then re-enable it for the
> existing link setup paths.
> 
> This does not drain RX DMA transfers or their completion callbacks.

Is this something that we should handle?

DJ

> 
> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 45d4365becac..36797ea3ff45 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -956,11 +956,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  
>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
>  
> -	cancel_delayed_work_sync(&qp->link_work);
> +	disable_delayed_work_sync(&qp->link_work);
> +	ntb_transport_set_qp_active(qp, false);
> +	tasklet_kill(&qp->rxc_db_work);
> +
>  	ntb_qp_link_down_reset(qp);
>  
>  	if (qp->event_handler)
>  		qp->event_handler(qp->cb_data, qp->link_is_up);
> +
> +	enable_delayed_work(&qp->link_work);
>  }
>  
>  static void ntb_qp_link_cleanup_work(struct work_struct *work)

