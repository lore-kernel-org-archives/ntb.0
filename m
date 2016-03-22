Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com. [2607:f8b0:400c:c05::243])
        by gmr-mx.google.com with ESMTPS id v71si1006487vkd.3.2016.03.21.17.00.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 17:00:55 -0700 (PDT)
Received: by mail-vk0-x243.google.com with SMTP id e6so18680160vkh.1
        for <linux-ntb@googlegroups.com>; Mon, 21 Mar 2016 17:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com>
References: <17b414e0af3e8caf31b3b3aa5dddb842ef397c1a.1458550127.git.Allen.Hubbe@emc.com>
	<6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com>
Date: Mon, 21 Mar 2016 20:00:54 -0400
Message-ID: <CAPoiz9zTK_wcU6vJUKVuNcagnxdqmkFczyo=k0V1pxnXofqTJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 21, 2016 at 4:53 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> Kernel zero day testing warned about address space confusion.  A virtual
> iomem address was used where a physical address is expected.  The
> offending functions implement an optional part of the api, so they are
> removed.  They can be added later, after testing.
>
> Fixes: a1b3695820aa490e58915d720a1438069813008b
>
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
>
> Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>

I don't see anything wrong with this, but I want Xiangliang to ack it.
So unless I hear from Xiangliang in the next 24 hours, I'm going to
push this fix to the next release (v4.7).  Is that acceptable?

Thanks,
Jon

> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 588803ad6847..6ccba0d862df 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -357,20 +357,6 @@ static int amd_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
>         return 0;
>  }
>
> -static int amd_ntb_peer_db_addr(struct ntb_dev *ntb,
> -                               phys_addr_t *db_addr,
> -                               resource_size_t *db_size)
> -{
> -       struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> -
> -       if (db_addr)
> -               *db_addr = (phys_addr_t)(ndev->peer_mmio + AMD_DBREQ_OFFSET);
> -       if (db_size)
> -               *db_size = sizeof(u32);
> -
> -       return 0;
> -}
> -
>  static int amd_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
>         struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> @@ -415,20 +401,6 @@ static int amd_ntb_spad_write(struct ntb_dev *ntb,
>         return 0;
>  }
>
> -static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> -                                 phys_addr_t *spad_addr)
> -{
> -       struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> -
> -       if (idx < 0 || idx >= ndev->spad_count)
> -               return -EINVAL;
> -
> -       if (spad_addr)
> -               *spad_addr = (phys_addr_t)(ndev->self_mmio + AMD_SPAD_OFFSET +
> -                                          ndev->peer_spad + (idx << 2));
> -       return 0;
> -}
> -
>  static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
>  {
>         struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> @@ -472,12 +444,10 @@ static const struct ntb_dev_ops amd_ntb_ops = {
>         .db_clear               = amd_ntb_db_clear,
>         .db_set_mask            = amd_ntb_db_set_mask,
>         .db_clear_mask          = amd_ntb_db_clear_mask,
> -       .peer_db_addr           = amd_ntb_peer_db_addr,
>         .peer_db_set            = amd_ntb_peer_db_set,
>         .spad_count             = amd_ntb_spad_count,
>         .spad_read              = amd_ntb_spad_read,
>         .spad_write             = amd_ntb_spad_write,
> -       .peer_spad_addr         = amd_ntb_peer_spad_addr,
>         .peer_spad_read         = amd_ntb_peer_spad_read,
>         .peer_spad_write        = amd_ntb_peer_spad_write,
>  };
> --
> 2.7.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
