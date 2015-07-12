Return-Path: <jdmason@kudzu.us>
Received: from mail-ig0-f193.google.com (mail-ig0-f193.google.com. [209.85.213.193])
        by gmr-mx.google.com with ESMTPS id fk9si453999igb.0.2015.07.12.11.14.59
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2015 11:14:59 -0700 (PDT)
Received: by igcqs7 with SMTP id qs7so4891016igc.2
        for <linux-ntb@googlegroups.com>; Sun, 12 Jul 2015 11:14:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bb4dd048e673ff6a7ccb49610873f8b0b41cfc1d.1436201347.git.Allen.Hubbe@emc.com>
References: <bb4dd048e673ff6a7ccb49610873f8b0b41cfc1d.1436201347.git.Allen.Hubbe@emc.com>
Date: Sun, 12 Jul 2015 14:14:58 -0400
Message-ID: <CAPoiz9ym5s7emxbBSAAZehe5y_fXrAY5DkC4Y8VzuD=s3XSahw@mail.gmail.com>
Subject: Re: [PATCH] NTB: Fix dereference before check
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 6, 2015 at 12:50 PM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> Remove early dereference of a pointer that is checked later in the code.

Looks good to me.  I assume this bug fix should be pushed to Linus,
and applied prior to any of the of other patches you have sent out.
Yes?

Thanks,
Jon


> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> ---
>  drivers/ntb/ntb_transport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 42ae5a122412..c64de9b99742 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1720,7 +1720,6 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
>   */
>  void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  {
> -       struct ntb_transport_ctx *nt = qp->transport;
>         struct pci_dev *pdev;
>         struct ntb_queue_entry *entry;
>         u64 qp_bit;
> @@ -1788,7 +1787,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>         while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
>                 kfree(entry);
>
> -       nt->qp_bitmap_free |= qp_bit;
> +       qp->transport->qp_bitmap_free |= qp_bit;
>
>         dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
>  }
> --
> 2.4.0.rc0.43.gcf8a8c6
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/bb4dd048e673ff6a7ccb49610873f8b0b41cfc1d.1436201347.git.Allen.Hubbe%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
