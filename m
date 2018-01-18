Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com. [2607:f8b0:400d:c0d::242])
        by gmr-mx.google.com with ESMTPS id h22si749710qkj.1.2018.01.18.14.30.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 14:30:12 -0800 (PST)
Received: by mail-qt0-x242.google.com with SMTP id z11so8465262qtm.3
        for <linux-ntb@googlegroups.com>; Thu, 18 Jan 2018 14:30:12 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 18 Jan 2018 17:30:10 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2 2/2] ntb_hw_switchtec: Check for alignment of the
 buffer in mw_set_trans()
Message-ID: <20180118223010.GD25893@kudzu.us>
References: <20171218182506.5219-1-logang@deltatee.com>
 <20171218182506.5219-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218182506.5219-2-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Allen.Hubbe@dell.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 18, 2017 at 11:25:06AM -0700, Logan Gunthorpe wrote:
> With Switchtec hardware, the buffer used for a memory window must be
> aligned to its size (the hardware only replaces the lower bits). In
> certain circumstances dma_alloc_coherent() will not provide a buffer
> that adheres to this requirement like when using the CMA and
> CONFIG_CMA_ALIGNMENT is set lower than the buffer size.
> 
> When we get an unaligned buffer mw_set_trans() should return an error.
> We also log an error so we know the cause of the problem.
> 

Applied to ntb-next.

Thanks,
Jon

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> ---
> 
> v2: Use IS_ALIGNED macro as suggested by Allen
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index bcd5b6fb3800..6c6f991999b5 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -320,6 +320,19 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (xlate_pos < 12)
>  		return -EINVAL;
> 
> +	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> +		/*
> +		 * In certain circumstances we can get a buffer that is
> +		 * not aligned to its size. (Most of the time
> +		 * dma_alloc_coherent ensures this). This can happen when
> +		 * using large buffers allocated by the CMA
> +		 * (see CMA_CONFIG_ALIGNMENT)
> +		 */
> +		dev_err(&sndev->stdev->dev,
> +			"ERROR: Memory window address is not aligned to it's size!\n");
> +		return -EINVAL;
> +	}
> +
>  	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
>  				   NTB_CTRL_PART_STATUS_LOCKED);
>  	if (rc)
> --
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20171218182506.5219-2-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
