Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E3495053;
	Fri, 11 Sep 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141785; cv=none; b=UFvBd7xFerv7ACIYHT8iKveEJSXrl6ML/vupOt8U866yUwro8fGjzKmhCp5bItvwLhQfjIhsYPJ18Lxy0cM6ubzzDzIe4r0iXN8jpeSCsR6kmqyT+e33jItMHsLB3VVMV/Kws/qXguK6hpZNTzNIxPEznejk+E1Oma6V2k6Dh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141785; c=relaxed/simple;
	bh=MHKkUlW2OaWTaH5xgFMNTTb00L7hJk1isvmXc5kFhCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiHb0sGL3cbGcuIkVtknNQCNYscRDgZiYi6a3o1wMKri+q8igsPIQ2dUX0DaZToIYb2wre4MGglLBHnaVgJyv8hwRv1nt4gg6H4yTWuQTA4xOtdGNqGPdXK9cl6qKl3e1wf0Ya9Uem0ElaQ3K1pf5gypRbLgbIgYstWQzYUvTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lokvYm4r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lokvYm4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789141783; x=1820677783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MHKkUlW2OaWTaH5xgFMNTTb00L7hJk1isvmXc5kFhCg=;
  b=lokvYm4ramMRqN8esSZbbYAbV4L2FDO8MDonXIKH4IvOuL+MmnAhdKPC
   1gn7zJXqHobJKX+VBO9r5zs9ExCEW3ye4ric5OmIOSS9spJwNIkWkVgJi
   n5lzhwF5JGnVlWVNevUItaPVRXpFHfMpizqoS5jUVV1yeTmOEt/Q6ya3f
   49DTFXiAvITeggowfDJMfa/kd5T0IIhkUCOy6Mbr6jNzuDKOoxbUcy5pn
   n4QjYnsKhLlqnhMdhwkMxm3fOnPSJwHNsL4RHsSAW2l+keTJXKMzVPPbe
   iNesZpj2tpEhbtNOXf9YMYifcehU2Xqfvifcmb3XlHKoTP1riUKEvRFqg
   g==;
X-CSE-ConnectionGUID: wG0Fmv6zTT23/XZ9vlNuug==
X-CSE-MsgGUID: +HNlzn+lQSeXWHcjhXCt3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="93475359"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="93475359"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:49:42 -0700
X-CSE-ConnectionGUID: mdOGYDETRjePvPQhYei0bQ==
X-CSE-MsgGUID: 16B0teyqQ5OfyJi51sB4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="330852"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.42]) ([10.125.108.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:49:42 -0700
Message-ID: <b90a302d-8ad4-480f-9794-2b62e273a6be@intel.com>
Date: Fri, 11 Sep 2026 08:49:40 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
To: Koichiro Den <den@valinux.co.jp>, sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
 <20260910043613.CE8FD1F000FF@smtp.kernel.org>
 <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/10/26 1:48 AM, Koichiro Den wrote:
> On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>
>> New issues:
>> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.
> 
> I believe this is a false positive. See my inline comment below.
> 
>>
>> Pre-existing issues:
>> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
>> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
>> --
>>
>> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
>> Author: Koichiro Den <den@valinux.co.jp>
>> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
>>
>> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
>> is still bound. This patch reorders the teardown process to unregister
>> clients before freeing resources, intending to fix unsafe memory accesses
>> during intensive TX loads.
>>
>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>> index c1e3a077c45ec..f24555b38d1b5 100644
>>> --- a/drivers/ntb/ntb_transport.c
>>> +++ b/drivers/ntb/ntb_transport.c
>>> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>>>  
>>>  	debugfs_remove_recursive(nt->debugfs_node_dir);
>>>  
>>> -	ntb_transport_link_cleanup(nt);
>>> -	cancel_work_sync(&nt->link_cleanup);
>>> -	cancel_delayed_work_sync(&nt->link_work);
>>> +	/* Stop transport work before clients release their QPs. */
>>> +	disable_delayed_work_sync(&nt->link_work);
>>> +	disable_work_sync(&nt->link_cleanup);
>>> +
>>> +	ntb_bus_remove(nt);
>>
>> [Severity: Critical]
>> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
>> introduce a DMA use-after-free regression?
>>
>> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
>> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
>> without polling:
>>
>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>     ...
>> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
>> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
>> 		kfree(entry);
>> 	}
>>     ...
>> }
> 
> Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
> those entries. For IOAT, this goes through ioat_free_chan_resources(), which
> calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
> channel.

The refute looks reasonable to me for ioat. Any concerns for other host DMA engines? 

DJ

> 
> I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
> them. I guess the mention on IOAT in an earlier patch in this series prompted
> Sashiko to focus on it here.
> 
> Best regards,
> Koichiro
> 
>>
>> Because IOAT DMA engines could still be actively copying into those buffers,
>> freeing them allows the hardware DMA engine to write to freed kernel memory.
>> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
>> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
>> call to ntb_transport_link_cleanup().
>>
>> [ ... ]
>>
>>> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
>>>  
>>>  	if (hdr->len > entry->len) {
>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>  			"receive buffer overflow! Wanted %d got %d\n",
>>>  			hdr->len, entry->len);
>>>  		qp->rx_err_oflow++;
>>>  
>>>  		entry->len = -EIO;
>>>  		entry->flags |= DESC_DONE_FLAG;
>>>  
>>>  		ntb_complete_rxc(qp);
>>>  	} else {
>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>  			"RX OK index %u ver %u size %d into buf size %d\n",
>>>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
>>>  
>>>  		qp->rx_bytes += hdr->len;
>>>  		qp->rx_pkts++;
>>>  
>>>  		entry->len = hdr->len;
>>
>> [Severity: Critical]
>> This is a pre-existing issue, but is there a time-of-check to time-of-use
>> race condition in this bounds check on hdr->len?
>>
>> Since hdr points to a payload header located inside a memory window writable
>> by the remote NTB peer (shared memory), hdr->len is read directly from
>> shared memory twice (once for the bounds check, once for the assignment).
>>
>> Can a remote peer swap hdr->len to a much larger value immediately after
>> the bounds check but before the assignment, bypassing the bounds check and
>> causing a buffer overflow when copied?
>>
>> [ ... ]
>>
>>> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
>>>  ntb_transport_create_queue(void *data, struct device *client_dev,
>>>  			   const struct ntb_queue_handlers *handlers)
>>>  {
>> [ ... ]
>>>  	free_queue--;
>>>  
>>>  	qp = &nt->qp_vec[free_queue];
>>>  	qp_bit = BIT_ULL(qp->qp_num);
>>>  
>>>  	nt->qp_bitmap_free &= ~qp_bit;
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but could this read-modify-write
>> of nt->qp_bitmap_free lead to queue state corruption?
>>
>> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
>> operations without holding any lock. It is also modified concurrently during
>> driver unbind:
>>
>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>     ...
>> 	qp->transport->qp_bitmap_free |= qp_bit;
>>     ...
>> }
>>
>> Since these are exported functions called by NTB client drivers, could
>> concurrent probe and remove operations race and lose bit updates, leading
>> to a leaked queue or two clients being assigned the same queue?
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
> 

