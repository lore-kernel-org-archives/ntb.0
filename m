Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862602BEC4E
	for <ntb@lists.linux.dev>; Thu, 20 Aug 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256230; cv=none; b=fuSVmrrL9dirJki+Tq/+x8cqyhqCb3IZDILTBlDS0whnyaMh7jOi8WzIsBEBU3BqKv6fRDLWX5Y5KPwqkhSIdsaFHTtqrWNrt+rTq15nyhkZLZZIuHIzvz/d03kfe6o2/6yKHgwL4CJhQ/TreQh/vnIKF1KOiwnQ4gOkZoNN74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256230; c=relaxed/simple;
	bh=JDI/5RPnjEHlzYWVfQF06rFoQRgLrkZ+cdgQghuuhZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkitrFNwQnXBzrkxJ3jjcqzy+zhl6iZLLShJoHLYm8i0cULGu1hkD6LYvVOj2oBaq/cos0JGa4CfXB+jWdJxdKXDWE3iKMZ6tpAOxflwnEWVYr59rjmhsx1774kFnznnd7cxurQGeXqfg3lpzv4OUE1+yvTFP1VJ44AD5vsizyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6jSqkgQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6jSqkgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787256228; x=1818792228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JDI/5RPnjEHlzYWVfQF06rFoQRgLrkZ+cdgQghuuhZI=;
  b=U6jSqkgQfJ4F4t3wpwMuLGnHGaFfPZrFi4hVjPELChTNT/UxaaFvWCnT
   thoeDJ5zre+Bzv0FjK3Nofm72YjsOJaaxIbuY6yftn/G2pOzyPq5FUNyW
   AEyyzVbDny7DSIg9JIBr6Kfe+XIqXaCCL/9QeuWJP1J5d6w9AJqT00/Ec
   WUNU7UG3p9CsL+U67reJK6NB3stBXaa/9HLFZse/crlJWqhAD92QvYZBM
   VkSkxTxOzMeSSatALl9tmm7sgF+1zyd8ziqZF0BgtaRFmO92W9ETWv4Sk
   aGUR8h6aCJc+OAf5p5LW22U8KsvGEGSgZDGmBvL7UXY5WzSkxypcm2SkZ
   w==;
