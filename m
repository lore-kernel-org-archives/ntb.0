Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2430E0CC;
	Mon, 14 Sep 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419729; cv=none; b=eDZZjnZsw/iKPhRHFcHY2MKm4J/4nLreXVz3jm6j3AqRiVb3OTxHbpKsxAkCsMknqoyoF7k9qeGFVhS9BbbFhPJy1um5z7OFuyIQduFHY4WNCkiJLgwrsUFBf0kQl+RxrWVfnPdOSFFzxh/KqSKto3OJowaCMKUWb8vwNOVMu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419729; c=relaxed/simple;
	bh=egdzo9uNW3hNfsYyj8fl2Xj/jnkdVilx41VTt2cHLb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFwEmcbw00kGs3TOR0N9W7LXdVRtxLEmBZ9I9U0emGS4grxzrfJ+LupO/Il0WJ23Aa6oZ+5UGAxx/UFMWTFV38Rc+wlAtwMW78Ha0enrT773EoIGWnQggCOplgKbm1oFTQyAEnEAYdkQYXsSJtrSydvpVXRx/Leg8gVpfcyAVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcEFGz5z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcEFGz5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789419727; x=1820955727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=egdzo9uNW3hNfsYyj8fl2Xj/jnkdVilx41VTt2cHLb0=;
  b=PcEFGz5zH4h07jDttAleXCCvpGHh/huiZnHh6R8odIqwGz6kzFhnhZyE
   wFGJ+SFmEJsLZ3rcCcUOUiycwiC6sI2m+2fkzFCbEI3YmzReR1NUOR/se
   255OodVTZ65Zv4pbT877nUjn7t+vivwsGBn8eVCqFKnzbE48kt0iPHY03
   kxAVdqUm3Rvs2qdzQJJGOVCdqEdn1uQF3VDKup75KDBnBrHzzvuFwSHXb
   HqDJPAX2rGMFeUGEDewGfQtTqT41+JDpZslN4n6grFLhcqGE2kpV1QXvf
   W6KwvLqNUXR6QkPGD1S7yQzjC64bs25mVsx2n2INaTp85l/eD5YtXRCOV
   Q==;
X-CSE-ConnectionGUID: p459ZJ+nQMKhjPJmFHa8tg==
X-CSE-MsgGUID: ycKAvCKVTHSuy4dD9+tcXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88717984"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88717984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:02:07 -0700
X-CSE-ConnectionGUID: 5+v6vEWKTNaVO5+uZOXqzA==
X-CSE-MsgGUID: TncgcYxqQ4aiGh4X4Ix9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273267739"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.142]) ([10.125.108.142])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:02:07 -0700
Message-ID: <016c0065-04de-41ab-b098-fac2bceb2d24@intel.com>
Date: Mon, 14 Sep 2026 14:02:05 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
To: Koichiro Den <den@valinux.co.jp>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
 <20260910043613.CE8FD1F000FF@smtp.kernel.org>
 <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
 <b90a302d-8ad4-480f-9794-2b62e273a6be@intel.com>
 <rtc2lb2iic42wuqtcjxqqvvyxcl535x4iv7uxhvkk55o3q5ire@lq7eukkl4aaj>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <rtc2lb2iic42wuqtcjxqqvvyxcl535x4iv7uxhvkk55o3q5ire@lq7eukkl4aaj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/13/26 9:27 PM, Koichiro Den wrote:
> On Fri, Sep 11, 2026 at 08:49:40AM -0700, Dave Jiang wrote:
>>
>>
>> On 9/10/26 1:48 AM, Koichiro Den wrote:
>>> On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>>>
>>>> New issues:
>>>> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.
>>>
>>> I believe this is a false positive. See my inline comment below.
>>>
>>>>
>>>> Pre-existing issues:
>>>> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
>>>> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
>>>> --
>>>>
>>>> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
>>>> Author: Koichiro Den <den@valinux.co.jp>
>>>> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
>>>>
>>>> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
>>>> is still bound. This patch reorders the teardown process to unregister
>>>> clients before freeing resources, intending to fix unsafe memory accesses
>>>> during intensive TX loads.
>>>>
>>>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>>>> index c1e3a077c45ec..f24555b38d1b5 100644
>>>>> --- a/drivers/ntb/ntb_transport.c
>>>>> +++ b/drivers/ntb/ntb_transport.c
>>>>> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>>>>>  
>>>>>  	debugfs_remove_recursive(nt->debugfs_node_dir);
>>>>>  
>>>>> -	ntb_transport_link_cleanup(nt);
>>>>> -	cancel_work_sync(&nt->link_cleanup);
>>>>> -	cancel_delayed_work_sync(&nt->link_work);
>>>>> +	/* Stop transport work before clients release their QPs. */
>>>>> +	disable_delayed_work_sync(&nt->link_work);
>>>>> +	disable_work_sync(&nt->link_cleanup);
>>>>> +
>>>>> +	ntb_bus_remove(nt);
>>>>
>>>> [Severity: Critical]
>>>> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
>>>> introduce a DMA use-after-free regression?
>>>>
>>>> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
>>>> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
>>>> without polling:
>>>>
>>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>>>     ...
>>>> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
>>>> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
>>>> 		kfree(entry);
>>>> 	}
>>>>     ...
>>>> }
>>>
>>> Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
>>> those entries. For IOAT, this goes through ioat_free_chan_resources(), which
>>> calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
>>> channel.
>>
>> The refute looks reasonable to me for ioat. Any concerns for other host DMA engines? 
> 
> Sorry for the late reply. I've been looking into the other engines and
> scratching my head a bit.. and
> 
> Yes, I found some concerns.
> 
> AFAICT:
> - IDXD: device_synchronize() does not fully synchronize callbacks.
> - AMD PTDMA/AE4DMA: device_synchronize() does not wait for their actual
>   callback paths.
> - DesignWare DMAC (not dw-edma): device_synchronize() is missing.

