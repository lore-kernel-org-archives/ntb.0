Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id p22si1254474ywe.3.2016.12.07.14.56.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 14:56:25 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com> <1480439777-1080-11-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-11-git-send-email-fancer.lancer@gmail.com>
Subject: RE: [PATCH 10/22] NTB Intel: Add port-related NTB API callback methods
Date: Wed, 7 Dec 2016 17:56:09 -0500
Message-ID: <004001d250dd$19e0e7d0$4da2b770$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
>

This needs an actual commit message.

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 195 +++++++++++++++++++++---------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  10 ++
>  2 files changed, 124 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index d3da0ce..724ccfe 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c

I am leaning more toward recommending that the topo api be left alone.

See RE: [PATCH 02/22] NTB: Add peer indexed ports NTB API

This is context for that response, highlighting 

> @@ -1464,31 +1490,37 @@ static int xeon_poll_link(struct intel_ntb_dev *ndev)
> 
>  static int xeon_link_is_up(struct intel_ntb_dev *ndev)
>  {
> -	if (ndev->ntb.topo == NTB_TOPO_SEC)
> +	if (ndev->ntb.port == NTB_PORT_SEC)

Should this also check ntb.topo == P2P?  I think just checking ntb.port is incorrect, because ntb.port is also used with ntb.topo == B2B to distinguish "upstream" and "downstream" topologies.

ndev->ntb.topo == NTB_TOPO_P2P && ndev->ntb.port == NTB_PORT_SEC

>  		return 1;
> 
>  	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
>  }
> 

Also, the changes to xeon_link_is_up cause a merge conflict with https://github.com/davejiang/linux ntb.

> 
>  static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
> @@ -1776,39 +1808,39 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  	ndev->db_count = XEON_DB_COUNT;
>  	ndev->db_link_mask = XEON_DB_LINK_BIT;
> 
> -	switch (ndev->ntb.topo) {
> -	case NTB_TOPO_PRI:
> -		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> -			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
> -			return -EINVAL;
> -		}
> -
> -		/* enable link to allow secondary side device to appear */
> -		ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
> -		ntb_ctl &= ~NTB_CTL_DISABLE;
> -		iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
> -
> -		/* use half the spads for the peer */
> -		ndev->spad_count >>= 1;
> -		ndev->self_reg = &xeon_pri_reg;
> -		ndev->peer_reg = &xeon_sec_reg;
> -		ndev->xlat_reg = &xeon_sec_xlat;
> -		break;
> +	if (ndev->ntb.topo == NTB_TOPO_P2P) {
> +		if (ndev->ntb.port == NTB_PORT_PRI) {

This was one case in a switch statement, now two branches.

> +			if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> +				dev_err(ndev_dev(ndev),
> +					"NTB Primary config disabled\n");
> +				return -EINVAL;
> +			}
> 
> -	case NTB_TOPO_SEC:
> -		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> -			dev_err(ndev_dev(ndev), "NTB Secondary config disabled\n");
> -			return -EINVAL;
> +			/* enable link to allow secondary side dev to appear */
> +			ntb_ctl = ioread32(ndev->self_mmio +
> +					   ndev->reg->ntb_ctl);
> +			ntb_ctl &= ~NTB_CTL_DISABLE;
> +			iowrite32(ntb_ctl, ndev->self_mmio +
> +				  ndev->reg->ntb_ctl);

The nested if has increased the indentation, and lines have had to be further split to conform to coding standards.

The indentation changes here affect many lines of code, and create a complicated merge with https://github.com/davejiang/linux ntb.

> +
> +			/* use half the spads for the peer */
> +			ndev->spad_count >>= 1;
> +			ndev->self_reg = &xeon_pri_reg;
> +			ndev->peer_reg = &xeon_sec_reg;
> +			ndev->xlat_reg = &xeon_sec_xlat;
> +		} else {
> +			if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
> +				dev_err(ndev_dev(ndev),
> +					"NTB Secondary config disabled\n");
> +				return -EINVAL;
> +			}
> +			/* use half the spads for the peer */
> +			ndev->spad_count >>= 1;
> +			ndev->self_reg = &xeon_sec_reg;
> +			ndev->peer_reg = &xeon_pri_reg;
> +			ndev->xlat_reg = &xeon_pri_xlat;
>  		}
> -		/* use half the spads for the peer */
> -		ndev->spad_count >>= 1;
> -		ndev->self_reg = &xeon_sec_reg;
> -		ndev->peer_reg = &xeon_pri_reg;
> -		ndev->xlat_reg = &xeon_pri_xlat;
> -		break;
> -
> -	case NTB_TOPO_B2B_USD:
> -	case NTB_TOPO_B2B_DSD:
> +	} else {

This else combines two cases in a switch statement, but is no less complex than what existed previously.

The case labels provided context for readability that is lost with else.  Now to understand the context of this else, one must now jump upwards by about a page to find the matching if.

>  		ndev->self_reg = &xeon_pri_reg;
>  		ndev->peer_reg = &xeon_b2b_reg;
>  		ndev->xlat_reg = &xeon_sec_xlat;
> @@ -1833,11 +1865,12 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
>  				b2b_mw_idx, ndev->b2b_idx);
> 
>  		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
> -			dev_warn(ndev_dev(ndev), "Reduce doorbell count by 1\n");
> +			dev_warn(ndev_dev(ndev),
> +				"Reduce doorbell count by 1\n");

Please split cleanup changes into a separate patch.

>  			ndev->db_count -= 1;
>  		}
> 
> -		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
> +		if (ndev->ntb.port == NTB_PORT_PRI) {

This is correct, but it is not obvious.  This is in the context of "else" as noted above.  At this point we need to jump several pages above to find the matching "if" to understand the context.

Prior to the change, the case labels made it clear that ntb.topo is B2B here.

>  			rc = xeon_setup_b2b_mw(ndev,
>  					       &xeon_b2b_dsd_addr,
>  					       &xeon_b2b_usd_addr);

