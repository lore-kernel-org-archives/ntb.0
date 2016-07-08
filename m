Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id c11si171074pfc.2.2016.07.07.22.22.14
        for <linux-ntb@googlegroups.com>;
        Thu, 07 Jul 2016 22:22:14 -0700 (PDT)
Date: Fri, 8 Jul 2016 10:59:22 +0530
From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/5] dmaengine: Adding error handling flag
Message-ID: <20160708052922.GN12591@localhost>
References: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
 <146715571138.208762.7964180099092112652.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146715571138.208762.7964180099092112652.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: allen.hubbe@emc.com, jdmason@kudzu.us, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 28, 2016 at 04:15:11PM -0700, Dave Jiang wrote:
> Adding error flag for the call back descriptor to notify upper layer that
> an error has occurred with this particular DMA op.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  0 files changed
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0174337..6524881 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -453,6 +453,20 @@ struct dmaengine_unmap_data {
>  };
>  
>  /**
> + * enum err_result_flags - result of DMA operations
> + * @ERR_DMA_NONE - no errors
> + * @ERR_DMA_READ - DMA read error
> + * @ERR_DMA_WRITE - DMA write error
> + * @ERR_DMA_ABORT - Operation aborted
> + */
> +enum err_result_flags {
> +	ERR_DMA_NONE = 0,
> +	ERR_DMA_READ,
> +	ERR_DMA_WRITE,
> +	ERR_DMA_ABORT,
> +};
> +
> +/**
>   * struct dma_async_tx_descriptor - async transaction descriptor
>   * ---dma generic offload fields---
>   * @cookie: tracking cookie for this transaction, set to -EBUSY if
> @@ -480,6 +494,7 @@ struct dma_async_tx_descriptor {
>  	dma_async_tx_callback callback;
>  	void *callback_param;
>  	struct dmaengine_unmap_data *unmap;
> +	enum err_result_flags result;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	struct dma_async_tx_descriptor *next;
>  	struct dma_async_tx_descriptor *parent;

Okay this needs more thoughts IMHO. The only issue with this approach is
that it violates one of the base fundamentals of dmaengine descriptor
submission.

Client do not touch or use a descriptor after it has been submitted. Looking
at the results inside descriptor is not right.

Perhaps we can add a query of results in the cookie or add this in
tx_status, am not sure.

FWIW, we definitely need some kind of error reporting

Thanks
-- 
~Vinod
