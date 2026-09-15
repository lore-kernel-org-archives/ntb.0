Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989C3C4544;
	Tue, 15 Sep 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487452; cv=none; b=F1OR517vNhMLFsoLFLzd1+5icLZzUjQI6fxkJsOp/YMejictdg/eNzFfjQngp/UYZWEMKmW2+FiaeVjcRnyoboNnAZyehY298YJh4A+F+ianzV+ZAHktcT5uycC5t18mpc/diNyqGe1j+h6wOV3w306EIcuEQYYkVoNwHhyacRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487452; c=relaxed/simple;
	bh=ZmkBrfUTjM7PdBr/m5D8Mqj8lpJDEjBNzuaGb1jBMsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxbDdICqQu0smIQhlCVDpof2shwdni7Fmqn66Rta0ZsnVA5l9PJn/WovB6bxxitjflozBqwkk0ElpMwcZmwcCXZVvrQ1oamhN7yacMt/wBUbWbB5z0PrSBqfboKLzmdzPsr4Dy+KU1Bg7mfvEUKdkIMYoobibW1nXbGrTFmdDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fePsybW7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fePsybW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789487449; x=1821023449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmkBrfUTjM7PdBr/m5D8Mqj8lpJDEjBNzuaGb1jBMsM=;
  b=fePsybW7pbvS64kl3/uxDxNM4Vhn8X5eRJ2+JFLxI8bpsMws9u5fnk1w
   mVJAaw/nJwpsWcDb5VToKltXwg1xwdHCQ+Y8dn6/uHpFmt2MV6mCgvrd7
   uz4EnXo+xT9VhFLcmUrgTpzFgy3bGNINYhvLoQoDc4sUJxfgrBGCtVoFu
   6IrF0T4PcBcVV5xFg/YkJlUw4zMSuwzkWTTOUe9jqDgp8Ozg7IL/fxdUA
   4LI2ltmncgyOfO7f5AYrjH/XkDp1PV8tl+x0G+uLmwmYTjbamaV32fCVP
   kbeztgbhPOSRpfChFQnApQUz0nLfijyV+7Tby9f8MTlwFL1MeuUC0e2Lt
   w==;
X-CSE-ConnectionGUID: wkln5pN0QtmzTpWqDS6Nww==
X-CSE-MsgGUID: WG/3TDc3SribR46T7xVLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101205794"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101205794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:50:48 -0700
X-CSE-ConnectionGUID: E1tlXyLhSjyJwVWNdodIww==
X-CSE-MsgGUID: OS4bZ6Y8RiOgprzKFVF5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302937712"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.195]) ([10.125.108.195])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:50:48 -0700
Message-ID: <37737659-6cef-4512-900a-4f373aa35566@intel.com>
Date: Tue, 15 Sep 2026 08:50:47 -0700
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
 <016c0065-04de-41ab-b098-fac2bceb2d24@intel.com>
 <vuoc76ik5ethjsq25gu3aku5o3yvdsm4ko6dnp4n3biheiqdy2@pxxgq24tk2cy>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <vuoc76ik5ethjsq25gu3aku5o3yvdsm4ko6dnp4n3biheiqdy2@pxxgq24tk2cy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/14/26 9:01 PM, Koichiro Den wrote:
