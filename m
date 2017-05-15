Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id c20si1990603pfh.1.2017.05.15.09.34.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 09:34:36 -0700 (PDT)
Subject: Re: [PATCH] ntb: Add error path/handling to Debug FS entry creation
References: <20170515153327.4400.83250.stgit@taos.amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <e8c142d8-33b4-a927-003c-caf2ec2c9276@intel.com>
Date: Mon, 15 May 2017 09:34:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170515153327.4400.83250.stgit@taos.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>



On 05/15/2017 08:33 AM, Gary R Hook wrote:
> If a failure occurs when creating Debug FS entries, unroll all of
> the work that's been done.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/ntb/test/ntb_perf.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6fdddf86269e..759f772fa00c 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -745,6 +745,7 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
>  	if (!debugfs_initialized())
>  		return -ENODEV;
>  
> +	/* Assumpion: only one NTB device in the system */
>  	if (!perf_debugfs_dir) {
>  		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>  		if (!perf_debugfs_dir)
> @@ -754,45 +755,50 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
>  	debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
>  					      perf_debugfs_dir);
>  	if (!debugfs_node_dir)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
>  					  debugfs_node_dir, perf,
>  					  &ntb_perf_debugfs_run);
>  	if (!debugfs_run)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
>  					    debugfs_node_dir,
>  					    &perf->perf_threads);
>  	if (!debugfs_threads)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
>  					       debugfs_node_dir,
>  					       &seg_order);
>  	if (!debugfs_seg_order)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_run_order = debugfs_create_u32("run_order", 0600,
>  					       debugfs_node_dir,
>  					       &run_order);
>  	if (!debugfs_run_order)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_use_dma = debugfs_create_bool("use_dma", 0600,
>  					       debugfs_node_dir,
>  					       &use_dma);
>  	if (!debugfs_use_dma)
> -		return -ENODEV;
> +		goto err;
>  
>  	debugfs_on_node = debugfs_create_bool("on_node", 0600,
>  					      debugfs_node_dir,
>  					      &on_node);
>  	if (!debugfs_on_node)
> -		return -ENODEV;
> +		goto err;
>  
>  	return 0;
> +
> +err:
> +	debugfs_remove_recursive(perf_debugfs_dir);
> +	perf_debugfs_dir = NULL;
> +	return -ENODEV;
>  }
>  
>  static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
> 
