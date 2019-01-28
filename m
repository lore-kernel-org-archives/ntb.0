Return-Path: <allenbh@gmail.com>
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com. [2a00:1450:4864:20::22d])
        by gmr-mx.google.com with ESMTPS id x188si2368792wmb.3.2019.01.28.07.38.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 07:38:00 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l15-v6so14620044lja.9
        for <linux-ntb@googlegroups.com>; Mon, 28 Jan 2019 07:38:00 -0800 (PST)
MIME-Version: 1.0
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com> <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
 <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com>
 <877b89c1-22bd-36bf-f7e1-ec85a9c63cb1@intel.com> <CAPWoNkLPbjj-fhrtVt6+iS+Qotrg17FpEjkUMvCRpeWrZ348Ng@mail.gmail.com>
In-Reply-To: <CAPWoNkLPbjj-fhrtVt6+iS+Qotrg17FpEjkUMvCRpeWrZ348Ng@mail.gmail.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 28 Jan 2019 10:37:49 -0500
Message-ID: <CAJ80sasqy4QhRMWojNQ7nb=v2_L_SzNYU=GcisMqeNb_6Qv59Q@mail.gmail.com>
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
Content-Type: text/plain; charset="UTF-8"
To: Leon Ravich <lravich@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Jan 27, 2019 at 3:13 AM Leon Ravich <lravich@gmail.com> wrote:
>
> Sorry for styling issues, this is my first commit to this community ,  attaching fixed commit after passing scripts/checkpatch.pl
>
> Thanks, Dave, Logan and Allen
>
> From aa9fde25f063c8254f59e705caeb102ecf47dd9a Mon Sep 17 00:00:00 2001
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> Date: Tue, 22 Jan 2019 15:20:56 +0200
> Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and db_data
>
> NTB door bell usage depends on NTB hardware.
>
> ex: intel NTB gen1 has one peer door bell register which can be controlled
> by the bitmap writen to it, while Intel NTB gen3 has a registers
> per door bell and the data trigering the each door bell is always 1.
>
> therefore exposing only peer door bell address forcing the user
> to be aware of such low level details
>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
>  drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
>  drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
>  drivers/ntb/hw/intel/ntb_hw_gen3.c     | 33 ++++++++++++++++++++++++++++++++-
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
>  include/linux/ntb.h                    | 10 +++++++---
>  5 files changed, 69 insertions(+), 13 deletions(-)


>         int (*peer_db_addr)(struct ntb_dev *ntb,
> -                           phys_addr_t *db_addr, resource_size_t *db_size);
> +                           phys_addr_t *db_addr, resource_size_t *db_size,
> +                               u64 *db_data, int db_bit);

For usage in ntrdma, this looks good to me.

Acked-by: Allen Hubbe <allenbh@gmail.com>
