Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com. [2607:f8b0:4002:c07::234])
        by gmr-mx.google.com with ESMTPS id i138si1707566ywe.2.2016.01.17.19.21.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 19:21:20 -0800 (PST)
Received: by mail-yk0-x234.google.com with SMTP id a85so522153938ykb.1
        for <linux-ntb@googlegroups.com>; Sun, 17 Jan 2016 19:21:20 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 17 Jan 2016 22:20:03 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: Add more than just the first NTB to debugfs
Message-ID: <20160118032002.GB11303@kudzu.us>
References: <2d02b2a1ea097008718489de404dfd939b560979.1452689594.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d02b2a1ea097008718489de404dfd939b560979.1452689594.git.Allen.Hubbe@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 13, 2016 at 07:55:30AM -0500, Allen Hubbe wrote:
> Due to perf_debugfs_setup called only if the top level perf_debugfs_dir
> was not created, only the first NTB would be added to debugfs.
> 
> Instead, call perf_debugfs_setup for every NTB.  Check that
> perf_debugfs_dir exists in perf_debugfs_setup, and if necessary, create
> it there.
> 
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>

This was pulled into Dave's patch.  So, nothing to do here :)

Thanks,
Jon

> ---
> 
> Dave, if you like, you can just fix up your patch with this.
> 
>  drivers/ntb/test/ntb_perf.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dcf903584c43..5d60d59bd2d6 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -636,9 +636,16 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
>  {
>  	struct pci_dev *pdev = perf->ntb->pdev;
>  
> -	if (!perf_debugfs_dir)
> +	if (!debugfs_initialized())
>  		return -ENODEV;
>  
> +	if (!perf_debugfs_dir) {
> +		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +		if (!perf_debugfs_dir)
> +			return -ENODEV;
> +	}
> +
>  	perf->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
>  						    perf_debugfs_dir);
>  	if (!perf->debugfs_node_dir)
> @@ -691,15 +698,9 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>  	ntb_link_event(ntb);
>  
> -	if (debugfs_initialized() && !perf_debugfs_dir) {
> -		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -		if (!perf_debugfs_dir)
> -			goto err_ctx;
> -
> -		rc = perf_debugfs_setup(perf);
> -		if (rc)
> -			goto err_ctx;
> -	}
> +	rc = perf_debugfs_setup(perf);
> +	if (rc)
> +		goto err_ctx;
>  
>  	return 0;
>  
> -- 
> 2.5.3
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/2d02b2a1ea097008718489de404dfd939b560979.1452689594.git.Allen.Hubbe%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
