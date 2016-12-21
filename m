Return-Path: <jdmason@kudzu.us>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com. [2607:f8b0:4002:c09::242])
        by gmr-mx.google.com with ESMTPS id z131si1880183ywz.4.2016.12.21.08.54.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:54:17 -0800 (PST)
Received: by mail-yb0-x242.google.com with SMTP id s74so614683ybi.3
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:54:17 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:54:14 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: fix SKX NTB config space size register offsets
Message-ID: <20161221165413.GD32599@kudzu.us>
References: <148164499341.194663.8632238363765425811.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148164499341.194663.8632238363765425811.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, Sandeep Mann <sandeep@purestorage.com>, Zachary Ross <zacharyx.ross@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 13, 2016 at 09:03:13AM -0700, Dave Jiang wrote:
> The offsets for the SZ registers are wrong. Updated.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reported-by: Sandeep Mann <sandeep@purestorage.com>
> Tested-by: Zachary Ross <zacharyx.ross@intel.com>

Applied to my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index 6e8c182..f2cf8a7 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -152,10 +152,10 @@
>  #define XEON_SPAD_COUNT			16
>  
>  /* Intel Skylake Xeon hardware */
> -#define SKX_IMBAR1SZ_OFFSET		0x00d1
> -#define SKX_IMBAR2SZ_OFFSET		0x00d5
> -#define SKX_EMBAR1SZ_OFFSET		0x00d3
> -#define SKX_EMBAR2SZ_OFFSET		0x00d6
> +#define SKX_IMBAR1SZ_OFFSET		0x00d0
> +#define SKX_IMBAR2SZ_OFFSET		0x00d1
> +#define SKX_EMBAR1SZ_OFFSET		0x00d2
> +#define SKX_EMBAR2SZ_OFFSET		0x00d3
>  #define SKX_DEVCTRL_OFFSET		0x0098
>  #define SKX_DEVSTS_OFFSET		0x009a
>  #define SKX_UNCERRSTS_OFFSET		0x014c
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/148164499341.194663.8632238363765425811.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
