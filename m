Return-Path: <lorenzo.pieralisi@arm.com>
Received: from foss.arm.com (foss.arm.com. [217.140.110.172])
        by gmr-mx.google.com with ESMTP id y189si804211oia.4.2021.02.12.09.45.26
        for <linux-ntb@googlegroups.com>;
        Fri, 12 Feb 2021 09:45:26 -0800 (PST)
Date: Fri, 12 Feb 2021 17:45:20 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH -next] NTB: Drop kfree for memory allocated with
 devm_kzalloc
Message-ID: <20210212174520.GA22934@e121166-lin.cambridge.arm.com>
References: <20210210075345.1096001-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210075345.1096001-1-weiyongjun1@huawei.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Hulk Robot <hulkci@huawei.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Feb 10, 2021 at 07:53:45AM +0000, Wei Yongjun wrote:
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Fixes: 363baf7d6051 ("NTB: Add support for EPF PCI-Express Non-Transparent Bridge")

Squashed it in the commit it is fixing and repushed pci/ntb out.

Thanks,
Lorenzo

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 2cccb7dff5dd..b019755e4e21 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -723,7 +723,6 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	ntb_unregister_device(&ndev->ntb);
>  	ntb_epf_cleanup_isr(ndev);
>  	ntb_epf_deinit_pci(ndev);
> -	kfree(ndev);
>  }
>  
>  static const struct ntb_epf_data j721e_data = {
> 
