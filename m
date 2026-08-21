Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17672DA765
	for <ntb@lists.linux.dev>; Fri, 21 Aug 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325015; cv=none; b=mfaMlquA7WZ9uFf/ujpFEnnV+O1KEtd823ou0uCnUFDixOiXaMJS/5m3/mGHB/aZkamw4FvBAdK4drn2eaoCudWiq3gSVznNuLcWVMyHPLL46SNOmef9i89csw2lKGacqS5gaO8JqdyEbnRMxCtjMPvXS8Cc/4Zx3idYxBBa0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325015; c=relaxed/simple;
	bh=KIDnisqyiapIp2aWC/o1Ez/+HC07tMqZ4tEYZLkcHMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUne+5ky3+n2WOxb3/3pEgw60VteXm7FE4kpH697Tt8Rieh0PYZkRfZKoGbOC1qBmpA2ZK6iK23rgi4YKBjtFw9XlQ+W47YpvcRX38iMf2g+q6zqot64P8M3ZnV9egQPKuFGHpNeJo9KStD/jbBygYO8BWC7jNs+m3GnXOI6pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CudNSd6d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CudNSd6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787325013; x=1818861013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KIDnisqyiapIp2aWC/o1Ez/+HC07tMqZ4tEYZLkcHMI=;
  b=CudNSd6dB2grEQebf5sqBbVG2M3t5gqO1iN7z4JZ1AiRfgfIBD9JyIr0
   F/yPY/h3Kk5QMG+tTN3HsumPtb4E8mg2NdrK2+CX8qym+TsPqdWgTMcwr
   I8bqFNOcYauKg5UXpkVBbX2Ggh8OphZ5VqOVsT69mSCmT300/MITX9QTO
   jdXeLvoVql1Y9CJ+Kz3d27gCXwPCABjCiBjKNPCLybATLbopeFPbXQm95
   WGydB7PbJ8o2Osl7Arg7gsYH4u1fQD3iIYJE4BsZQSvp7Lk+t0s7jfs8G
   1TRE0oe8ArVeteYYibTqLiX8Jm+xcNbmqVod8aX4FMcFcR7rPxgjXheQ3
   g==;
X-CSE-ConnectionGUID: /wQIAn2eTJCErWPHHg/Ypg==
X-CSE-MsgGUID: aurp1c3vSD+ocsu97VcJpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="98468368"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="98468368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:10:12 -0700
X-CSE-ConnectionGUID: eojqfFmdToadbK/p8PNOPg==
X-CSE-MsgGUID: nnUD/oCLShqhr/kHV9Or4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="266972934"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.117]) ([10.125.108.117])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:10:11 -0700
Message-ID: <1e169332-3be2-4835-8a38-2f99c78b7c5e@intel.com>
Date: Fri, 21 Aug 2026 08:10:10 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] NTB: ntb_transport: Add opt-in direct-DMA channel
 reservation
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@kernel.org>,
 Allen Hubbe <allenbh@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-9-den@valinux.co.jp>
 <60af3a30-dabd-4013-8324-f950d8add1fb@intel.com>
 <xspfobekn74ua5g447ibtmqyvn5sbfflftnnebzf7gb3b55b4z@ls3mqy2xifva>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <xspfobekn74ua5g447ibtmqyvn5sbfflftnnebzf7gb3b55b4z@ls3mqy2xifva>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 7:38 AM, Koichiro Den wrote:
