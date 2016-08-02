Return-Path: <Allen.Hubbe@emc.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id m82si148016ywm.2.2016.08.02.06.46.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 06:46:16 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160802114821.3765-1-baolex.ni@intel.com>
In-Reply-To: <20160802114821.3765-1-baolex.ni@intel.com>
Subject: RE: [PATCH 0807/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 09:45:55 -0400
Message-ID: <000001d1ecc4$324df510$96e9df30$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Baole Ni' <baolex.ni@intel.com>, jdmason@kudzu.us, dave.jiang@intel.com, linuxwifi@intel.com, kvalo@codeaurora.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-ID: <linux-ntb.googlegroups.com>

From: Baole Ni
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 40d04ef..7aa1faa 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -92,56 +92,56 @@ static const struct file_operations intel_ntb_debugfs_info;
>  static struct dentry *debugfs_dir;
> 
>  static int b2b_mw_idx = -1;
> -module_param(b2b_mw_idx, int, 0644);
> +module_param(b2b_mw_idx, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

The result of this change should be simplified to S_IWUSR | S_IRUGO.

>  module_param_named(xeon_b2b_usd_bar2_addr64,
> -		   xeon_b2b_usd_addr.bar2_addr64, ullong, 0644);
> +		   xeon_b2b_usd_addr.bar2_addr64, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

This line is 97 columns long.

The result of this change should be simplified to S_IWUSR | S_IRUGO, and that might put it under 80 columns.  There are bound to still be other places where this kind of replacement will require additional changes to code formatting.

