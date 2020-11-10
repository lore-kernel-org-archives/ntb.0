Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com. [2a00:1450:4864:20::144])
        by gmr-mx.google.com with ESMTPS id m18si393609lfr.11.2020.11.10.10.33.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 10:33:43 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a25so10130965lfb.2
        for <linux-ntb@googlegroups.com>; Tue, 10 Nov 2020 10:33:43 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 10 Nov 2020 21:33:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] ntb: idt: fix error check in ntb_hw_idt.c
Message-ID: <20201110183340.77xcobfsnz43vsa2@mobilestation>
References: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
To: Wang Qing <wangqing@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hello Wang

On Fri, Nov 06, 2020 at 05:43:31PM +0800, Wang Qing wrote:
> idt_create_dev never return NULL and fix smatch warning.

Thanks for submitting this. For the both changes
Acked-by: Serge Semin <fancer.lancer@gmail.com>

They are mostly unrelated though. If they weren't trivial I'd have
suggested to split them up into the dedicated patches. Since they
aren't I suppose leaving the patch 'as is' is ok, unless the subsystem
maintainer thinks differently.

-Sergey

> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index d54261f..e7a4c2a
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2511,7 +2511,7 @@ static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
>  	/* If the top directory is not created then do nothing */
>  	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
>  		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> -		return PTR_ERR(dbgfs_topdir);
> +		return PTR_ERR_OR_ZERO(dbgfs_topdir);
>  	}
>  
>  	/* Create the info file node */
> @@ -2756,7 +2756,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
>  
>  	/* Allocate the memory for IDT NTB device data */
>  	ndev = idt_create_dev(pdev, id);
> -	if (IS_ERR_OR_NULL(ndev))
> +	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
>  	/* Initialize the basic PCI subsystem of the device */
> -- 
> 2.7.4
> 
