Return-Path: <Allen.Hubbe@emc.com>
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com. [68.232.149.220])
        by gmr-mx.google.com with ESMTPS id f206si900253ywb.6.2016.08.24.15.04.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 15:04:55 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <147207338678.160450.10674653800874976448.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <147207338678.160450.10674653800874976448.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH] ntb: ntb_hw_intel: init peer_addr in struct intel_ntb_dev
Date: Wed, 24 Aug 2016 18:04:36 -0400
Message-ID: <000101d1fe53$8112f920$8338eb60$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> The peer_addr member of intel_ntb_dev is not set, therefore when
> acquiring ntb_peer_db and ntb_peer_spad we only get the offset rather
> than the actual physical address. Adding fix to correct that.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 40d04ef..3ad1f15 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -1718,6 +1718,8 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
>  					    XEON_B2B_MIN_SIZE);
>  		if (!ndev->peer_mmio)
>  			return -EIO;
> +
> +		ndev->peer_addr = pci_resource_start(pdev, b2b_bar);
>  	}
> 
>  	return 0;
> @@ -1982,6 +1984,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct
> pci_dev *pdev)
>  		goto err_mmio;
>  	}
>  	ndev->peer_mmio = ndev->self_mmio;
> +	ndev->peer_addr = pci_resource_start(pdev, 0);
> 
>  	return 0;
> 


