Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com. [2607:f8b0:4864:20::743])
        by gmr-mx.google.com with ESMTPS id bg1si430843plb.5.2020.08.24.07.53.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:53:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so7621596qkp.2
        for <linux-ntb@googlegroups.com>; Mon, 24 Aug 2020 07:53:21 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 24 Aug 2020 10:52:47 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [RESEND] NTB: hw: amd: fix an issue about leak system resources
Message-ID: <20200824145246.GB27238@kudzu.us>
References: <1597111197-28563-1-git-send-email-likaige@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597111197-28563-1-git-send-email-likaige@loongson.cn>
To: Kaige Li <likaige@loongson.cn>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 11, 2020 at 09:59:57AM +0800, Kaige Li wrote:
> The related system resources were not released when pci_set_dma_mask(),
> pci_set_consistent_dma_mask(), or pci_iomap() return error in the
> amd_ntb_init_pci() function. Add pci_release_regions() to fix it.
> 
> Signed-off-by: Kaige Li <likaige@loongson.cn>

Pulled into my ntb branch.  I added:
    Fixes: a1b3695820aa ("NTB: Add support for AMD PCI-Express Non-Transparent Bridge")

Thanks,
Jon

> ---
> 
> changed commit massage.
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 88e1db6..71428d8 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1203,6 +1203,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>  
>  err_dma_mask:
>  	pci_clear_master(pdev);
> +	pci_release_regions(pdev);
>  err_pci_regions:
>  	pci_disable_device(pdev);
>  err_pci_enable:
> -- 
> 2.1.0
> 
