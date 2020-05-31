Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com. [2607:f8b0:4864:20::741])
        by gmr-mx.google.com with ESMTPS id p28si1357039ota.3.2020.05.31.12.55.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 12:55:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c185so7230087qke.7
        for <linux-ntb@googlegroups.com>; Sun, 31 May 2020 12:55:10 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 31 May 2020 15:55:08 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: intel: add revision lockdown for Icelake NTB driver
Message-ID: <20200531195507.GC4620@kudzu.us>
References: <158993143119.41853.10657616792966099233.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158993143119.41853.10657616792966099233.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, allenbh@gmail.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 19, 2020 at 04:37:11PM -0700, Dave Jiang wrote:
> Add PCI device revision during probe to ensure that the driver only runs
> on intended CPU steppings for Icelake.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Pulled into the ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen4.c |    6 ++++++
>  drivers/ntb/hw/intel/ntb_hw_gen4.h |   13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> index ed6574d8fcc6..dcbd6d3cf7ae 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> @@ -221,6 +221,12 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
>  	u16 lnkctl;
>  	int rc;
>  
> +	if (!pdev_is_ICX(pdev)) {
> +		dev_warn(&pdev->dev,
> +			 "Incorrect device revision: %d.\n", pdev->revision);
> +		return -ENODEV;
> +	}
> +
>  	ndev->reg = &gen4_reg;
>  
>  	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
> index 10f3ddf2ad30..c2ff5ed86d7d 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
> @@ -46,6 +46,10 @@
>  
>  #include "ntb_hw_intel.h"
>  
> +/* Supported PCI device revision range for ICX */
> +#define PCI_DEVICE_REVISION_ICX_MIN	0x2
> +#define PCI_DEVICE_REVISION_ICX_MAX	0x7
> +
>  /* Intel Gen4 NTB hardware */
>  /* PCIe config space */
>  #define GEN4_IMBAR23SZ_OFFSET		0x00c4
> @@ -125,4 +129,13 @@ ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
>  
>  extern const struct ntb_dev_ops intel_ntb4_ops;
>  
> +static inline int pdev_is_ICX(struct pci_dev *pdev)
> +{
> +	if (pdev_is_gen4(pdev) &&
> +	    pdev->revision >= PCI_DEVICE_REVISION_ICX_MIN &&
> +	    pdev->revision <= PCI_DEVICE_REVISION_ICX_MAX)
> +		return 1;
> +	return 0;
> +}
> +
>  #endif
> 
