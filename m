Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com. [2607:f8b0:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id q16si56238qtb.4.2017.12.05.11.30.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 11:30:52 -0800 (PST)
Received: by mail-vk0-x236.google.com with SMTP id s141so1017987vkb.12
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 11:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204175721.10322-1-logang@deltatee.com>
References: <20171204175721.10322-1-logang@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 14:30:51 -0500
Message-ID: <CAPoiz9x=sKryUszkSiPwTGW0fENpHKky_O708bA_zXLYZi0HoA@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before initializing
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, ThanhTuThai <cruisethai@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 4, 2017 at 12:57 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> If one host crashes and soft reboots, the other host may not see a
> link down event. Then when the crashed host comes back up, the
> surviving host may not know the link was reset and the NTB clients
> may not work without being reset.
>
> To solve this, we send a LINK_FORCE_DOWN message to each peer every
> time we come up, before we register the NTB device. If a surviving
> host still thinks the link is up it will take it down immediately.
> In this way, once the crashed host comes up fully, it will send a
> regular link up event as per usual and the link will be properly
> restarted.
>
> While we are in the area, this also fixes the MSG_LINK_UP message that
> was in the link down function that was reported by Doug Meyers.

So, this only applies on the ntb-next branch, and applying it after
your multi-partition patch series causes it to fail to apply.  The
fixup appears to be trivial, but please double check me.

Thanks,
Jon

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reported-by: ThanhTuThai <cruisethai@gmail.com>
> ---
>
> I had a small epiphany over the weekend as to why the link still was
> not coming up after a hard reboot. I think this will fix it.
>
> @Thai Thu: Can you please retest?
>
> Changes in v2:
>  * Reinitialize the shared memory window on a forced link down
>
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 57 +++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 709f37fbe232..6bc213cf7bf6 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -118,6 +118,7 @@ struct switchtec_ntb {
>         bool link_is_up;
>         enum ntb_speed link_speed;
>         enum ntb_width link_width;
> +       struct work_struct link_reinit_work;
>  };
>
>  static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
> @@ -463,18 +464,43 @@ static void switchtec_ntb_set_link_speed(struct switchtec_ntb *sndev)
>         sndev->link_width = min(self_width, peer_width);
>  }
>
> -enum {
> +enum switchtec_msg {
>         LINK_MESSAGE = 0,
>         MSG_LINK_UP = 1,
>         MSG_LINK_DOWN = 2,
>         MSG_CHECK_LINK = 3,
> +       MSG_LINK_FORCE_DOWN = 4,
>  };
>
> -static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
> +static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev);
> +
> +static void link_reinit_work(struct work_struct *work)
> +{
> +       struct switchtec_ntb *sndev;
> +
> +       sndev = container_of(work, struct switchtec_ntb, link_reinit_work);
> +
> +       switchtec_ntb_reinit_peer(sndev);
> +}
> +
> +static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
> +                                    enum switchtec_msg msg)
>  {
>         int link_sta;
>         int old = sndev->link_is_up;
>
> +       if (msg == MSG_LINK_FORCE_DOWN) {
> +               schedule_work(&sndev->link_reinit_work);
> +
> +               if (sndev->link_is_up) {
> +                       sndev->link_is_up = 0;
> +                       ntb_link_event(&sndev->ntb);
> +                       dev_info(&sndev->stdev->dev, "ntb link forced down\n");
> +               }
> +
> +               return;
> +       }
> +
>         link_sta = sndev->self_shared->link_sta;
>         if (link_sta) {
>                 u64 peer = ioread64(&sndev->peer_shared->magic);
> @@ -500,7 +526,7 @@ static void switchtec_ntb_link_notification(struct switchtec_dev *stdev)
>  {
>         struct switchtec_ntb *sndev = stdev->sndev;
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>  }
>
>  static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
> @@ -528,7 +554,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
>         sndev->self_shared->link_sta = 1;
>         switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>
>         return 0;
>  }
> @@ -540,9 +566,9 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
>         dev_dbg(&sndev->stdev->dev, "disabling link\n");
>
>         sndev->self_shared->link_sta = 0;
> -       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>
>         return 0;
>  }
> @@ -785,6 +811,8 @@ static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
>         sndev->ntb.topo = NTB_TOPO_SWITCH;
>         sndev->ntb.ops = &switchtec_ntb_ops;
>
> +       INIT_WORK(&sndev->link_reinit_work, link_reinit_work);
> +
>         sndev->self_partition = sndev->stdev->partition;
>
>         sndev->mmio_ntb = sndev->stdev->mmio_ntb;
> @@ -1062,7 +1090,7 @@ static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
>                         iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
>
>                         if (i == LINK_MESSAGE)
> -                               switchtec_ntb_check_link(sndev);
> +                               switchtec_ntb_check_link(sndev, msg);
>                 }
>         }
>
> @@ -1123,6 +1151,14 @@ static void switchtec_ntb_deinit_db_msg_irq(struct switchtec_ntb *sndev)
>         free_irq(sndev->message_irq, sndev);
>  }
>
> +static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
> +{
> +       dev_info(&sndev->stdev->dev, "peer reinitialized\n");
> +       switchtec_ntb_deinit_shared_mw(sndev);
> +       switchtec_ntb_init_mw(sndev);
> +       return switchtec_ntb_init_shared_mw(sndev);
> +}
> +
>  static int switchtec_ntb_add(struct device *dev,
>                              struct class_interface *class_intf)
>  {
> @@ -1160,6 +1196,13 @@ static int switchtec_ntb_add(struct device *dev,
>         if (rc)
>                 goto deinit_shared_and_exit;
>
> +       /*
> +        * If this host crashed, the other host may think the link is
> +        * still up. Tell them to force it down (it will go back up
> +        * once we register the ntb device).
> +        */
> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_FORCE_DOWN);
> +
>         rc = ntb_register_device(&sndev->ntb);
>         if (rc)
>                 goto deinit_and_exit;
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20171204175721.10322-1-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
