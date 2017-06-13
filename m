Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com. [2607:f8b0:400c:c05::243])
        by gmr-mx.google.com with ESMTPS id j141si1027540vke.7.2017.06.13.06.55.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 06:55:59 -0700 (PDT)
Received: by mail-vk0-x243.google.com with SMTP id 19so9088045vkd.2
        for <linux-ntb@googlegroups.com>; Tue, 13 Jun 2017 06:55:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fede6f0967b7d1d2a256e8f1e571557c2bfb7462.1497045952.git.Allen.Hubbe@dell.com>
References: <fede6f0967b7d1d2a256e8f1e571557c2bfb7462.1497045952.git.Allen.Hubbe@dell.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 13 Jun 2017 09:55:58 -0400
Message-ID: <CAPoiz9z61CO_oVCR1tS+ackRFcyvnQ_Tqjk1SFpsAc1X9GxWRA@mail.gmail.com>
Subject: Re: [PATCH] ntb: no sleep in ntb_async_tx_submit
Content-Type: text/plain; charset="UTF-8"
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 9, 2017 at 6:06 PM, Allen Hubbe <Allen.Hubbe@dell.com> wrote:
> Do not sleep in ntb_async_tx_submit, which could deadlock.
> This reverts commit "8c874cc140d667f84ae4642bb5b5e0d6396d2ca4"
>
> Fixes: 8c874cc140d667f84ae4642bb5b5e0d6396d2ca4

Nit, this should be
Fixes: 8c874cc140d6 ("NTB: Address out of DMA descriptor issue with NTB")

12 characters and the description

I fixed it up, added Dave's ack, and put it in my ntb branch.

Thanks,
Jon

> Reported-by: Jia-Ju Bai <baijiaju1990@163.com>
> Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>
> ---
>  drivers/ntb/ntb_transport.c | 50 +++++++--------------------------------------
>  1 file changed, 7 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 5b6b00ea6ed9..10e5bf460139 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -177,14 +177,12 @@ struct ntb_transport_qp {
>         u64 rx_err_ver;
>         u64 rx_memcpy;
>         u64 rx_async;
> -       u64 dma_rx_prep_err;
>         u64 tx_bytes;
>         u64 tx_pkts;
>         u64 tx_ring_full;
>         u64 tx_err_no_buf;
>         u64 tx_memcpy;
>         u64 tx_async;
> -       u64 dma_tx_prep_err;
>  };
>
>  struct ntb_transport_mw {
> @@ -254,8 +252,6 @@ enum {
>  #define QP_TO_MW(nt, qp)       ((qp) % nt->mw_count)
>  #define NTB_QP_DEF_NUM_ENTRIES 100
>  #define NTB_LINK_DOWN_TIMEOUT  10
> -#define DMA_RETRIES            20
> -#define DMA_OUT_RESOURCE_TO    msecs_to_jiffies(50)
>
>  static void ntb_transport_rxc_db(unsigned long data);
>  static const struct ntb_ctx_ops ntb_transport_ops;
> @@ -516,12 +512,6 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
>         out_offset += snprintf(buf + out_offset, out_count - out_offset,
>                                "free tx - \t%u\n",
>                                ntb_transport_tx_free_entry(qp));
> -       out_offset += snprintf(buf + out_offset, out_count - out_offset,
> -                              "DMA tx prep err - \t%llu\n",
> -                              qp->dma_tx_prep_err);
> -       out_offset += snprintf(buf + out_offset, out_count - out_offset,
> -                              "DMA rx prep err - \t%llu\n",
> -                              qp->dma_rx_prep_err);
>
>         out_offset += snprintf(buf + out_offset, out_count - out_offset,
>                                "\n");
> @@ -768,8 +758,6 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>         qp->tx_err_no_buf = 0;
>         qp->tx_memcpy = 0;
>         qp->tx_async = 0;
> -       qp->dma_tx_prep_err = 0;
> -       qp->dma_rx_prep_err = 0;
>  }
>
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> @@ -1317,7 +1305,6 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>         struct dmaengine_unmap_data *unmap;
>         dma_cookie_t cookie;
>         void *buf = entry->buf;
> -       int retries = 0;
>
>         len = entry->len;
>         device = chan->device;
> @@ -1346,22 +1333,11 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>
>         unmap->from_cnt = 1;
>
> -       for (retries = 0; retries < DMA_RETRIES; retries++) {
> -               txd = device->device_prep_dma_memcpy(chan,
> -                                                    unmap->addr[1],
> -                                                    unmap->addr[0], len,
> -                                                    DMA_PREP_INTERRUPT);
> -               if (txd)
> -                       break;
> -
> -               set_current_state(TASK_INTERRUPTIBLE);
> -               schedule_timeout(DMA_OUT_RESOURCE_TO);
> -       }
> -
> -       if (!txd) {
> -               qp->dma_rx_prep_err++;
> +       txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> +                                            unmap->addr[0], len,
> +                                            DMA_PREP_INTERRUPT);
> +       if (!txd)
>                 goto err_get_unmap;
> -       }
>
>         txd->callback_result = ntb_rx_copy_callback;
>         txd->callback_param = entry;
> @@ -1606,7 +1582,6 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>         struct dmaengine_unmap_data *unmap;
>         dma_addr_t dest;
>         dma_cookie_t cookie;
> -       int retries = 0;
>
>         device = chan->device;
>         dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
> @@ -1628,21 +1603,10 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>
>         unmap->to_cnt = 1;
>
> -       for (retries = 0; retries < DMA_RETRIES; retries++) {
> -               txd = device->device_prep_dma_memcpy(chan, dest,
> -                                                    unmap->addr[0], len,
> -                                                    DMA_PREP_INTERRUPT);
> -               if (txd)
> -                       break;
> -
> -               set_current_state(TASK_INTERRUPTIBLE);
> -               schedule_timeout(DMA_OUT_RESOURCE_TO);
> -       }
> -
> -       if (!txd) {
> -               qp->dma_tx_prep_err++;
> +       txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
> +                                            DMA_PREP_INTERRUPT);
> +       if (!txd)
>                 goto err_get_unmap;
> -       }
>
>         txd->callback_result = ntb_tx_copy_callback;
>         txd->callback_param = entry;
> --
> 2.13.0
>
