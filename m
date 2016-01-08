Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id o63si3648425ywd.1.2016.01.08.08.57.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 08:57:47 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160108165105.95687.61824.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160108165105.95687.61824.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v2] NTB: Address out of DMA descriptor issue with NTB
Date: Fri, 8 Jan 2016 11:57:32 -0500
Message-ID: <000e01d14a35$aaf9e140$00eda3c0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> The transport right now does not handle the case where we run out of DMA
> descriptors. We just fail when we do not succeed. Adding code to retry
> for
> a bit attempting to use the DMA engine instead of instantly fail to CPU
> copy.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Allen Hubbe <Allen.Hubbe@emc.com>



> ---
>  drivers/ntb/ntb_transport.c |   48
> +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 60654d5..8da0e6c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -171,12 +171,14 @@ struct ntb_transport_qp {
>  	u64 rx_err_ver;
>  	u64 rx_memcpy;
>  	u64 rx_async;
> +	u64 dma_rx_prep_err;
>  	u64 tx_bytes;
>  	u64 tx_pkts;
>  	u64 tx_ring_full;
>  	u64 tx_err_no_buf;
>  	u64 tx_memcpy;
>  	u64 tx_async;
> +	u64 dma_tx_prep_err;
>  };
> 
>  struct ntb_transport_mw {
> @@ -249,6 +251,8 @@ enum {
>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
>  #define NTB_QP_DEF_NUM_ENTRIES	100
>  #define NTB_LINK_DOWN_TIMEOUT	10
> +#define DMA_RETRIES		20
> +#define DMA_OUT_RESOURCE_TO	50
> 
>  static void ntb_transport_rxc_db(unsigned long data);
>  static const struct ntb_ctx_ops ntb_transport_ops;
> @@ -501,6 +505,12 @@ static ssize_t debugfs_read(struct file *filp, char
> __user *ubuf, size_t count,
>  	out_offset += snprintf(buf + out_offset, out_count - out_offset,
>  			       "free tx - \t%u\n",
>  			       ntb_transport_tx_free_entry(qp));
> +	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +			       "DMA tx prep err - \t%llu\n",
> +			       qp->dma_tx_prep_err);
> +	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> +			       "DMA rx prep err - \t%llu\n",
> +			       qp->dma_rx_prep_err);
> 
>  	out_offset += snprintf(buf + out_offset, out_count - out_offset,
>  			       "\n");
> @@ -726,6 +736,8 @@ static void ntb_qp_link_down_reset(struct
> ntb_transport_qp *qp)
>  	qp->tx_err_no_buf = 0;
>  	qp->tx_memcpy = 0;
>  	qp->tx_async = 0;
> +	qp->dma_tx_prep_err = 0;
> +	qp->dma_rx_prep_err = 0;
>  }
> 
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> @@ -1228,6 +1240,7 @@ static void ntb_async_rx(struct ntb_queue_entry
> *entry, void *offset)
>  	struct dmaengine_unmap_data *unmap;
>  	dma_cookie_t cookie;
>  	void *buf = entry->buf;
> +	int retries = 0;
> 
>  	len = entry->len;
> 
> @@ -1263,11 +1276,21 @@ static void ntb_async_rx(struct ntb_queue_entry
> *entry, void *offset)
> 
>  	unmap->from_cnt = 1;
> 
> -	txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> -					     unmap->addr[0], len,
> -					     DMA_PREP_INTERRUPT);
> -	if (!txd)
> +	for (retries = 0; retries < DMA_RETRIES; retries++) {
> +		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> +						     unmap->addr[0], len,
> +						     DMA_PREP_INTERRUPT);
> +		if (txd)
> +			break;
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(DMA_OUT_RESOURCE_TO);
> +	}
> +
> +	if (!txd) {
> +		qp->dma_rx_prep_err++;
>  		goto err_get_unmap;
> +	}
> 
>  	txd->callback = ntb_rx_copy_callback;
>  	txd->callback_param = entry;
> @@ -1460,6 +1483,7 @@ static void ntb_async_tx(struct ntb_transport_qp
> *qp,
>  	void __iomem *offset;
>  	size_t len = entry->len;
>  	void *buf = entry->buf;
> +	int retries = 0;
> 
>  	offset = qp->tx_mw + qp->tx_max_frame * qp->tx_index;
>  	hdr = offset + qp->tx_max_frame - sizeof(struct
> ntb_payload_header);
> @@ -1494,10 +1518,20 @@ static void ntb_async_tx(struct ntb_transport_qp
> *qp,
> 
>  	unmap->to_cnt = 1;
> 
> -	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0],
> len,
> -					     DMA_PREP_INTERRUPT);
> -	if (!txd)
> +	for (retries = 0; retries < DMA_RETRIES; retries++) {
> +		txd = device->device_prep_dma_memcpy(chan, dest, unmap-
> >addr[0],
> +						     len, DMA_PREP_INTERRUPT);
> +		if (txd)
> +			break;
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(DMA_OUT_RESOURCE_TO);
> +	}
> +
> +	if (!txd) {
> +		qp->dma_tx_prep_err++;
>  		goto err_get_unmap;
> +	}
> 
>  	txd->callback = ntb_tx_copy_callback;
>  	txd->callback_param = entry;

