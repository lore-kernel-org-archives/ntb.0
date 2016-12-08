Return-Path: <Allen.Hubbe@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id p22si1506648ywe.3.2016.12.08.09.16.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 09:17:00 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <297aec6b47924ce9889abe4d6c51c173@mspexmb1.Beer.Town> <89e7f17cb62a4a62a02673b10bf4a967@mspexmb1.Beer.Town>
In-Reply-To: <89e7f17cb62a4a62a02673b10bf4a967@mspexmb1.Beer.Town>
Subject: RE: [PATCH] ntb_transport: Remove unnecessary call to ntb_peer_spad_read.
Date: Thu, 8 Dec 2016 12:16:45 -0500
Message-ID: <002001d25176$da7cabc0$8f760340$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: "Wahl, Steve" <Steve.Wahl@dell.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Steven Wahl 
> The results were previously ignored, anyway.
> 
> Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>

Fixes: e26a5843f7f5014ae4460030ca4de029a3ac35d3

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb_transport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4eb8adb..cd9a392 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -960,7 +960,6 @@ static void ntb_qp_link_work(struct work_struct *work)
>         ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));
> 
>         /* query remote spad for qp ready bits */
> -       ntb_peer_spad_read(nt->ndev, QP_LINKS);
>         dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
> 
>         /* See if the remote side is up */
> --
> 2.7.4

