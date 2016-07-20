Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id r127si357052ywh.0.2016.07.20.14.16.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 14:16:00 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <146904507864.11972.10146989448811282060.stgit@djiang5-desk3.ch.intel.com> <146904564766.11972.13720989511027291565.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146904564766.11972.13720989511027291565.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v4 39/41] ntb: add DMA error handling for TX DMA
Date: Wed, 20 Jul 2016 17:15:49 -0400
Message-ID: <002c01d1e2cb$e43ac3f0$acb04bd0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, vinod.koul@intel.com, lars@metafoo.de
Cc: laurent.pinchart@ideasonboard.com, 'Jon Mason' <jdmason@kudzu.us>, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang 
> Adding support on the tx DMA path to allow recovery of errors when
> DMA responds with error status and abort all the subsequent ops.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: linux-ntb@googlegroups.com

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/ntb_transport.c |  110 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 83 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 2ef9d913..01da764 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -102,6 +102,9 @@ struct ntb_queue_entry {
>  	void *buf;
>  	unsigned int len;
>  	unsigned int flags;
> +	int retries;
> +	int errors;
> +	unsigned int tx_index;
> 
>  	struct ntb_transport_qp *qp;
>  	union {
> @@ -258,6 +261,9 @@ enum {
>  static void ntb_transport_rxc_db(unsigned long data);
>  static const struct ntb_ctx_ops ntb_transport_ops;
>  static struct ntb_client ntb_transport_client;
> +static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> +			       struct ntb_queue_entry *entry);
> +static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
> 
>  static int ntb_transport_bus_match(struct device *dev,
>  				   struct device_driver *drv)
> @@ -1439,12 +1445,39 @@ static void ntb_transport_rxc_db(unsigned long data)
>  	}
>  }
> 
> -static void ntb_tx_copy_callback(void *data)
> +static void ntb_tx_copy_callback(void *data,
> +				 const struct dmaengine_result *res)
>  {
>  	struct ntb_queue_entry *entry = data;
>  	struct ntb_transport_qp *qp = entry->qp;
>  	struct ntb_payload_header __iomem *hdr = entry->tx_hdr;
> 
> +	/* we need to check DMA results if we are using DMA */
> +	if (res) {
> +		enum dmaengine_tx_result dma_err = res->result;
> +
> +		switch (dma_err) {
> +		case DMA_TRANS_READ_FAILED:
> +		case DMA_TRANS_WRITE_FAILED:
> +			entry->errors++;
> +		case DMA_TRANS_ABORTED:
> +		{
> +			void __iomem *offset =
> +				qp->tx_mw + qp->tx_max_frame *
> +				entry->tx_index;
> +
> +			/* resubmit via CPU */
> +			ntb_memcpy_tx(entry, offset);
> +			qp->tx_memcpy++;
> +			return;
> +		}
> +
> +		case DMA_TRANS_NOERROR:
> +		default:
> +			break;
> +		}
> +	}
> +
>  	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
> 
>  	ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
> @@ -1479,40 +1512,25 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void
> __iomem *offset)
>  	/* Ensure that the data is fully copied out before setting the flags */
>  	wmb();
> 
> -	ntb_tx_copy_callback(entry);
> +	ntb_tx_copy_callback(entry, NULL);
>  }
> 
> -static void ntb_async_tx(struct ntb_transport_qp *qp,
> -			 struct ntb_queue_entry *entry)
> +static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> +			       struct ntb_queue_entry *entry)
>  {
> -	struct ntb_payload_header __iomem *hdr;
>  	struct dma_async_tx_descriptor *txd;
>  	struct dma_chan *chan = qp->tx_dma_chan;
>  	struct dma_device *device;
> +	size_t len = entry->len;
> +	void *buf = entry->buf;
>  	size_t dest_off, buff_off;
>  	struct dmaengine_unmap_data *unmap;
>  	dma_addr_t dest;
>  	dma_cookie_t cookie;
> -	void __iomem *offset;
> -	size_t len = entry->len;
> -	void *buf = entry->buf;
>  	int retries = 0;
> 
> -	offset = qp->tx_mw + qp->tx_max_frame * qp->tx_index;
> -	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> -	entry->tx_hdr = hdr;
> -
> -	iowrite32(entry->len, &hdr->len);
> -	iowrite32((u32)qp->tx_pkts, &hdr->ver);
> -
> -	if (!chan)
> -		goto err;
> -
> -	if (len < copy_bytes)
> -		goto err;
> -
>  	device = chan->device;
> -	dest = qp->tx_mw_phys + qp->tx_max_frame * qp->tx_index;
> +	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
>  	dest_off = (size_t)dest & ~PAGE_MASK;
> 
> @@ -1532,8 +1550,9 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  	unmap->to_cnt = 1;
> 
>  	for (retries = 0; retries < DMA_RETRIES; retries++) {
> -		txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0],
> -						     len, DMA_PREP_INTERRUPT);
> +		txd = device->device_prep_dma_memcpy(chan, dest,
> +						     unmap->addr[0], len,
> +						     DMA_PREP_INTERRUPT);
>  		if (txd)
>  			break;
> 
> @@ -1546,7 +1565,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  		goto err_get_unmap;
>  	}
> 
> -	txd->callback = ntb_tx_copy_callback;
> +	txd->callback_result = ntb_tx_copy_callback;
>  	txd->callback_param = entry;
>  	dma_set_unmap(txd, unmap);
> 
> @@ -1557,14 +1576,48 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  	dmaengine_unmap_put(unmap);
> 
>  	dma_async_issue_pending(chan);
> -	qp->tx_async++;
> 
> -	return;
> +	return 0;
>  err_set_unmap:
>  	dmaengine_unmap_put(unmap);
>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
> +	return -ENXIO;
> +}
> +
> +static void ntb_async_tx(struct ntb_transport_qp *qp,
> +			 struct ntb_queue_entry *entry)
> +{
> +	struct ntb_payload_header __iomem *hdr;
> +	struct dma_chan *chan = qp->tx_dma_chan;
> +	void __iomem *offset;
> +	int res;
> +
> +	entry->tx_index = qp->tx_index;
> +	offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> +	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> +	entry->tx_hdr = hdr;
> +
> +	iowrite32(entry->len, &hdr->len);
> +	iowrite32((u32)qp->tx_pkts, &hdr->ver);
> +
> +	if (!chan)
> +		goto err;
> +
> +	if (entry->len < copy_bytes)
> +		goto err;
> +
> +	res = ntb_async_tx_submit(qp, entry);
> +	if (res < 0)
> +		goto err;
> +
> +	if (!entry->retries)
> +		qp->tx_async++;
> +
> +	return;
> +
> +err:
>  	ntb_memcpy_tx(entry, offset);
>  	qp->tx_memcpy++;
>  }
> @@ -1940,6 +1993,9 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb,
> void *data,
>  	entry->buf = data;
>  	entry->len = len;
>  	entry->flags = 0;
> +	entry->errors = 0;
> +	entry->retries = 0;
> +	entry->tx_index = 0;
> 
>  	rc = ntb_process_tx(qp, entry);
>  	if (rc)


