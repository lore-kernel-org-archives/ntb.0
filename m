Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com. [2607:f8b0:4864:20::f44])
        by gmr-mx.google.com with ESMTPS id c198si144045qkg.2.2020.12.06.15.24.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 15:24:29 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id bd6so531726qvb.9
        for <linux-ntb@googlegroups.com>; Sun, 06 Dec 2020 15:24:29 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 6 Dec 2020 18:24:27 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: intel: add Intel NTB LTR vendor support for gen4 NTB
Message-ID: <20201206232426.GA11795@kudzu.us>
References: <160614577287.521825.7762300396286632790.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160614577287.521825.7762300396286632790.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: allenbh@gmail.com, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 23, 2020 at 08:36:12AM -0700, Dave Jiang wrote:
> Intel NTB device has custom LTR management that is not compliant with the
> PCIe standard. Add support to set LTR status triggered by link status
> change.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to ntb-next branch.

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen1.h |    1 +
>  drivers/ntb/hw/intel/ntb_hw_gen4.c |   27 ++++++++++++++++++++++++++-
>  drivers/ntb/hw/intel/ntb_hw_gen4.h |   15 +++++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> index 1b759942d8af..344249fc18d1 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> @@ -141,6 +141,7 @@
>  #define NTB_HWERR_B2BDOORBELL_BIT14	BIT_ULL(2)
>  #define NTB_HWERR_MSIX_VECTOR32_BAD	BIT_ULL(3)
>  #define NTB_HWERR_BAR_ALIGN		BIT_ULL(4)
> +#define NTB_HWERR_LTR_BAD		BIT_ULL(5)
>  
>  extern struct intel_b2b_addr xeon_b2b_usd_addr;
>  extern struct intel_b2b_addr xeon_b2b_dsd_addr;
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> index bc4541cbf8c6..fede05151f69 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> @@ -177,8 +177,10 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
>  
>  	ndev->reg = &gen4_reg;
>  
> -	if (pdev_is_ICX(pdev))
> +	if (pdev_is_ICX(pdev)) {
>  		ndev->hwerr_flags |= NTB_HWERR_BAR_ALIGN;
> +		ndev->hwerr_flags |= NTB_HWERR_LTR_BAD;
> +	}
>  
>  	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
>  	ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
> @@ -431,6 +433,25 @@ static int intel_ntb4_link_enable(struct ntb_dev *ntb,
>  		dev_dbg(&ntb->pdev->dev,
>  				"ignoring max_width %d\n", max_width);
>  
> +	if (!(ndev->hwerr_flags & NTB_HWERR_LTR_BAD)) {
> +		u32 ltr;
> +
> +		/* Setup active snoop LTR values */
> +		ltr = NTB_LTR_ACTIVE_REQMNT | NTB_LTR_ACTIVE_VAL | NTB_LTR_ACTIVE_LATSCALE;
> +		/* Setup active non-snoop values */
> +		ltr = (ltr << NTB_LTR_NS_SHIFT) | ltr;
> +		iowrite32(ltr, ndev->self_mmio + GEN4_LTR_ACTIVE_OFFSET);
> +
> +		/* Setup idle snoop LTR values */
> +		ltr = NTB_LTR_IDLE_VAL | NTB_LTR_IDLE_LATSCALE | NTB_LTR_IDLE_REQMNT;
> +		/* Setup idle non-snoop values */
> +		ltr = (ltr << NTB_LTR_NS_SHIFT) | ltr;
> +		iowrite32(ltr, ndev->self_mmio + GEN4_LTR_IDLE_OFFSET);
> +
> +		/* setup PCIe LTR to active */
> +		iowrite8(NTB_LTR_SWSEL_ACTIVE, ndev->self_mmio + GEN4_LTR_SWSEL_OFFSET);
> +	}
> +
>  	ntb_ctl = NTB_CTL_E2I_BAR23_SNOOP | NTB_CTL_I2E_BAR23_SNOOP;
>  	ntb_ctl |= NTB_CTL_E2I_BAR45_SNOOP | NTB_CTL_I2E_BAR45_SNOOP;
>  	iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
> @@ -476,6 +497,10 @@ static int intel_ntb4_link_disable(struct ntb_dev *ntb)
>  	lnkctl |= GEN4_LINK_CTRL_LINK_DISABLE;
>  	iowrite16(lnkctl, ndev->self_mmio + GEN4_LINK_CTRL_OFFSET);
>  
> +	/* set LTR to idle */
> +	if (!(ndev->hwerr_flags & NTB_HWERR_LTR_BAD))
> +		iowrite8(NTB_LTR_SWSEL_IDLE, ndev->self_mmio + GEN4_LTR_SWSEL_OFFSET);
> +
>  	ndev->dev_up = 0;
>  
>  	return 0;
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
> index a868c788de02..3fcd3fdce9ed 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
> @@ -35,6 +35,9 @@
>  #define GEN4_IM_SPAD_SEM_OFFSET		0x00c0	/* SPAD hw semaphore */
>  #define GEN4_IM_SPAD_STICKY_OFFSET	0x00c4  /* sticky SPAD */
>  #define GEN4_IM_DOORBELL_OFFSET		0x0100  /* 0-31 doorbells */
> +#define GEN4_LTR_SWSEL_OFFSET		0x30ec
> +#define GEN4_LTR_ACTIVE_OFFSET		0x30f0
> +#define GEN4_LTR_IDLE_OFFSET		0x30f4
>  #define GEN4_EM_SPAD_OFFSET		0x8080
>  /* note, link status is now in MMIO and not config space for NTB */
>  #define GEN4_LINK_CTRL_OFFSET		0xb050
> @@ -80,6 +83,18 @@
>  
>  #define NTB_SJC_FORCEDETECT		0x000004
>  
> +#define NTB_LTR_SWSEL_ACTIVE		0x0
> +#define NTB_LTR_SWSEL_IDLE		0x1
> +
> +#define NTB_LTR_NS_SHIFT		16
> +#define NTB_LTR_ACTIVE_VAL		0x0000  /* 0 us */
> +#define NTB_LTR_ACTIVE_LATSCALE		0x0800  /* 1us scale */
> +#define NTB_LTR_ACTIVE_REQMNT		0x8000  /* snoop req enable */
> +
> +#define NTB_LTR_IDLE_VAL		0x0258  /* 600 us */
> +#define NTB_LTR_IDLE_LATSCALE		0x0800  /* 1us scale */
> +#define NTB_LTR_IDLE_REQMNT		0x8000  /* snoop req enable */
> +
>  ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
>  				      size_t count, loff_t *offp);
>  int gen4_init_dev(struct intel_ntb_dev *ndev);
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/160614577287.521825.7762300396286632790.stgit%40djiang5-desk3.ch.intel.com.
