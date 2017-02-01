Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com. [2607:f8b0:400d:c0d::242])
        by gmr-mx.google.com with ESMTPS id n10si2379724ywd.4.2017.02.01.10.09.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 10:09:47 -0800 (PST)
Received: by mail-qt0-x242.google.com with SMTP id n13so65679406qtc.0
        for <linux-ntb@googlegroups.com>; Wed, 01 Feb 2017 10:09:47 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 1 Feb 2017 13:09:44 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: ntb_perf missing dmaengine_unmap_put
Message-ID: <20170201180943.GA24153@kudzu.us>
References: <148581127718.58806.1803127910265426156.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148581127718.58806.1803127910265426156.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jan 30, 2017 at 02:21:17PM -0700, Dave Jiang wrote:
> In the normal I/O execution path, ntb_perf is missing a call to
> dmaengine_unmap_put() after submission. That causes us to leak
> unmap objects.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good to me.  Pulled into my ntb branch.

Given that this is a bug fix, we should probably start following the
new-ish standard of adding a "Fixes: " to this.  I'll add this one by
hand.  I believe it should be:

Fixes: 8a7b6a77 ("ntb: ntb perf tool")

Thanks,
Jon

> ---
>  drivers/ntb/test/ntb_perf.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e75d4fd..434e1d4 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -265,6 +265,8 @@ static ssize_t perf_copy(struct pthr_ctx *pctx, char __iomem *dst,
>  	if (dma_submit_error(cookie))
>  		goto err_set_unmap;
>  
> +	dmaengine_unmap_put(unmap);
> +
>  	atomic_inc(&pctx->dma_sync);
>  	dma_async_issue_pending(chan);
>  
> 
