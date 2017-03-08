Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com. [2607:f8b0:400d:c09::242])
        by gmr-mx.google.com with ESMTPS id r198si462016ywe.4.2017.03.08.08.44.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 08:44:00 -0800 (PST)
Received: by mail-qk0-x242.google.com with SMTP id n141so12582606qke.3
        for <linux-ntb@googlegroups.com>; Wed, 08 Mar 2017 08:44:00 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 8 Mar 2017 11:43:57 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2 3/4] ntb_hw_amd: Print kernel messages with the ntb
 device not the pci one
Message-ID: <20170308164356.GC13161@kudzu.us>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
 <1484094819-16084-4-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484094819-16084-4-git-send-email-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 10, 2017 at 05:33:38PM -0700, Logan Gunthorpe wrote:
> Now that macros are open it's pretty clear that these should print
> using the NTB struct device not the PCI one.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

I believe that using the PCI dev here makes it more debugable, as this
is more referring to possible issues with the HW.  So, I'm not taking
this patch (or the one for Intel).

Thanks,
Jon

> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 0135fcf..69b8c64 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -225,7 +225,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
>  		if (width)
>  			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
>  
> -		dev_dbg(&ntb->pdev->dev, "link is up.\n");
> +		dev_dbg(&ntb->dev, "link is up.\n");
>  
>  		ret = 1;
>  	} else {
> @@ -234,7 +234,7 @@ static int amd_ntb_link_is_up(struct ntb_dev *ntb,
>  		if (width)
>  			*width = NTB_WIDTH_NONE;
>  
> -		dev_dbg(&ntb->pdev->dev, "link is down.\n");
> +		dev_dbg(&ntb->dev, "link is down.\n");
>  	}
>  
>  	return ret;
> @@ -254,7 +254,7 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
>  
>  	if (ndev->ntb.topo == NTB_TOPO_SEC)
>  		return -EINVAL;
> -	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
> +	dev_dbg(&ntb->dev, "Enabling Link.\n");
>  
>  	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
>  	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
> @@ -275,7 +275,7 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
>  
>  	if (ndev->ntb.topo == NTB_TOPO_SEC)
>  		return -EINVAL;
> -	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
> +	dev_dbg(&ntb->dev, "Enabling Link.\n");
>  
>  	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
>  	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
> @@ -466,19 +466,18 @@ static void amd_ack_smu(struct amd_ntb_dev *ndev, u32 bit)
>  static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
>  {
>  	void __iomem *mmio = ndev->self_mmio;
> -	struct device *dev = &ndev->ntb.pdev->dev;
>  	u32 status;
>  
>  	status = readl(mmio + AMD_INTSTAT_OFFSET);
>  	if (!(status & AMD_EVENT_INTMASK))
>  		return;
>  
> -	dev_dbg(dev, "status = 0x%x and vec = %d\n", status, vec);
> +	dev_dbg(&ndev->ntb.dev, "status = 0x%x and vec = %d\n", status, vec);
>  
>  	status &= AMD_EVENT_INTMASK;
>  	switch (status) {
>  	case AMD_PEER_FLUSH_EVENT:
> -		dev_info(dev, "Flush is done.\n");
> +		dev_info(&ndev->ntb.dev, "Flush is done.\n");
>  		break;
>  	case AMD_PEER_RESET_EVENT:
>  		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
> @@ -504,7 +503,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
>  		status = readl(mmio + AMD_PMESTAT_OFFSET);
>  		/* check if this is WAKEUP event */
>  		if (status & 0x1)
> -			dev_info(dev, "Wakeup is done.\n");
> +			dev_info(&ndev->ntb.dev, "Wakeup is done.\n");
>  
>  		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
>  
> @@ -513,14 +512,14 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
>  				      AMD_LINK_HB_TIMEOUT);
>  		break;
>  	default:
> -		dev_info(dev, "event status = 0x%x.\n", status);
> +		dev_info(&ndev->ntb.dev, "event status = 0x%x.\n", status);
>  		break;
>  	}
>  }
>  
>  static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
>  {
> -	dev_dbg(&ndev->ntb.pdev->dev, "vec %d\n", vec);
> +	dev_dbg(&ndev->ntb.dev, "vec %d\n", vec);
>  
>  	if (vec > (AMD_DB_CNT - 1) || (ndev->msix_vec_count == 1))
>  		amd_handle_event(ndev, vec);
> @@ -814,7 +813,7 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>  	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
>  	reg &= NTB_LIN_STA_ACTIVE_BIT;
>  
> -	dev_dbg(&ndev->ntb.pdev->dev, "%s: reg_val = 0x%x.\n", __func__, reg);
> +	dev_dbg(&ndev->ntb.dev, "%s: reg_val = 0x%x.\n", __func__, reg);
>  
>  	if (reg == ndev->cntl_sta)
>  		return 0;
> @@ -1052,7 +1051,7 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
>  	if (rc)
>  		goto err_register;
>  
> -	dev_info(&pdev->dev, "NTB device registered.\n");
> +	dev_info(&ndev->ntb.dev, "NTB device registered.\n");
>  
>  	return 0;
>  
> -- 
> 2.1.4
> 
