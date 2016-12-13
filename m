Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id z131si2431612ywz.4.2016.12.12.20.14.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 20:14:49 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH v2 8/9] NTB: Add PCIe Gen4 link speed
Date: Mon, 12 Dec 2016 23:14:20 -0500
Message-ID: <000701d254f7$622876c0$26796440$@dell.com>
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
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> 
> ---
>  include/linux/ntb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 90746df..fe0437c 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -108,6 +108,7 @@ static inline char *ntb_topo_string(enum ntb_topo topo)
>   * @NTB_SPEED_GEN1:	Link is trained to gen1 speed.
>   * @NTB_SPEED_GEN2:	Link is trained to gen2 speed.
>   * @NTB_SPEED_GEN3:	Link is trained to gen3 speed.
> + * @NTB_SPEED_GEN4:	Link is trained to gen4 speed.
>   */
>  enum ntb_speed {
>  	NTB_SPEED_AUTO = -1,
> @@ -115,6 +116,7 @@ enum ntb_speed {
>  	NTB_SPEED_GEN1 = 1,
>  	NTB_SPEED_GEN2 = 2,
>  	NTB_SPEED_GEN3 = 3,
> +	NTB_SPEED_GEN4 = 4
>  };
> 
>  /**
> --
> 2.6.6


