Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com. [2607:f8b0:4864:20::b36])
        by gmr-mx.google.com with ESMTPS id 3si1154230ott.3.2018.10.31.13.34.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:34:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t13-v6so1086375ybb.8
        for <linux-ntb@googlegroups.com>; Wed, 31 Oct 2018 13:34:45 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 31 Oct 2018 16:34:42 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular
 NULL checks
Message-ID: <20181031203441.GB22474@kudzu.us>
References: <20180827221306.GA8936@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827221306.GA8936@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 27, 2018 at 05:13:06PM -0500, Gustavo A. R. Silva wrote:
> Both devm_kcalloc() and devm_kzalloc() return NULL on error. They
> never return error pointers.
> 
> The use of IS_ERR_OR_NULL is currently applied to the wrong
> context.
> 
> Fix this by replacing IS_ERR_OR_NULL with regular NULL checks.
> 
> Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index dbe72f1..a67ef23 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -1105,9 +1105,9 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  	}
>  
>  	/* Allocate memory for memory window descriptors */
> -	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt,
> -				sizeof(*ret_mws), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(ret_mws))
> +	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
> +			       GFP_KERNEL);
> +	if (!ret_mws)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Copy the info of detected memory windows */
> @@ -2390,7 +2390,7 @@ static struct idt_ntb_dev *idt_create_dev(struct pci_dev *pdev,
>  
>  	/* Allocate memory for the IDT PCIe-device descriptor */
>  	ndev = devm_kzalloc(&pdev->dev, sizeof(*ndev), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(ndev)) {
> +	if (!ndev) {
>  		dev_err(&pdev->dev, "Memory allocation failed for descriptor");
>  		return ERR_PTR(-ENOMEM);
>  	}
> -- 
> 2.7.4
> 
