Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id f20si1249246oig.3.2021.06.07.08.51.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:51:32 -0700 (PDT)
References: <1623045380-125394-1-git-send-email-yang.lee@linux.alibaba.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9182a6e0-541b-e350-d760-06623cb06855@deltatee.com>
Date: Mon, 7 Jun 2021 09:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <1623045380-125394-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] NTB: Fix an error code in ntb_msit_probe()
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2021-06-06 11:56 p.m., Yang Li wrote:
> When the value of nm->isr_ctx is false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing
> error code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> 
> Change in v2:
> --revise typo
> 
>  drivers/ntb/test/ntb_msi_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 7095ecd..4e18e08 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -369,8 +369,10 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  	if (ret)
>  		goto remove_dbgfs;
>  
> -	if (!nm->isr_ctx)
> +	if (!nm->isr_ctx) {
> +		ret = -ENOMEM;
>  		goto remove_dbgfs;
> +	}
>  
>  	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>  
> 
