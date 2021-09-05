Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com. [2a00:1450:4864:20::230])
        by gmr-mx.google.com with ESMTPS id w12si312061edj.5.2021.09.05.08.35.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 08:35:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g14so6855986ljk.5
        for <linux-ntb@googlegroups.com>; Sun, 05 Sep 2021 08:35:55 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sun, 5 Sep 2021 18:35:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] ntb: ntb_pingpong: remove redundant initialization of
 variables msg_data and spad_data
Message-ID: <20210905153553.nmmgv7w3t3oeqtca@mobilestation>
References: <20210609112128.184667-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609112128.184667-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jun 09, 2021 at 12:21:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variables msg_data and spad_data are being initialized with values
> that are never read, they are being updated later on. The initializations
> are redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wow, missed this in my emails log. Thanks for the cleanup.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 2164e8492772..8aeca7914050 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -187,7 +187,7 @@ static void pp_ping(struct pp_ctx *pp)
>  
>  static void pp_pong(struct pp_ctx *pp)
>  {
> -	u32 msg_data = -1, spad_data = -1;
> +	u32 msg_data, spad_data;
>  	int pidx = 0;
>  
>  	/* Read pong data */
> -- 
> 2.31.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20210609112128.184667-1-colin.king%40canonical.com.
