Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com. [2607:f8b0:400d:c09::241])
        by gmr-mx.google.com with ESMTPS id u30si1190706ywh.7.2017.02.16.17.07.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:07:14 -0800 (PST)
Received: by mail-qk0-x241.google.com with SMTP id 11so4751365qkl.0
        for <linux-ntb@googlegroups.com>; Thu, 16 Feb 2017 17:07:14 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 16 Feb 2017 20:07:12 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: ntb_hw_intel: link_poll isn't clearing the pending
 status properly
Message-ID: <20170217010711.GA1207@kudzu.us>
References: <148728735682.1188.5989205862351479482.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148728735682.1188.5989205862351479482.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Feb 16, 2017 at 04:22:36PM -0700, Dave Jiang wrote:
> On Skylake hardware, the link_poll isn't clearing the pending interrupt
> bit.  Adding a new function for SKX that handles clearing of status bit the
> right way.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Pulled into my ntb branch.  I'll give it a couple of hours for the
bots to build test it, then I'll give a pull request to Linux (assuming
that it isn't too late in the cycle).

Thanks,
Jon


> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index eca9688..c002384 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -1629,6 +1629,28 @@ static void atom_deinit_dev(struct intel_ntb_dev *ndev)
>  
>  /* Skylake Xeon NTB */
>  
> +static int skx_poll_link(struct intel_ntb_dev *ndev)
> +{
> +	u16 reg_val;
> +	int rc;
> +
> +	ndev->reg->db_iowrite(ndev->db_link_mask,
> +			      ndev->self_mmio +
> +			      ndev->self_reg->db_clear);
> +
> +	rc = pci_read_config_word(ndev->ntb.pdev,
> +				  SKX_LINK_STATUS_OFFSET, &reg_val);
> +	if (rc)
> +		return 0;
> +
> +	if (reg_val == ndev->lnk_sta)
> +		return 0;
> +
> +	ndev->lnk_sta = reg_val;
> +
> +	return 1;
> +}
> +
>  static u64 skx_db_ioread(void __iomem *mmio)
>  {
>  	return ioread64(mmio);
> @@ -2852,7 +2874,7 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
>  };
>  
>  static const struct intel_ntb_reg skx_reg = {
> -	.poll_link		= xeon_poll_link,
> +	.poll_link		= skx_poll_link,
>  	.link_is_up		= xeon_link_is_up,
>  	.db_ioread		= skx_db_ioread,
>  	.db_iowrite		= skx_db_iowrite,
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/148728735682.1188.5989205862351479482.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
