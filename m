Return-Path: <Allen.Hubbe@emc.com>
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com. [68.232.149.220])
        by gmr-mx.google.com with ESMTPS id e130si2595032ywh.4.2016.08.08.06.08.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 06:08:34 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1470649722-29709-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1470649722-29709-1-git-send-email-weiyj.lk@gmail.com>
Subject: RE: [PATCH] NTB: ntb_hw_intel: Fix typo in module parameter descriptions
Date: Mon, 8 Aug 2016 09:08:10 -0400
Message-ID: <000101d1f175$e9d800d0$bd880270$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Wei Yongjun' <weiyj.lk@gmail.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Wei Yongjun
> Fix typo in module parameter descriptions.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 0d5c29a..1ee61d9 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -112,17 +112,17 @@ MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
> 
>  module_param_named(xeon_b2b_usd_bar4_addr64,
>  		   xeon_b2b_usd_addr.bar4_addr64, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr64,
>  		 "XEON B2B USD BAR 4 64-bit address");
> 
>  module_param_named(xeon_b2b_usd_bar4_addr32,
>  		   xeon_b2b_usd_addr.bar4_addr32, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr32,
>  		 "XEON B2B USD split-BAR 4 32-bit address");
> 
>  module_param_named(xeon_b2b_usd_bar5_addr32,
>  		   xeon_b2b_usd_addr.bar5_addr32, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_usd_bar5_addr32,
>  		 "XEON B2B USD split-BAR 5 32-bit address");
> 
>  module_param_named(xeon_b2b_dsd_bar2_addr64,
> @@ -132,17 +132,17 @@ MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
> 
>  module_param_named(xeon_b2b_dsd_bar4_addr64,
>  		   xeon_b2b_dsd_addr.bar4_addr64, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr64,
>  		 "XEON B2B DSD BAR 4 64-bit address");
> 
>  module_param_named(xeon_b2b_dsd_bar4_addr32,
>  		   xeon_b2b_dsd_addr.bar4_addr32, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr32,
>  		 "XEON B2B DSD split-BAR 4 32-bit address");
> 
>  module_param_named(xeon_b2b_dsd_bar5_addr32,
>  		   xeon_b2b_dsd_addr.bar5_addr32, ullong, 0644);
> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
> +MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
>  		 "XEON B2B DSD split-BAR 5 32-bit address");
> 
>  #ifndef ioread64

