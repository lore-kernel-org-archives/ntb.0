Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id v25-v6si152506wmh.2.2018.06.15.12.47.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:47:40 -0700 (PDT)
Received: by mail-lf0-x242.google.com with SMTP id p23-v6so4537087lfh.11
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:47:40 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:47:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 1/8] NTB: ntb_tool: reading the link file should not end
 in a NULL byte
Message-ID: <20180615194748.GA15481@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-2-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:11PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When running ntb_test this warning is issued:
> 
> ./ntb_test.sh: line 200: warning: command substitution: ignored null
> byte in input
> 

This is weird. Neither me nor the folks' who tested the script saw this warning.
I tried it on my laptop with bash and on a target device with busybox-shell. The
warning never occurred. I even tried a simple command like:
[[ $(echo -ne "\x4e\x0a\00") == "N" ]] && echo "True"

It might be that your bash is more modern than mine. Anyway if this patch solves the
problem you see, that's great. Thanks for it.

-Sergey

> This is caused by the kernel returning one more byte than is necessary
> when reading the link file.
> 
> Reduce the number of bytes read back to 2 as it was before the
> commit that regressed this.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index d592c0ffbd19..ec5cf095cdb9 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -504,7 +504,7 @@ static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
>  	buf[1] = '\n';
>  	buf[2] = '\0';
>  
> -	return simple_read_from_buffer(ubuf, size, offp, buf, 3);
> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
>  }
>  
>  static TOOL_FOPS_RDWR(tool_peer_link_fops,
> @@ -1690,4 +1690,3 @@ static void __exit tool_exit(void)
>  	debugfs_remove_recursive(tool_dbgfs_topdir);
>  }
>  module_exit(tool_exit);
> -
> -- 
> 2.11.0
> 
