Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com. [2607:f8b0:4864:20::c42])
        by gmr-mx.google.com with ESMTPS id z137-v6si805880iof.2.2018.10.31.13.13.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:13:58 -0700 (PDT)
Received: by mail-yw1-xc42.google.com with SMTP id v1-v6so7010758ywv.6
        for <linux-ntb@googlegroups.com>; Wed, 31 Oct 2018 13:13:58 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 31 Oct 2018 16:13:55 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: intel: fix return value for ndev_vec_mask()
Message-ID: <20181031201354.GA22474@kudzu.us>
References: <153550163921.39832.16483542818926290854.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153550163921.39832.16483542818926290854.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, allenbh@gmail.com, lucas.van@intel.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 28, 2018 at 05:13:59PM -0700, Dave Jiang wrote:
> ndev_vec_mask() should be returning u64 mask value instead of int.
> Otherwise the mask value returned can be incorrect for larger
> vectors.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Lucas Van <lucas.van@intel.com>

Pulled into my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen1.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 6aa573227279..2ad263f708da 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -265,7 +265,7 @@ static inline int ndev_db_clear_mask(struct intel_ntb_dev *ndev, u64 db_bits,
>  	return 0;
>  }
>  
> -static inline int ndev_vec_mask(struct intel_ntb_dev *ndev, int db_vector)
> +static inline u64 ndev_vec_mask(struct intel_ntb_dev *ndev, int db_vector)
>  {
>  	u64 shift, mask;
>  
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/153550163921.39832.16483542818926290854.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
