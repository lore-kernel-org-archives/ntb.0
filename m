Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id r1-v6si816636ioa.5.2018.06.11.13.50.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 13:50:27 -0700 (PDT)
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
References: <20180611203926.2666-1-jdmason@kudzu.us>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <d2083cc5-2254-e97a-37a1-b58777d53db2@intel.com>
Date: Mon, 11 Jun 2018 13:50:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180611203926.2666-1-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 06/11/2018 01:39 PM, Jon Mason wrote:
> The tx_time should be in usecs (according to the comment above the
> variable), but the setting of the timer during the rearming is done in
> msecs.  Change it to match the expected units.
> 
> Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
> Suggested-by: Gerd W. Haeussler <gerd.haeussler@cesys-it.com>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 9f6f7ccd44f7..306a662eba94 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -236,7 +236,7 @@ static void ntb_netdev_tx_timer(struct timer_list *t)
>  	struct net_device *ndev = dev->ndev;
>  
>  	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
> -		mod_timer(&dev->tx_timer, jiffies + msecs_to_jiffies(tx_time));
> +		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
>  	} else {
>  		/* Make sure anybody stopping the queue after this sees the new
>  		 * value of ntb_transport_tx_free_entry()
> 
