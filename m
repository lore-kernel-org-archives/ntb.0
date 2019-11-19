Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w63si904057pgd.2.2019.11.19.08.50.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 08:50:18 -0800 (PST)
References: <1574136121-7941-1-git-send-email-linjiasen@hygon.cn>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c487042e-471b-dd99-37a6-2119b4115283@deltatee.com>
Date: Tue, 19 Nov 2019 09:50:08 -0700
MIME-Version: 1.0
In-Reply-To: <1574136121-7941-1-git-send-email-linjiasen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] NTB: ntb_perf: Fix address err in perf_copy_chunk
To: Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc: allenbh@gmail.com, dave.jiang@intel.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-11-18 9:02 p.m., Jiasen Lin wrote:
> peer->outbuf is a virtual address which is get by ioremap, it can not
> be converted to a physical address by virt_to_page and page_to_phys.
> This conversion will result in DMA error, because the destination address
> which is converted by page_to_phys is invalid.
> 
> This patch save the MMIO address of NTB BARx in perf_setup_peer_mw,
> and map the BAR space to DMA address after we assign the DMA channel.
> Then fill the destination address of DMA descriptor with this DMA address
> to guarantee that the address of memory write requests fall into
> memory window of NBT BARx with IOMMU enabled and disabled.
> 
> Changes since v1:
>   * Map NTB BARx MMIO address to DMA address after assign the DMA channel,
>     to ensure the destination address in valid. (per suggestion from Logan)
> 
> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>

