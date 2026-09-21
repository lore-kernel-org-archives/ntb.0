Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A203CA4BC;
	Mon, 21 Sep 2026 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032149; cv=none; b=ShbwT935KkNUXyVF3Qevw/3w9UtGblTFcxW485if6Kve7fI17BVxaxEjCO5Pxori3jSrL3CSitb2xZGpznXTd5dSQy+N9fr81ZIybwoOH8mVFCVEJGgySHFNB70hMirxekEJqTiRjL/lzkF0q7Ui3lmNQkzDU+n9JyxiCGAWgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032149; c=relaxed/simple;
	bh=ArWFFIpBekvbrO70QQbAqVt8dwdk5uDBhXPKRg8R56I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNLTIACLe6V6HiuIPE8npdPjzNcABJ7w29G8fHnoeRaIuE5Z05YVzL82WvK8NFIY1GQxf7R9ARQErUK+xKtcyrgwAd/jsxyqYl7vRyf76IvNrxxK2YZN21htsdkGFLgzPi6aGiRJtaUIhoxscdHrwblfkPx+R3cZ+iuvWKuWMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcFT6sPs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcFT6sPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790032149; x=1821568149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ArWFFIpBekvbrO70QQbAqVt8dwdk5uDBhXPKRg8R56I=;
  b=KcFT6sPsbYJlgjG5KBxat0i2KATPC71xaAzbwbC4AbFUxECBCzpOwlmM
   vHqOhF77p03SG1lwJLJbzP8xd9oLIOU/w4FQ1NNW/9YJgfq1U101RBRO4
   Rph1SfDteoPjIY07oCbrT01aYVH6eKpodbixfYD11tuDaGzZeNb/k7t1S
   4XpgVMd4V6IioYSdq//L9P/EMlq1aoAevBjvX4F8hjAUj8R3DIkRWrF99
   W11NmCMjF3OgA1g13eTh6TJIK8f6noHwmqDVhxMthpgo0yr1rtJMQ9BBb
   38BpzoU7a2raQHf1B9wEJtg0x+IstumHchuwivto26yC9ZA9+NMDqJ/xc
   Q==;
X-CSE-ConnectionGUID: QBnh4D6oQf+nheVWtbybYg==
X-CSE-MsgGUID: NfaGoaxFTlCS9rohhiRMzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116114428"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="116114428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 16:09:08 -0700
X-CSE-ConnectionGUID: /zDupwKcT7eJSFM/59g1nA==
X-CSE-MsgGUID: S+xvSuQITuGOrTPzmi+bVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299106959"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 16:09:05 -0700
Message-ID: <cb8b0e2a-dadb-45dc-a1dc-80b9944fb06b@intel.com>
Date: Mon, 21 Sep 2026 16:09:04 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ntb: use dmaengine_get_dma_device() instead of
 chan->device->dev