X-CSE-ConnectionGUID: 7Zm+mXwzTt6032m7QT7ZgQ==
X-CSE-MsgGUID: wfehfNWHS+Wjib9XqaGapw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87567730"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87567730"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 13:03:48 -0700
X-CSE-ConnectionGUID: Paz7+YKkTq2/4ynv96Bpfg==
X-CSE-MsgGUID: f4grEtbTSiGrLigFeBgE2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="296060084"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.63]) ([10.125.108.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 13:03:46 -0700
Message-ID: <60af3a30-dabd-4013-8324-f950d8add1fb@intel.com>
Date: Thu, 20 Aug 2026 13:03:45 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] NTB: ntb_transport: Add opt-in direct-DMA channel
 reservation
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Frank Li <Frank.Li@kernel.org>, Allen Hubbe <allenbh@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-9-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260810165136.2292436-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/26 9:51 AM, Koichiro Den wrote:
> Direct DMA is opt-in. Add 'use_direct_dma' module parameter to request
> it. Some endpoint integrations expose NTB and DMA through sibling PCI
> functions, so add direct_dma_func to select the DMA function when the
> NTB device cannot return the DMA device directly.
> 
> When use_direct_dma is set and negotiation scratchpads are available,
> locate the DMA device and reserve one suitable channel for every QP
> before registering clients. This avoids negotiating direct TX before a
> later-created QP discovers that no channel is available. If the full set
> is unavailable, leave direct TX disabled. Note that direct RX does not
> require these channels.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 120 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f873eacd532b..6051d8abfc0d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -98,6 +98,16 @@ static bool use_dma;
>  module_param(use_dma, bool, 0644);
>  MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
>  
> +static bool use_direct_dma;
> +module_param(use_direct_dma, bool, 0644);
> +MODULE_PARM_DESC(use_direct_dma,
> +		 "Use PCI endpoint DMA to transfer directly to peer RX buffers");
> +
> +static unsigned int direct_dma_func;
> +module_param(direct_dma_func, uint, 0644);
> +MODULE_PARM_DESC(direct_dma_func,
> +		 "PCI function number of a sibling endpoint DMA function");

This feel like very adhoc way of determining which DMA device to use. Is there a better way to do some sort of auto discovery without required user input?


> +
>  static unsigned int direct_dma_ring_entries = 64;
>  module_param(direct_dma_ring_entries, uint, 0644);
>  MODULE_PARM_DESC(direct_dma_ring_entries,
> @@ -147,6 +157,7 @@ struct ntb_transport_qp {
>  	void *cb_data;
>  	struct dma_chan *tx_dma_chan;
>  	struct dma_chan *rx_dma_chan;
> +	struct dma_chan *direct_dma_chan;
>  
>  	bool client_ready;
>  	bool link_is_up;
> @@ -269,6 +280,7 @@ struct ntb_transport_ctx {
>  	struct work_struct link_cleanup;
>  
>  	struct dentry *debugfs_node_dir;
> +	struct device *direct_dma_dev;
>  	u32 direct_features;
>  	u32 peer_direct_features;
>  	unsigned int direct_ring_entries;
> @@ -352,6 +364,97 @@ static inline u32 ntb_direct_ring_used(u32 head, u32 tail)
>  	return head - tail;
>  }
>  
> +static bool ntb_direct_dma_filter_fn(struct dma_chan *chan, void *data)
> +{
> +	struct dma_slave_caps caps;
> +
> +	if (chan->device->dev != data || dma_get_slave_caps(chan, &caps))
> +		return false;
> +
> +	/* Payload and completion descriptors must complete in order. */
> +	return caps.cmd_terminate &&
> +	       !dma_has_cap(DMA_COMPLETION_NO_ORDER, chan->device->cap_mask) &&
> +	       (caps.directions & BIT(DMA_MEM_TO_DEV));
> +}
> +
> +static struct device *ntb_direct_get_dma_dev(struct ntb_dev *ndev)
> +{
> +	struct pci_dev *pdev = ndev->pdev;
> +	struct pci_dev *dma_pdev;
> +	struct device *dev;
> +
> +	if (ndev->ops->get_dma_dev) {
> +		dev = ntb_get_dma_dev(ndev);
> +		return dev ? get_device(dev) : ERR_PTR(-ENODEV);
> +	}
> +
> +	if (!pdev || !pdev->bus || direct_dma_func > 7)
> +		return ERR_PTR(-ENODEV);
> +
> +	dma_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					       pdev->bus->number,
> +					       PCI_DEVFN(PCI_SLOT(pdev->devfn),
> +							 direct_dma_func));
> +	if (!dma_pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	return &dma_pdev->dev;
> +}
> +
> +static void ntb_direct_dma_release_channels(struct ntb_transport_ctx *nt)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nt->qp_count; i++) {
> +		if (!nt->qp_vec[i].direct_dma_chan)
> +			continue;
> +
> +		dma_release_channel(nt->qp_vec[i].direct_dma_chan);
> +		nt->qp_vec[i].direct_dma_chan = NULL;
> +	}
> +}
> +
> +static void ntb_direct_dma_release(struct ntb_transport_ctx *nt)
> +{
> +	ntb_direct_dma_release_channels(nt);
> +	if (nt->direct_dma_dev) {
> +		put_device(nt->direct_dma_dev);
> +		nt->direct_dma_dev = NULL;
> +	}
> +}
> +
> +static void ntb_direct_dma_init(struct ntb_transport_ctx *nt)
> +{
> +	dma_cap_mask_t mask;
> +	unsigned int i;
> +
> +	if (!use_direct_dma)
> +		return;
> +
> +	nt->direct_dma_dev = ntb_direct_get_dma_dev(nt->ndev);
> +	if (IS_ERR(nt->direct_dma_dev)) {
> +		dev_info(&nt->ndev->dev, "direct DMA device unavailable: %pe\n",
> +			 nt->direct_dma_dev);
> +		nt->direct_dma_dev = NULL;
> +		return;
> +	}
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);

Are only slave DMA usable in this case? Is it not possible to do DMA with host DMA engines?

My main concern in all of this is looking for a way to make this usable for all ntb_transport users if possible and not niche the generic code to a specific hardware vendor.

DJ
> +
> +	for (i = 0; i < nt->qp_count; i++) {
> +		nt->qp_vec[i].direct_dma_chan =
> +			dma_request_channel(mask, ntb_direct_dma_filter_fn,
> +					    nt->direct_dma_dev);
> +		if (!nt->qp_vec[i].direct_dma_chan) {
> +			dev_info(&nt->ndev->dev,
> +				 "not enough direct DMA channels for all QPs\n");
> +			ntb_direct_dma_release_channels(nt);
> +			return;
> +		}
> +	}
> +}
> +
>  struct ntb_payload_header {
>  	unsigned int ver;
>  	unsigned int len;
> @@ -1476,6 +1579,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  		return -ENOMEM;
>  
>  	nt->ndev = ndev;
> +	if (use_direct_dma &&
> +	    (direct_dma_ring_entries < 2 ||
> +	     direct_dma_ring_entries > NTB_DIRECT_MAX_RING_ENTRIES ||
> +	     !is_power_of_2(direct_dma_ring_entries))) {
> +		dev_err(&ndev->dev,
> +			"direct DMA ring entries must be a power of two between 2 and %u\n",
> +			NTB_DIRECT_MAX_RING_ENTRIES);
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  	nt->direct_ring_entries = direct_dma_ring_entries;
>  
>  	/*
> @@ -1582,6 +1695,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  		if (rc)
>  			goto err2;
>  	}
> +	if (ntb_direct_spads_available(nt))
> +		ntb_direct_dma_init(nt);
> +	else if (use_direct_dma)
> +		dev_info(&ndev->dev,
> +			 "not enough scratchpads for direct DMA negotiation\n");
>  
>  	mutex_init(&nt->link_event_lock);
>  	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
> @@ -1605,6 +1723,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  err3:
>  	ntb_clear_ctx(ndev);
>  err2:
> +	ntb_direct_dma_release(nt);
>  	kfree(nt->qp_vec);
>  err1:
>  	while (i--) {
> @@ -1648,6 +1767,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  		iounmap(nt->mw_vec[i].vbase);
>  	}
>  
> +	ntb_direct_dma_release(nt);
>  	kfree(nt->qp_vec);
>  	kfree(nt->mw_vec);
>  	kfree(nt);

