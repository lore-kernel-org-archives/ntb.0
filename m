Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id i64si63348ywg.11.2017.06.09.06.51.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 06:51:46 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <149695115133.26451.13997592259493006219.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <149695115133.26451.13997592259493006219.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v2] ntb: ntb_hw_intel: Skylake doorbells should be 32bits, not 64bits
Date: Fri, 9 Jun 2017 09:51:30 -0400
Message-ID: <000001d2e127$7fb8d740$7f2a85c0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, ujjal.singh@intel.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang 
> Fixing doorbell register length to 32bits per spec. On Skylake NTB, the
> doorbell registers are 32bit write only registers. The source for the doorbell is
> a 64bit register that shows the interrupt bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
> 
> v2: Allen: remove unnecessary change to code.
> 
>  drivers/ntb/hw/intel/ntb_hw_intel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c
> b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index c002384..7b3b6fd 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -2878,7 +2878,7 @@ static const struct intel_ntb_reg skx_reg = {
>  	.link_is_up		= xeon_link_is_up,
>  	.db_ioread		= skx_db_ioread,
>  	.db_iowrite		= skx_db_iowrite,
> -	.db_size		= sizeof(u64),
> +	.db_size		= sizeof(u32),
>  	.ntb_ctl		= SKX_NTBCNTL_OFFSET,
>  	.mw_bar			= {2, 4},
>  };


