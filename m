Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h14si388046plr.2.2019.07.08.09.18.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:18:16 -0700 (PDT)
References: <20190708155717.wh4vweidewab4dpz@yadro.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a9344325-4d43-ff3c-37ca-ecd948cce41f@deltatee.com>
Date: Mon, 8 Jul 2019 10:18:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190708155717.wh4vweidewab4dpz@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning error
 if size == 0
To: Alexander Fomichev <fomichev.ru@gmail.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-07-08 9:57 a.m., Alexander Fomichev wrote:
> ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> addr == 0. But error in xlate_pos checking condition prevents this.
> Fix the condition to make ntb_mw_clear_trans working.

Nice catch, but you'll need to resubmit the patch with a Signed-off-by
line. Please see [1].

When you do, you can also add:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan

[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin


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
> 
