Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id y24si542816qtm.0.2021.05.20.16.49.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:49:00 -0700 (PDT)
References: <20210520222323.104901-1-jkirsher@ixsystems.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
Date: Thu, 20 May 2021 17:48:56 -0600
MIME-Version: 1.0
In-Reply-To: <20210520222323.104901-1-jkirsher@ixsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC] ntb/plx: Add support for PLX hardware
To: Jeff Kirsher <jkirsher@ixsystems.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, Alexander Motin <mav@ixsystems.com>
List-ID: <linux-ntb.googlegroups.com>


Hi Jeff,

I've just done a quick review and found some style issues. Generally the
driver looks pretty good but I didn't dig into too many details.

On 2021-05-20 4:23 p.m., Jeff Kirsher wrote:
> +static const struct file_operations plx_ntb_debugfs_info;
> +static struct dentry *debugfs_dir;
> +static int plx_ntb_mw_set_trans_internal(struct ntb_dev *ntb, int idx);

Kernel style tries to avoid forward declarations unless they are needed
to avoid a mutual recursion (not here). This means the code will always
be in a specific order where we can read the code before it's used and
it also generally forces initialization functions on the bottom. This is
easier to read.


> +static int plx_ntb_init_pci(struct plx_ntb_dev *ndev, struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	pci_set_drvdata(pdev, ndev);
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc)
> +		goto err_pci_enable;
> +
> +	rc = pci_request_regions(pdev, NTB_NAME);
> +	if (rc)
> +		goto err_pci_regions;
> +
> +	pci_set_master(pdev);
> +
> +	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
> +	}
> +
> +	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> +	}
> +
> +	ndev->self_mmio = pci_iomap(pdev, 0, 0);
> +	if (!ndev->self_mmio) {
> +		rc = -EIO;
> +		goto err_mmio;
> +	}

I'd recommend using the device managed variants of all of these.
pcim_enable_device(), pcim_iomap(), devm_request_irq(), etc. It really
simplifies the code as the cleanup paths are much easier.


> +module_exit(plx_ntb_pci_driver_exit);
> diff --git a/drivers/ntb/hw/plx/ntb_hw_plx.h b/drivers/ntb/hw/plx/ntb_hw_plx.h
> new file mode 100644
> index 000000000000..4f118432e718
> --- /dev/null
> +++ b/drivers/ntb/hw/plx/ntb_hw_plx.h

We generally do not add header files unless they are shared by multiple
C files. All this code can and should be placed at the top of the C file.
> +#define ntb_ndev(__ntb) container_of(__ntb, struct plx_ntb_dev, ntb)

Although you see this a lot (and I've added my fair share) many kernel
devs prefer these to be open coded. It's much clearer. Also, though, why
the double underscore on ntb?

> +/* Bases of NTx our/peer interface registers */
> +#define PLX_NTX_OUR_BASE(sc)				\
> +	(PLX_NTX_BASE(sc) + ((sc)->link ? PLX_NTX_LNK_OFFSET : 0))
> +#define PLX_NTX_PEER_BASE(sc)				\
> +	(PLX_NTX_BASE(sc) + ((sc)->link ? 0 : PLX_NTX_LNK_OFFSET))
> +
> +/* Read/write NTx our interface registers */
> +#define NTX_READ(sc, reg)				\
> +	readl((sc)->self_mmio + PLX_NTX_OUR_BASE(sc) + (reg))
> +#define NTX_WRITE(val, sc, reg)				\
> +	writel((val), (sc)->self_mmio + PLX_NTX_OUR_BASE(sc) + (reg))>
> +/* Read/write NTx peer interface registers */
> +#define PNTX_READ(sc, reg)				\
> +	readl((sc)->self_mmio + PLX_NTX_PEER_BASE(sc) + (reg))
> +#define PNTX_WRITE(val, sc, reg)			\
> +	writel((val), (sc)->self_mmio + PLX_NTX_PEER_BASE(sc) + (reg))
> +
> +/* Read/write B2B NTx registers */
> +#define BNTX_READ(sc, reg)				\
> +	readl((sc)->mw_info[(sc)->b2b_mw].mw_res,	\
> +	PLX_NTX_BASE(sc) + (reg))
> +#define BNTX_WRITE(val, sc, reg)			\
> +	writel((val), (sc)->mw_info[(sc)->b2b_mw].mw_res + PLX_NTX_BASE(sc) + (reg))

This is quite nasty. I was expecting to just say to open code the
writel's and not define your own. But they apparently hide a giant mess.
There's got to be a better way than nesting all this hidden logic behind
macros. It'd probably be better to pre-calcualate and store a lot of
these base pointers. Then just open code the writel and readls.
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4a02561cfb96..ee39c5e9f274 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -873,6 +873,11 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
>  	xlat_size = round_up(size, xlat_align_size);
>  	buff_size = round_up(size, xlat_align);
>  
> +	/* DEBUG code */
> +	dev_info(&pdev->dev, "xlat_size is %lu\n", xlat_size);
> +	dev_info(&pdev->dev, "buff_size is %lu\n", buff_size);
> +	dev_info(&pdev->dev, "size is %llu\n", size);

Please don't add noisy extra debug prints to every ntb-transport user.
If we want to add some dev_dbg() calls that might be acceptable, but
please do it in another patch.

>  	/* No need to re-setup */
>  	if (mw->xlat_size == xlat_size)
>  		return 0;
> @@ -1204,7 +1209,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	tx_size -= sizeof(struct ntb_rx_info);
>  	qp->rx_info = qp->tx_mw + tx_size;
>  
> -	/* Due to housekeeping, there must be atleast 2 buffs */
> +	/* Due to housekeeping, there must be at least 2 buffs */

Please send in separate patch if you want to cleanup other random code
bits. It shouldn't be hidden within a large new driver patch.

Thanks,

Logan
