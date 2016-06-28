Return-Path: <allenbh@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com. [2607:f8b0:400d:c09::243])
        by gmr-mx.google.com with ESMTPS id w2si1355959yww.0.2016.06.27.18.53.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 18:53:06 -0700 (PDT)
Received: by mail-qk0-x243.google.com with SMTP id j2so627511qkf.1
        for <linux-ntb@googlegroups.com>; Mon, 27 Jun 2016 18:53:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <146706899641.188649.16969346461413257840.stgit@djiang5-desk3.ch.intel.com>
References: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
 <146706899641.188649.16969346461413257840.stgit@djiang5-desk3.ch.intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 27 Jun 2016 21:53:05 -0400
Message-ID: <CAJ80satSazc03Q=y5uNCi1dNYYdJCgM8wD6RwRH21J-yPHtWyw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ntb: add DMA error handling for TX DMA
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: vinod.koul@intel.com, Allen Hubbe <allen.hubbe@emc.com>, jdmason@kudzu.us, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 27, 2016 at 7:09 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Adding support on the tx DMA path to allow recovery of errors when DMA
> responds with error status and abort all the subsequent ops.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c |  123 +++++++++++++++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 2ef9d913..55a5ae0 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -102,6 +102,10 @@ struct ntb_queue_entry {
>         void *buf;
>         unsigned int len;
>         unsigned int flags;
> +       struct dma_async_tx_descriptor *txd;
> +       int retries;
> +       int errors;
> +       unsigned int tx_index;
>
>         struct ntb_transport_qp *qp;
>         union {
> @@ -258,6 +262,9 @@ enum {
>  static void ntb_transport_rxc_db(unsigned long data);
>  static const struct ntb_ctx_ops ntb_transport_ops;
>  static struct ntb_client ntb_transport_client;
> +static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> +                              struct ntb_queue_entry *entry);
> +static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
>
>  static int ntb_transport_bus_match(struct device *dev,
>                                    struct device_driver *drv)
> @@ -1444,21 +1451,46 @@ static void ntb_tx_copy_callback(void *data)
>         struct ntb_queue_entry *entry = data;
>         struct ntb_transport_qp *qp = entry->qp;
>         struct ntb_payload_header __iomem *hdr = entry->tx_hdr;
> +       struct dma_async_tx_descriptor *txd;
> +       unsigned int len;
> +       bool abort = false;
> +
> +       txd = entry->txd;
> +
> +       /* we need to check DMA results if we are using DMA */
> +       if (txd) {
> +               switch (txd->result) {
> +               case ERR_DMA_READ:
> +               case ERR_DMA_WRITE:
> +                       entry->errors++;
> +               case ERR_DMA_ABORT:
> +                       abort = true;
> +                       goto handle_tx;
> +               case ERR_DMA_NONE:
> +               default:
> +                       break;
> +               }
> +       }
>
>         iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
>
>         ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
>
> +handle_tx:
> +
>         /* The entry length can only be zero if the packet is intended to be a
>          * "link down" or similar.  Since no payload is being sent in these
>          * cases, there is nothing to add to the completion queue.
>          */
>         if (entry->len > 0) {
> -               qp->tx_bytes += entry->len;
> +               if (!abort) {
> +                       qp->tx_bytes += entry->len;
> +                       len = entry->len;
> +               } else
> +                       len = 0;

Checkpatch will complain about different { } for then and else.

>
>                 if (qp->tx_handler)
> -                       qp->tx_handler(qp, qp->cb_data, entry->cb_data,
> -                                      entry->len);
> +                       qp->tx_handler(qp, qp->cb_data, entry->cb_data, len);
>         }
>
>         ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> @@ -1482,37 +1514,21 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
>         ntb_tx_copy_callback(entry);
>  }
>
> -static void ntb_async_tx(struct ntb_transport_qp *qp,
> -                        struct ntb_queue_entry *entry)
> +static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> +                              struct ntb_queue_entry *entry)
>  {
> -       struct ntb_payload_header __iomem *hdr;
> -       struct dma_async_tx_descriptor *txd;
>         struct dma_chan *chan = qp->tx_dma_chan;
>         struct dma_device *device;
> +       size_t len = entry->len;
> +       void *buf = entry->buf;
>         size_t dest_off, buff_off;
>         struct dmaengine_unmap_data *unmap;
>         dma_addr_t dest;
>         dma_cookie_t cookie;
> -       void __iomem *offset;
> -       size_t len = entry->len;
> -       void *buf = entry->buf;
>         int retries = 0;
>
> -       offset = qp->tx_mw + qp->tx_max_frame * qp->tx_index;
> -       hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> -       entry->tx_hdr = hdr;
> -
> -       iowrite32(entry->len, &hdr->len);
> -       iowrite32((u32)qp->tx_pkts, &hdr->ver);
> -
> -       if (!chan)
> -               goto err;
> -
> -       if (len < copy_bytes)
> -               goto err;
> -
>         device = chan->device;
> -       dest = qp->tx_mw_phys + qp->tx_max_frame * qp->tx_index;
> +       dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
>         buff_off = (size_t)buf & ~PAGE_MASK;
>         dest_off = (size_t)dest & ~PAGE_MASK;
>
> @@ -1532,39 +1548,74 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>         unmap->to_cnt = 1;
>
>         for (retries = 0; retries < DMA_RETRIES; retries++) {
> -               txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0],
> -                                                    len, DMA_PREP_INTERRUPT);
> -               if (txd)
> +               entry->txd = device->device_prep_dma_memcpy(chan, dest,
> +                                                           unmap->addr[0], len,
> +                                                           DMA_PREP_INTERRUPT);
> +               if (entry->txd)
>                         break;
>
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 schedule_timeout(DMA_OUT_RESOURCE_TO);
>         }
>
> -       if (!txd) {
> +       if (!entry->txd) {
>                 qp->dma_tx_prep_err++;
>                 goto err_get_unmap;
>         }
>
> -       txd->callback = ntb_tx_copy_callback;
> -       txd->callback_param = entry;
> -       dma_set_unmap(txd, unmap);
> +       entry->txd->callback = ntb_tx_copy_callback;
> +       entry->txd->callback_param = entry;
> +       dma_set_unmap(entry->txd, unmap);
>
> -       cookie = dmaengine_submit(txd);
> +       cookie = dmaengine_submit(entry->txd);
>         if (dma_submit_error(cookie))
>                 goto err_set_unmap;
>
>         dmaengine_unmap_put(unmap);
>
>         dma_async_issue_pending(chan);
> -       qp->tx_async++;
>
> -       return;
> +       return 0;
>  err_set_unmap:
>         dmaengine_unmap_put(unmap);
>  err_get_unmap:
>         dmaengine_unmap_put(unmap);
>  err:
> +       return -ENXIO;
> +}
> +
> +static void ntb_async_tx(struct ntb_transport_qp *qp,
> +                        struct ntb_queue_entry *entry)
> +{
> +       struct ntb_payload_header __iomem *hdr;
> +       struct dma_chan *chan = qp->tx_dma_chan;
> +       void __iomem *offset;
> +       int res;
> +
> +       entry->tx_index = qp->tx_index;
> +       offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> +       hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> +       entry->tx_hdr = hdr;
> +
> +       iowrite32(entry->len, &hdr->len);
> +       iowrite32((u32)qp->tx_pkts, &hdr->ver);
> +
> +       if (!chan)
> +               goto err;
> +
> +       if (entry->len < copy_bytes)
> +               goto err;
> +
> +       res = ntb_async_tx_submit(qp, entry);
> +       if (res < 0)
> +               goto err;
> +
> +       if (!entry->retries)
> +               qp->tx_async++;
> +
> +       return;
> +
> +err:

If there is an error building or submitting the dma descriptor, we
will fall back to cpu memcpy, but if there is an error indicated at
the time of the dma completion, we will not.  This would be a problem
if we later notify the peer driver that some data has been
transferred, even though it has not been transferred.

This seems like it would be a likely situation (or, as likely as
encountering a dma engine error), because dma prep will begin to fail
as soon as the first error is encountered.  After detecting an error,
in [PATCH 2/5] bit IOAT_CHAN_DOWN is set, causing dma prep to fail in
the mean time.  Then, ntb_transport will immediately fall back to
transferring data via cpu memcpy, but I do not see any fall back to
cpu memcpy for the failed or aborted descriptors.

>         ntb_memcpy_tx(entry, offset);
>         qp->tx_memcpy++;
>  }
> @@ -1940,6 +1991,10 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>         entry->buf = data;
>         entry->len = len;
>         entry->flags = 0;
> +       entry->errors = 0;
> +       entry->retries = 0;
> +       entry->tx_index = 0;
> +       entry->txd = NULL;
>
>         rc = ntb_process_tx(qp, entry);
>         if (rc)
>
