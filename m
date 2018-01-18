Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22e.google.com (mail-qt0-x22e.google.com. [2607:f8b0:400d:c0d::22e])
        by gmr-mx.google.com with ESMTPS id p1si643841vke.4.2018.01.18.14.29.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 14:29:56 -0800 (PST)
Received: by mail-qt0-x22e.google.com with SMTP id f4so13411966qtj.6
        for <linux-ntb@googlegroups.com>; Thu, 18 Jan 2018 14:29:56 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 18 Jan 2018 17:29:54 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2 1/2] ntb_transport: Fix bug with max_mw_size parameter
Message-ID: <20180118222953.GC25893@kudzu.us>
References: <20171218182506.5219-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218182506.5219-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Allen.Hubbe@dell.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 18, 2017 at 11:25:05AM -0700, Logan Gunthorpe wrote:
> When using the max_mw_size parameter of ntb_transport to limit the size of
> the Memory windows, communication cannot be established and the queues
> freeze.
> 
> This is because the mw_size that's reported to the peer is correctly
> limited but the size used locally is not. So the MW is initialized
> with a buffer smaller than the window but the TX side is using the
> full window. This means the TX side will be writing to a region of the
> window that points nowhere.
> 
> This is easily fixed by applying the same limit to tx_size in
> ntb_transport_init_queue().

Applied to ntb-next.

Thanks,
Jon

> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 045e3dd4750e..9878c48826e3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1003,6 +1003,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	mw_base = nt->mw_vec[mw_num].phys_addr;
>  	mw_size = nt->mw_vec[mw_num].phys_size;
>  
> +	if (max_mw_size && mw_size > max_mw_size)
> +		mw_size = max_mw_size;
> +
>  	tx_size = (unsigned int)mw_size / num_qps_mw;
>  	qp_offset = tx_size * (qp_num / mw_count);
>  
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20171218182506.5219-1-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
