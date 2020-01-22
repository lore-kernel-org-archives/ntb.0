Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com. [2a00:1450:4864:20::241])
        by gmr-mx.google.com with ESMTPS id p20si2010148lji.1.2020.01.22.05.15.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 05:15:14 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y4so6733150ljj.9
        for <linux-ntb@googlegroups.com>; Wed, 22 Jan 2020 05:15:14 -0800 (PST)
Return-Path: <fomichev.ru@gmail.com>
Date: Wed, 22 Jan 2020 16:15:10 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans
 returning error if size == 0
Message-ID: <20200122131510.d5ckfj22idh56ef5@yadro.com>
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc: linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Somehow this patch was lost. The problem is still actual.
Please, add to upstream.

On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> addr == 0. But error in xlate_pos checking condition prevents this.
> Fix the condition to make ntb_mw_clear_trans working.
> 
> Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 1e2f627d3bac..19d46af19650 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
>  		return -EINVAL;
>  
> -	if (xlate_pos < 12)
> +	if (size != 0 && xlate_pos < 12)
>  		return -EINVAL;
>  
>  	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> -- 
> 2.17.1

-- 
Regards,
  Alexander
