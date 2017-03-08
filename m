Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com. [2607:f8b0:400d:c09::241])
        by gmr-mx.google.com with ESMTPS id r6si410222ywb.6.2017.03.08.08.41.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 08:41:42 -0800 (PST)
Received: by mail-qk0-x241.google.com with SMTP id o135so12573732qke.2
        for <linux-ntb@googlegroups.com>; Wed, 08 Mar 2017 08:41:42 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 8 Mar 2017 11:41:39 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2 2/4] ntb_hw_intel: Style fixes: open code macros that
 just obfuscate code
Message-ID: <20170308164138.GB13161@kudzu.us>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
 <1484094819-16084-3-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484094819-16084-3-git-send-email-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 10, 2017 at 05:33:37PM -0700, Logan Gunthorpe wrote:
> As per a comments in [1] by Greg Kroah-Hartman, the ndev_* macros should
> be cleaned up. This makes it more clear what's actually going on when
> reading the code.
> 
> [1] http://www.spinics.net/lists/linux-pci/msg56904.html
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to my ntb-next branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 192 ++++++++++++++++++------------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>  2 files changed, 95 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index eca9688..6456f54 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -270,12 +270,12 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
>  
>  	if (db_addr) {
>  		*db_addr = reg_addr + reg;
> -		dev_dbg(ndev_dev(ndev), "Peer db addr %llx\n", *db_addr);
> +		dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx\n", *db_addr);
>  	}
>  
>  	if (db_size) {
>  		*db_size = ndev->reg->db_size;
> -		dev_dbg(ndev_dev(ndev), "Peer db size %llx\n", *db_size);
> +		dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n", *db_size);
>  	}
>  
>  	return 0;
> @@ -368,7 +368,8 @@ static inline int ndev_spad_addr(struct intel_ntb_dev *ndev, int idx,
>  
>  	if (spad_addr) {
>  		*spad_addr = reg_addr + reg + (idx << 2);
> -		dev_dbg(ndev_dev(ndev), "Peer spad addr %llx\n", *spad_addr);
> +		dev_dbg(&ndev->ntb.pdev->dev, "Peer spad addr %llx\n",
> +			*spad_addr);
>  	}
>  
>  	return 0;
> @@ -409,7 +410,7 @@ static irqreturn_t ndev_interrupt(struct intel_ntb_dev *ndev, int vec)
>  	if ((ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD) && (vec == 31))
>  		vec_mask |= ndev->db_link_mask;
>  
> -	dev_dbg(ndev_dev(ndev), "vec %d vec_mask %llx\n", vec, vec_mask);
> +	dev_dbg(&ndev->ntb.pdev->dev, "vec %d vec_mask %llx\n", vec, vec_mask);
>  
>  	ndev->last_ts = jiffies;
>  
> @@ -428,7 +429,7 @@ static irqreturn_t ndev_vec_isr(int irq, void *dev)
>  {
>  	struct intel_ntb_vec *nvec = dev;
>  
> -	dev_dbg(ndev_dev(nvec->ndev), "irq: %d  nvec->num: %d\n",
> +	dev_dbg(&nvec->ndev->ntb.pdev->dev, "irq: %d  nvec->num: %d\n",
>  		irq, nvec->num);
>  
>  	return ndev_interrupt(nvec->ndev, nvec->num);
> @@ -438,7 +439,7 @@ static irqreturn_t ndev_irq_isr(int irq, void *dev)
>  {
>  	struct intel_ntb_dev *ndev = dev;
>  
> -	return ndev_interrupt(ndev, irq - ndev_pdev(ndev)->irq);
> +	return ndev_interrupt(ndev, irq - ndev->ntb.pdev->irq);
>  }
>  
>  static int ndev_init_isr(struct intel_ntb_dev *ndev,
> @@ -448,7 +449,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
>  	struct pci_dev *pdev;
>  	int rc, i, msix_count, node;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  
>  	node = dev_to_node(&pdev->dev);
>  
> @@ -487,7 +488,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
>  			goto err_msix_request;
>  	}
>  
> -	dev_dbg(ndev_dev(ndev), "Using %d msix interrupts\n", msix_count);
> +	dev_dbg(&pdev->dev, "Using %d msix interrupts\n", msix_count);
>  	ndev->db_vec_count = msix_count;
>  	ndev->db_vec_shift = msix_shift;
>  	return 0;
> @@ -515,7 +516,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
>  	if (rc)
>  		goto err_msi_request;
>  
> -	dev_dbg(ndev_dev(ndev), "Using msi interrupts\n");
> +	dev_dbg(&pdev->dev, "Using msi interrupts\n");
>  	ndev->db_vec_count = 1;
>  	ndev->db_vec_shift = total_shift;
>  	return 0;
> @@ -533,7 +534,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
>  	if (rc)
>  		goto err_intx_request;
>  
> -	dev_dbg(ndev_dev(ndev), "Using intx interrupts\n");
> +	dev_dbg(&pdev->dev, "Using intx interrupts\n");
>  	ndev->db_vec_count = 1;
>  	ndev->db_vec_shift = total_shift;
>  	return 0;
> @@ -547,7 +548,7 @@ static void ndev_deinit_isr(struct intel_ntb_dev *ndev)
>  	struct pci_dev *pdev;
>  	int i;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  
>  	/* Mask all doorbell interrupts */
>  	ndev->db_mask = ndev->db_valid_mask;
> @@ -744,7 +745,7 @@ static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
>  	union { u64 v64; u32 v32; u16 v16; u8 v8; } u;
>  
>  	ndev = filp->private_data;
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  	mmio = ndev->self_mmio;
>  
>  	buf_size = min(count, 0x800ul);
> @@ -1019,7 +1020,8 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
>  		ndev->debugfs_info = NULL;
>  	} else {
>  		ndev->debugfs_dir =
> -			debugfs_create_dir(ndev_name(ndev), debugfs_dir);
> +			debugfs_create_dir(pci_name(ndev->ntb.pdev),
> +					   debugfs_dir);
>  		if (!ndev->debugfs_dir)
>  			ndev->debugfs_info = NULL;
>  		else
> @@ -1206,13 +1208,13 @@ static int intel_ntb_link_enable(struct ntb_dev *ntb,
>  	if (ndev->ntb.topo == NTB_TOPO_SEC)
>  		return -EINVAL;
>  
> -	dev_dbg(ndev_dev(ndev),
> +	dev_dbg(&ntb->pdev->dev,
>  		"Enabling link with max_speed %d max_width %d\n",
>  		max_speed, max_width);
>  	if (max_speed != NTB_SPEED_AUTO)
> -		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
> +		dev_dbg(&ntb->pdev->dev, "ignoring max_speed %d\n", max_speed);
>  	if (max_width != NTB_WIDTH_AUTO)
> -		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
> +		dev_dbg(&ntb->pdev->dev, "ignoring max_width %d\n", max_width);
>  
>  	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
>  	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
> @@ -1235,7 +1237,7 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
>  	if (ndev->ntb.topo == NTB_TOPO_SEC)
>  		return -EINVAL;
>  
> -	dev_dbg(ndev_dev(ndev), "Disabling link\n");
> +	dev_dbg(&ntb->pdev->dev, "Disabling link\n");
>  
>  	/* Bring NTB link down */
>  	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
> @@ -1442,30 +1444,33 @@ static int atom_link_is_err(struct intel_ntb_dev *ndev)
>  
>  static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
>  {
> +	struct device *dev = &ndev->ntb.pdev->dev;
> +
>  	switch (ppd & ATOM_PPD_TOPO_MASK) {
>  	case ATOM_PPD_TOPO_B2B_USD:
> -		dev_dbg(ndev_dev(ndev), "PPD %d B2B USD\n", ppd);
> +		dev_dbg(dev, "PPD %d B2B USD\n", ppd);
>  		return NTB_TOPO_B2B_USD;
>  
>  	case ATOM_PPD_TOPO_B2B_DSD:
> -		dev_dbg(ndev_dev(ndev), "PPD %d B2B DSD\n", ppd);
> +		dev_dbg(dev, "PPD %d B2B DSD\n", ppd);
>  		return NTB_TOPO_B2B_DSD;
>  
>  	case ATOM_PPD_TOPO_PRI_USD:
>  	case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
>  	case ATOM_PPD_TOPO_SEC_USD:
>  	case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
> -		dev_dbg(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
> +		dev_dbg(dev, "PPD %d non B2B disabled\n", ppd);
>  		return NTB_TOPO_NONE;
>  	}
>  
> -	dev_dbg(ndev_dev(ndev), "PPD %d invalid\n", ppd);
> +	dev_dbg(dev, "PPD %d invalid\n", ppd);
>  	return NTB_TOPO_NONE;
>  }
>  
>  static void atom_link_hb(struct work_struct *work)
>  {
>  	struct intel_ntb_dev *ndev = hb_ndev(work);
> +	struct device *dev = &ndev->ntb.pdev->dev;
>  	unsigned long poll_ts;
>  	void __iomem *mmio;
>  	u32 status32;
> @@ -1503,30 +1508,30 @@ static void atom_link_hb(struct work_struct *work)
>  
>  	/* Clear AER Errors, write to clear */
>  	status32 = ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "ERRCORSTS = %x\n", status32);
> +	dev_dbg(dev, "ERRCORSTS = %x\n", status32);
>  	status32 &= PCI_ERR_COR_REP_ROLL;
>  	iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
>  
>  	/* Clear unexpected electrical idle event in LTSSM, write to clear */
>  	status32 = ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "LTSSMERRSTS0 = %x\n", status32);
> +	dev_dbg(dev, "LTSSMERRSTS0 = %x\n", status32);
>  	status32 |= ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
>  	iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
>  
>  	/* Clear DeSkew Buffer error, write to clear */
>  	status32 = ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "DESKEWSTS = %x\n", status32);
> +	dev_dbg(dev, "DESKEWSTS = %x\n", status32);
>  	status32 |= ATOM_DESKEWSTS_DBERR;
>  	iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
>  
>  	status32 = ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "IBSTERRRCRVSTS0 = %x\n", status32);
> +	dev_dbg(dev, "IBSTERRRCRVSTS0 = %x\n", status32);
>  	status32 &= ATOM_IBIST_ERR_OFLOW;
>  	iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
>  
>  	/* Releases the NTB state machine to allow the link to retrain */
>  	status32 = ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "LTSSMSTATEJMP = %x\n", status32);
> +	dev_dbg(dev, "LTSSMSTATEJMP = %x\n", status32);
>  	status32 &= ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
>  	iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
>  
> @@ -1677,11 +1682,11 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	int b2b_bar;
>  	u8 bar_sz;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  	mmio = ndev->self_mmio;
>  
>  	if (ndev->b2b_idx == UINT_MAX) {
> -		dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
> +		dev_dbg(&pdev->dev, "not using b2b mw\n");
>  		b2b_bar = 0;
>  		ndev->b2b_off = 0;
>  	} else {
> @@ -1689,24 +1694,21 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		if (b2b_bar < 0)
>  			return -EIO;
>  
> -		dev_dbg(ndev_dev(ndev), "using b2b mw bar %d\n", b2b_bar);
> +		dev_dbg(&pdev->dev, "using b2b mw bar %d\n", b2b_bar);
>  
>  		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
>  
> -		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
> +		dev_dbg(&pdev->dev, "b2b bar size %#llx\n", bar_size);
>  
>  		if (b2b_mw_share && ((bar_size >> 1) >= XEON_B2B_MIN_SIZE)) {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b using first half of bar\n");
> +			dev_dbg(&pdev->dev, "b2b using first half of bar\n");
>  			ndev->b2b_off = bar_size >> 1;
>  		} else if (bar_size >= XEON_B2B_MIN_SIZE) {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b using whole bar\n");
> +			dev_dbg(&pdev->dev, "b2b using whole bar\n");
>  			ndev->b2b_off = 0;
>  			--ndev->mw_count;
>  		} else {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b bar size is too small\n");
> +			dev_dbg(&pdev->dev, "b2b bar size is too small\n");
>  			return -EIO;
>  		}
>  	}
> @@ -1716,7 +1718,7 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	 * except disable or halve the size of the b2b secondary bar.
>  	 */
>  	pci_read_config_byte(pdev, SKX_IMBAR1SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "IMBAR1SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "IMBAR1SZ %#x\n", bar_sz);
>  	if (b2b_bar == 1) {
>  		if (ndev->b2b_off)
>  			bar_sz -= 1;
> @@ -1726,10 +1728,10 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  
>  	pci_write_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, bar_sz);
>  	pci_read_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "EMBAR1SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "EMBAR1SZ %#x\n", bar_sz);
>  
>  	pci_read_config_byte(pdev, SKX_IMBAR2SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "IMBAR2SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "IMBAR2SZ %#x\n", bar_sz);
>  	if (b2b_bar == 2) {
>  		if (ndev->b2b_off)
>  			bar_sz -= 1;
> @@ -1739,7 +1741,7 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  
>  	pci_write_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, bar_sz);
>  	pci_read_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "EMBAR2SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "EMBAR2SZ %#x\n", bar_sz);
>  
>  	/* SBAR01 hit by first part of the b2b bar */
>  	if (b2b_bar == 0)
> @@ -1755,12 +1757,12 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	bar_addr = addr->bar2_addr64 + (b2b_bar == 1 ? ndev->b2b_off : 0);
>  	iowrite64(bar_addr, mmio + SKX_IMBAR1XLMT_OFFSET);
>  	bar_addr = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "IMBAR1XLMT %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "IMBAR1XLMT %#018llx\n", bar_addr);
>  
>  	bar_addr = addr->bar4_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
>  	iowrite64(bar_addr, mmio + SKX_IMBAR2XLMT_OFFSET);
>  	bar_addr = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "IMBAR2XLMT %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "IMBAR2XLMT %#018llx\n", bar_addr);
>  
>  	/* zero incoming translation addrs */
>  	iowrite64(0, mmio + SKX_IMBAR1XBASE_OFFSET);
> @@ -1830,7 +1832,7 @@ static int skx_init_dev(struct intel_ntb_dev *ndev)
>  	u8 ppd;
>  	int rc;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  
>  	ndev->reg = &skx_reg;
>  
> @@ -1839,7 +1841,7 @@ static int skx_init_dev(struct intel_ntb_dev *ndev)
>  		return -EIO;
>  
>  	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
> -	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
> +	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd,
>  		ntb_topo_string(ndev->ntb.topo));
>  	if (ndev->ntb.topo == NTB_TOPO_NONE)
>  		return -EINVAL;
> @@ -1863,14 +1865,14 @@ static int intel_ntb3_link_enable(struct ntb_dev *ntb,
>  
>  	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
>  
> -	dev_dbg(ndev_dev(ndev),
> +	dev_dbg(&ntb->pdev->dev,
>  		"Enabling link with max_speed %d max_width %d\n",
>  		max_speed, max_width);
>  
>  	if (max_speed != NTB_SPEED_AUTO)
> -		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
> +		dev_dbg(&ntb->pdev->dev, "ignoring max_speed %d\n", max_speed);
>  	if (max_width != NTB_WIDTH_AUTO)
> -		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
> +		dev_dbg(&ntb->pdev->dev, "ignoring max_width %d\n", max_width);
>  
>  	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
>  	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
> @@ -1931,7 +1933,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
>  		return -EIO;
>  	}
>  
> -	dev_dbg(ndev_dev(ndev), "BAR %d IMBARXBASE: %#Lx\n", bar, reg_val);
> +	dev_dbg(&ntb->pdev->dev, "BAR %d IMBARXBASE: %#Lx\n", bar, reg_val);
>  
>  	/* set and verify setting the limit */
>  	iowrite64(limit, mmio + limit_reg);
> @@ -1942,7 +1944,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
>  		return -EIO;
>  	}
>  
> -	dev_dbg(ndev_dev(ndev), "BAR %d IMBARXLMT: %#Lx\n", bar, reg_val);
> +	dev_dbg(&ntb->pdev->dev, "BAR %d IMBARXLMT: %#Lx\n", bar, reg_val);
>  
>  	/* setup the EP */
>  	limit_reg = ndev->xlat_reg->bar2_limit + (idx * 0x10) + 0x4000;
> @@ -1963,7 +1965,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
>  		return -EIO;
>  	}
>  
> -	dev_dbg(ndev_dev(ndev), "BAR %d EMBARXLMT: %#Lx\n", bar, reg_val);
> +	dev_dbg(&ntb->pdev->dev, "BAR %d EMBARXLMT: %#Lx\n", bar, reg_val);
>  
>  	return 0;
>  }
> @@ -2070,7 +2072,7 @@ static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
>  static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
>  {
>  	if (ppd & XEON_PPD_SPLIT_BAR_MASK) {
> -		dev_dbg(ndev_dev(ndev), "PPD %d split bar\n", ppd);
> +		dev_dbg(&ndev->ntb.pdev->dev, "PPD %d split bar\n", ppd);
>  		return 1;
>  	}
>  	return 0;
> @@ -2100,11 +2102,11 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	int b2b_bar;
>  	u8 bar_sz;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  	mmio = ndev->self_mmio;
>  
>  	if (ndev->b2b_idx == UINT_MAX) {
> -		dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
> +		dev_dbg(&pdev->dev, "not using b2b mw\n");
>  		b2b_bar = 0;
>  		ndev->b2b_off = 0;
>  	} else {
> @@ -2112,24 +2114,21 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		if (b2b_bar < 0)
>  			return -EIO;
>  
> -		dev_dbg(ndev_dev(ndev), "using b2b mw bar %d\n", b2b_bar);
> +		dev_dbg(&pdev->dev, "using b2b mw bar %d\n", b2b_bar);
>  
>  		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
>  
> -		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
> +		dev_dbg(&pdev->dev, "b2b bar size %#llx\n", bar_size);
>  
>  		if (b2b_mw_share && XEON_B2B_MIN_SIZE <= bar_size >> 1) {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b using first half of bar\n");
> +			dev_dbg(&pdev->dev, "b2b using first half of bar\n");
>  			ndev->b2b_off = bar_size >> 1;
>  		} else if (XEON_B2B_MIN_SIZE <= bar_size) {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b using whole bar\n");
> +			dev_dbg(&pdev->dev, "b2b using whole bar\n");
>  			ndev->b2b_off = 0;
>  			--ndev->mw_count;
>  		} else {
> -			dev_dbg(ndev_dev(ndev),
> -				"b2b bar size is too small\n");
> +			dev_dbg(&pdev->dev, "b2b bar size is too small\n");
>  			return -EIO;
>  		}
>  	}
> @@ -2141,7 +2140,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	 * offsets are not in a consistent order (bar5sz comes after ppd, odd).
>  	 */
>  	pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "PBAR23SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "PBAR23SZ %#x\n", bar_sz);
>  	if (b2b_bar == 2) {
>  		if (ndev->b2b_off)
>  			bar_sz -= 1;
> @@ -2150,11 +2149,11 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	}
>  	pci_write_config_byte(pdev, XEON_SBAR23SZ_OFFSET, bar_sz);
>  	pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &bar_sz);
> -	dev_dbg(ndev_dev(ndev), "SBAR23SZ %#x\n", bar_sz);
> +	dev_dbg(&pdev->dev, "SBAR23SZ %#x\n", bar_sz);
>  
>  	if (!ndev->bar4_split) {
>  		pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "PBAR45SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "PBAR45SZ %#x\n", bar_sz);
>  		if (b2b_bar == 4) {
>  			if (ndev->b2b_off)
>  				bar_sz -= 1;
> @@ -2163,10 +2162,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		}
>  		pci_write_config_byte(pdev, XEON_SBAR45SZ_OFFSET, bar_sz);
>  		pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "SBAR45SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "SBAR45SZ %#x\n", bar_sz);
>  	} else {
>  		pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "PBAR4SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "PBAR4SZ %#x\n", bar_sz);
>  		if (b2b_bar == 4) {
>  			if (ndev->b2b_off)
>  				bar_sz -= 1;
> @@ -2175,10 +2174,10 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		}
>  		pci_write_config_byte(pdev, XEON_SBAR4SZ_OFFSET, bar_sz);
>  		pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "SBAR4SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "SBAR4SZ %#x\n", bar_sz);
>  
>  		pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "PBAR5SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "PBAR5SZ %#x\n", bar_sz);
>  		if (b2b_bar == 5) {
>  			if (ndev->b2b_off)
>  				bar_sz -= 1;
> @@ -2187,7 +2186,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		}
>  		pci_write_config_byte(pdev, XEON_SBAR5SZ_OFFSET, bar_sz);
>  		pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET, &bar_sz);
> -		dev_dbg(ndev_dev(ndev), "SBAR5SZ %#x\n", bar_sz);
> +		dev_dbg(&pdev->dev, "SBAR5SZ %#x\n", bar_sz);
>  	}
>  
>  	/* SBAR01 hit by first part of the b2b bar */
> @@ -2204,7 +2203,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	else
>  		return -EIO;
>  
> -	dev_dbg(ndev_dev(ndev), "SBAR01 %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "SBAR01 %#018llx\n", bar_addr);
>  	iowrite64(bar_addr, mmio + XEON_SBAR0BASE_OFFSET);
>  
>  	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
> @@ -2215,26 +2214,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
>  	iowrite64(bar_addr, mmio + XEON_SBAR23BASE_OFFSET);
>  	bar_addr = ioread64(mmio + XEON_SBAR23BASE_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "SBAR23 %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "SBAR23 %#018llx\n", bar_addr);
>  
>  	if (!ndev->bar4_split) {
>  		bar_addr = addr->bar4_addr64 +
>  			(b2b_bar == 4 ? ndev->b2b_off : 0);
>  		iowrite64(bar_addr, mmio + XEON_SBAR45BASE_OFFSET);
>  		bar_addr = ioread64(mmio + XEON_SBAR45BASE_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR45 %#018llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR45 %#018llx\n", bar_addr);
>  	} else {
>  		bar_addr = addr->bar4_addr32 +
>  			(b2b_bar == 4 ? ndev->b2b_off : 0);
>  		iowrite32(bar_addr, mmio + XEON_SBAR4BASE_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_SBAR4BASE_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR4 %#010llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR4 %#010llx\n", bar_addr);
>  
>  		bar_addr = addr->bar5_addr32 +
>  			(b2b_bar == 5 ? ndev->b2b_off : 0);
>  		iowrite32(bar_addr, mmio + XEON_SBAR5BASE_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_SBAR5BASE_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR5 %#010llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR5 %#010llx\n", bar_addr);
>  	}
>  
>  	/* setup incoming bar limits == base addrs (zero length windows) */
> @@ -2242,26 +2241,26 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
>  	iowrite64(bar_addr, mmio + XEON_SBAR23LMT_OFFSET);
>  	bar_addr = ioread64(mmio + XEON_SBAR23LMT_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "SBAR23LMT %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "SBAR23LMT %#018llx\n", bar_addr);
>  
>  	if (!ndev->bar4_split) {
>  		bar_addr = addr->bar4_addr64 +
>  			(b2b_bar == 4 ? ndev->b2b_off : 0);
>  		iowrite64(bar_addr, mmio + XEON_SBAR45LMT_OFFSET);
>  		bar_addr = ioread64(mmio + XEON_SBAR45LMT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR45LMT %#018llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR45LMT %#018llx\n", bar_addr);
>  	} else {
>  		bar_addr = addr->bar4_addr32 +
>  			(b2b_bar == 4 ? ndev->b2b_off : 0);
>  		iowrite32(bar_addr, mmio + XEON_SBAR4LMT_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_SBAR4LMT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR4LMT %#010llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR4LMT %#010llx\n", bar_addr);
>  
>  		bar_addr = addr->bar5_addr32 +
>  			(b2b_bar == 5 ? ndev->b2b_off : 0);
>  		iowrite32(bar_addr, mmio + XEON_SBAR5LMT_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_SBAR5LMT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "SBAR5LMT %#05llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "SBAR5LMT %#05llx\n", bar_addr);
>  	}
>  
>  	/* zero incoming translation addrs */
> @@ -2287,23 +2286,23 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  	bar_addr = peer_addr->bar2_addr64;
>  	iowrite64(bar_addr, mmio + XEON_PBAR23XLAT_OFFSET);
>  	bar_addr = ioread64(mmio + XEON_PBAR23XLAT_OFFSET);
> -	dev_dbg(ndev_dev(ndev), "PBAR23XLAT %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "PBAR23XLAT %#018llx\n", bar_addr);
>  
>  	if (!ndev->bar4_split) {
>  		bar_addr = peer_addr->bar4_addr64;
>  		iowrite64(bar_addr, mmio + XEON_PBAR45XLAT_OFFSET);
>  		bar_addr = ioread64(mmio + XEON_PBAR45XLAT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "PBAR45XLAT %#018llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "PBAR45XLAT %#018llx\n", bar_addr);
>  	} else {
>  		bar_addr = peer_addr->bar4_addr32;
>  		iowrite32(bar_addr, mmio + XEON_PBAR4XLAT_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_PBAR4XLAT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "PBAR4XLAT %#010llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "PBAR4XLAT %#010llx\n", bar_addr);
>  
>  		bar_addr = peer_addr->bar5_addr32;
>  		iowrite32(bar_addr, mmio + XEON_PBAR5XLAT_OFFSET);
>  		bar_addr = ioread32(mmio + XEON_PBAR5XLAT_OFFSET);
> -		dev_dbg(ndev_dev(ndev), "PBAR5XLAT %#010llx\n", bar_addr);
> +		dev_dbg(&pdev->dev, "PBAR5XLAT %#010llx\n", bar_addr);
>  	}
>  
>  	/* set the translation offset for b2b registers */
> @@ -2321,7 +2320,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  		return -EIO;
>  
>  	/* B2B_XLAT_OFFSET is 64bit, but can only take 32bit writes */
> -	dev_dbg(ndev_dev(ndev), "B2BXLAT %#018llx\n", bar_addr);
> +	dev_dbg(&pdev->dev, "B2BXLAT %#018llx\n", bar_addr);
>  	iowrite32(bar_addr, mmio + XEON_B2B_XLAT_OFFSETL);
>  	iowrite32(bar_addr >> 32, mmio + XEON_B2B_XLAT_OFFSETU);
>  
> @@ -2340,6 +2339,7 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  
>  static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  {
> +	struct device *dev = &ndev->ntb.pdev->dev;
>  	int rc;
>  	u32 ntb_ctl;
>  
> @@ -2355,7 +2355,7 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  	switch (ndev->ntb.topo) {
>  	case NTB_TOPO_PRI:
>  		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> -			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
> +			dev_err(dev, "NTB Primary config disabled\n");
>  			return -EINVAL;
>  		}
>  
> @@ -2373,7 +2373,7 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  
>  	case NTB_TOPO_SEC:
>  		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> -			dev_err(ndev_dev(ndev), "NTB Secondary config disabled\n");
> +			dev_err(dev, "NTB Secondary config disabled\n");
>  			return -EINVAL;
>  		}
>  		/* use half the spads for the peer */
> @@ -2398,18 +2398,17 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  				ndev->b2b_idx = b2b_mw_idx;
>  
>  			if (ndev->b2b_idx >= ndev->mw_count) {
> -				dev_dbg(ndev_dev(ndev),
> +				dev_dbg(dev,
>  					"b2b_mw_idx %d invalid for mw_count %u\n",
>  					b2b_mw_idx, ndev->mw_count);
>  				return -EINVAL;
>  			}
>  
> -			dev_dbg(ndev_dev(ndev),
> -				"setting up b2b mw idx %d means %d\n",
> +			dev_dbg(dev, "setting up b2b mw idx %d means %d\n",
>  				b2b_mw_idx, ndev->b2b_idx);
>  
>  		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
> -			dev_warn(ndev_dev(ndev), "Reduce doorbell count by 1\n");
> +			dev_warn(dev, "Reduce doorbell count by 1\n");
>  			ndev->db_count -= 1;
>  		}
>  
> @@ -2450,7 +2449,7 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
>  	u8 ppd;
>  	int rc, mem;
>  
> -	pdev = ndev_pdev(ndev);
> +	pdev = ndev->ntb.pdev;
>  
>  	switch (pdev->device) {
>  	/* There is a Xeon hardware errata related to writes to SDOORBELL or
> @@ -2526,14 +2525,14 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
>  		return -EIO;
>  
>  	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
> -	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
> +	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd,
>  		ntb_topo_string(ndev->ntb.topo));
>  	if (ndev->ntb.topo == NTB_TOPO_NONE)
>  		return -EINVAL;
>  
>  	if (ndev->ntb.topo != NTB_TOPO_SEC) {
>  		ndev->bar4_split = xeon_ppd_bar4_split(ndev, ppd);
> -		dev_dbg(ndev_dev(ndev), "ppd %#x bar4_split %d\n",
> +		dev_dbg(&pdev->dev, "ppd %#x bar4_split %d\n",
>  			ppd, ndev->bar4_split);
>  	} else {
>  		/* This is a way for transparent BAR to figure out if we are
> @@ -2543,7 +2542,7 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
>  		mem = pci_select_bars(pdev, IORESOURCE_MEM);
>  		ndev->bar4_split = hweight32(mem) ==
>  			HSX_SPLIT_BAR_MW_COUNT + 1;
> -		dev_dbg(ndev_dev(ndev), "mem %#x bar4_split %d\n",
> +		dev_dbg(&pdev->dev, "mem %#x bar4_split %d\n",
>  			mem, ndev->bar4_split);
>  	}
>  
> @@ -2580,7 +2579,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
> -		dev_warn(ndev_dev(ndev), "Cannot DMA highmem\n");
> +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>  
>  	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> @@ -2588,7 +2587,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
> -		dev_warn(ndev_dev(ndev), "Cannot DMA consistent highmem\n");
> +		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>  	}
>  
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
> @@ -2614,7 +2613,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  
>  static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
>  {
> -	struct pci_dev *pdev = ndev_pdev(ndev);
> +	struct pci_dev *pdev = ndev->ntb.pdev;
>  
>  	if (ndev->peer_mmio && ndev->peer_mmio != ndev->self_mmio)
>  		pci_iounmap(pdev, ndev->peer_mmio);
> @@ -2986,4 +2985,3 @@ static void __exit intel_ntb_pci_driver_exit(void)
>  	debugfs_remove_recursive(debugfs_dir);
>  }
>  module_exit(intel_ntb_pci_driver_exit);
> -
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index f2cf8a7..2d6c38a 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -382,9 +382,6 @@ struct intel_ntb_dev {
>  	struct dentry			*debugfs_info;
>  };
>  
> -#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
> -#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> -#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
>  #define ntb_ndev(__ntb) container_of(__ntb, struct intel_ntb_dev, ntb)
>  #define hb_ndev(__work) container_of(__work, struct intel_ntb_dev, \
>  				     hb_timer.work)
> -- 
> 2.1.4
> 
