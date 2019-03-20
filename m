Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com. [2607:f8b0:4864:20::c41])
        by gmr-mx.google.com with ESMTPS id v2si166974qka.0.2019.03.20.10.50.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:50:15 -0700 (PDT)
Received: by mail-yw1-xc41.google.com with SMTP id d132so2708788ywa.2
        for <linux-ntb@googlegroups.com>; Wed, 20 Mar 2019 10:50:15 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 20 Mar 2019 13:50:12 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Message-ID: <20190320175011.GA27156@kudzu.us>
References: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Feb 15, 2019 at 09:20:07AM +0000, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> while waiting for the peer ntb_perf to initialize scratchpad
> registers, local side ntb_perf  might have already exhausted the
> maximum number of retries which is currently set to 500. To avoid
> this and to give little more time to the peer ntb_perf for scratchpad
> initialization, increased the number of retries to 1000
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>

Series applied to my ntb branch.

Thanks,
Jon


> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 2a9d6b0..a828d0e 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -100,7 +100,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
>  #define DMA_TRIES		100
>  #define DMA_MDELAY		10
>  
> -#define MSG_TRIES		500
> +#define MSG_TRIES		1000
>  #define MSG_UDELAY_LOW		1000
>  #define MSG_UDELAY_HIGH		2000
>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1550222279-27216-1-git-send-email-Sanju.Mehta%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