Thanks, looks good to me except for the one nit below.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/test/ntb_perf.c | 69 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e9b7c2d..dfca7e1 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -149,7 +149,8 @@ struct perf_peer {
>  	u64 outbuf_xlat;
>  	resource_size_t outbuf_size;
>  	void __iomem *outbuf;
> -
> +	phys_addr_t out_phys_addr;
> +	dma_addr_t dma_dst_addr;
>  	/* Inbound MW params */
>  	dma_addr_t inbuf_xlat;
>  	resource_size_t inbuf_size;
> @@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
>  }
>  
>  static int perf_copy_chunk(struct perf_thread *pthr,
> -			   void __iomem *dst, void *src, size_t len)
> +			   void __iomem *dst, void *src, size_t len,
> +			   dma_addr_t dst_dma_addr)
>  {
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_unmap_data *unmap;
> @@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	}
>  	unmap->to_cnt = 1;
>  
> -	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
> -		offset_in_page(dst), len, DMA_FROM_DEVICE);
> +	unmap->addr[1] = dst_dma_addr;
>  	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
>  		ret = -EIO;
>  		goto err_free_resource;
> @@ -865,6 +866,7 @@ static int perf_init_test(struct perf_thread *pthr)
>  {
>  	struct perf_ctx *perf = pthr->perf;
>  	dma_cap_mask_t dma_mask;
> +	struct perf_peer *peer = pthr->perf->test_peer;
>  
>  	pthr->src = kmalloc_node(perf->test_peer->outbuf_size, GFP_KERNEL,
>  				 dev_to_node(&perf->ntb->dev));
> @@ -882,15 +884,33 @@ static int perf_init_test(struct perf_thread *pthr)
>  	if (!pthr->dma_chan) {
>  		dev_err(&perf->ntb->dev, "%d: Failed to get DMA channel\n",
>  			pthr->tidx);
> -		atomic_dec(&perf->tsync);
> -		wake_up(&perf->twait);
> -		kfree(pthr->src);
> -		return -ENODEV;
> +		goto err_free;
> +	}
> +	peer->dma_dst_addr =
> +		dma_map_resource(pthr->dma_chan->device->dev,
> +				 peer->out_phys_addr, peer->outbuf_size,
> +				 DMA_FROM_DEVICE, 0);
> +	if (dma_mapping_error(pthr->dma_chan->device->dev,
> +			      peer->dma_dst_addr)) {
> +		dev_err(pthr->dma_chan->device->dev, "%d: Failed to map DMA addr\n",
> +			pthr->tidx);
> +		peer->dma_dst_addr = 0;
> +		dma_release_channel(pthr->dma_chan);
> +		goto err_free;
>  	}
> +	dev_dbg(pthr->dma_chan->device->dev, "%d: Map MMIO %pa to DMA addr %pad\n",
> +			pthr->tidx,
> +			&peer->out_phys_addr,
> +			&peer->dma_dst_addr);
>  
>  	atomic_set(&pthr->dma_sync, 0);
> -
>  	return 0;
> +
> +err_free:
> +	atomic_dec(&perf->tsync);
> +	wake_up(&perf->twait);
> +	kfree(pthr->src);
> +	return -ENODEV;
>  }
>  
>  static int perf_run_test(struct perf_thread *pthr)
> @@ -901,6 +921,8 @@ static int perf_run_test(struct perf_thread *pthr)
>  	u64 total_size, chunk_size;
>  	void *flt_src;
>  	int ret = 0;
> +	dma_addr_t flt_dma_addr;
> +	dma_addr_t bnd_dma_addr;
>  
>  	total_size = 1ULL << total_order;
>  	chunk_size = 1ULL << chunk_order;
> @@ -910,11 +932,15 @@ static int perf_run_test(struct perf_thread *pthr)
>  	bnd_dst = peer->outbuf + peer->outbuf_size;
>  	flt_dst = peer->outbuf;
>  
> +	flt_dma_addr = peer->dma_dst_addr;
> +	bnd_dma_addr = peer->dma_dst_addr + peer->outbuf_size;
> +
>  	pthr->duration = ktime_get();
>  
>  	/* Copied field is cleared on test launch stage */
>  	while (pthr->copied < total_size) {
> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
> +				flt_dma_addr);
>  		if (ret) {
>  			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>  				pthr->tidx, ret);
> @@ -925,8 +951,15 @@ static int perf_run_test(struct perf_thread *pthr)
>  
>  		flt_dst += chunk_size;
>  		flt_src += chunk_size;
> -		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
> +		flt_dma_addr += chunk_size;
> +
> +		if (flt_dst >= bnd_dst ||
> +		    flt_dst < peer->outbuf ||
> +		    flt_dma_addr >= bnd_dma_addr ||

Nit: I'm pretty sure the check against bnd_dma_addr is redundant with
the check on bnd_dst.

> +		    flt_dma_addr < peer->dma_dst_addr) {
> +
>  			flt_dst = peer->outbuf;
> +			flt_dma_addr = peer->dma_dst_addr;
>  			flt_src = pthr->src;
>  		}
>  
> @@ -978,8 +1011,13 @@ static void perf_clear_test(struct perf_thread *pthr)
>  	 * We call it anyway just to be sure of the transfers completion.
>  	 */
>  	(void)dmaengine_terminate_sync(pthr->dma_chan);
> -
> -	dma_release_channel(pthr->dma_chan);
> +	if (pthr->perf->test_peer->dma_dst_addr)
> +		dma_unmap_resource(pthr->dma_chan->device->dev,
> +				   pthr->perf->test_peer->dma_dst_addr,
> +				   pthr->perf->test_peer->outbuf_size,
> +				   DMA_FROM_DEVICE, 0);
> +	if (pthr->dma_chan)
> +		dma_release_channel(pthr->dma_chan);
>  
>  no_dma_notify:
>  	atomic_dec(&perf->tsync);
> @@ -1195,6 +1233,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>  			"\tOut buffer addr 0x%pK\n", peer->outbuf);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> +			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
> +
> +		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buffer size %pa\n", &peer->outbuf_size);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> @@ -1388,6 +1429,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>  	if (!peer->outbuf)
>  		return -ENOMEM;
>  
> +	peer->out_phys_addr = phys_addr;
> +
>  	if (max_mw_size && peer->outbuf_size > max_mw_size) {
>  		peer->outbuf_size = max_mw_size;
>  		dev_warn(&peer->perf->ntb->dev,
> 
