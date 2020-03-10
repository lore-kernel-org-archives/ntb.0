Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e124si215537ywb.4.2020.03.10.14.21.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:21:04 -0700 (PDT)
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-2-git-send-email-sanju.mehta@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e700a5f6-1929-0d65-b204-c5bfde58f5f7@deltatee.com>
Date: Tue, 10 Mar 2020 15:21:00 -0600
MIME-Version: 1.0
In-Reply-To: <1583873694-19151-2-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] ntb_perf: refactor code for CPU and DMA transfers
To: Sanjay R Mehta <sanju.mehta@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2020-03-10 2:54 p.m., Sanjay R Mehta wrote:
> From: Arindam Nath <arindam.nath@amd.com>
> 
> This patch creates separate function to handle CPU
> and DMA transfers. Since CPU transfers use memcopy
> and DMA transfers use dmaengine APIs, these changes
> not only allow logical separation between the two,
> but also allows someone to clearly see the difference
> in the way the two are handled.
> 
> In the case of DMA, we DMA from system memory to the
> memory window(MW) of NTB, which is a MMIO region, we
> should not use dma_map_page() for mapping MW. The
> correct way to map a MMIO region is to use
> dma_map_resource(), so the code is modified
> accordingly.
> 
> dma_map_resource() expects physical address of the
> region to be mapped for DMA, we add a new field,
> outbuf_phys_addr, to struct perf_peer, and also
> another field, outbuf_dma_addr, to store the
> corresponding mapped address returned by the API.
> 
> Since the MW is contiguous, rather than mapping
> chunk-by-chunk, we map the entire MW before the
> actual DMA transfer happens. Then for each chunk,
> we simply pass offset into the mapped region and
> DMA to that region. Then later, we unmap the MW
> during perf_clear_test().
> 
> The above means that now we need to have different
> function parameters to deal with in the case of
> CPU and DMA transfers. In the case of CPU transfers,
> we simply need the CPU virtual addresses for memcopy,
> but in the case of DMA, we need dma_addr_t, which
> will be different from CPU physical address depending
> on whether IOMMU is enabled or not. Thus we now
> have two separate functions, perf_copy_chunk_cpu(),
> and perf_copy_chunk_dma() to take care of above
> consideration.
> 
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 141 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 105 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e9b7c2d..6d16628 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -149,6 +149,8 @@ struct perf_peer {
>  	u64 outbuf_xlat;
>  	resource_size_t outbuf_size;
>  	void __iomem *outbuf;
> +	phys_addr_t outbuf_phys_addr;
> +	dma_addr_t outbuf_dma_addr;
>  
>  	/* Inbound MW params */
>  	dma_addr_t inbuf_xlat;
> @@ -775,26 +777,24 @@ static void perf_dma_copy_callback(void *data)
>  	wake_up(&pthr->dma_wait);
>  }
>  
> -static int perf_copy_chunk(struct perf_thread *pthr,
> -			   void __iomem *dst, void *src, size_t len)
> +static int perf_copy_chunk_cpu(struct perf_thread *pthr,
> +			       void __iomem *dst, void *src, size_t len)
> +{
> +	memcpy_toio(dst, src, len);
> +
> +	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
> +}
> +
> +static int perf_copy_chunk_dma(struct perf_thread *pthr,
> +			       dma_addr_t dst, void *src, size_t len)
>  {
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_unmap_data *unmap;
>  	struct device *dma_dev;
>  	int try = 0, ret = 0;
>  
> -	if (!use_dma) {
> -		memcpy_toio(dst, src, len);
> -		goto ret_check_tsync;
> -	}
> -
>  	dma_dev = pthr->dma_chan->device->dev;
> -
> -	if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
> -				 offset_in_page(dst), len))
> -		return -EIO;

Can you please split this patch into multiple patches? It is hard to
review and part of the reason this code is such a mess is because we
merged large patches with a bunch of different changes rolled into one,
many of which didn't get sufficient reviewer attention.

Patches that refactor things shouldn't be making functional changes
(like adding dma_map_resources()).


> -static int perf_run_test(struct perf_thread *pthr)
> +static int perf_run_test_cpu(struct perf_thread *pthr)
>  {
>  	struct perf_peer *peer = pthr->perf->test_peer;
>  	struct perf_ctx *perf = pthr->perf;
> @@ -914,7 +903,7 @@ static int perf_run_test(struct perf_thread *pthr)
>  
>  	/* Copied field is cleared on test launch stage */
>  	while (pthr->copied < total_size) {
> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +		ret = perf_copy_chunk_cpu(pthr, flt_dst, flt_src, chunk_size);
>  		if (ret) {
>  			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>  				pthr->tidx, ret);
> @@ -937,6 +926,74 @@ static int perf_run_test(struct perf_thread *pthr)
>  	return 0;
>  }
>  
> +static int perf_run_test_dma(struct perf_thread *pthr)
> +{
> +	struct perf_peer *peer = pthr->perf->test_peer;
> +	struct perf_ctx *perf = pthr->perf;
> +	struct device *dma_dev;
> +	dma_addr_t flt_dst, bnd_dst;
> +	u64 total_size, chunk_size;
> +	void *flt_src;
> +	int ret = 0;
> +
> +	total_size = 1ULL << total_order;
> +	chunk_size = 1ULL << chunk_order;
> +	chunk_size = min_t(u64, peer->outbuf_size, chunk_size);
> +
> +	/* Map MW for DMA */
> +	dma_dev = pthr->dma_chan->device->dev;
> +	peer->outbuf_dma_addr = dma_map_resource(dma_dev,
> +						 peer->outbuf_phys_addr,
> +						 peer->outbuf_size,
> +						 DMA_FROM_DEVICE, 0);
> +	if (dma_mapping_error(dma_dev, peer->outbuf_dma_addr)) {
> +		dma_unmap_resource(dma_dev, peer->outbuf_dma_addr,
> +				   peer->outbuf_size, DMA_FROM_DEVICE, 0);
> +		return -EIO;
> +	}
> +
> +	flt_src = pthr->src;
> +	bnd_dst = peer->outbuf_dma_addr + peer->outbuf_size;
> +	flt_dst = peer->outbuf_dma_addr;
> +
> +	pthr->duration = ktime_get();
> +	/* Copied field is cleared on test launch stage */
> +	while (pthr->copied < total_size) {
> +		ret = perf_copy_chunk_dma(pthr, flt_dst, flt_src, chunk_size);
> +		if (ret) {
> +			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
> +				pthr->tidx, ret);
> +			return ret;
> +		}
> +

Honestly, this doesn't seem like a good approach to me. Duplicating the
majority of the perf_run_test() function is making the code more
complicated and harder to maintain.

You should be able to just selectively call dma_map_resources() in
perf_run_test(), or even in perf_setup_peer_mw() without needing to add
so much extra duplicate code.

Logan
