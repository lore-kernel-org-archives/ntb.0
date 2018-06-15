Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id l23-v6si92273lfc.5.2018.06.15.12.49.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:49:32 -0700 (PDT)
Received: by mail-lf0-x241.google.com with SMTP id t2-v6so9847848lfd.6
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:49:32 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:49:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 5/8] NTB: perf: Don't require one more memory window than
 number of peers
Message-ID: <20180615194940.GA25252@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-6-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:15PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> ntb_perf should not require more than one memory window per peer. This
> was probably an off-by-one error.
> 

Good catch. Thanks. IDT got a lot of MWs especially if LookUpTables are
enabled. That's why I didn't find the effect of this error.

Regards,
-Sergey

> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 2a9d6b0d1f19..fe27412ffe91 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -655,7 +655,7 @@ static int perf_init_service(struct perf_ctx *perf)
>  {
>  	u64 mask;
>  
> -	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
> +	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
>  		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-6-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
