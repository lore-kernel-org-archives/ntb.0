Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id c23-v6si75574wmb.0.2018.06.15.12.50.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:50:22 -0700 (PDT)
Received: by mail-lf0-x242.google.com with SMTP id n3-v6so16210463lfe.12
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:50:22 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:50:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 6/8] NTB: perf: Fix support for hardware that doesn't
 have port numbers
Message-ID: <20180615195030.GA25303@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-8-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:17PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> Legacy drivers do not have port numbers (but is reliably only two ports)
> and was broken by the recent commit that added mult-port support to
> ntb_perf. This is especially important to support the cross link
> topology which is perfectly symmetric and cannot assign unique port
> numbers easily.
> 

Please, see the comment to the patch 3/8. I explained everything there
including the fact, that the Intel/AMD drivers do have unique port numbers
assigned.

Regards,
-Sergey

> Hardware that returns zero for both the local port and the peer should
> just always use gidx=0 for the only peer.
> 
> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index fe27412ffe91..6285cb8515ac 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1417,6 +1417,16 @@ static int perf_init_peers(struct perf_ctx *perf)
>  	if (perf->gidx == -1)
>  		perf->gidx = pidx;
>  
> +	/*
> +	 * Hardware with only two ports may not have unique port
> +	 * numbers. In this case, the gidxs should all be zero.
> +	 */
> +	if (perf->pcnt == 1 &&  ntb_port_number(perf->ntb) == 0 &&
> +	    ntb_peer_port_number(perf->ntb, 0) == 0) {
> +		perf->gidx = 0;
> +		perf->peers[0].gidx = 0;
> +	}
> +
>  	for (pidx = 0; pidx < perf->pcnt; pidx++) {
>  		ret = perf_setup_peer_mw(&perf->peers[pidx]);
>  		if (ret)
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-8-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
