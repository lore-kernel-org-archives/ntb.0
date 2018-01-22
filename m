Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x22e.google.com (mail-lf0-x22e.google.com. [2a00:1450:4010:c07::22e])
        by gmr-mx.google.com with ESMTPS id v10si2242131wrv.5.2018.01.22.02.02.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 02:02:28 -0800 (PST)
Received: by mail-lf0-x22e.google.com with SMTP id m8so9828887lfc.6
        for <linux-ntb@googlegroups.com>; Mon, 22 Jan 2018 02:02:28 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Mon, 22 Jan 2018 13:02:39 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH][next] NTB: ntb_tool: fix memory leak on 'buf' on error
 exit path
Message-ID: <20180122100239.GA32024@mobilestation>
References: <20180122093857.2174-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122093857.2174-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jan 22, 2018 at 09:38:57AM +0000, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is a memory leak on buf when the call to ntb_mw_get_align
> fails.  Add an exit err label and jump to this so that kfree on buf frees
> the memory.
> 
> Detected by CoverityScan, CID#1464286 ("Resource leak")
> 
> Fixes: d637628ce00c ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch, thanks!

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 920fc9b161b0..d592c0ffbd19 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -659,7 +659,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
>  	ret = ntb_mw_get_align(inmw->tc->ntb, inmw->pidx, inmw->widx,
>  			       &addr_align, &size_align, &size_max);
>  	if (ret)
> -		return ret;
> +		goto err;
>  
>  	off += scnprintf(buf + off, buf_size - off,
>  			 "Inbound MW     \t%d\n",
> @@ -694,6 +694,8 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 &size_max);
>  
>  	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
> +
> +err:
>  	kfree(buf);
>  
>  	return ret;
> -- 
> 2.15.1
> 