Given that different DMA drivers have different implementations, this becomes a difficult issue. Either there needs to be a standard expectation and documented in dmaengine API (which would also including fixing up every DMA driver and seems kind of unrealistic). Or we document and fix it on the NTB side in a uniform way. Thoughts?

DJ

> 
> These appear to be existing driver issues, but Patch 14 could expose them in
> transport teardown. Leaving the patch out does not fix the original crash
> described in its commit message either.
> 
> For now, I would drop this patch 14(/14) from this series and work on:
> (a) Seeing whether an NTB-side rework can fix the original issue without
>     depending on the missing callback synchronization.
> (b) Fixing callback synchronization in the DMA drivers.
> 
> I'm not very familiar with these engines and don't have hardware to verify this
> though, so please take this with a pinch of salt. Just my source-level
> assessment.
> 
> A few details:
> 
> - IDXD
> 
>   idxd_dma_synchronize() drains the hardware WQ, but idxd_wq_thread() can
>   already have moved a completed descriptor to its local flist. It invokes
>   the client callback after dropping list_lock.
> 
>   The WQ drain does not wait for that callback to finish, contrary to [1].
>   idxd_dma_free_chan_resources() does not provide a compensating wait either,
>   unlike IOAT's channel teardown.
> 
> - AMD PTDMA / AE4DMA
> 
>   pt_synchronize() only calls vchan_synchronize(), but these drivers invoke
>   callbacks outside the virt-dma tasklet: through status processing in PTDMA and
>   ae4_pending_work in AE4DMA. pt_free_chan_resources() does not wait for those
>   callbacks either.
> 
>   Synchronization needs to cover those actual callback paths.
>   ldma_synchronize() might be an example of waiting for driver-specific work as
>   well as the virt-dma tasklet, though the details would differ here. The
>   ordering of descriptor freeing would also need checking.
> 
> - DesignWare DMAC
> 
>   The legacy DW driver still lacks device_synchronize(), although its tasklet
>   can drop the channel lock before invoking the client callback.  Channel
>   resource release does not wait for that tasklet either.
> 
>   Adding callback synchronization might be a right direction here. This looks
>   like the kind of race the termination synchronization API was introduced to
>   address:
>   https://lore.kernel.org/r/1445334391-12272-1-git-send-email-lars@metafoo.de/
> 
> [1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
>     > Must make sure that all complete callbacks for previously
>     > submitted descriptors have finished running and none are
>     > scheduled to run.
> 
> Best regards,
> Koichiro
> 
>>
>> DJ
>>
>>>
>>> I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
>>> them. I guess the mention on IOAT in an earlier patch in this series prompted
>>> Sashiko to focus on it here.
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>>
>>>> Because IOAT DMA engines could still be actively copying into those buffers,
>>>> freeing them allows the hardware DMA engine to write to freed kernel memory.
>>>> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
>>>> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
>>>> call to ntb_transport_link_cleanup().
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
>>>>>  
>>>>>  	if (hdr->len > entry->len) {
>>>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>>>  			"receive buffer overflow! Wanted %d got %d\n",
>>>>>  			hdr->len, entry->len);
>>>>>  		qp->rx_err_oflow++;
>>>>>  
>>>>>  		entry->len = -EIO;
>>>>>  		entry->flags |= DESC_DONE_FLAG;
>>>>>  
>>>>>  		ntb_complete_rxc(qp);
>>>>>  	} else {
>>>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>>>  			"RX OK index %u ver %u size %d into buf size %d\n",
>>>>>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
>>>>>  
>>>>>  		qp->rx_bytes += hdr->len;
>>>>>  		qp->rx_pkts++;
>>>>>  
>>>>>  		entry->len = hdr->len;
>>>>
>>>> [Severity: Critical]
>>>> This is a pre-existing issue, but is there a time-of-check to time-of-use
>>>> race condition in this bounds check on hdr->len?
>>>>
>>>> Since hdr points to a payload header located inside a memory window writable
>>>> by the remote NTB peer (shared memory), hdr->len is read directly from
>>>> shared memory twice (once for the bounds check, once for the assignment).
>>>>
>>>> Can a remote peer swap hdr->len to a much larger value immediately after
>>>> the bounds check but before the assignment, bypassing the bounds check and
>>>> causing a buffer overflow when copied?
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
>>>>>  ntb_transport_create_queue(void *data, struct device *client_dev,
>>>>>  			   const struct ntb_queue_handlers *handlers)
>>>>>  {
>>>> [ ... ]
>>>>>  	free_queue--;
>>>>>  
>>>>>  	qp = &nt->qp_vec[free_queue];
>>>>>  	qp_bit = BIT_ULL(qp->qp_num);
>>>>>  
>>>>>  	nt->qp_bitmap_free &= ~qp_bit;
>>>>
>>>> [Severity: High]
>>>> This isn't a bug introduced by this patch, but could this read-modify-write
>>>> of nt->qp_bitmap_free lead to queue state corruption?
>>>>
>>>> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
>>>> operations without holding any lock. It is also modified concurrently during
>>>> driver unbind:
>>>>
>>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>>>     ...
>>>> 	qp->transport->qp_bitmap_free |= qp_bit;
>>>>     ...
>>>> }
>>>>
>>>> Since these are exported functions called by NTB client drivers, could
>>>> concurrent probe and remove operations race and lose bit updates, leading
>>>> to a leaked queue or two clients being assigned the same queue?
>>>>
>>>> -- 
>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
>>>
>>

