Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id h10si760682ljf.4.2018.01.23.00.55.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 00:55:19 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id a204so14073234lfa.2
        for <linux-ntb@googlegroups.com>; Tue, 23 Jan 2018 00:55:19 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 23 Jan 2018 11:55:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] ntb_perf: Fix an error code in perf_copy_chunk()
Message-ID: <20180123085531.GA17853@mobilestation>
References: <20180123083356.GC10091@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123083356.GC10091@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Gary R Hook <gary.hook@amd.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 23, 2018 at 11:33:56AM +0300, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We accidentally return success if dmaengine_submit() fails.  The fix is
> to preserve the error code from dma_submit_error().
> 

Yep, absolutely right. Thanks!

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 8de72f3fba4d..387e685063fc 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -828,7 +828,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	tx->callback_param = pthr;
>  	dma_set_unmap(tx, unmap);
>  
> -	if (dma_submit_error(dmaengine_submit(tx))) {
> +	ret = dma_submit_error(dmaengine_submit(tx));
> +	if (ret) {
>  		dmaengine_unmap_put(unmap);
>  		goto err_free_resource;
>  	}
