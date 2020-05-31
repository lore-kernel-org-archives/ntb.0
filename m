Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com. [2607:f8b0:4864:20::f43])
        by gmr-mx.google.com with ESMTPS id x10si245701ila.3.2020.05.31.12.56.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 12:56:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j7so3544098qvp.2
        for <linux-ntb@googlegroups.com>; Sun, 31 May 2020 12:56:04 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 31 May 2020 15:56:02 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: intel: fix static declaration
Message-ID: <20200531195602.GE4620@kudzu.us>
References: <159051413389.47606.2615869180413030098.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159051413389.47606.2615869180413030098.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 26, 2020 at 10:28:53AM -0700, Dave Jiang wrote:
> intel_ntb4_link_disable() missing static declaration.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Pulled into the ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen4.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> index dcbd6d3cf7ae..af5c8feb2df8 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> @@ -498,7 +498,7 @@ static int intel_ntb4_link_enable(struct ntb_dev *ntb,
>  	return 0;
>  }
>  
> -int intel_ntb4_link_disable(struct ntb_dev *ntb)
> +static int intel_ntb4_link_disable(struct ntb_dev *ntb)
>  {
>  	struct intel_ntb_dev *ndev;
>  	u32 ntb_cntl;
> 
