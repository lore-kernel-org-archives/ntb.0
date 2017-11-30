Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v14si306578pfk.5.2017.11.30.14.16.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:16:59 -0800 (PST)
References: <20171130213910.21052-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <67533cef-83f0-05e4-1cb2-0071db3d8576@deltatee.com>
Date: Thu, 30 Nov 2017 15:16:57 -0700
MIME-Version: 1.0
In-Reply-To: <20171130213910.21052-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: Set dma mask and dma coherent mask to NTB devices
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 30/11/17 02:39 PM, Serge Semin wrote:
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index f0788aae05c9..3cfa46876239 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1020,6 +1020,10 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>   			goto err_dma_mask;
>   		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>   	}
> +	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> +					  dma_get_mask(&pdev->dev));
> +	if (rc)
> +		goto err_dma_mask;

I can't say I understand fully what this is solving. Perhaps you could 
explain it a little further in the commit message.

In any case, to me, it looks like it would be better in 
ntb_register_device() instead of every single driver.


> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 03b80d89b980..79e50a5f8902 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -112,7 +112,6 @@ int ntb_register_device(struct ntb_dev *ntb)
>   
>   	init_completion(&ntb->released);
>   
> -	memset(&ntb->dev, 0, sizeof(ntb->dev));
>   	ntb->dev.bus = &ntb_bus;
>   	ntb->dev.parent = &ntb->pdev->dev;
>   	ntb->dev.release = ntb_dev_release;
> 

This is unrelated to above. I agree it should probably be removed but 
I'd suggest it should be in its own commit with its own justification.

Thanks,

Logan
