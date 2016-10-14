Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id um12si3220550pab.2.2016.10.14.10.07.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 10:07:14 -0700 (PDT)
Subject: Re: [patch] ntb_perf: potential info leak in debugfs
References: <20161014073418.GD15168@mwanda>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <2df67889-a7d5-2313-2828-3457115fbcfa@intel.com>
Date: Fri, 14 Oct 2016 10:07:13 -0700
MIME-Version: 1.0
In-Reply-To: <20161014073418.GD15168@mwanda>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>, Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 10/14/2016 12:34 AM, Dan Carpenter wrote:
> This is a static checker warning, not something I'm desperately
> concerned about.  But snprintf() returns the number of bytes that
> would have been copied if there were space.  We really care about the
> number of bytes that actually were copied so we should use scnprintf()
> instead.
> 
> It probably won't overrun, and in that case we may as well just use
> sprintf() but these sorts of things make static checkers and code
> reviewers happier.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>

> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6a50f20..2d9ca58 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -589,7 +589,7 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
>  		return -ENOMEM;
>  
>  	if (mutex_is_locked(&perf->run_mutex)) {
> -		out_off = snprintf(buf, 64, "running\n");
> +		out_off = scnprintf(buf, 64, "running\n");
>  		goto read_from_buf;
>  	}
>  
> @@ -600,14 +600,14 @@ static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
>  			break;
>  
>  		if (pctx->status) {
> -			out_off += snprintf(buf + out_off, 1024 - out_off,
> +			out_off += scnprintf(buf + out_off, 1024 - out_off,
>  					    "%d: error %d\n", i,
>  					    pctx->status);
>  			continue;
>  		}
>  
>  		rate = div64_u64(pctx->copied, pctx->diff_us);
> -		out_off += snprintf(buf + out_off, 1024 - out_off,
> +		out_off += scnprintf(buf + out_off, 1024 - out_off,
>  			"%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
>  			i, pctx->copied, pctx->diff_us, rate);
>  	}
> 
