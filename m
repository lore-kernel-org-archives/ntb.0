Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id i136si1610887pfe.1.2016.07.19.09.59.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2016 09:59:02 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <146887810715.16107.9753805230903892880.stgit@djiang5-desk3.ch.intel.com> <146887868819.16107.9327765724121941820.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146887868819.16107.9327765724121941820.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v3 40/41] ntb: add DMA error handling for RX DMA
Date: Tue, 19 Jul 2016 12:58:46 -0400
Message-ID: <003c01d1e1de$d0a83950$71f8abf0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, vinod.koul@intel.com, lars@metafoo.de
Cc: laurent.pinchart@ideasonboard.com, 'Jon Mason' <jdmason@kudzu.us>, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> Adding support on the rx DMA path to allow recovery of errors when
> DMA responds with error status and abort all the subsequent ops.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: linux-ntb@googlegroups.com
> ---
>  drivers/ntb/ntb_transport.c |  103 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 6403b5b..42f588d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -106,13 +106,13 @@ struct ntb_queue_entry {
>  	int retries;
>  	int errors;
>  	unsigned int tx_index;
> +	unsigned int rx_index;
> 
>  	struct ntb_transport_qp *qp;
>  	union {
>  		struct ntb_payload_header __iomem *tx_hdr;
>  		struct ntb_payload_header *rx_hdr;
>  	};
> -	unsigned int index;
>  };
> 
>  struct ntb_rx_info {
> @@ -265,6 +265,9 @@ static struct ntb_client ntb_transport_client;
>  static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  			       struct ntb_queue_entry *entry);
>  static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
> +static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
> +static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
> +
> 
>  static int ntb_transport_bus_match(struct device *dev,
>  				   struct device_driver *drv)
> @@ -1208,7 +1211,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  			break;
> 
>  		entry->rx_hdr->flags = 0;
> -		iowrite32(entry->index, &qp->rx_info->entry);
> +		iowrite32(entry->rx_index, &qp->rx_info->entry);
> 
>  		cb_data = entry->cb_data;
>  		len = entry->len;
> @@ -1226,9 +1229,39 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  	spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
>  }
> 
> -static void ntb_rx_copy_callback(void *data)
> +static void ntb_rx_copy_callback(void *data,
> +				 const struct dmaengine_result *res)
>  {
>  	struct ntb_queue_entry *entry = data;
> +	struct dma_async_tx_descriptor *txd;
> +
> +	txd = entry->txd;

Same comment as TX DMA.

> +
> +	/* we need to check DMA results if we are using DMA */
> +	if (txd) {
> +		enum dmaengine_tx_result dma_err = res->result;
> +
> +		switch (dma_err) {
> +		case DMA_TRANS_READ_FAILED:
> +		case DMA_TRANS_WRITE_FAILED:
> +			entry->errors++;
> +		case DMA_TRANS_ABORTED:
> +		{
> +			struct ntb_transport_qp *qp = entry->qp;
> +			void *offset = qp->rx_buff + qp->rx_max_frame *
> +					qp->rx_index;
> +
> +			entry->txd = NULL;
> +			ntb_memcpy_rx(entry, offset);
> +			qp->rx_memcpy++;
> +			return;
> +		}
> +
> +		case DMA_TRANS_NOERROR:
> +		default:
> +			break;
> +		}
> +	}
> 
>  	entry->flags |= DESC_DONE_FLAG;
> 
> @@ -1245,12 +1278,11 @@ static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void
> *offset)
>  	/* Ensure that the data is fully copied out before clearing the flag */
>  	wmb();
> 
> -	ntb_rx_copy_callback(entry);
> +	ntb_rx_copy_callback(entry, NULL);
>  }
> 
> -static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
> +static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  {
> -	struct dma_async_tx_descriptor *txd;
>  	struct ntb_transport_qp *qp = entry->qp;
>  	struct dma_chan *chan = qp->rx_dma_chan;
>  	struct dma_device *device;
> @@ -1261,13 +1293,6 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void
> *offset)
>  	int retries = 0;
> 
>  	len = entry->len;
> -
> -	if (!chan)
> -		goto err;
> -
> -	if (len < copy_bytes)
> -		goto err;
> -
>  	device = chan->device;
>  	pay_off = (size_t)offset & ~PAGE_MASK;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
> @@ -1295,26 +1320,27 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void
> *offset)
>  	unmap->from_cnt = 1;
> 
>  	for (retries = 0; retries < DMA_RETRIES; retries++) {
> -		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> -						     unmap->addr[0], len,
> -						     DMA_PREP_INTERRUPT);
> -		if (txd)
> +		entry->txd = device->device_prep_dma_memcpy(chan,
> +							    unmap->addr[1],
> +							    unmap->addr[0], len,
> +							    DMA_PREP_INTERRUPT);
> +		if (entry->txd)
>  			break;
> 
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		schedule_timeout(DMA_OUT_RESOURCE_TO);
>  	}
> 
> -	if (!txd) {
> +	if (!entry->txd) {
>  		qp->dma_rx_prep_err++;
>  		goto err_get_unmap;
>  	}
> 
> -	txd->callback = ntb_rx_copy_callback;
> -	txd->callback_param = entry;
> -	dma_set_unmap(txd, unmap);
> +	entry->txd->callback_result = ntb_rx_copy_callback;
> +	entry->txd->callback_param = entry;
> +	dma_set_unmap(entry->txd, unmap);
> 
> -	cookie = dmaengine_submit(txd);
> +	cookie = dmaengine_submit(entry->txd);
>  	if (dma_submit_error(cookie))
>  		goto err_set_unmap;
> 
> @@ -1324,13 +1350,38 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void
> *offset)
> 
>  	qp->rx_async++;
> 
> -	return;
> +	return 0;
> 
>  err_set_unmap:
>  	dmaengine_unmap_put(unmap);
>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
> +	return -ENXIO;
> +}
> +
> +static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
> +{
> +	struct ntb_transport_qp *qp = entry->qp;
> +	struct dma_chan *chan = qp->rx_dma_chan;
> +	int res;
> +
> +	if (!chan)
> +		goto err;
> +
> +	if (entry->len < copy_bytes)
> +		goto err;
> +
> +	res = ntb_async_rx_submit(entry, offset);
> +	if (res < 0)
> +		goto err;
> +
> +	if (!entry->retries)
> +		qp->rx_async++;
> +
> +	return;
> +
> +err:
>  	ntb_memcpy_rx(entry, offset);
>  	qp->rx_memcpy++;
>  }
> @@ -1376,7 +1427,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  	}
> 
>  	entry->rx_hdr = hdr;
> -	entry->index = qp->rx_index;
> +	entry->rx_index = qp->rx_index;
> 
>  	if (hdr->len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,
> @@ -1955,6 +2006,10 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb,
> void *data,
>  	entry->buf = data;
>  	entry->len = len;
>  	entry->flags = 0;
> +	entry->retries = 0;
> +	entry->errors = 0;
> +	entry->rx_index = 0;
> +	entry->txd = NULL;
> 
>  	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
> 


