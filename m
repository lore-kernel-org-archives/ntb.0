Return-Path: <jdmason@kudzu.us>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com. [2607:f8b0:4002:c09::241])
        by gmr-mx.google.com with ESMTPS id y81-v6si1633243itc.2.2018.05.21.17.35.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 17:35:05 -0700 (PDT)
Received: by mail-yb0-x241.google.com with SMTP id s8-v6so4479429ybp.11
        for <linux-ntb@googlegroups.com>; Mon, 21 May 2018 17:35:05 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 21 May 2018 20:35:03 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 2/2] ntb: ntb_transport: Replace GFP_ATOMIC with
 GFP_KERNEL in ntb_transport_create_queue
Message-ID: <20180522003503.GA3255@kudzu.us>
References: <1523366274-31737-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523366274-31737-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Apr 10, 2018 at 09:17:54PM +0800, Jia-Ju Bai wrote:
> ntb_transport_create_queue() is never called in atomic context.
> 
> ntb_transport_create_queue() is only called by ntb_netdev_probe(),
> which is set as ".probe" in struct ntb_transport_client.
> 
> Despite never getting called from atomic context,
> ntb_transport_create_queue() calls kzalloc_node() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Both patches have been applied to my ntb-next branch.

Thanks,
Jon

> ---
>  drivers/ntb/ntb_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f58d8e3..2c0c8bc 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1825,7 +1825,7 @@ struct ntb_transport_qp *
>  		qp->rx_dma_chan ? "DMA" : "CPU");
>  
>  	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
> -		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
>  		if (!entry)
>  			goto err1;
>  
> @@ -1836,7 +1836,7 @@ struct ntb_transport_qp *
>  	qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
>  
>  	for (i = 0; i < qp->tx_max_entry; i++) {
> -		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
>  		if (!entry)
>  			goto err2;
>  
> -- 
> 1.9.1
> 
