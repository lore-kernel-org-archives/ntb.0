Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id z62si5432753pfz.1.2016.12.19.09.04.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 09:04:26 -0800 (PST)
Subject: Re: [PATCH] NTB: Fix 'request_irq()' and 'free_irq()' inconsistancy
References: <20161219055255.21418-1-christophe.jaillet@wanadoo.fr>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <56b16dd5-b83b-e8b0-bf79-2dd2bc56f1e1@intel.com>
Date: Mon, 19 Dec 2016 10:04:24 -0700
MIME-Version: 1.0
In-Reply-To: <20161219055255.21418-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Xiangliang.Yu@amd.com, jdmason@kudzu.us, Allen.Hubbe@emc.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 12/18/2016 10:52 PM, Christophe JAILLET wrote:
> 'request_irq()' and 'free_irq()' should have the same 'dev_id'.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acking the Intel driver portion.
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     | 2 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 6ccba0d862df..a48c3e085eab 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -598,7 +598,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
>  
>  err_msix_request:
>  	while (i-- > 0)
> -		free_irq(ndev->msix[i].vector, ndev);
> +		free_irq(ndev->msix[i].vector, &ndev->vec[i]);
>  	pci_disable_msix(pdev);
>  err_msix_enable:
>  	kfree(ndev->msix);
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 7310a261c858..2413600aae30 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -472,7 +472,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
>  
>  err_msix_request:
>  	while (i-- > 0)
> -		free_irq(ndev->msix[i].vector, ndev);
> +		free_irq(ndev->msix[i].vector, &ndev->vec[i]);
>  	pci_disable_msix(pdev);
>  err_msix_enable:
>  	kfree(ndev->msix);
> 
