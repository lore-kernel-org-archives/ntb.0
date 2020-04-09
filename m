Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com. [2607:f8b0:4864:20::f41])
        by gmr-mx.google.com with ESMTPS id a141si894734pfd.5.2020.04.09.11.08.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:08:35 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id bu9so5944768qvb.13
        for <linux-ntb@googlegroups.com>; Thu, 09 Apr 2020 11:08:35 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 9 Apr 2020 14:08:32 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: Fix static check warning in perf_clear_test
Message-ID: <20200409180831.GB21666@kudzu.us>
References: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
To: Jiasen Lin <linjiasen@hygon.cn>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, dan.carpenter@oracle.com, allenbh@gmail.com, dave.jiang@intel.com, zhangpanyong@hygon.cn
List-ID: <linux-ntb.googlegroups.com>

On Thu, Apr 09, 2020 at 12:11:24AM -0700, Jiasen Lin wrote:
> As pthr->dma_chan can't be NULL in this context, so there is
> no need to check pthr->dma_chan.
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>

Pulled into my ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/test/ntb_perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 972f6d9..f73b126 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1010,8 +1010,8 @@ static void perf_clear_test(struct perf_thread *pthr)
>  				   pthr->perf->test_peer->dma_dst_addr,
>  				   pthr->perf->test_peer->outbuf_size,
>  				   DMA_FROM_DEVICE, 0);
> -	if (pthr->dma_chan)
> -		dma_release_channel(pthr->dma_chan);
> +
> +	dma_release_channel(pthr->dma_chan);
>  
>  no_dma_notify:
>  	atomic_dec(&perf->tsync);
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1586416284-3246-1-git-send-email-linjiasen%40hygon.cn.
