Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id m132si386393ioa.3.2021.02.12.04.48.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 04:48:39 -0800 (PST)
Subject: Re: [PATCH -next] NTB: Drop kfree for memory allocated with
 devm_kzalloc
References: <20210210075345.1096001-1-weiyongjun1@huawei.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ede29bb2-d501-4add-979a-baed99fe730c@ti.com>
Date: Fri, 12 Feb 2021 18:18:31 +0530
MIME-Version: 1.0
In-Reply-To: <20210210075345.1096001-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Wei Yongjun <weiyongjun1@huawei.com>, Hulk Robot <hulkci@huawei.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>



On 10/02/21 1:23 pm, Wei Yongjun wrote:
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Fixes: 363baf7d6051 ("NTB: Add support for EPF PCI-Express Non-Transparent Bridge")
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

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  static const struct ntb_epf_data j721e_data = {
> 