> On Thu, Aug 20, 2026 at 01:03:45PM -0700, Dave Jiang wrote:
>>
>>
>> On 8/10/26 9:51 AM, Koichiro Den wrote:
>>> Direct DMA is opt-in. Add 'use_direct_dma' module parameter to request
>>> it. Some endpoint integrations expose NTB and DMA through sibling PCI
>>> functions, so add direct_dma_func to select the DMA function when the
>>> NTB device cannot return the DMA device directly.
>>>
>>> When use_direct_dma is set and negotiation scratchpads are available,
>>> locate the DMA device and reserve one suitable channel for every QP
>>> before registering clients. This avoids negotiating direct TX before a
>>> later-created QP discovers that no channel is available. If the full set
>>> is unavailable, leave direct TX disabled. Note that direct RX does not
>>> require these channels.
>>>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>> ---
>>>  drivers/ntb/ntb_transport.c | 120 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 120 insertions(+)
>>>
>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>> index f873eacd532b..6051d8abfc0d 100644
>>> --- a/drivers/ntb/ntb_transport.c
>>> +++ b/drivers/ntb/ntb_transport.c
>>> @@ -98,6 +98,16 @@ static bool use_dma;
>>>  module_param(use_dma, bool, 0644);
>>>  MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
>>>  
>>> +static bool use_direct_dma;
>>> +module_param(use_direct_dma, bool, 0644);
>>> +MODULE_PARM_DESC(use_direct_dma,
>>> +		 "Use PCI endpoint DMA to transfer directly to peer RX buffers");
>>> +
>>> +static unsigned int direct_dma_func;
>>> +module_param(direct_dma_func, uint, 0644);
>>> +MODULE_PARM_DESC(direct_dma_func,
>>> +		 "PCI function number of a sibling endpoint DMA function");
>>
>> This feel like very adhoc way of determining which DMA device to use. Is there a better way to do some sort of auto discovery without required user input?
> 
> Hi, thanks for the review.
> 
> Yes, I agree. The PCI function layout is still being discussed here:
> https://lore.kernel.org/r/fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh/
> Depending on the outcome, we may not need this parameter at all.
> 
> If EPC-local DMA is exposed as part of the vNTB function, its association is
> explicit and no function-number parameter is needed. That was my original
> approach [1], which you also reviewed as part of my gigantic RFC (thanks
> again!).
> 
> If we keep the separate PCI function used by this v1, its PCI class can narrow
> down the candidates, but we still need a defined association when a slot has
> more than one DMA-class function.
> 
> In any case, I'll align v2 with the outcome of that discussion.
> 
> [1]
> https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/
> https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> and later tried the separate PCI DMA function here:
> https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/
> 
>>
>>
>>> +
>>>  static unsigned int direct_dma_ring_entries = 64;
>>>  module_param(direct_dma_ring_entries, uint, 0644);
>>>  MODULE_PARM_DESC(direct_dma_ring_entries,
>>> @@ -147,6 +157,7 @@ struct ntb_transport_qp {
>>>  	void *cb_data;
>>>  	struct dma_chan *tx_dma_chan;
>>>  	struct dma_chan *rx_dma_chan;
>>> +	struct dma_chan *direct_dma_chan;
>>>  
>>>  	bool client_ready;
>>>  	bool link_is_up;
>>> @@ -269,6 +280,7 @@ struct ntb_transport_ctx {
>>>  	struct work_struct link_cleanup;
>>>  
>>>  	struct dentry *debugfs_node_dir;
>>> +	struct device *direct_dma_dev;
>>>  	u32 direct_features;
>>>  	u32 peer_direct_features;
>>>  	unsigned int direct_ring_entries;
>>> @@ -352,6 +364,97 @@ static inline u32 ntb_direct_ring_used(u32 head, u32 tail)
>>>  	return head - tail;
>>>  }
>>>  
>>> +static bool ntb_direct_dma_filter_fn(struct dma_chan *chan, void *data)
>>> +{
>>> +	struct dma_slave_caps caps;
>>> +
>>> +	if (chan->device->dev != data || dma_get_slave_caps(chan, &caps))
>>> +		return false;
>>> +
>>> +	/* Payload and completion descriptors must complete in order. */
>>> +	return caps.cmd_terminate &&
>>> +	       !dma_has_cap(DMA_COMPLETION_NO_ORDER, chan->device->cap_mask) &&
>>> +	       (caps.directions & BIT(DMA_MEM_TO_DEV));
>>> +}
>>> +
>>> +static struct device *ntb_direct_get_dma_dev(struct ntb_dev *ndev)
>>> +{
>>> +	struct pci_dev *pdev = ndev->pdev;
>>> +	struct pci_dev *dma_pdev;
>>> +	struct device *dev;
>>> +
>>> +	if (ndev->ops->get_dma_dev) {
>>> +		dev = ntb_get_dma_dev(ndev);
>>> +		return dev ? get_device(dev) : ERR_PTR(-ENODEV);
>>> +	}
>>> +
>>> +	if (!pdev || !pdev->bus || direct_dma_func > 7)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	dma_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>>> +					       pdev->bus->number,
>>> +					       PCI_DEVFN(PCI_SLOT(pdev->devfn),
>>> +							 direct_dma_func));
>>> +	if (!dma_pdev)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	return &dma_pdev->dev;
>>> +}
>>> +
>>> +static void ntb_direct_dma_release_channels(struct ntb_transport_ctx *nt)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < nt->qp_count; i++) {
>>> +		if (!nt->qp_vec[i].direct_dma_chan)
>>> +			continue;
>>> +
>>> +		dma_release_channel(nt->qp_vec[i].direct_dma_chan);
>>> +		nt->qp_vec[i].direct_dma_chan = NULL;
>>> +	}
>>> +}
>>> +
>>> +static void ntb_direct_dma_release(struct ntb_transport_ctx *nt)
>>> +{
>>> +	ntb_direct_dma_release_channels(nt);
>>> +	if (nt->direct_dma_dev) {
>>> +		put_device(nt->direct_dma_dev);
>>> +		nt->direct_dma_dev = NULL;
>>> +	}
>>> +}
>>> +
>>> +static void ntb_direct_dma_init(struct ntb_transport_ctx *nt)
>>> +{
>>> +	dma_cap_mask_t mask;
>>> +	unsigned int i;
>>> +
>>> +	if (!use_direct_dma)
>>> +		return;
>>> +
>>> +	nt->direct_dma_dev = ntb_direct_get_dma_dev(nt->ndev);
>>> +	if (IS_ERR(nt->direct_dma_dev)) {
>>> +		dev_info(&nt->ndev->dev, "direct DMA device unavailable: %pe\n",
>>> +			 nt->direct_dma_dev);
>>> +		nt->direct_dma_dev = NULL;
>>> +		return;
>>> +	}
>>> +
>>> +	dma_cap_zero(mask);
>>> +	dma_cap_set(DMA_SLAVE, mask);
>>
>> Are only slave DMA usable in this case? Is it not possible to do DMA with host DMA engines?
>>
>> My main concern in all of this is looking for a way to make this usable for all ntb_transport users if possible and not niche the generic code to a specific hardware vendor.
> 
> DMA_SLAVE is only the initial capability mask. ntb_direct_dma_filter_fn() then
> filters further.
> 
> A host-local DMA controller may accelerate copies into a fixed NTB MW, as the
> existing MEMCPY path does. But AFAICT it cannot generally write directly to
> arbitrary endpoint RX buffers. Exposing each buffer per transfer through a
> BAR-backed inbound mapping would put mapping reprogramming on the hot path and
> defeat the throughput improvement purpose. Direct mode therefore needs EPC-local
> DMA, but is not tied to a particular hardware vendor.

Ok understood. I think this point needs to go into kernel documentation somewhere if it's not already.

DJ
 > 
> Best regards,
> Koichiro
> 
>>
>> DJ
>>> +
>>> +	for (i = 0; i < nt->qp_count; i++) {
>>> +		nt->qp_vec[i].direct_dma_chan =
>>> +			dma_request_channel(mask, ntb_direct_dma_filter_fn,
>>> +					    nt->direct_dma_dev);
>>> +		if (!nt->qp_vec[i].direct_dma_chan) {
>>> +			dev_info(&nt->ndev->dev,
>>> +				 "not enough direct DMA channels for all QPs\n");
>>> +			ntb_direct_dma_release_channels(nt);
>>> +			return;
>>> +		}
>>> +	}
>>> +}
>>> +
>>>  struct ntb_payload_header {
>>>  	unsigned int ver;
>>>  	unsigned int len;
>>> @@ -1476,6 +1579,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>>>  		return -ENOMEM;
>>>  
>>>  	nt->ndev = ndev;
>>> +	if (use_direct_dma &&
>>> +	    (direct_dma_ring_entries < 2 ||
>>> +	     direct_dma_ring_entries > NTB_DIRECT_MAX_RING_ENTRIES ||
>>> +	     !is_power_of_2(direct_dma_ring_entries))) {
>>> +		dev_err(&ndev->dev,
>>> +			"direct DMA ring entries must be a power of two between 2 and %u\n",
>>> +			NTB_DIRECT_MAX_RING_ENTRIES);
>>> +		rc = -EINVAL;
>>> +		goto err;
>>> +	}
>>>  	nt->direct_ring_entries = direct_dma_ring_entries;
>>>  
>>>  	/*
>>> @@ -1582,6 +1695,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>>>  		if (rc)
>>>  			goto err2;
>>>  	}
>>> +	if (ntb_direct_spads_available(nt))
>>> +		ntb_direct_dma_init(nt);
>>> +	else if (use_direct_dma)
>>> +		dev_info(&ndev->dev,
>>> +			 "not enough scratchpads for direct DMA negotiation\n");
>>>  
>>>  	mutex_init(&nt->link_event_lock);
>>>  	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
>>> @@ -1605,6 +1723,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>>>  err3:
>>>  	ntb_clear_ctx(ndev);
>>>  err2:
>>> +	ntb_direct_dma_release(nt);
>>>  	kfree(nt->qp_vec);
>>>  err1:
>>>  	while (i--) {
>>> @@ -1648,6 +1767,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>>>  		iounmap(nt->mw_vec[i].vbase);
>>>  	}
>>>  
>>> +	ntb_direct_dma_release(nt);
>>>  	kfree(nt->qp_vec);
>>>  	kfree(nt->mw_vec);
>>>  	kfree(nt);
>>

