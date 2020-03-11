Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r16si86497iot.3.2020.03.11.10.08.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:08:17 -0700 (PDT)
References: <20200311084917.18592-1-tiwai@suse.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <03f25a1e-c72f-8fd8-d23e-f0da5e8d39b4@deltatee.com>
Date: Wed, 11 Mar 2020 11:08:11 -0600
MIME-Version: 1.0
In-Reply-To: <20200311084917.18592-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_transport: Use scnprintf() for avoiding
 potential buffer overflow
To: Takashi Iwai <tiwai@suse.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 2020-03-11 2:49 a.m., Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Makes sense. Looks good to me!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

> ---
>  drivers/ntb/ntb_transport.c | 58 ++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 00a5d5764993..e6d1f5b298f3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -481,70 +481,70 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
>  		return -ENOMEM;
>  
>  	out_offset = 0;
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "\nNTB QP stats:\n\n");
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_async - \t%llu\n", qp->rx_async);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_buff - \t0x%p\n", qp->rx_buff);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_index - \t%u\n", qp->rx_index);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
>  
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_async - \t%llu\n", qp->tx_async);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_mw - \t0x%p\n", qp->tx_mw);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_index (H) - \t%u\n", qp->tx_index);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "RRI (T) - \t%u\n",
>  			       qp->remote_rx_info->entry);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "free tx - \t%u\n",
>  			       ntb_transport_tx_free_entry(qp));
>  
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "\n");
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "Using TX DMA - \t%s\n",
>  			       qp->tx_dma_chan ? "Yes" : "No");
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "Using RX DMA - \t%s\n",
>  			       qp->rx_dma_chan ? "Yes" : "No");
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "QP Link - \t%s\n",
>  			       qp->link_is_up ? "Up" : "Down");
> -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
>  			       "\n");
>  
>  	if (out_offset > out_count)
> 
