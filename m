Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com. [2607:f8b0:4864:20::842])
        by gmr-mx.google.com with ESMTPS id my14si319857pjb.0.2020.03.12.16.41.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 16:41:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e20so6030377qto.5
        for <linux-ntb@googlegroups.com>; Thu, 12 Mar 2020 16:41:06 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 12 Mar 2020 19:41:04 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_tool: Fix printk format
Message-ID: <20200312234103.GA13046@kudzu.us>
References: <20200114192247.GA30840@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114192247.GA30840@ls3530.fritz.box>
To: Helge Deller <deller@gmx.de>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 14, 2020 at 08:22:47PM +0100, Helge Deller wrote:
> The correct printk format is %pa or %pap, but not %pa[p].

Thanks, pulled into my ntb branch

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 7f46c8b3a5523 ("NTB: ntb_tool: Add full multi-port NTB API support")
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index d592c0ffbd19..69da758fe64c 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -678,19 +678,19 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 &inmw->dma_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Window Size    \t%pa[p]\n",
> +			 "Window Size    \t%pap\n",
>  			 &inmw->size);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Alignment      \t%pa[p]\n",
> +			 "Alignment      \t%pap\n",
>  			 &addr_align);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Size Alignment \t%pa[p]\n",
> +			 "Size Alignment \t%pap\n",
>  			 &size_align);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Size Max       \t%pa[p]\n",
> +			 "Size Max       \t%pap\n",
>  			 &size_max);
> 
>  	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
> @@ -907,16 +907,16 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 "Virtual address     \t0x%pK\n", outmw->io_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Phys Address        \t%pa[p]\n", &map_base);
> +			 "Phys Address        \t%pap\n", &map_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Mapping Size        \t%pa[p]\n", &map_size);
> +			 "Mapping Size        \t%pap\n", &map_size);
> 
>  	off += scnprintf(buf + off, buf_size - off,
>  			 "Translation Address \t0x%016llx\n", outmw->tr_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Window Size         \t%pa[p]\n", &outmw->size);
> +			 "Window Size         \t%pap\n", &outmw->size);
> 
>  	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
>  	kfree(buf);
