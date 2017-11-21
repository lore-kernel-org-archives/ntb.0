Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w196si870850vkd.2.2017.11.21.15.06.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:06:47 -0800 (PST)
References: <20171121225945.29377-1-colin.king@canonical.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dda6fccc-093a-7f1c-87a1-d01a8d8aacb8@deltatee.com>
Date: Tue, 21 Nov 2017 16:06:41 -0700
MIME-Version: 1.0
In-Reply-To: <20171121225945.29377-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming" ->
 "performing"
To: Colin King <colin.king@canonical.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Thanks Colin!

Reviewed-By: Logan Gunthorpe <logang@deltatee.com>

On 21/11/17 03:59 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index afe8ed6f3b23..d46d113210b5 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -172,7 +172,7 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
>   
>   	if (ps == status) {
>   		dev_err(&sndev->stdev->dev,
> -			"Timed out while peforming %s (%d). (%08x)",
> +			"Timed out while performing %s (%d). (%08x)",
>   			op_text[op], op,
>   			ioread32(&ctl->partition_status));
>   
> 
