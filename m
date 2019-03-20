Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc35.google.com (mail-yw1-xc35.google.com. [2607:f8b0:4864:20::c35])
        by gmr-mx.google.com with ESMTPS id d192si151370qkb.4.2019.03.20.11.17.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:17:12 -0700 (PDT)
Received: by mail-yw1-xc35.google.com with SMTP id z191so2760059ywa.6
        for <linux-ntb@googlegroups.com>; Wed, 20 Mar 2019 11:17:12 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 20 Mar 2019 14:17:10 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is
 initaliazed
Message-ID: <20190320181709.GA1201@kudzu.us>
References: <20190219195636.1485-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219195636.1485-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Feb 19, 2019 at 12:56:36PM -0700, Logan Gunthorpe wrote:
> Dan Carpenter's static checker reported:
> 
>     drivers/ntb/ntb_transport.c:1926 ntb_transport_create_queue()
>     error: we previously assumed 'qp->tx_dma_chan' could be null (see line 1872)
> 
> This is because the tx_mw_dma_addr is uninitialized in this function and
> may be incorrectly released using a NULL DMA channel.
> 
> In practice this bug will not likely be seen. I'd guess you could hit
> this if you loaded ntb_netdev with use_dma=True, then unloaded it and
> loaded it again after setting the module parameter to use_dma=False.
> 
> To fix this, we simply ensure that tx_mw_dma_addr is always
> initialized to zero. This is the safest in case any other part of the
> code operates on it if it is non-zero.
> 
> Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Jon Mason <jdmason@kudzu.us>

Included in the ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/ntb_transport.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> @Jon, it would be best if you can squash this with the commit that
> introduced the bug in ntb-next. Thanks.
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 526b65afc16a..e8a8304a42df 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1866,6 +1866,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  		qp->rx_dma_chan = NULL;
>  	}
> 
> +	qp->tx_mw_dma_addr = 0;
>  	if (qp->tx_dma_chan) {
>  		qp->tx_mw_dma_addr =
>  			dma_map_resource(qp->tx_dma_chan->device->dev,
> --
> 2.19.0
