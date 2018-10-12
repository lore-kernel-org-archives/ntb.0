Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id j66-v6si95869otc.3.2018.10.12.13.52.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 13:52:51 -0700 (PDT)
Subject: Re: [PATCH] NTB: transport: Try harder to alloc an aligned MW buffer
References: <1539376503-7917-1-git-send-email-asierra@xes-inc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <fac38b33-bf9b-29ee-71ff-dc67b10976ed@intel.com>
Date: Fri, 12 Oct 2018 13:52:50 -0700
MIME-Version: 1.0
In-Reply-To: <1539376503-7917-1-git-send-email-asierra@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Aaron Sierra <asierra@xes-inc.com>, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 10/12/2018 01:35 PM, Aaron Sierra wrote:
> Be a little wasteful if the (likely CMA) message window buffer is not
> suitably aligned after our first attempt; allocate a buffer twice as big
> as we need and manually align our MW buffer within it.
> 
> This was needed on Intel Broadwell DE platforms with intel_iommu=off
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Thanks Aaron. That's very helpful.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 86 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 812efd4..c503a9e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -194,6 +194,8 @@ struct ntb_transport_mw {
>  	void __iomem *vbase;
>  	size_t xlat_size;
>  	size_t buff_size;
> +	size_t alloc_size;
> +	void *alloc_addr;
>  	void *virt_addr;
>  	dma_addr_t dma_addr;
>  };
> @@ -691,13 +693,59 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  		return;
>  
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> -	dma_free_coherent(&pdev->dev, mw->buff_size,
> -			  mw->virt_addr, mw->dma_addr);
> +	dma_free_coherent(&pdev->dev, mw->alloc_size,
> +			  mw->alloc_addr, mw->dma_addr);
>  	mw->xlat_size = 0;
>  	mw->buff_size = 0;
> +	mw->alloc_size = 0;
> +	mw->alloc_addr = NULL;
>  	mw->virt_addr = NULL;
>  }
>  
> +static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
> +			       struct device *dma_dev, size_t align)
> +{
> +	dma_addr_t dma_addr;
> +	void *alloc_addr, *virt_addr;
> +	int rc;
> +
> +	alloc_addr = dma_alloc_coherent(dma_dev, mw->alloc_size,
> +					&dma_addr, GFP_KERNEL);
> +	if (!alloc_addr) {
> +		dev_err(dma_dev, "Unable to alloc MW buff of size %zu\n",
> +			mw->alloc_size);
> +		return -ENOMEM;
> +	}
> +	virt_addr = alloc_addr;
> +
> +	/*
> +	 * we must ensure that the memory address allocated is BAR size
> +	 * aligned in order for the XLAT register to take the value. This
> +	 * is a requirement of the hardware. It is recommended to setup CMA
> +	 * for BAR sizes equal or greater than 4MB.
> +	 */
> +	if (!IS_ALIGNED(dma_addr, align)) {
> +		if (mw->alloc_size > mw->buff_size) {
> +			virt_addr = PTR_ALIGN(alloc_addr, align);
> +			dma_addr = ALIGN(dma_addr, align);
> +		} else {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +	}
> +
> +	mw->alloc_addr = alloc_addr;
> +	mw->virt_addr = virt_addr;
> +	mw->dma_addr = dma_addr;
> +
> +	return 0;
> +
> +err:
> +	dma_free_coherent(dma_dev, mw->alloc_size, alloc_addr, dma_addr);
> +
> +	return rc;
> +}
> +
>  static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  		      resource_size_t size)
>  {
> @@ -729,28 +777,20 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	/* Alloc memory for receiving data.  Must be aligned */
>  	mw->xlat_size = xlat_size;
>  	mw->buff_size = buff_size;
> +	mw->alloc_size = buff_size;
>  
> -	mw->virt_addr = dma_alloc_coherent(&pdev->dev, buff_size,
> -					   &mw->dma_addr, GFP_KERNEL);
> -	if (!mw->virt_addr) {
> -		mw->xlat_size = 0;
> -		mw->buff_size = 0;
> -		dev_err(&pdev->dev, "Unable to alloc MW buff of size %zu\n",
> -			buff_size);
> -		return -ENOMEM;
> -	}
> -
> -	/*
> -	 * we must ensure that the memory address allocated is BAR size
> -	 * aligned in order for the XLAT register to take the value. This
> -	 * is a requirement of the hardware. It is recommended to setup CMA
> -	 * for BAR sizes equal or greater than 4MB.
> -	 */
> -	if (!IS_ALIGNED(mw->dma_addr, xlat_align)) {
> -		dev_err(&pdev->dev, "DMA memory %pad is not aligned\n",
> -			&mw->dma_addr);
> -		ntb_free_mw(nt, num_mw);
> -		return -ENOMEM;
> +	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +	if (rc) {
> +		mw->alloc_size *= 2;
> +		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> +		if (rc) {
> +			dev_err(&pdev->dev,
> +				"Unable to alloc aligned MW buff\n");
> +			mw->xlat_size = 0;
> +			mw->buff_size = 0;
> +			mw->alloc_size = 0;
> +			return rc;
> +		}
>  	}
>  
>  	/* Notify HW the memory location of the receive buffer */
> 
