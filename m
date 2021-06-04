Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id w16si268090oov.0.2021.06.04.08.18.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:18:23 -0700 (PDT)
References: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
 <1622802051-43464-2-git-send-email-yang.lee@linux.alibaba.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <490f9031-7a12-6031-7262-f38cd96cb502@deltatee.com>
Date: Fri, 4 Jun 2021 09:18:17 -0600
MIME-Version: 1.0
In-Reply-To: <1622802051-43464-2-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] NTB: Fix an error code in ntb_msit_probe()
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>




On 2021-06-04 4:20 a.m., Yang Li wrote:
> When the value of nm->isr_ctx is false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing error
> code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/ntb/test/ntb_msi_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 7095ecd..5f9e0be 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -369,8 +369,10 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  	if (ret)
>  		goto remove_dbgfs;
>  
> -	if (!nm->isr_ctx)
> +	if (!nm->isr_ctx) {
> +		return -ENOMEM;
>  		goto remove_dbgfs;

I think you made a typo here. You probably meant ret = -ENOMEM.

Thanks,

Logan
