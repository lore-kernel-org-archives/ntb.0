Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x22a.google.com (mail-ua0-x22a.google.com. [2607:f8b0:400c:c08::22a])
        by gmr-mx.google.com with ESMTPS id k95si45487iod.0.2017.12.05.08.51.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 08:51:09 -0800 (PST)
Received: by mail-ua0-x22a.google.com with SMTP id q13so687048uaq.8
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 08:51:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171203191736.3399-3-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com> <20171203191736.3399-3-fancer.lancer@gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 11:51:08 -0500
Message-ID: <CAPoiz9xHuhynY-o7U_-ZQdSXsDFZdq7Xju6mC44eMPj9LOotkA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] NTB: Set dma mask and dma coherent mask to NTB devices
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> The dma_mask and dma_coherent_mask fields of the NTB struct device
> weren't initialized in hardware drivers. In fact it should be done
> instead of PCIe interface usage, since NTB clients are supposed to
> use NTB API only and left unaware of real hardware implementation.
> In addition to that ntb_device_register() method shouldn't clear
> the passed ntb_dev structure, since it dma_mask is initialized
> by hardware drivers.

This seems like a bug fix.  Should this be broken out of this patch or
is it not noticed without your changes?

Thanks,
Jon

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     | 4 ++++
>  drivers/ntb/hw/idt/ntb_hw_idt.c     | 8 +++++++-
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 4 ++++
>  drivers/ntb/ntb.c                   | 1 -
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index f0788aae05c9..3cfa46876239 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1020,6 +1020,10 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> +       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> +                                         dma_get_mask(&pdev->dev));
> +       if (rc)
> +               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 6fb87c0f0d97..d87dbd4bc82c 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2426,7 +2426,7 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>         struct pci_dev *pdev = ndev->ntb.pdev;
>         int ret;
>
> -       /* Initialize the bit mask of DMA */
> +       /* Initialize the bit mask of PCI/NTB DMA */
>         ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>         if (ret != 0) {
>                 ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> @@ -2447,6 +2447,12 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>                 dev_warn(&pdev->dev,
>                         "Cannot set consistent DMA highmem bit mask\n");
>         }
> +       ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> +                                          dma_get_mask(&pdev->dev));
> +       if (ret != 0) {
> +               dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
> +               return ret;
> +       }
>
>         /*
>          * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 4de074a86073..ea6c82f8655f 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -2586,6 +2586,10 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> +       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> +                                         dma_get_mask(&pdev->dev));
> +       if (rc)
> +               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 03b80d89b980..79e50a5f8902 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -112,7 +112,6 @@ int ntb_register_device(struct ntb_dev *ntb)
>
>         init_completion(&ntb->released);
>
> -       memset(&ntb->dev, 0, sizeof(ntb->dev));
>         ntb->dev.bus = &ntb_bus;
>         ntb->dev.parent = &ntb->pdev->dev;
>         ntb->dev.release = ntb_dev_release;
> --
> 2.12.0
>