> On Mon, Sep 14, 2026 at 02:02:05PM -0700, Dave Jiang wrote:
>>
>>
>> On 9/13/26 9:27 PM, Koichiro Den wrote:
>>> On Fri, Sep 11, 2026 at 08:49:40AM -0700, Dave Jiang wrote:
>>>>
>>>>
>>>> On 9/10/26 1:48 AM, Koichiro Den wrote:
>>>>> On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
>>>>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>>>>>
>>>>>> New issues:
>>>>>> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.
>>>>>
>>>>> I believe this is a false positive. See my inline comment below.
>>>>>
>>>>>>
>>>>>> Pre-existing issues:
>>>>>> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
>>>>>> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
>>>>>> --
>>>>>>
>>>>>> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
>>>>>> Author: Koichiro Den <den@valinux.co.jp>
>>>>>> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
>>>>>>
>>>>>> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
>>>>>> is still bound. This patch reorders the teardown process to unregister
>>>>>> clients before freeing resources, intending to fix unsafe memory accesses
>>>>>> during intensive TX loads.
>>>>>>
>>>>>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>>>>>> index c1e3a077c45ec..f24555b38d1b5 100644
>>>>>>> --- a/drivers/ntb/ntb_transport.c
>>>>>>> +++ b/drivers/ntb/ntb_transport.c
>>>>>>> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>>>>>>>  
>>>>>>>  	debugfs_remove_recursive(nt->debugfs_node_dir);
>>>>>>>  
>>>>>>> -	ntb_transport_link_cleanup(nt);
>>>>>>> -	cancel_work_sync(&nt->link_cleanup);
>>>>>>> -	cancel_delayed_work_sync(&nt->link_work);
>>>>>>> +	/* Stop transport work before clients release their QPs. */
>>>>>>> +	disable_delayed_work_sync(&nt->link_work);
>>>>>>> +	disable_work_sync(&nt->link_cleanup);
>>>>>>> +
>>>>>>> +	ntb_bus_remove(nt);
>>>>>>
>>>>>> [Severity: Critical]
>>>>>> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
>>>>>> introduce a DMA use-after-free regression?
>>>>>>
>>>>>> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
>>>>>> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
>>>>>> without polling:
>>>>>>
>>>>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>>>>>     ...
>>>>>> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
>>>>>> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
>>>>>> 		kfree(entry);
>>>>>> 	}
>>>>>>     ...
>>>>>> }
>>>>>
>>>>> Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
>>>>> those entries. For IOAT, this goes through ioat_free_chan_resources(), which
>>>>> calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
>>>>> channel.
>>>>
>>>> The refute looks reasonable to me for ioat. Any concerns for other host DMA engines? 
>>>
>>> Sorry for the late reply. I've been looking into the other engines and
>>> scratching my head a bit.. and
>>>
>>> Yes, I found some concerns.
>>>
>>> AFAICT:
>>> - IDXD: device_synchronize() does not fully synchronize callbacks.
>>> - AMD PTDMA/AE4DMA: device_synchronize() does not wait for their actual
>>>   callback paths.
>>> - DesignWare DMAC (not dw-edma): device_synchronize() is missing.
>>
>> Given that different DMA drivers have different implementations, this becomes a difficult issue. Either there needs to be a standard expectation and documented in dmaengine API (which would also including fixing up every DMA driver and seems kind of unrealistic). Or we document and fix it on the NTB side in a uniform way. Thoughts?
> 
> There is already a documented requirement. Here is [1] from my previous email
> again:
> 
> [1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
>     > Must make sure that all complete callbacks for previously
>     > submitted descriptors have finished running and none are
>     > scheduled to run.
> 
> Based on that requirement and the code I checked, AFAICT:
> 
>   - IDXD             : fixes needed
>   - AMD PTDMA/AE4DMA : fixes needed
>   - DesignWare DMAC  : follow-up is desired
> 
> I agree that a uniform NTB-side approach would be worth looking into. But after
> some more head-scratching, I'd like to revise my conclusion:
> 
> - I'd prefer to keep Patch 14 as-is. Compared to mainline, I consider this a
>   pre-existing issue, rather than a new regression. This revises my earlier plan
>   to drop Patch 14 for rework. My reasoning is in [2].

Ok yeah agreed. If it's already documented then the drivers need to fix the issues.

DJ

> 
> - A uniform NTB-side approach can be explored separately from this series. It
>   may require a larger rework than this fix.
> 
> 
> [2] Why I consider the issue pre-existing.
> 
>     The key point of this patch 14 is to stop clients before freeing the
>     resources they use.
> 
>     It relies on ntb_transport_free_queue() to stop and release QPs. This API is
>     already called directly during standalone ntb_netdev removal, without prior
>     transport link cleanup. It relies on the DMA driver to stop transfers and
>     synchronize callbacks before resources are freed. Some drivers have gaps in
>     that synchronization, allowing late callbacks to access freed resources.
>     Those gaps already affect standalone netdev removal.
> 
>     Patch 10 added an RX wait before QP reset and MW release. That wait also
>     covered transport removal. Patch 14 bypasses it, so compared with its
>     immediate parent, it does remove some protection against the existing DMA
>     driver bugs. I agree that this is a real change.
> 
>     However, that RX wait did not exist in mainline before this series, and the
>     same callback-lifetime issue was already possible there. It would therefore
>     be misleading to describe this as a new DMA synchronization bug or callback
>     use-after-free introduced into mainline by the series.
> 
>     Relying on the DMA driver to synchronize callbacks is consistent with the
>     existing dmaengine API contract. I would therefore prefer to keep Patch 14
>     and address the DMA driver bugs separately, while acknowledging that Patch
>     14 no longer benefits from the RX wait added earlier in the series.
> 
> Best regards,
> Koichiro
> 
>>
>> DJ
>>
>>>
>>> These appear to be existing driver issues, but Patch 14 could expose them in
>>> transport teardown. Leaving the patch out does not fix the original crash
>>> described in its commit message either.
>>>
>>> For now, I would drop this patch 14(/14) from this series and work on:
>>> (a) Seeing whether an NTB-side rework can fix the original issue without
>>>     depending on the missing callback synchronization.
>>> (b) Fixing callback synchronization in the DMA drivers.
>>>
>>> I'm not very familiar with these engines and don't have hardware to verify this
>>> though, so please take this with a pinch of salt. Just my source-level
>>> assessment.
>>>
>>> A few details:
>>>
>>> - IDXD
>>>
>>>   idxd_dma_synchronize() drains the hardware WQ, but idxd_wq_thread() can
>>>   already have moved a completed descriptor to its local flist. It invokes
>>>   the client callback after dropping list_lock.
>>>
>>>   The WQ drain does not wait for that callback to finish, contrary to [1].
>>>   idxd_dma_free_chan_resources() does not provide a compensating wait either,
>>>   unlike IOAT's channel teardown.
>>>
>>> - AMD PTDMA / AE4DMA
>>>
>>>   pt_synchronize() only calls vchan_synchronize(), but these drivers invoke
>>>   callbacks outside the virt-dma tasklet: through status processing in PTDMA and
>>>   ae4_pending_work in AE4DMA. pt_free_chan_resources() does not wait for those
>>>   callbacks either.
>>>
>>>   Synchronization needs to cover those actual callback paths.
>>>   ldma_synchronize() might be an example of waiting for driver-specific work as
>>>   well as the virt-dma tasklet, though the details would differ here. The
>>>   ordering of descriptor freeing would also need checking.
>>>
>>> - DesignWare DMAC
>>>
>>>   The legacy DW driver still lacks device_synchronize(), although its tasklet
>>>   can drop the channel lock before invoking the client callback.  Channel
>>>   resource release does not wait for that tasklet either.
>>>
>>>   Adding callback synchronization might be a right direction here. This looks
>>>   like the kind of race the termination synchronization API was introduced to
>>>   address:
>>>   https://lore.kernel.org/r/1445334391-12272-1-git-send-email-lars@metafoo.de/
>>>
>>> [1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
>>>     > Must make sure that all complete callbacks for previously
>>>     > submitted descriptors have finished running and none are
>>>     > scheduled to run.
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>>
>>>> DJ
>>>>
>>>>>
>>>>> I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
>>>>> them. I guess the mention on IOAT in an earlier patch in this series prompted
>>>>> Sashiko to focus on it here.
>>>>>
>>>>> Best regards,
>>>>> Koichiro
>>>>>
>>>>>>
>>>>>> Because IOAT DMA engines could still be actively copying into those buffers,
>>>>>> freeing them allows the hardware DMA engine to write to freed kernel memory.
>>>>>> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
>>>>>> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
>>>>>> call to ntb_transport_link_cleanup().
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
>>>>>>>  
>>>>>>>  	if (hdr->len > entry->len) {
>>>>>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>>>>>  			"receive buffer overflow! Wanted %d got %d\n",
>>>>>>>  			hdr->len, entry->len);
>>>>>>>  		qp->rx_err_oflow++;
>>>>>>>  
>>>>>>>  		entry->len = -EIO;
>>>>>>>  		entry->flags |= DESC_DONE_FLAG;
>>>>>>>  
>>>>>>>  		ntb_complete_rxc(qp);
>>>>>>>  	} else {
>>>>>>>  		dev_dbg(&qp->ndev->pdev->dev,
>>>>>>>  			"RX OK index %u ver %u size %d into buf size %d\n",
>>>>>>>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
>>>>>>>  
>>>>>>>  		qp->rx_bytes += hdr->len;
>>>>>>>  		qp->rx_pkts++;
>>>>>>>  
>>>>>>>  		entry->len = hdr->len;
>>>>>>
>>>>>> [Severity: Critical]
>>>>>> This is a pre-existing issue, but is there a time-of-check to time-of-use
>>>>>> race condition in this bounds check on hdr->len?
>>>>>>
>>>>>> Since hdr points to a payload header located inside a memory window writable
>>>>>> by the remote NTB peer (shared memory), hdr->len is read directly from
>>>>>> shared memory twice (once for the bounds check, once for the assignment).
>>>>>>
>>>>>> Can a remote peer swap hdr->len to a much larger value immediately after
>>>>>> the bounds check but before the assignment, bypassing the bounds check and
>>>>>> causing a buffer overflow when copied?
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
>>>>>>>  ntb_transport_create_queue(void *data, struct device *client_dev,
>>>>>>>  			   const struct ntb_queue_handlers *handlers)
>>>>>>>  {
>>>>>> [ ... ]
>>>>>>>  	free_queue--;
>>>>>>>  
>>>>>>>  	qp = &nt->qp_vec[free_queue];
>>>>>>>  	qp_bit = BIT_ULL(qp->qp_num);
>>>>>>>  
>>>>>>>  	nt->qp_bitmap_free &= ~qp_bit;
>>>>>>
>>>>>> [Severity: High]
>>>>>> This isn't a bug introduced by this patch, but could this read-modify-write
>>>>>> of nt->qp_bitmap_free lead to queue state corruption?
>>>>>>
>>>>>> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
>>>>>> operations without holding any lock. It is also modified concurrently during
>>>>>> driver unbind:
>>>>>>
>>>>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>>>>>>     ...
>>>>>> 	qp->transport->qp_bitmap_free |= qp_bit;
>>>>>>     ...
>>>>>> }
>>>>>>
>>>>>> Since these are exported functions called by NTB client drivers, could
>>>>>> concurrent probe and remove operations race and lose bit updates, leading
>>>>>> to a leaked queue or two clients being assigned the same queue?
>>>>>>
>>>>>> -- 
>>>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
>>>>>
>>>>
>>

