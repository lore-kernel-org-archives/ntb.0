Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id p22si298888ywe.3.2016.12.01.18.23.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Dec 2016 18:23:01 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <7f3cc2fa-7899-a387-4822-d515c403fcfa@amd.com>
In-Reply-To: <7f3cc2fa-7899-a387-4822-d515c403fcfa@amd.com>
Subject: RE: [PATCH 2/2] NTB: Register and offset values fix for memory window
Date: Thu, 1 Dec 2016 21:22:37 -0500
Message-ID: <000001d24c42$f407cc70$dc176550$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Shyam Sundar S K' <ssundark@amd.com>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Shyam Sundar S K
> Due to incorrect limit and translation register values, NTB link was
> going down when the memory window was setup. Made appropriate changes
> as per spec.
> 
> Fix limit register values for BAR1, which was overlapping
> with the BAR23 address.
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 6ccba0d..d59f494 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -138,11 +138,11 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
>  	base_addr = pci_resource_start(ndev->ntb.pdev, bar);
> 
>  	if (bar != 1) {
> -		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 3);
> -		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 3);
> +		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 2);
> +		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 2);
> 
>  		/* Set the limit if supported */
> -		limit = base_addr + size;
> +		limit = size;
> 
>  		/* set and verify setting the translation address */
>  		write64(addr, peer_mmio + xlat_reg);
> @@ -164,14 +164,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
>  		xlat_reg = AMD_BAR1XLAT_OFFSET;
>  		limit_reg = AMD_BAR1LMT_OFFSET;
> 
> -		/* split bar addr range must all be 32 bit */
> -		if (addr & (~0ull << 32))
> -			return -EINVAL;
> -		if ((addr + size) & (~0ull << 32))
> -			return -EINVAL;
> -
>  		/* Set the limit if supported */
> -		limit = base_addr + size;
> +		limit = size;
> 
>  		/* set and verify setting the translation address */
>  		write64(addr, peer_mmio + xlat_reg);
> --
> 2.7.4

