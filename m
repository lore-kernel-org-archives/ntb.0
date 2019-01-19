Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id x17si163080ior.3.2019.01.18.16.25.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:25:22 -0800 (PST)
Subject: Re: [PATCH] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
References: <20190119001001.13087-1-logang@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <34680d2e-ec3f-7cb4-4f42-2398fc14dd5e@intel.com>
Date: Fri, 18 Jan 2019 17:25:20 -0700
MIME-Version: 1.0
In-Reply-To: <20190119001001.13087-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 1/18/19 5:10 PM, Logan Gunthorpe wrote:
> Presently, when ntb_transport is used with DMA and the IOMMU turned on,
> it fails with errors from the IOMMU such as:
> 
>   DMAR: DRHD: handling fault status reg 202
>   DMAR: [DMA Write] Request device [00:04.0] fault addr
> 	381fc0340000 [fault reason 05] PTE Write access is not set
> 
> This is because ntb_transport does not map the BAR space with the IOMMU.
> 
> To fix this, we map the entire MW region for each QP after we assign
> the DMA channel. This prevents needing an extra DMA map in the fast
> path.
> 
> Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>

Nice! I actually never encountered this on the Intel NTB with IOMMU on.
It also could be that the Intel BIOS already took care of it for all
embedded device BARs on the uncore. Nevertheless it's needed. Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3bfdb4562408..526b65afc16a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -144,7 +144,9 @@ struct ntb_transport_qp {
>  	struct list_head tx_free_q;
>  	spinlock_t ntb_tx_free_q_lock;
>  	void __iomem *tx_mw;
> -	dma_addr_t tx_mw_phys;
> +	phys_addr_t tx_mw_phys;
> +	size_t tx_mw_size;
> +	dma_addr_t tx_mw_dma_addr;
>  	unsigned int tx_index;
>  	unsigned int tx_max_entry;
>  	unsigned int tx_max_frame;
> @@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	tx_size = (unsigned int)mw_size / num_qps_mw;
>  	qp_offset = tx_size * (qp_num / mw_count);
>  
> +	qp->tx_mw_size = tx_size;
>  	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
>  	if (!qp->tx_mw)
>  		return -EINVAL;
> @@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	dma_cookie_t cookie;
>  
>  	device = chan->device;
> -	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
> +	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
>  	dest_off = (size_t)dest & ~PAGE_MASK;
>  
> @@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  		qp->rx_dma_chan = NULL;
>  	}
>  
> +	if (qp->tx_dma_chan) {
> +		qp->tx_mw_dma_addr =
> +			dma_map_resource(qp->tx_dma_chan->device->dev,
> +					 qp->tx_mw_phys, qp->tx_mw_size,
> +					 DMA_FROM_DEVICE, 0);
> +		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> +				      qp->tx_mw_dma_addr)) {
> +			qp->tx_mw_dma_addr = 0;
> +			goto err1;
> +		}
> +	}
> +
>  	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
>  		qp->tx_dma_chan ? "DMA" : "CPU");
>  
> @@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->rx_alloc_entry = 0;
>  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
>  		kfree(entry);
> +	if (qp->tx_mw_dma_addr)
> +		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> +				   DMA_FROM_DEVICE, 0);
>  	if (qp->tx_dma_chan)
>  		dma_release_channel(qp->tx_dma_chan);
>  	if (qp->rx_dma_chan)
> @@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  		 */
>  		dma_sync_wait(chan, qp->last_cookie);
>  		dmaengine_terminate_all(chan);
> +
> +		dma_unmap_resource(chan->device->dev,
> +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> +				   DMA_FROM_DEVICE, 0);
> +
>  		dma_release_channel(chan);
>  	}
>  
> 
