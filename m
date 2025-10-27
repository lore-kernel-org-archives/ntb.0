Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD161E1C22
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580221; cv=none; b=pB4Cz/BkaSrn2hb45Xz+KQe5ovoUHcM7P/J0ok5IaC8Rh1bEEGCCwrLWL0FC1NM8GbtuxfDG+t0uqxEXpJ6uCrV2pj8uoHOjrItVutTF3Zq3kn/+JWfBGLIoYWsk853pYQ7KCvM+LiiCxECvYPsuMSCkdU6SOW6L0SRRBFsDyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580221; c=relaxed/simple;
	bh=t72j+ItUKqmjEVIKjlp8ozusn4PAVfWRUx2HEwjKlZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EP8jjXBwKrjlLZ2wvq4hFK/hzYNNmXkh22l1Vzl/a/jqWpiDAhETBE39YKpbCChuzsnLkAiuUZIZIR7IGjomMm2oHhoAKLlBFoSmPRUFeBNgGeW51oo+blCqzuC6mxSBqovI/8dvOjLwmpcCVOOgKPDaF00cZXBQI+cHdZm19yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzqgC975; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzqgC975"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761580217; x=1793116217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t72j+ItUKqmjEVIKjlp8ozusn4PAVfWRUx2HEwjKlZU=;
  b=RzqgC975cqf6+m9YT8MY9cehS/ZjH/XtwcWGd9vq1ZSHAfJlykfeVNjE
   Xk746MECek3G+KA3aEH+ON13mX+ud1rSYQM5D/eryqwsy9SHWaD1v+Pga
   di4KBS4aKIzlVLBSecdYJeX44EtD9gPxttlJtu2uGl89kiTVV4YpKVIL1
   Z/CJYNUeHfyMkcn8j3cY+8XCruUeddK0fwlrwiEYve6EgIGlZ0M+y5U4+
   JaL6SPxElui9dK4YKcgknkKE7doJEEB5W3c/MogmkGBVVvnSaBovIM2p4
   UBL98QoQ5njc+sVZ2Y7CLgI5lAmd43Pnr+pdx0c48CmsBZyCwBytI4Pg+
   g==;
