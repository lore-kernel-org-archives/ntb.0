Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com. [2a00:1450:4864:20::12f])
        by gmr-mx.google.com with ESMTPS id v25si225779lfr.1.2021.09.05.04.11.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 04:11:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h16so7553177lfk.10
        for <linux-ntb@googlegroups.com>; Sun, 05 Sep 2021 04:11:52 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sun, 5 Sep 2021 14:11:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] NTB: switch from 'pci_' to 'dma_' API
Message-ID: <20210905111149.atqgurplzy472thz@mobilestation>
References: <6a1db73ba4e46958cb40d3766eff771ef5d7a11b.1629640974.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1db73ba4e46958cb40d3766eff771ef5d7a11b.1629640974.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sanju.mehta@amd.com, Shyam-sundar.S-k@amd.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hi Christophe

On Sun, Aug 22, 2021 at 04:04:12PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> 
> It has been compile tested.

Thanks for the clean up. Explicit Ack for the IDT-part is below.

> 
> 
> @@
> @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
> 
> @@
> @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
> 
> @@
> @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
> 
> @@
> @@
> -    PCI_DMA_NONE
> +    DMA_NONE
> 
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> 
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> 
> This patch is mostly mechanical and compile tested. I hope it is ok to
> update the "drivers/ntb/hw/" directory all at once.
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c    | 12 ++----------

>  drivers/ntb/hw/idt/ntb_hw_idt.c    | 15 ++-------------

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  drivers/ntb/hw/intel/ntb_hw_gen1.c | 12 ++----------
>  3 files changed, 6 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 71428d8cbcfc..87847c380051 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1176,22 +1176,14 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>  
>  	pci_set_master(pdev);
>  
> -	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>  
> -	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (rc)
> -			goto err_dma_mask;
> -		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> -	}
> -
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
>  		rc = -EIO;
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index e7a4c2aa8baa..733557231ed0 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2640,26 +2640,15 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	int ret;
>  
>  	/* Initialize the bit mask of PCI/NTB DMA */
> -	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret != 0) {
> -		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (ret != 0) {
>  			dev_err(&pdev->dev, "Failed to set DMA bit mask\n");
>  			return ret;
>  		}
>  		dev_warn(&pdev->dev, "Cannot set DMA highmem bit mask\n");
>  	}
> -	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (ret != 0) {
> -		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (ret != 0) {
> -			dev_err(&pdev->dev,
> -				"Failed to set consistent DMA bit mask\n");
> -			return ret;
> -		}
> -		dev_warn(&pdev->dev,
> -			"Cannot set consistent DMA highmem bit mask\n");
> -	}
>  
>  	/*
>  	 * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 093dd20057b9..e5f14e20a9ff 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1771,22 +1771,14 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  
>  	pci_set_master(pdev);
>  
> -	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>  
> -	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (rc)
> -			goto err_dma_mask;
> -		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> -	}
> -
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
>  		rc = -EIO;
> -- 
> 2.30.2
> 
