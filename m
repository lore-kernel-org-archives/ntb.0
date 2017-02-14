Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id o207si66355ywo.6.2017.02.14.06.20.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 06:20:19 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <742181292.969165.1487025986540.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <742181292.969165.1487025986540.JavaMail.zimbra@xes-inc.com>
Subject: RE: ntb_transport: Pick an unused queue
Date: Tue, 14 Feb 2017 09:20:00 -0500
Message-ID: <000001d286cd$6d62e0e0$4828a2a0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Aaron Sierra' <asierra@xes-inc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, 'Thomas Vanselus' <tvanselus@xes-inc.com>
List-ID: <linux-ntb.googlegroups.com>

From: Aaron Sierra
> From: Thomas VanSelus <tvanselus@xes-inc.com>
> 
> Fix typo causing ntb_transport_create_queue to select the first
> queue every time, instead of using the next free queue.
> 
> Signed-off-by: Thomas VanSelus <tvanselus@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f81aa4b..95b5540 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1802,7 +1802,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> 
>  	node = dev_to_node(&ndev->dev);
> 
> -	free_queue = ffs(nt->qp_bitmap);
> +	free_queue = ffs(nt->qp_bitmap_free);
>  	if (!free_queue)
>  		goto err;
> 

