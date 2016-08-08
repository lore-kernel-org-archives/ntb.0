Return-Path: <Allen.Hubbe@emc.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id e130si2594589ywh.4.2016.08.08.06.07.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 06:07:33 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1470649680-29533-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1470649680-29533-1-git-send-email-weiyj.lk@gmail.com>
Subject: RE: [PATCH] ntb_pingpong: Fix db_init parameter description
Date: Mon, 8 Aug 2016 09:07:17 -0400
Message-ID: <000001d1f175$cae862f0$60b928d0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Wei Yongjun' <weiyj.lk@gmail.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Logan Gunthorpe' <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Wei Yongjun
> Fix 'db_init' parameter description.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_pingpong.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 7d31179..4358611 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -88,7 +88,7 @@ MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to
> peer");
> 
>  static unsigned long db_init = 0x7;
>  module_param(db_init, ulong, 0644);
> -MODULE_PARM_DESC(delay_ms, "Initial doorbell bits to ring on the peer");
> +MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
> 
>  struct pp_ctx {
>  	struct ntb_dev			*ntb;

