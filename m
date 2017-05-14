Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com. [2607:f8b0:400d:c0d::243])
        by gmr-mx.google.com with ESMTPS id f9si967448ywh.6.2017.05.14.06.33.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 May 2017 06:33:26 -0700 (PDT)
Received: by mail-qt0-x243.google.com with SMTP id r58so12352939qtb.2
        for <linux-ntb@googlegroups.com>; Sun, 14 May 2017 06:33:26 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 14 May 2017 09:33:23 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH V3 3/3] ntb: Add more debugfs support for ntb_perf
 testing options
Message-ID: <20170514133323.GB6027@kudzu.us>
References: <20170509142856.12995.96207.stgit@taos.amd.com>
 <20170509143336.12995.17807.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509143336.12995.17807.stgit@taos.amd.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: linux-ntb@googlegroups.com, Allen.Hubbe@emc.com, dave.jiang@intel.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 09, 2017 at 09:33:36AM -0500, Gary R Hook wrote:
> The ntb_perf tool uses module parameters to control the
> characteristics of its test.  Enable the changing of these
> options through debugfs, and eliminating the need to unload
> and reload the module to make changes and run additional tests.
> 
> Add a new module parameter that forces the DMA channel
> selection onto the same node as the NTB device (default: true).
> 
>  - seg_order: Size of the NTB memory window; power of 2.
>  - run_order: Size of the data buffer; power of 2.
>  - use_dma:   Use DMA or memcpy? Default: 0.
>  - on_node:   Only use DMA channel(s) on the NTB node. Default: true.
> 
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 60e0dd320aef..6fdddf86269e 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -737,6 +737,10 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
>  	struct dentry *debugfs_node_dir;
>  	struct dentry *debugfs_run;
>  	struct dentry *debugfs_threads;
> +	struct dentry *debugfs_seg_order;
> +	struct dentry *debugfs_run_order;
> +	struct dentry *debugfs_use_dma;
> +	struct dentry *debugfs_on_node;
>  
>  	if (!debugfs_initialized())
>  		return -ENODEV;
> @@ -764,6 +768,30 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
>  	if (!debugfs_threads)
>  		return -ENODEV;
>  
> +	debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
> +					       debugfs_node_dir,
> +					       &seg_order);
> +	if (!debugfs_seg_order)
> +		return -ENODEV;
> +
> +	debugfs_run_order = debugfs_create_u32("run_order", 0600,
> +					       debugfs_node_dir,
> +					       &run_order);
> +	if (!debugfs_run_order)
> +		return -ENODEV;
> +
> +	debugfs_use_dma = debugfs_create_bool("use_dma", 0600,
> +					       debugfs_node_dir,
> +					       &use_dma);
> +	if (!debugfs_use_dma)
> +		return -ENODEV;
> +
> +	debugfs_on_node = debugfs_create_bool("on_node", 0600,
> +					      debugfs_node_dir,
> +					      &on_node);
> +	if (!debugfs_on_node)
> +		return -ENODEV;
> +

Similar to my other comment, I would like to see an error path that
unrolls the creation of these on error.  It is okay to do this in a
follow-on patch.

Thanks,
Jon

>  	return 0;
>  }
>  
> 
