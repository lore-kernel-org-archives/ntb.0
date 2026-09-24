Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24E4A498B
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265220; cv=none; b=Stx0US83pTO8GdHFrEEGZqdpwwVzC7cd1f68jAKAy3BC2WlKLTZTtNaHiXfqaj+kqcKKOzu+9MOnZRpHtsGvD9agW+pHQ7hI7rSKcF87gaDNwzx+coPrO/nsKn/gUojl5uoL3paUyK8Ls+JV8us7n4ukSg49IfFsjvcfT/b0Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265220; c=relaxed/simple;
	bh=BWznX5ibWZDb3IGefPQuCr6j200iYUPTnaiBpQq8i1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GLcSpfbDJe8ROtrC1+ivJS7fj8AePOF9Avg/4gwJvKzsNI0PCJmNj3ptRvzTluTPvGbPha6cUv0fK8neYK+y9vBaZp72QsNmdQEk+SwAq5FEYNu6L3pUOnp4HfWZ8Zd5shHLycsc3FgaoKnruQs7qHnSQrjnzg0Y2rS9qEma2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8YMW36M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8YMW36M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265218; x=1821801218;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=BWznX5ibWZDb3IGefPQuCr6j200iYUPTnaiBpQq8i1U=;
  b=i8YMW36MffqZ2eu19P0orZvvAyXz1kAY+LDqCfRgWWdpGFfLVKl63wYA
   jPnCQ3aRC3pUDtOUh2PoJHLxXT2KlRzlHQR6s4O3fFi4ASUVOCGgItkxh
   u/LMSDn4+MKyaknxHyWTRb4D9HKIUAYUtNQpBPfAioLcKZVTJpjPEuIP6
   8KWaKh1csUUgCDzK2JiC9phV/sVY6W8SjXF/soX0yKXez7EoSXs/fcTec
   Damhuy4R8tpoM6ZTsFkR9JlFzk6W6HopVTPF2IMBpkWExpQRXv+mfcxFt
   rUaySHuFfnZQqJBXd+H3ewMhlK9tnMxxHlrM3XQNLlWuz+YatL7oVqS+m
   g==;
X-CSE-ConnectionGUID: mVjNWj8wRj2a1glABjb++Q==
X-CSE-MsgGUID: YzpZNQd1TUWnqI8XgRQPuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101214392"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101214392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:53:37 -0700
X-CSE-ConnectionGUID: bqXD1IBTS6m6oA202VJTRw==
X-CSE-MsgGUID: BKPRHSKCR5K+ilprF7//hQ==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:53:36 -0700
Message-ID: <81b16606-4000-4e21-ba32-ab00a471d44f@intel.com>
Date: Thu, 24 Sep 2026 08:53:35 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during
 link cleanup
From: Dave Jiang <dave.jiang@intel.com>
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
 <6a0db9eb-c1b4-4545-8b12-2dd8326d664b@intel.com>
Content-Language: en-US
In-Reply-To: <6a0db9eb-c1b4-4545-8b12-2dd8326d664b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/26 8:51 AM, Dave Jiang wrote:
> 
> 
> On 9/9/26 9:08 PM, Koichiro Den wrote:
>> ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
>> tasklet. The tasklet can still be processing the ring while cleanup
>> resets the QP, and transport link cleanup can free the MW before the
>> tasklet finishes.
>>
>> Clear active under rx_sched_lock and drain the tasklet before resetting
>> the QP. Temporarily disable QP link work so a concurrent client link-up
>> request cannot reactivate RX during cleanup, then re-enable it for the
>> existing link setup paths.
>>
>> This does not drain RX DMA transfers or their completion callbacks.
> 
> Is this something that we should handle?

Ah I see you are handling it in the next patch. I would add a comment to say that is being handled follow on.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> DJ
> 
>>
>> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>> ---
>> Changes in v2:
>>   - No changes.
>>
>>  drivers/ntb/ntb_transport.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 45d4365becac..36797ea3ff45 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -956,11 +956,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>>  
>>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
>>  
>> -	cancel_delayed_work_sync(&qp->link_work);
>> +	disable_delayed_work_sync(&qp->link_work);
>> +	ntb_transport_set_qp_active(qp, false);
>> +	tasklet_kill(&qp->rxc_db_work);
>> +
>>  	ntb_qp_link_down_reset(qp);
>>  
>>  	if (qp->event_handler)
>>  		qp->event_handler(qp->cb_data, qp->link_is_up);
>> +
>> +	enable_delayed_work(&qp->link_work);
>>  }
>>  
>>  static void ntb_qp_link_cleanup_work(struct work_struct *work)
> 

