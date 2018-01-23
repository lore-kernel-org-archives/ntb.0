Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b32si1038663uad.4.2018.01.23.08.36.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jan 2018 08:36:08 -0800 (PST)
References: <1516673361-170397-1-git-send-email-weiyongjun1@huawei.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <14b5eb05-c152-6a30-d590-881600a8a72f@deltatee.com>
Date: Tue, 23 Jan 2018 09:35:52 -0700
MIME-Version: 1.0
In-Reply-To: <1516673361-170397-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] ntb_hw_switchtec: Make function
 switchtec_ntb_remove() static
To: Wei Yongjun <weiyongjun1@huawei.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Looks good, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan


On 22/01/18 07:09 PM, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1552:6: warning:
>   symbol 'switchtec_ntb_remove' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index a1d547b6..f624ae2 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -1549,8 +1549,8 @@ static int switchtec_ntb_add(struct device *dev,
>   	return rc;
>   }
>   
> -void switchtec_ntb_remove(struct device *dev,
> -			  struct class_interface *class_intf)
> +static void switchtec_ntb_remove(struct device *dev,
> +				 struct class_interface *class_intf)
>   {
>   	struct switchtec_dev *stdev = to_stdev(dev);
>   	struct switchtec_ntb *sndev = stdev->sndev;
> 
