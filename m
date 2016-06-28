Return-Path: <allenbh@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id t206si945512ywb.3.2016.06.27.18.08.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 18:08:45 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id r136so437163qke.3
        for <linux-ntb@googlegroups.com>; Mon, 27 Jun 2016 18:08:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <146706898537.188649.13633369547142674206.stgit@djiang5-desk3.ch.intel.com>
References: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
 <146706898537.188649.13633369547142674206.stgit@djiang5-desk3.ch.intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 27 Jun 2016 21:08:45 -0400
Message-ID: <CAJ80satySmQk_O9hu6E7ytEovSq7v=DMFo9jawU-Sizx2Or8Lg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dmaengine: IOATDMA: Add error handling to driver
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: vinod.koul@intel.com, Allen Hubbe <allen.hubbe@emc.com>, jdmason@kudzu.us, dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 27, 2016 at 7:09 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/ioat/dma.c       |  136 ++++++++++++++++++++++++++++++++++++------
>  drivers/dma/ioat/registers.h |    2 +
>  2 files changed, 120 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index bd09961..1bbc005 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -622,7 +622,8 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
>         if (is_ioat_halted(*ioat_chan->completion)) {
>                 u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
>
> -               if (chanerr & IOAT_CHANERR_HANDLE_MASK) {
> +               if (chanerr &
> +                   (IOAT_CHANERR_HANDLE_MASK | IOAT_CHANERR_RECOVER_MASK)) {
>                         mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
>                         ioat_eh(ioat_chan);
>                 }
> @@ -652,6 +653,60 @@ static void ioat_restart_channel(struct ioatdma_chan *ioat_chan)
>         __ioat_restart_chan(ioat_chan);
>  }
>
> +
> +static void ioat_abort_descs(struct ioatdma_chan *ioat_chan)
> +{
> +       struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
> +       struct ioat_ring_ent *desc;
> +       u16 active;
> +       int idx = ioat_chan->tail, i;
> +
> +       /*
> +        * We assume that the failed descriptor has been processed.
> +        * Now we are just returning all the remaining submitted
> +        * descriptors to abort.
> +        */
> +       active = ioat_ring_active(ioat_chan);
> +
> +       /* we skip the failed descriptor that tail points to */
> +       for (i = 1; i < active; i++) {
> +               struct dma_async_tx_descriptor *tx;
> +
> +               smp_read_barrier_depends();
> +               prefetch(ioat_get_ring_ent(ioat_chan, idx + i + 1));
> +               desc = ioat_get_ring_ent(ioat_chan, idx + i);
> +               desc->txd.result |= ERR_DMA_ABORT;

See below, txd.result doesn't seem to be a bit mask.

> +
> +               tx = &desc->txd;
> +               if (tx->cookie) {
> +                       dma_cookie_complete(tx);
> +                       dma_descriptor_unmap(tx);
> +                       if (tx->callback) {
> +                               tx->callback(tx->callback_param);
> +                               tx->callback = NULL;
> +                       }
> +               }
> +
> +               /* skip extended descriptors */
> +               if (desc_has_ext(desc)) {
> +                       WARN_ON(i + 1 >= active);
> +                       i++;

Is it always true that extended descriptors (note: descriptors is
plural) means "exactly one?"  Otherwise, ++ aught to be += how how
many.  I didn't notice anything in dma_prep.c that would use more than
one extra.

> +               }
> +
> +               /* cleanup super extended descriptors */
> +               if (desc->sed) {
> +                       ioat_free_sed(ioat_dma, desc->sed);
> +                       desc->sed = NULL;
> +               }
> +       }
> +
> +       smp_mb(); /* finish all descriptor reads before incrementing tail */
> +       ioat_chan->tail = idx + i;

Would it also be correct to say `idx + active` here?  If so, that
might be more clear.

> +
> +       desc = ioat_get_ring_ent(ioat_chan, ioat_chan->tail);
> +       ioat_chan->last_completion = *ioat_chan->completion = desc->txd.phys;
> +}
> +
>  static void ioat_eh(struct ioatdma_chan *ioat_chan)
>  {
>         struct pci_dev *pdev = to_pdev(ioat_chan);
> @@ -662,6 +717,7 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
>         u32 err_handled = 0;
>         u32 chanerr_int;
>         u32 chanerr;
> +       bool abort = false;
>
>         /* cleanup so tail points to descriptor that caused the error */
>         if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
> @@ -697,30 +753,50 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
>                 break;
>         }
>
> +       if (chanerr & IOAT_CHANERR_RECOVER_MASK) {
> +               if (chanerr & IOAT_CHANERR_READ_DATA_ERR) {
> +                       desc->txd.result |= ERR_DMA_READ;

In [PATCH 1/5] ERR_DMA_XYZ values do not look appropriate for use as a bit mask.

+enum err_result_flags {
+       ERR_DMA_NONE = 0,
+       ERR_DMA_READ,
+       ERR_DMA_WRITE,
+       ERR_DMA_ABORT,
+};

And in [PATCH 4/5] and [PATCH 5/5] txd.result is not used as a bit mask.

+               switch (txd->result) {
+               case ERR_DMA_READ:
+               case ERR_DMA_WRITE:
+                       entry->errors++;
+               case ERR_DMA_ABORT:
+                       flags = DESC_ABORT_FLAG;
+                       break;
+               case ERR_DMA_NONE:
+               default:
+                       break;
+               }

> +                       err_handled |= IOAT_CHANERR_READ_DATA_ERR;
> +               } else if (chanerr & IOAT_CHANERR_WRITE_DATA_ERR) {
> +                       desc->txd.result |= ERR_DMA_WRITE;
> +                       err_handled |= IOAT_CHANERR_WRITE_DATA_ERR;
> +               }
> +
> +               abort = true;
> +       }
> +
>         /* fault on unhandled error or spurious halt */
>         if (chanerr ^ err_handled || chanerr == 0) {

Not part of your change, but chanerr == 0 is confusing.  Doesn't that
mean "no errors?"  No errors would make it hard to justify BUG() that
follows.

>                 dev_err(to_dev(ioat_chan), "%s: fatal error (%x:%x)\n",
>                         __func__, chanerr, err_handled);
>                 BUG();
> -       } else { /* cleanup the faulty descriptor */
> -               tx = &desc->txd;
> -               if (tx->cookie) {
> -                       dma_cookie_complete(tx);
> -                       dma_descriptor_unmap(tx);
> -                       if (tx->callback) {
> -                               tx->callback(tx->callback_param);
> -                               tx->callback = NULL;
> -                       }
> -               }
>         }
>
> -       writel(chanerr, ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
> -       pci_write_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, chanerr_int);
> +       /* cleanup the faulty descriptor since we are continuing */
> +       tx = &desc->txd;
> +       if (tx->cookie) {
> +               dma_cookie_complete(tx);
> +               dma_descriptor_unmap(tx);
> +               if (tx->callback) {
> +                       tx->callback(tx->callback_param);
> +                       tx->callback = NULL;
> +               }
> +       }
>
>         /* mark faulting descriptor as complete */
>         *ioat_chan->completion = desc->txd.phys;
>
>         spin_lock_bh(&ioat_chan->prep_lock);
> +       /* we need abort all descriptors */
> +       if (abort) {
> +               ioat_abort_descs(ioat_chan);
> +               /* clean up the channel, we could be in weird state */
> +               ioat_reset_hw(ioat_chan);
> +       }
> +
> +       writel(chanerr, ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
> +       pci_write_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, chanerr_int);
> +
>         ioat_restart_channel(ioat_chan);
>         spin_unlock_bh(&ioat_chan->prep_lock);
>  }
> @@ -753,10 +829,25 @@ void ioat_timer_event(unsigned long data)
>                 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
>                 dev_err(to_dev(ioat_chan), "%s: Channel halted (%x)\n",
>                         __func__, chanerr);
> -               if (test_bit(IOAT_RUN, &ioat_chan->state))
> -                       BUG_ON(is_ioat_bug(chanerr));
> -               else /* we never got off the ground */
> -                       return;
> +               if (test_bit(IOAT_RUN, &ioat_chan->state)) {
> +                       spin_lock_bh(&ioat_chan->cleanup_lock);
> +                       spin_lock_bh(&ioat_chan->prep_lock);
> +                       set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
> +                       spin_unlock_bh(&ioat_chan->prep_lock);
> +
> +                       ioat_abort_descs(ioat_chan);
> +                       dev_warn(to_dev(ioat_chan), "Reset channel...\n");
> +                       ioat_reset_hw(ioat_chan);
> +                       dev_warn(to_dev(ioat_chan), "Restart channel...\n");
> +                       ioat_restart_channel(ioat_chan);
> +
> +                       spin_lock_bh(&ioat_chan->prep_lock);
> +                       clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
> +                       spin_unlock_bh(&ioat_chan->prep_lock);
> +                       spin_unlock_bh(&ioat_chan->cleanup_lock);
> +               }
> +
> +               return;
>         }
>
>         spin_lock_bh(&ioat_chan->cleanup_lock);
> @@ -780,14 +871,23 @@ void ioat_timer_event(unsigned long data)
>                 u32 chanerr;
>
>                 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
> -               dev_warn(to_dev(ioat_chan), "Restarting channel...\n");
>                 dev_warn(to_dev(ioat_chan), "CHANSTS: %#Lx CHANERR: %#x\n",
>                          status, chanerr);
>                 dev_warn(to_dev(ioat_chan), "Active descriptors: %d\n",
>                          ioat_ring_active(ioat_chan));
>
>                 spin_lock_bh(&ioat_chan->prep_lock);
> +               set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
> +               spin_unlock_bh(&ioat_chan->prep_lock);
> +
> +               ioat_abort_descs(ioat_chan);
> +               dev_warn(to_dev(ioat_chan), "Resetting channel...\n");
> +               ioat_reset_hw(ioat_chan);
> +               dev_warn(to_dev(ioat_chan), "Restarting channel...\n");
>                 ioat_restart_channel(ioat_chan);
> +
> +               spin_lock_bh(&ioat_chan->prep_lock);
> +               clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
>                 spin_unlock_bh(&ioat_chan->prep_lock);
>                 spin_unlock_bh(&ioat_chan->cleanup_lock);
>                 return;
> diff --git a/drivers/dma/ioat/registers.h b/drivers/dma/ioat/registers.h
> index 4994a36..faf20fa 100644
> --- a/drivers/dma/ioat/registers.h
> +++ b/drivers/dma/ioat/registers.h
> @@ -233,6 +233,8 @@
>  #define IOAT_CHANERR_DESCRIPTOR_COUNT_ERR      0x40000
>
>  #define IOAT_CHANERR_HANDLE_MASK (IOAT_CHANERR_XOR_P_OR_CRC_ERR | IOAT_CHANERR_XOR_Q_ERR)
> +#define IOAT_CHANERR_RECOVER_MASK (IOAT_CHANERR_READ_DATA_ERR | \
> +                                  IOAT_CHANERR_WRITE_DATA_ERR)
>
>  #define IOAT_CHANERR_MASK_OFFSET               0x2C    /* 32-bit Channel Error Register */
>
>
