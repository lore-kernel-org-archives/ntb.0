Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com. [2a00:1450:4864:20::22a])
        by gmr-mx.google.com with ESMTPS id p17si357114lfe.0.2021.06.05.11.05.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 11:05:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z22so24800ljh.8
        for <linux-ntb@googlegroups.com>; Sat, 05 Jun 2021 11:05:57 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 5 Jun 2021 21:05:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 1/2] NTB: perf: Fix an error code in perf_setup_inbuf()
Message-ID: <20210605180554.ql4rhpukj57ujkxw@mobilestation>
References: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hello Yang.

On Fri, Jun 04, 2021 at 06:20:50PM +0800, Yang Li wrote:
> When the function IS_ALIGNED() returns false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
> code 'ret'.

Great catch! Thanks for posing the fix. Indeed ret would zero in case of
unaligned buffer allocation. Though such situation is very improbable.
A tiny nitpick below.

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 89df135..c20b375 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -598,6 +598,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>  		return -ENOMEM;
>  	}
>  	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {

> +		ret = -ENOMEM;

I'd set -EINVAL here. In this case we do have enough memory, but the
base address is unaligned in a way the NTB hw requires. After fixing
that feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
>  		goto err_free_inbuf;
>  	}
> -- 
> 1.8.3.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1622802051-43464-1-git-send-email-yang.lee%40linux.alibaba.com.
