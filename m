Return-Path: <allenbh@gmail.com>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com. [2607:f8b0:400d:c09::229])
        by gmr-mx.google.com with ESMTPS id h206si184045ywb.6.2015.12.17.08.45.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2015 08:45:37 -0800 (PST)
Received: by mail-qk0-x229.google.com with SMTP id t125so100761152qkh.3
        for <linux-ntb@googlegroups.com>; Thu, 17 Dec 2015 08:45:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1450340265-18912-1-git-send-email-Xiangliang.Yu@amd.com>
References: <1450340265-18912-1-git-send-email-Xiangliang.Yu@amd.com>
Date: Thu, 17 Dec 2015 11:45:37 -0500
Message-ID: <CAJ80satY97nwd5hJgN=F+a4fAwpqxh8nV5a7hHm6WK=2qqhOig@mail.gmail.com>
Subject: Re: [PATCH 1/3] NTB: Add AMD PCI-Express NTB driver
From: Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset=UTF-8
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 17, 2015 at 3:17 AM, Xiangliang Yu <Xiangliang.Yu@amd.com> wrote:
> AMD NTB support following main features:
> (1) Three memory windows;
> (2) Sixteen 32-bit scratch pad;
> (3) Two 16-bit doorbell interrupt;
> (4) Five event interrupts;
> (5) One system can wake up opposite system of NTB;
> (6) Flush previous request to the opposite system;
> (7) There are reset and PME_TO mechanisms between two systems;
>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

Is hardware available on which this can be tested?

> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c

> +static u64 amd_ntb_db_read(struct ntb_dev *ntb)
> +{
> +       struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> +
> +       return (u64)NTB_READ_REG(DBSTAT);
> +}

DBSTAT hides the use of ndev, or ndev is unused.  The code should be
more clear, here, and in other places where NTB_READ_REG and
NTB_WRITE_REG are used with a macro argument.

> +static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
> +{
> +       int reg;
> +
> +       reg = NTB_READ_REG(SMUACK);
> +       reg |= bit;
> +       NTB_WRITE_REG(reg, SMUACK);
> +
> +       ndev->peer_sta |= bit;
> +}
> +
> +/*
> + * flush the requests to peer side
> + */
> +static int amd_flush_peer_requests(struct amd_ntb_dev *ndev)
> +{
> +       u32 reg;
> +
> +       if (!amd_link_is_up(ndev)) {
> +               dev_err(ndev_dev(ndev), "link is down.\n");
> +               return -EINVAL;
> +       }
> +

Add reinit_completion, or this may already be "complete" from a previous flush.

> +       reg = NTB_READ_REG(FLUSHTRIG);
> +       reg |= 0x1;
> +       NTB_WRITE_REG(reg, FLUSHTRIG);
> +
> +       wait_for_completion(&ndev->flush_cmpl);

Because of wait_for_completion, that this can only be called in a
thread context.  This is unlike other functions of ntb.h, so there
should at least be a note in the api documentation.

> +
> +       return 0;
> +}
> +
> +/*
> + * wake up the peer side
> + */
> +static int amd_wakeup_peer_side(struct amd_ntb_dev *ndev)
> +{
> +       u32 reg;
> +
> +       if (!amd_link_is_up(ndev)) {
> +               dev_warn(ndev_dev(ndev), "link is down.\n");
> +               return -EINVAL;
> +       }
> +

See previous comment.

> +       NTB_READ_REG(PMSGTRIG);
> +       reg |= 0x1;
> +       NTB_WRITE_REG(reg, PMSGTRIG);
> +
> +       wait_for_completion(&ndev->wakeup_cmpl);
> +
> +       return 0;
> +}


> +static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
> +{
> +       u32 status;
> +
> +       status = NTB_READ_REG(INTSTAT);
> +       if (!(status & AMD_EVENT_INTMASK))
> +               return;
> +
> +       dev_dbg(ndev_dev(ndev), "status = 0x%x and vec = %d\n", status, vec);
> +
> +       status &= AMD_EVENT_INTMASK;
> +       switch (status) {
> +       case AMD_PEER_FLUSH_EVENT:
> +               complete(&ndev->flush_cmpl);
> +               break;
> +       case AMD_PEER_RESET_EVENT:
> +               amd_ack_SMU(ndev, AMD_PEER_RESET_EVENT);
> +
> +               /* link down first */
> +               ntb_link_event(&ndev->ntb);
> +               /* polling peer status */
> +               schedule_delayed_work(&ndev->hb_timer, AMD_LINK_HB_TIMEOUT);
> +
> +               break;
> +       case AMD_PEER_D3_EVENT:
> +       case AMD_PEER_PMETO_EVENT:
> +               amd_ack_SMU(ndev, status);
> +
> +               /* link down */
> +               ntb_link_event(&ndev->ntb);
> +
> +               break;
> +       case AMD_PEER_D0_EVENT:
> +               status = NTB_READ_PEER_REG(PMESTAT);
> +               /* check if this is WAKEUP event */
> +               if (status & 0x1)
> +                       complete(&ndev->wakeup_cmpl);
> +
> +               amd_ack_SMU(ndev, AMD_PEER_D0_EVENT);
> +
> +               if (amd_link_is_up(ndev))
> +                       ntb_link_event(&ndev->ntb);
> +               else
> +                       schedule_delayed_work(&ndev->hb_timer,
> +                                               AMD_LINK_HB_TIMEOUT);
> +               break;
> +       default:
> +               pr_err("Unsupported interrupt.\n");
> +               break;
> +       }
> +}
> +
> +static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
> +{
> +       dev_dbg(ndev_dev(ndev), "vec %d\n", vec);
> +
> +       if (vec > 20) {

This duplicates the "default" case of amd_handle_event.

> +               dev_err(ndev_dev(ndev), "Invalid interrupt.\n");
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (vec > 16 || (ndev->msix_vec_count == 1))
> +               amd_handle_event(ndev, vec);
> +
> +       if (vec < 16)
> +               ntb_db_event(&ndev->ntb, vec);
> +
> +       return IRQ_HANDLED;
> +}