To: Frank.Li@oss.nxp.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org
References: <20260921203910.1350228-1-Frank.Li@oss.nxp.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260921203910.1350228-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/26 1:39 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() accessor in NTB DMA consumers.
> 
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
> 
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> change in v2
> - fix commit message wrong mention IIO (copy-parste error). (report by
> sashkio)
> ---
>  drivers/ntb/ntb_transport.c | 29 +++++++++++++++++------------
>  drivers/ntb/test/ntb_perf.c | 14 ++++++++------
>  2 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..890697cfc6b96 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1519,6 +1519,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  	struct ntb_transport_qp *qp = entry->qp;
>  	struct dma_chan *chan = qp->rx_dma_chan;
>  	struct dma_device *device;
> +	struct device *dma_dev;
>  	size_t pay_off, buff_off, len;
>  	struct dmaengine_unmap_data *unmap;
>  	dma_cookie_t cookie;
> @@ -1526,27 +1527,28 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	len = entry->len;
>  	device = chan->device;
> +	dma_dev = dmaengine_get_dma_device(chan);
>  	pay_off = (size_t)offset & ~PAGE_MASK;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
>  
>  	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
>  		goto err;
>  
> -	unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
> +	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
>  	if (!unmap)
>  		goto err;
>  
>  	unmap->len = len;
> -	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(offset),
> +	unmap->addr[0] = dma_map_phys(dma_dev, virt_to_phys(offset),
>  				      len, DMA_TO_DEVICE, 0);
> -	if (dma_mapping_error(device->dev, unmap->addr[0]))
> +	if (dma_mapping_error(dma_dev, unmap->addr[0]))
>  		goto err_get_unmap;
>  
>  	unmap->to_cnt = 1;
>  
> -	unmap->addr[1] = dma_map_phys(device->dev, virt_to_phys(buf),
> +	unmap->addr[1] = dma_map_phys(dma_dev, virt_to_phys(buf),
>  				      len, DMA_FROM_DEVICE, 0);
> -	if (dma_mapping_error(device->dev, unmap->addr[1]))
> +	if (dma_mapping_error(dma_dev, unmap->addr[1]))
>  		goto err_get_unmap;
>  
>  	unmap->from_cnt = 1;
> @@ -1856,6 +1858,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  {
>  	struct dma_async_tx_descriptor *txd;
>  	struct dma_chan *chan = qp->tx_dma_chan;
> +	struct device *dma_dev = dmaengine_get_dma_device(chan);
>  	struct dma_device *device;
>  	size_t len = entry->len;
>  	void *buf = entry->buf;
> @@ -1872,14 +1875,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	if (!is_dma_copy_aligned(device, buff_off, dest_off, len))
>  		goto err;
>  
> -	unmap = dmaengine_get_unmap_data(device->dev, 1, GFP_NOWAIT);
> +	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
>  	if (!unmap)
>  		goto err;
>  
>  	unmap->len = len;
> -	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(buf),
> +	unmap->addr[0] = dma_map_phys(dma_dev, virt_to_phys(buf),
>  				      len, DMA_TO_DEVICE, 0);
> -	if (dma_mapping_error(device->dev, unmap->addr[0]))
> +	if (dma_mapping_error(dma_dev, unmap->addr[0]))
>  		goto err_get_unmap;
>  
>  	unmap->to_cnt = 1;
> @@ -2026,6 +2029,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	struct ntb_transport_qp *qp;
>  	u64 qp_bit;
>  	unsigned int free_queue;
> +	struct device *tx_dev;
>  	dma_cap_mask_t dma_mask;
>  	int node;
>  	int i;
> @@ -2089,11 +2093,12 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  
>  	qp->tx_mw_dma_addr = 0;
>  	if (qp->tx_dma_chan) {
> +		tx_dev = dmaengine_get_dma_device(qp->tx_dma_chan);
>  		qp->tx_mw_dma_addr =
> -			dma_map_resource(qp->tx_dma_chan->device->dev,
> +			dma_map_resource(tx_dev,
>  					 qp->tx_mw_phys, qp->tx_mw_size,
>  					 DMA_FROM_DEVICE, 0);
> -		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> +		if (dma_mapping_error(tx_dev,
>  				      qp->tx_mw_dma_addr)) {
>  			qp->tx_mw_dma_addr = 0;
>  			goto err1;
> @@ -2142,7 +2147,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
>  		kfree(entry);
>  	if (qp->tx_mw_dma_addr)
> -		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> +		dma_unmap_resource(tx_dev,
>  				   qp->tx_mw_dma_addr, qp->tx_mw_size,
>  				   DMA_FROM_DEVICE, 0);
>  	if (qp->tx_dma_chan)
> @@ -2192,7 +2197,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  		dma_sync_wait(chan, qp->last_cookie);
>  		dmaengine_terminate_all(chan);
>  
> -		dma_unmap_resource(chan->device->dev,
> +		dma_unmap_resource(dmaengine_get_dma_device(chan),
>  				   qp->tx_mw_dma_addr, qp->tx_mw_size,
>  				   DMA_FROM_DEVICE, 0);
>  
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..b936f15079df2 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -799,7 +799,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  		goto ret_check_tsync;
>  	}
>  
> -	dma_dev = pthr->dma_chan->device->dev;
> +	dma_dev = dmaengine_get_dma_device(pthr->dma_chan);
>  
>  	if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
>  				 offset_in_page(dst), len))
> @@ -869,6 +869,7 @@ static bool perf_dma_filter(struct dma_chan *chan, void *data)
>  static int perf_init_test(struct perf_thread *pthr)
>  {
>  	struct perf_ctx *perf = pthr->perf;
> +	struct device *dma_dev;
>  	dma_cap_mask_t dma_mask;
>  	struct perf_peer *peer = pthr->perf->test_peer;
>  
> @@ -890,19 +891,20 @@ static int perf_init_test(struct perf_thread *pthr)
>  			pthr->tidx);
>  		goto err_free;
>  	}
> +	dma_dev = dmaengine_get_dma_device(pthr->dma_chan);
>  	peer->dma_dst_addr =
> -		dma_map_resource(pthr->dma_chan->device->dev,
> +		dma_map_resource(dma_dev,
>  				 peer->out_phys_addr, peer->outbuf_size,
>  				 DMA_FROM_DEVICE, 0);
> -	if (dma_mapping_error(pthr->dma_chan->device->dev,
> +	if (dma_mapping_error(dma_dev,
>  			      peer->dma_dst_addr)) {
> -		dev_err(pthr->dma_chan->device->dev, "%d: Failed to map DMA addr\n",
> +		dev_err(dma_dev, "%d: Failed to map DMA addr\n",
>  			pthr->tidx);
>  		peer->dma_dst_addr = 0;
>  		dma_release_channel(pthr->dma_chan);
>  		goto err_free;
>  	}
> -	dev_dbg(pthr->dma_chan->device->dev, "%d: Map MMIO %pa to DMA addr %pad\n",
> +	dev_dbg(dma_dev, "%d: Map MMIO %pa to DMA addr %pad\n",
>  			pthr->tidx,
>  			&peer->out_phys_addr,
>  			&peer->dma_dst_addr);
> @@ -1003,7 +1005,7 @@ static void perf_clear_test(struct perf_thread *pthr)
>  	 */
>  	(void)dmaengine_terminate_sync(pthr->dma_chan);
>  	if (pthr->perf->test_peer->dma_dst_addr)
> -		dma_unmap_resource(pthr->dma_chan->device->dev,
> +		dma_unmap_resource(dmaengine_get_dma_device(pthr->dma_chan),
>  				   pthr->perf->test_peer->dma_dst_addr,
>  				   pthr->perf->test_peer->outbuf_size,
>  				   DMA_FROM_DEVICE, 0);

