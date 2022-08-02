Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD697F
	for <ntb@lists.linux.dev>; Tue,  2 Aug 2022 22:30:55 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id y11so11757178qvn.3
        for <ntb@lists.linux.dev>; Tue, 02 Aug 2022 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pKbkxiSNs17/PMEr24W4rJEdMbCJWbaw28wbnfPXzUc=;
        b=iMJhTyk+hZtSvmOk74eReIxFJE6rrsUtriqJbIttFZ8LfoQ4yiJgKImojxgosNdUMG
         LR+jmNsJQJvtjU4C//RNs9Xuo+lR+TVRz7vO5pSVzLvAjUcpXCn0ZvdNQJhzZKQf7KQv
         /s0usQcW07Yt0ftv+uKB7T5YUhK3v1YZHkCzC5rhZJblIJTFx3TRnliiQsV3W+jfdJ5j
         oPxpkImLfXedNv4lXFhB/SH/9rrxqkbctPxtE6EyMMMid5B3iqkeXy5wBUEvrLMplvQH
         ijIOoVqg4UcGSAnqJVBNeyLFDo5NzxTetCQEGWo/4Ta8g9WQrYbK9CIK0slJePQiSgU7
         oc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pKbkxiSNs17/PMEr24W4rJEdMbCJWbaw28wbnfPXzUc=;
        b=jYoo3wZEZLFPw1duXJWpiX6jdD6zHHqNUkTY5AacTPDvP0WOCc0S9aLJluBG2XR38g
         cGgnDzJ7IHEAyOAZVGZsVOHNejHU51aPOfoKI4jNIq7ezwmCSwZSo6JBrNLwGauuiK5C
         Ybxybqx5Bs8EnZrhwRv2tGAtJ+pXyQc6cyfVO4LoWfvM5PLuTlMzetffftH8t5xwCb6u
         Aaqob8yfUVANbSBTTIslWpLyoyfSBRypQQBZ1PKg+cK/Xu0xtiXWxdkiWmcy+ZAkv/zh
         Ztb3PHeFwlKxNDqKJM0bOBdXgQcrB3LVAuntvfmZz8MK5loHSgfkdWv5/LtkVIASLnbI
         N5zQ==
X-Gm-Message-State: ACgBeo14OyoYrtG+yU5Gp7Tbwu3Y2cbUHXEu4KewAcaOiCHcFs/3YuC8
	nTMQZtTxawTLMnh8afzXOE5Bp6nJJd3rrQYloBOlLhMXBNA=
X-Google-Smtp-Source: AA6agR4ySik/T9RtnyYo1W+trg2Cmsd4FloVkQxpT/ZyR1ogljxRN1d/spBnoCt2K/BI37aLQkdp1W5FWGg6plxKCys=
X-Received: by 2002:ad4:5e8c:0:b0:476:ebf1:47fb with SMTP id
 jl12-20020ad45e8c000000b00476ebf147fbmr3291766qvb.102.1659479454442; Tue, 02
 Aug 2022 15:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <165947448457.3727412.2993602211644885680.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165947448457.3727412.2993602211644885680.stgit@djiang5-desk3.ch.intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Tue, 2 Aug 2022 18:30:43 -0400
Message-ID: <CAJ80sav7vSFYTP+s58jfe3BoGq9fF7=CsbhRAG9fcfcx2Ta9Tw@mail.gmail.com>
Subject: Re: [PATCH v3] ntb: intel: add GNR support for Intel PCIe gen5 NTB
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 2, 2022 at 5:10 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add Intel Granite Rapids NTB PCI device ID and related enabling.
> Expectation is same hardware interface as Saphire Rapids Xeon platforms.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <allenbh@gmail.com>

> ---
>
> v3:
> - Remove SPR related bits to avoid confusion (Allen)
> - Simplify pdev_is_gen5() function (Allen)
>
> v2:
> - Add debugfs check for GNR generation. Otherwise it fails on GNR.
>
>  drivers/ntb/hw/intel/ntb_hw_gen1.c  |   12 ++++++++----
>  drivers/ntb/hw/intel/ntb_hw_gen4.c  |    2 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.h |    7 +++++++
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index e5f14e20a9ff..84772013812b 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -763,7 +763,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
>                 return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
>         else if (pdev_is_gen3(ndev->ntb.pdev))
>                 return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
> -       else if (pdev_is_gen4(ndev->ntb.pdev))
> +       else if (pdev_is_gen4(ndev->ntb.pdev) || pdev_is_gen5(ndev->ntb.pdev))
>                 return ndev_ntb4_debugfs_read(filp, ubuf, count, offp);
>
>         return -ENXIO;
> @@ -1874,7 +1874,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>                 rc = gen3_init_dev(ndev);
>                 if (rc)
>                         goto err_init_dev;
> -       } else if (pdev_is_gen4(pdev)) {
> +       } else if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev)) {
>                 ndev->ntb.ops = &intel_ntb4_ops;
>                 rc = intel_ntb_init_pci(ndev, pdev);
>                 if (rc)
> @@ -1904,7 +1904,8 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>
>  err_register:
>         ndev_deinit_debugfs(ndev);
> -       if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) || pdev_is_gen4(pdev))
> +       if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
> +           pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
>                 xeon_deinit_dev(ndev);
>  err_init_dev:
>         intel_ntb_deinit_pci(ndev);
> @@ -1920,7 +1921,8 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
>
>         ntb_unregister_device(&ndev->ntb);
>         ndev_deinit_debugfs(ndev);
> -       if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) || pdev_is_gen4(pdev))
> +       if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev) ||
> +           pdev_is_gen4(pdev) || pdev_is_gen5(pdev))
>                 xeon_deinit_dev(ndev);
>         intel_ntb_deinit_pci(ndev);
>         kfree(ndev);
> @@ -2047,6 +2049,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
>
>         /* GEN4 */
>         {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
> +       /* GEN5 PCIe */
> +       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},
>         {0}
>  };
>  MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> index 4081fc538ff4..22cac7975b3c 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> @@ -197,7 +197,7 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
>         ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
>         if (pdev_is_ICX(pdev))
>                 ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
> -       else if (pdev_is_SPR(pdev))
> +       else if (pdev_is_SPR(pdev) || pdev_is_gen5(pdev))
>                 ndev->ntb.topo = spr_ppd_topo(ndev, ppd1);
>         dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd1,
>                 ntb_topo_string(ndev->ntb.topo));
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index b233d1c6ba2d..da4d5fe55bab 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -70,6 +70,7 @@
>  #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX 0x6F0F
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX        0x201C
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX        0x347e
> +#define PCI_DEVICE_ID_INTEL_NTB_B2B_GNR        0x0db4
>
>  /* Ntb control and link status */
>  #define NTB_CTL_CFG_LOCK               BIT(0)
> @@ -228,4 +229,10 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
>
>         return 0;
>  }
> +
> +static inline int pdev_is_gen5(struct pci_dev *pdev)
> +{
> +       return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR;
> +}
> +
>  #endif
>
>