X-CSE-ConnectionGUID: LJiAIE0gTPOifCSLIKNGwA==
X-CSE-MsgGUID: joxGGppeTu2lxuNEFNqbsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63569683"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63569683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:50:17 -0700
X-CSE-ConnectionGUID: 1Ff+dZ4XTsKDX36s75Ci+A==
X-CSE-MsgGUID: sbv4qarjQJO0KXm4OsVnRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="222288120"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.111]) ([10.125.109.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:50:16 -0700
Message-ID: <658755f6-d8d5-474b-8dd1-e5fd27cd48c0@intel.com>
Date: Mon, 27 Oct 2025 08:50:15 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] NTB: ntb_transport: Support multi-channel DMA via
 module parameters
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-5-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251027004331.562345-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/25 5:43 PM, Koichiro Den wrote:
> The reclamation delay of ntb_queue_entry can be a key performance
> limiter and the MEMCPY portion often accounts for a large part of the
> round-trip latency when DMA MEMCPY is used. Distributing work across
> multiple channels can improve overall throughput on busy systems by
> increasing the average service rate of the MEMCPY part, as observed on
> R-Car S4.
> 
> Allow ntb_transport to use multiple DMA engine channels per queue to
> better utilize hardware under load with the new module parameters:
> 
>   - num_tx_dma_chan: TX DMA channels per queue (default 1)
>   - num_rx_dma_chan: RX DMA channels per queue (default 1)
> 
> Channel selection is a simple round-robin driven by an atomic counter.
> A least-used policy was also tested on R-Car S4, but showed not much
> benefit, so the simpler round-robin approach is chosen.
> 
> Behavior is unchanged when DMA is disabled or only one channel is used,
> and the CPU memcpy fallback remains.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Thanks for adding the improvements!

Is it possible to split the tx and rx changes for this patch? May help with git bisect in the future if there are problems in one of the paths. Otherwise the series LGTM.

DJ

> ---
>  drivers/ntb/ntb_transport.c | 368 ++++++++++++++++++++++++------------
>  1 file changed, 252 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index aee6793812bc..1860e15295b3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -47,6 +47,7 @@
>   * Contact Information:
>   * Jon Mason <jon.mason@intel.com>
>   */
> +#include <linux/atomic.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
> @@ -102,6 +103,14 @@ static bool use_rx_dma;
>  module_param(use_rx_dma, bool, 0644);
>  MODULE_PARM_DESC(use_rx_dma, "Use DMA engine to perform large data copy on RX");
>  
> +static unsigned int num_tx_dma_chan = 1;
> +module_param(num_tx_dma_chan, uint, 0644);
> +MODULE_PARM_DESC(num_tx_dma_chan, "Number of TX DMA channels per queue (round-robin). 1 by default");
> +
> +static unsigned int num_rx_dma_chan = 1;
> +module_param(num_rx_dma_chan, uint, 0644);
> +MODULE_PARM_DESC(num_rx_dma_chan, "Number of RX DMA channels per queue (round-robin). 1 by default");
> +
>  static bool use_msi;
>  #ifdef CONFIG_NTB_MSI
>  module_param(use_msi, bool, 0644);
> @@ -137,12 +146,21 @@ struct ntb_rx_info {
>  	unsigned int entry;
>  };
>  
> +struct ntb_transport_dma {
> +	struct dma_chan **chan;
> +	unsigned int num_chan;
> +	atomic_t cur_chan;
> +	/* cache for graceful teardown */
> +	dma_cookie_t *last_cookie;
> +};
> +
>  struct ntb_transport_qp {
>  	struct ntb_transport_ctx *transport;
>  	struct ntb_dev *ndev;
>  	void *cb_data;
> -	struct dma_chan *tx_dma_chan;
> -	struct dma_chan *rx_dma_chan;
> +
> +	struct ntb_transport_dma tx_dma;
> +	struct ntb_transport_dma rx_dma;
>  
>  	bool client_ready;
>  	bool link_is_up;
> @@ -161,7 +179,7 @@ struct ntb_transport_qp {
>  	void __iomem *tx_mw;
>  	phys_addr_t tx_mw_phys;
>  	size_t tx_mw_size;
> -	dma_addr_t tx_mw_dma_addr;
> +	dma_addr_t *tx_mw_dma_addr;
>  	unsigned int tx_index;
>  	unsigned int tx_max_entry;
>  	unsigned int tx_max_frame;
> @@ -178,7 +196,6 @@ struct ntb_transport_qp {
>  	unsigned int rx_max_entry;
>  	unsigned int rx_max_frame;
>  	unsigned int rx_alloc_entry;
> -	dma_cookie_t last_cookie;
>  	struct tasklet_struct rxc_db_work;
>  
>  	void (*event_handler)(void *data, int status);
> @@ -549,10 +566,10 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
>  			       "\n");
>  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "Using TX DMA - \t%s\n",
> -			       qp->tx_dma_chan ? "Yes" : "No");
> +			       qp->tx_dma.num_chan > 0 ? "Yes" : "No");
>  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "Using RX DMA - \t%s\n",
> -			       qp->rx_dma_chan ? "Yes" : "No");
> +			       qp->rx_dma.num_chan > 0 ? "Yes" : "No");
>  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "QP Link - \t%s\n",
>  			       qp->link_is_up ? "Up" : "Down");
> @@ -1559,16 +1576,43 @@ static inline struct page *ntb_vaddr_to_page(const void *addr)
>  	return is_vmalloc_addr(addr) ? vmalloc_to_page(addr) : virt_to_page(addr);
>  }
>  
> +static inline struct dma_chan *
> +ntb_pick_dma_chan(struct ntb_transport_dma *dma, unsigned int *idx_out)
> +{
> +	unsigned int n = dma->num_chan;
> +	unsigned int cur, idx;
> +
> +	if (unlikely(!n))
> +		return NULL;
> +
> +	if (n == 1) {
> +		if (idx_out)
> +			*idx_out = 0;
> +		return dma->chan[0];
> +	}
> +
> +	cur = (unsigned int)atomic_inc_return(&dma->cur_chan) - 1;
> +	idx = cur % n;
> +	if (idx_out)
> +		*idx_out = idx;
> +	return dma->chan[idx];
> +}
> +
>  static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  {
> -	struct dma_async_tx_descriptor *txd;
>  	struct ntb_transport_qp *qp = entry->qp;
> -	struct dma_chan *chan = qp->rx_dma_chan;
> -	struct dma_device *device;
> -	size_t pay_off, buff_off, len;
> +	struct dma_async_tx_descriptor *txd;
>  	struct dmaengine_unmap_data *unmap;
> -	dma_cookie_t cookie;
> +	size_t pay_off, buff_off, len;
> +	struct dma_device *device;
>  	void *buf = entry->buf;
> +	struct dma_chan *chan;
> +	unsigned int cidx = 0;
> +	dma_cookie_t cookie;
> +
> +	chan = ntb_pick_dma_chan(&qp->rx_dma, &cidx);
> +	if (unlikely(!chan))
> +		return -ENODEV;
>  
>  	len = entry->len;
>  	device = chan->device;
> @@ -1613,7 +1657,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	dmaengine_unmap_put(unmap);
>  
> -	qp->last_cookie = cookie;
> +	dma_async_issue_pending(chan);
> +
> +	qp->rx_dma.last_cookie[cidx] = cookie;
>  
>  	qp->rx_async++;
>  
> @@ -1630,10 +1676,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
>  {
>  	struct ntb_transport_qp *qp = entry->qp;
> -	struct dma_chan *chan = qp->rx_dma_chan;
>  	int res;
>  
> -	if (!chan)
> +	if (!qp->rx_dma.chan)
>  		goto err;
>  
>  	if (entry->len < copy_bytes)
> @@ -1742,9 +1787,6 @@ static void ntb_transport_rxc_db(unsigned long data)
>  			break;
>  	}
>  
> -	if (i && qp->rx_dma_chan)
> -		dma_async_issue_pending(qp->rx_dma_chan);
> -
>  	if (i == qp->rx_max_entry) {
>  		/* there is more work to do */
>  		if (qp->active)
> @@ -1842,17 +1884,22 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  			       struct ntb_queue_entry *entry)
>  {
>  	struct dma_async_tx_descriptor *txd;
> -	struct dma_chan *chan = qp->tx_dma_chan;
> +	struct dmaengine_unmap_data *unmap;
>  	struct dma_device *device;
> +	size_t dest_off, buff_off;
>  	size_t len = entry->len;
>  	void *buf = entry->buf;
> -	size_t dest_off, buff_off;
> -	struct dmaengine_unmap_data *unmap;
> -	dma_addr_t dest;
> +	struct dma_chan *chan;
> +	unsigned int cidx = 0;
>  	dma_cookie_t cookie;
> +	dma_addr_t dest;
> +
> +	chan = ntb_pick_dma_chan(&qp->tx_dma, &cidx);
> +	if (unlikely(!chan))
> +		return -ENODEV;
>  
>  	device = chan->device;
> -	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
> +	dest = qp->tx_mw_dma_addr[cidx] + qp->tx_max_frame * entry->tx_index;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
>  	dest_off = (size_t)dest & ~PAGE_MASK;
>  
> @@ -1901,7 +1948,6 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  			 struct ntb_queue_entry *entry)
>  {
>  	struct ntb_payload_header __iomem *hdr;
> -	struct dma_chan *chan = qp->tx_dma_chan;
>  	void __iomem *offset;
>  	int res;
>  
> @@ -1913,7 +1959,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  	iowrite32(entry->len, &hdr->len);
>  	iowrite32((u32)qp->tx_pkts, &hdr->ver);
>  
> -	if (!chan)
> +	if (!qp->tx_dma.chan)
>  		goto err;
>  
>  	if (entry->len < copy_bytes)
> @@ -1999,8 +2045,99 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
>  	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
>  }
>  
> +static void ntb_transport_teardown_dma(struct ntb_transport_dma *dma,
> +				       dma_addr_t *mem, size_t size)
> +{
> +	struct dma_chan *chan;
> +	unsigned int i;
> +
> +	if (!dma)
> +		return;
> +
> +	if (!dma->chan) {
> +		kfree(dma->last_cookie);
> +		dma->last_cookie = NULL;
> +		return;
> +	}
> +
> +	for (i = 0; i < dma->num_chan; i++) {
> +		chan = dma->chan[i];
> +		if (!chan)
> +			continue;
> +
> +		if (dma->last_cookie)
> +			/* Try to be nice and wait for any queued DMA engine
> +			 * transactions to process before smashing it with a rock
> +			 */
> +			dma_sync_wait(chan, dma->last_cookie[i]);
> +
> +		dmaengine_terminate_all(chan);
> +		if (mem && mem[i])
> +			dma_unmap_resource(chan->device->dev, mem[i], size,
> +					   DMA_FROM_DEVICE, 0);
> +		dma_release_channel(chan);
> +		dma->chan[i] = NULL;
> +	}
> +
> +	kfree(dma->chan);
> +	kfree(dma->last_cookie);
> +	dma->chan = NULL;
> +	dma->num_chan = 0;
> +	dma->last_cookie = NULL;
> +}
> +
> +static unsigned int ntb_transport_setup_dma(struct pci_dev *pdev,
> +					    struct ntb_transport_dma *dma,
> +					    unsigned int req, int node)
> +{
> +	dma_cap_mask_t dma_mask;
> +	struct dma_chan *c;
> +	unsigned int i = 0;
> +
> +	dma_cap_zero(dma_mask);
> +	dma_cap_set(DMA_MEMCPY, dma_mask);
> +
> +	dma->last_cookie = NULL;
> +	dma->num_chan = 0;
> +	dma->chan = kcalloc_node(req, sizeof(*dma->chan), GFP_KERNEL, node);
> +	if (!dma->chan) {
> +		dev_info(&pdev->dev, "Unable to alloc DMA arrays\n");
> +		return 0;
> +	}
> +
> +	atomic_set(&dma->cur_chan, 0);
> +	for (i = 0; i < req; i++) {
> +		c = dma_request_channel(dma_mask, ntb_dma_filter_fn,
> +					(void *)(unsigned long)node);
> +		if (!c) {
> +			if (!i)
> +				dev_info(&pdev->dev,
> +					 "Unable to allocate DMA channel(s)\n");
> +			break;
> +		}
> +		dma->chan[i] = c;
> +		dma->num_chan++;
> +	}
> +	if (!dma->num_chan)
> +		goto err_out;
> +
> +	dma->last_cookie = kcalloc_node(dma->num_chan, sizeof(dma_cookie_t),
> +					GFP_KERNEL, node);
> +	if (!dma->last_cookie)
> +		goto err_out;
> +
> +	return dma->num_chan;
> +
> +err_out:
> +	for (i = 0; i < dma->num_chan; i++)
> +		dma_release_channel(dma->chan[i]);
> +	kfree(dma->chan);
> +	dma->chan = NULL;
> +	dma->num_chan = 0;
> +	return 0;
> +}
> +
>  /**
> - * ntb_transport_create_queue - Create a new NTB transport layer queue
>   * @data: pointer for callback data
>   * @client_dev: &struct device pointer
>   * @handlers: pointer to various ntb queue (callback) handlers
> @@ -2024,7 +2161,8 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	struct ntb_transport_qp *qp;
>  	u64 qp_bit;
>  	unsigned int free_queue;
> -	dma_cap_mask_t dma_mask;
> +	struct dma_chan *c;
> +	dma_addr_t mw_dma;
>  	int node;
>  	int i;
>  
> @@ -2036,7 +2174,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  
>  	free_queue = ffs(nt->qp_bitmap_free);
>  	if (!free_queue)
> -		goto err;
> +		return NULL;
>  
>  	/* decrement free_queue to make it zero based */
>  	free_queue--;
> @@ -2051,54 +2189,70 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->tx_handler = handlers->tx_handler;
>  	qp->event_handler = handlers->event_handler;
>  
> -	dma_cap_zero(dma_mask);
> -	dma_cap_set(DMA_MEMCPY, dma_mask);
> -
>  	if (use_dma) {
>  		use_tx_dma = true;
>  		use_rx_dma = true;
>  	}
> -	if (use_tx_dma) {
> -		qp->tx_dma_chan =
> -			dma_request_channel(dma_mask, ntb_dma_filter_fn,
> -					    (void *)(unsigned long)node);
> -		if (!qp->tx_dma_chan)
> -			dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
> -	} else
> -		qp->tx_dma_chan = NULL;
> -
> -	if (use_rx_dma) {
> -		qp->rx_dma_chan =
> -			dma_request_channel(dma_mask, ntb_dma_filter_fn,
> -					    (void *)(unsigned long)node);
> -		if (!qp->rx_dma_chan)
> -			dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
> -	} else
> -		qp->rx_dma_chan = NULL;
> -
> -	qp->tx_mw_dma_addr = 0;
> -	if (qp->tx_dma_chan) {
> -		qp->tx_mw_dma_addr =
> -			dma_map_resource(qp->tx_dma_chan->device->dev,
> -					 qp->tx_mw_phys, qp->tx_mw_size,
> -					 DMA_FROM_DEVICE, 0);
> -		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> -				      qp->tx_mw_dma_addr)) {
> -			qp->tx_mw_dma_addr = 0;
> -			goto err1;
> +
> +	/* setup TX dma if requested */
> +	qp->tx_dma.chan = NULL;
> +	qp->tx_dma.num_chan = 0;
> +	if (use_tx_dma)
> +		ntb_transport_setup_dma(pdev, &qp->tx_dma, num_tx_dma_chan ?: 1,
> +					node);
> +
> +	/* setup RX dma if requested */
> +	qp->rx_dma.chan = NULL;
> +	qp->rx_dma.num_chan = 0;
> +	if (use_rx_dma)
> +		ntb_transport_setup_dma(pdev, &qp->rx_dma, num_rx_dma_chan ?: 1,
> +					node);
> +
> +	/* setup TX dma dest map */
> +	if (qp->tx_dma.num_chan > 0) {
> +		qp->tx_mw_dma_addr = kcalloc_node(qp->tx_dma.num_chan,
> +				sizeof(*qp->tx_mw_dma_addr), GFP_KERNEL, node);
> +		if (!qp->tx_mw_dma_addr)
> +			/* this sets qp->tx_dma.num_chan back to 0 */
> +			ntb_transport_teardown_dma(&qp->tx_dma, NULL, 0);
> +
> +		for (i = 0; i < qp->tx_dma.num_chan; i++) {
> +			c = qp->tx_dma.chan[i];
> +			mw_dma = dma_map_resource(c->device->dev,
> +						  qp->tx_mw_phys,
> +						  qp->tx_mw_size,
> +						  DMA_FROM_DEVICE, 0);
> +			if (dma_mapping_error(c->device->dev, mw_dma)) {
> +				dev_info(&pdev->dev,
> +					 "TX MW dma_map_resource failed for channel %u\n", i);
> +				break;
> +			}
> +			qp->tx_mw_dma_addr[i] = mw_dma;
>  		}
> +		if (qp->tx_dma.num_chan > 0 && i < qp->tx_dma.num_chan)
> +			/* this sets qp->tx_dma.num_chan back to 0 */
> +			ntb_transport_teardown_dma(&qp->tx_dma,
> +						   qp->tx_mw_dma_addr,
> +						   qp->tx_mw_size);
>  	}
>  
> -	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
> -		qp->tx_dma_chan ? "DMA" : "CPU");
> +	if (qp->tx_dma.num_chan > 0)
> +		dev_dbg(&pdev->dev, "Using DMA memcpy for TX (num_chan = %u)\n",
> +			qp->tx_dma.num_chan);
> +	else
> +		dev_dbg(&pdev->dev, "Using CPU memcpy for TX\n");
>  
> -	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
> -		qp->rx_dma_chan ? "DMA" : "CPU");
> +	if (qp->rx_dma.num_chan > 0)
> +		dev_dbg(&pdev->dev, "Using DMA memcpy for RX (num_chan = %u)\n",
> +			qp->rx_dma.num_chan);
> +	else
> +		dev_dbg(&pdev->dev, "Using CPU memcpy for RX\n");
>  
> +	/* alloc and link entries */
>  	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
>  		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
>  		if (!entry)
> -			goto err1;
> +			goto err;
>  
>  		entry->qp = qp;
>  		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> @@ -2109,7 +2263,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	for (i = 0; i < qp->tx_max_entry; i++) {
>  		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
>  		if (!entry)
> -			goto err2;
> +			goto err;
>  
>  		entry->qp = qp;
>  		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> @@ -2123,23 +2277,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  
>  	return qp;
>  
> -err2:
> +err:
>  	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
>  		kfree(entry);
> -err1:
> -	qp->rx_alloc_entry = 0;
>  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
>  		kfree(entry);
> -	if (qp->tx_mw_dma_addr)
> -		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> -				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> -				   DMA_FROM_DEVICE, 0);
> -	if (qp->tx_dma_chan)
> -		dma_release_channel(qp->tx_dma_chan);
> -	if (qp->rx_dma_chan)
> -		dma_release_channel(qp->rx_dma_chan);
> +	qp->rx_alloc_entry = 0;
> +
> +	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
> +	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
> +				   qp->tx_mw_size);
> +	kfree(qp->tx_mw_dma_addr);
> +	qp->tx_mw_dma_addr = NULL;
> +
>  	nt->qp_bitmap_free |= qp_bit;
> -err:
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
> @@ -2163,40 +2314,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  
>  	qp->active = false;
>  
> -	if (qp->tx_dma_chan) {
> -		struct dma_chan *chan = qp->tx_dma_chan;
> -		/* Putting the dma_chan to NULL will force any new traffic to be
> -		 * processed by the CPU instead of the DAM engine
> -		 */
> -		qp->tx_dma_chan = NULL;
> -
> -		/* Try to be nice and wait for any queued DMA engine
> -		 * transactions to process before smashing it with a rock
> -		 */
> -		dma_sync_wait(chan, qp->last_cookie);
> -		dmaengine_terminate_all(chan);
> -
> -		dma_unmap_resource(chan->device->dev,
> -				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> -				   DMA_FROM_DEVICE, 0);
> -
> -		dma_release_channel(chan);
> -	}
> -
> -	if (qp->rx_dma_chan) {
> -		struct dma_chan *chan = qp->rx_dma_chan;
> -		/* Putting the dma_chan to NULL will force any new traffic to be
> -		 * processed by the CPU instead of the DAM engine
> -		 */
> -		qp->rx_dma_chan = NULL;
> -
> -		/* Try to be nice and wait for any queued DMA engine
> -		 * transactions to process before smashing it with a rock
> -		 */
> -		dma_sync_wait(chan, qp->last_cookie);
> -		dmaengine_terminate_all(chan);
> -		dma_release_channel(chan);
> -	}
> +	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
> +	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
> +				   qp->tx_mw_size);
> +	kfree(qp->tx_mw_dma_addr);
> +	qp->tx_mw_dma_addr = NULL;
>  
>  	qp_bit = BIT_ULL(qp->qp_num);
>  
> @@ -2444,17 +2566,31 @@ EXPORT_SYMBOL_GPL(ntb_transport_qp_num);
>  unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
>  {
>  	unsigned int max_size;
> -	unsigned int copy_align;
> +	unsigned int copy_align = 0;
>  	struct dma_chan *rx_chan, *tx_chan;
> +	unsigned int i;
>  
>  	if (!qp)
>  		return 0;
>  
> -	rx_chan = qp->rx_dma_chan;
> -	tx_chan = qp->tx_dma_chan;
> -
> -	copy_align = max(rx_chan ? rx_chan->device->copy_align : 0,
> -			 tx_chan ? tx_chan->device->copy_align : 0);
> +	if (qp->rx_dma.chan) {
> +		for (i = 0; i < qp->rx_dma.num_chan; i++) {
> +			rx_chan = qp->rx_dma.chan[i];
> +			if (!rx_chan)
> +				continue;
> +			copy_align = max(copy_align,
> +					 rx_chan->device->copy_align);
> +		}
> +	}
> +	if (qp->tx_dma.chan) {
> +		for (i = 0; i < qp->tx_dma.num_chan; i++) {
> +			tx_chan = qp->tx_dma.chan[i];
> +			if (!tx_chan)
> +				continue;
> +			copy_align = max(copy_align,
> +					 tx_chan->device->copy_align);
> +		}
> +	}
>  
>  	/* If DMA engine usage is possible, try to find the max size for that */
>  	max_size = qp->tx_max_frame - sizeof(struct ntb_payload_header);

