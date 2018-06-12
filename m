Return-Path: <jdmason@kudzu.us>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com. [2607:f8b0:4001:c06::243])
        by gmr-mx.google.com with ESMTPS id z5-v6si30505qto.0.2018.06.12.08.48.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 08:48:16 -0700 (PDT)
Received: by mail-io0-x243.google.com with SMTP id s26-v6so28631828ioj.4
        for <linux-ntb@googlegroups.com>; Tue, 12 Jun 2018 08:48:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180609000819.13883-3-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com> <20180609000819.13883-3-logang@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 12 Jun 2018 11:48:15 -0400
Message-ID: <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
Subject: Re: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Commit  417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
> devices") added code to set the DMA mask for the NTB device
> to each driver individually. However, it neglected to set it for the
> Switchtec driver. So when the monolithic commit 7f46c8b3a552 ("NTB:
> ntb_tool: Add full multi-port NTB API support") started allocating
> DMA memory against the NTB device it broke the Switchtec driver.
>
> Seeing this is setting up a property of the NTB device, it should be
> done by the common NTB code (inside ntb_register_device()) so we can be
> sure it's done properly for all drivers. This avoids each driver needing
> to duplicate the code and helps prevent us from inadvertently breaking
> one of the drivers in the future if we have to make changes in this area.
>
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c     |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  4 ----
>  drivers/ntb/ntb.c                   | 13 ++++++++++++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 3cfa46876239..f0788aae05c9 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> -       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                         dma_get_mask(&pdev->dev));
> -       if (rc)
> -               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 8d98872d0983..1918a2db1c43 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2447,12 +2447,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>                 dev_warn(&pdev->dev,
>                         "Cannot set consistent DMA highmem bit mask\n");
>         }
> -       ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                          dma_get_mask(&pdev->dev));
> -       if (ret != 0) {
> -               dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
> -               return ret;
> -       }
>
>         /*
>          * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 156b45cd4a19..341a3d5baa3f 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -2334,10 +2334,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> -       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                         dma_get_mask(&pdev->dev));
> -       if (rc)
> -               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2581ab724c34..93f24440d11d 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
>
>  int ntb_register_device(struct ntb_dev *ntb)
>  {
> +       int ret;
> +
>         if (!ntb)
>                 return -EINVAL;
>         if (!ntb->pdev)
> @@ -120,7 +122,16 @@ int ntb_register_device(struct ntb_dev *ntb)
>         ntb->ctx_ops = NULL;
>         spin_lock_init(&ntb->ctx_lock);
>
> -       return device_register(&ntb->dev);
> +       device_initialize(&ntb->dev);
> +
> +       ret = dma_coerce_mask_and_coherent(&ntb->dev,
> +                                          dma_get_mask(&ntb->pdev->dev));

ntb.c is more of a glue layer, and this is more device specific.
While I like adding it here for more common code, it should probably
reside in the ntb_hw_*.c files to enforce the hw specific code all
reside in that layer.  So, this probably needs to be replaced with a
patch which adds the setting of the mask to the switchtec driver.

Thanks,
Jon


> +       if (ret != 0) {
> +               dev_err(&ntb->dev, "Failed to set NTB device DMA bit mask\n");
> +               return ret;
> +       }
> +
> +       return device_add(&ntb->dev);
>  }
>  EXPORT_SYMBOL(ntb_register_device);
>
> --
> 2.11.0
>
