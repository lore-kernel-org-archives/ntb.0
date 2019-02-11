Return-Path: <jdmason@kudzu.us>
Received: from mail-it1-x12c.google.com (mail-it1-x12c.google.com. [2607:f8b0:4864:20::12c])
        by gmr-mx.google.com with ESMTPS id j3si561082pll.0.2019.02.11.05.30.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 05:30:10 -0800 (PST)
Received: by mail-it1-x12c.google.com with SMTP id c9so26174431itj.1
        for <linux-ntb@googlegroups.com>; Mon, 11 Feb 2019 05:30:10 -0800 (PST)
MIME-Version: 1.0
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com> <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
 <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com>
 <877b89c1-22bd-36bf-f7e1-ec85a9c63cb1@intel.com> <CAPWoNkLPbjj-fhrtVt6+iS+Qotrg17FpEjkUMvCRpeWrZ348Ng@mail.gmail.com>
In-Reply-To: <CAPWoNkLPbjj-fhrtVt6+iS+Qotrg17FpEjkUMvCRpeWrZ348Ng@mail.gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 11 Feb 2019 08:29:57 -0500
Message-ID: <CAPoiz9zBahdSOPfb2--VsCZqKPMxdxLZP7gxm5gqEnOHrAsPFQ@mail.gmail.com>
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
Content-Type: text/plain; charset="UTF-8"
To: Leon Ravich <lravich@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>, "Hubbe, Allen" <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Jan 27, 2019 at 3:13 AM Leon Ravich <lravich@gmail.com> wrote:
>
> Sorry for styling issues, this is my first commit to this community ,  attaching fixed commit after passing scripts/checkpatch.pl

I apprecaite you sending out this patch, but it is a mess and won't
apply to my git tree.  I spent way too much time trying to get it to
work by hand, only to ultimately fail.  I think it is being caused due
to this patch not being a new email (like it should be) and simply
thrown into a response (please don't do that).  This caused the email
to wrap lines at 72, thus breaking the patch tool.  It could also be
caused by how the patch was sent out by your mail client (use
Thunderbird or mutt, and inline the patch. Don't use the gmail web
interface).

Please resend this patch as a new version (e.g., add [PATCH v2] to the
subject).  If using `git send-email` or `git format-patch`, this can
be done by adding "-v2" to the command.  Also, add the "Acked-by" that
everyone gave in the previous version(s) to the v2 patch.

Thanks,
Jon

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
>
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 2ad263f..bb57ec2 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
>         return ndev->reg->mw_bar[idx];
>  }
>
> -static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
> +void ndev_db_addr(struct intel_ntb_dev *ndev,
>                                phys_addr_t *db_addr, resource_size_t *db_size,
>                                phys_addr_t reg_addr, unsigned long reg)
>  {
> @@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
>                 *db_size = ndev->reg->db_size;
>                 dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n", *db_size);
>         }
> -
> -       return 0;
>  }
>
>  u64 ndev_db_read(struct intel_ntb_dev *ndev,
> @@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
>                                   ndev->self_reg->db_mask);
>  }
>
> -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -                          resource_size_t *db_size)
> +static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> +                          resource_size_t *db_size, u64 *db_data, int db_bit)
>  {
> +       u64 db_bits;
>         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>
> -       return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
> +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> +               return -EINVAL;
> +
> +       db_bits = BIT_ULL(db_bit);
> +
> +       if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
> +               return -EINVAL;
> +
> +       ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
>                             ndev->peer_reg->db_bell);
> +
> +       if (db_data)
> +               *db_data = db_bits;
> +
> +
> +       return 0;
>  }
>
>  static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> index ad8ec14..544cf5c 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> @@ -147,6 +147,9 @@
>  int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int msix_max,
>                 int msix_shift, int total_shift);
>  enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
> +void ndev_db_addr(struct intel_ntb_dev *ndev,
> +                               phys_addr_t *db_addr, resource_size_t *db_size,
> +                               phys_addr_t reg_addr, unsigned long reg);
>  u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio);
>  int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
>                                 void __iomem *mmio);
> @@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum ntb_speed *speed,
>  u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector);
>  int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
>  int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
> -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -               resource_size_t *db_size);
>  int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);
>  int intel_ntb_spad_count(struct ntb_dev *ntb);
>  u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index b3fa247..f475b56 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -532,6 +532,37 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>         return 0;
>  }
>
> +int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> +                               resource_size_t *db_size,
> +                               u64 *db_data, int db_bit)
> +{
> +       phys_addr_t db_addr_base;
> +       struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> +
> +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> +               return -EINVAL;
> +
> +       if (unlikely(BIT_ULL(db_bit) & ~ntb_ndev(ntb)->db_valid_mask))
> +               return -EINVAL;
> +
> +       ndev_db_addr(ndev, &db_addr_base, db_size, ndev->peer_addr,
> +                               ndev->peer_reg->db_bell);
> +
> +       if (db_addr) {
> +               *db_addr = db_addr_base + (db_bit * 4);
> +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx db bit %d\n",
> +                               *db_addr, db_bit);
> +       }
> +
> +       if (db_data) {
> +               *db_data = 1;
> +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit %d\n",
> +                               *db_data, db_bit);
> +       }
> +
> +       return 0;
> +}
> +
>  static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>  {
>         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> @@ -584,7 +615,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb, u64 db_bits)
>         .db_clear               = intel_ntb3_db_clear,
>         .db_set_mask            = intel_ntb_db_set_mask,
>         .db_clear_mask          = intel_ntb_db_clear_mask,
> -       .peer_db_addr           = intel_ntb_peer_db_addr,
> +       .peer_db_addr           = intel_ntb3_peer_db_addr,
>         .peer_db_set            = intel_ntb3_peer_db_set,
>         .spad_is_unsafe         = intel_ntb_spad_is_unsafe,
>         .spad_count             = intel_ntb_spad_count,
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 5ee5f40..9fa1b99 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev *ntb)
>
>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>                                       phys_addr_t *db_addr,
> -                                     resource_size_t *db_size)
> +                                     resource_size_t *db_size,
> +                                     u64 *db_data,
> +                                     int db_bit)
>  {
>         struct switchtec_ntb *sndev = ntb_sndev(ntb);
>         unsigned long offset;
>
> +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> +               return -EINVAL;
> +
>         offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
>                 (unsigned long)sndev->stdev->mmio;
>
> @@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>                 *db_addr = pci_resource_start(ntb->pdev, 0) + offset;
>         if (db_size)
>                 *db_size = sizeof(u32);
> +       if (db_data)
> +               *db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;
>
>         return 0;
>  }
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 181d166..56a92e3 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -296,7 +296,8 @@ struct ntb_dev_ops {
>         int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
>
>         int (*peer_db_addr)(struct ntb_dev *ntb,
> -                           phys_addr_t *db_addr, resource_size_t *db_size);
> +                           phys_addr_t *db_addr, resource_size_t *db_size,
> +                               u64 *db_data, int db_bit);
>         u64 (*peer_db_read)(struct ntb_dev *ntb);
>         int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
>         int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
> @@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
>   * @ntb:       NTB device context.
>   * @db_addr:   OUT - The address of the peer doorbell register.
>   * @db_size:   OUT - The number of bytes to write the peer doorbell register.
> + * @db_data:   OUT - The data of peer doorbell register
> + * @db_bit:            door bell bit number
>   *
>   * Return the address of the peer doorbell register.  This may be used, for
>   * example, by drivers that offload memory copy operations to a dma engine.
> @@ -1091,12 +1094,13 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
>   */
>  static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
>                                    phys_addr_t *db_addr,
> -                                  resource_size_t *db_size)
> +                                  resource_size_t *db_size,
> +                                  u64 *db_data, int db_bit)
>  {
>         if (!ntb->ops->peer_db_addr)
>                 return -EINVAL;
>
> -       return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
> +       return ntb->ops->peer_db_addr(ntb, db_addr, db_size, db_data, db_bit);
>  }
>
>  /**
> --
> 1.9.3
>
>
> On Thu, 24 Jan 2019 at 18:56, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 1/24/19 6:51 AM, Leon Ravich wrote:
>> > added missed functionality to switchtec driver, I hope its OK the way I
>> > sent the fix .
>> >
>> > Thanks,
>> > Leonid
>> >
>> > From a04eb9162aa347a885104aaef9dcf2af1884b8c2 Mon Sep 17 00:00:00 2001
>> > From: Leonid Ravich <Leonid.Ravich@emc.com <mailto:Leonid.Ravich@emc.com>>
>> > Date: Tue, 22 Jan 2019 15:20:56 +0200
>> > Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and db_data
>> >
>> > NTB door bell usage depends on NTB hardware.
>> >
>> > ex: intel NTB gen1 has one peer door bell register which can be controled
>> > by the bitmap writen to it, while Intel NTB gen3 has a registes
>> > per door bell and the data trigering the each door bell is always 1.
>> >
>> > therefore exposing only peer door bell address forcing the user to be
>> > aware of such
>> > low level details
>> >
>> >
>> > Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com
>> > <mailto:Leonid.Ravich@emc.com>>
>> > Cc: Allen Hubbe <allenbh@gmail.com <mailto:allenbh@gmail.com>>
>> > Cc: Logan Gunthorpe <logang@deltatee.com <mailto:logang@deltatee.com>>
>>
>> Just tiny nit below.
>> Otherwise Acked-by: Dave Jiang <dave.jiang@intel.com>
>>
>>
>> >
>> > ---
>> >  drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
>> >  drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
>> >  drivers/ntb/hw/intel/ntb_hw_gen3.c     | 30 +++++++++++++++++++++++++++++-
>> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
>> >  include/linux/ntb.h                    |  9 ++++++---
>> >  5 files changed, 65 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c
>> > b/drivers/ntb/hw/intel/ntb_hw_gen1.c
>> > index 2ad263f..fcccc7c 100644
>> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
>> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
>> > @@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
>> >         return ndev->reg->mw_bar[idx];
>> >  }
>> >
>> > -static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
>> > +void ndev_db_addr(struct intel_ntb_dev *ndev,
>> >                                phys_addr_t *db_addr, resource_size_t
>> > *db_size,
>> >                                phys_addr_t reg_addr, unsigned long reg)
>> >  {
>> > @@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev
>> > *ndev,
>> >                 *db_size = ndev->reg->db_size;
>> >                 dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n",
>> > *db_size);
>> >         }
>> > -
>> > -       return 0;
>> >  }
>> >
>> >  u64 ndev_db_read(struct intel_ntb_dev *ndev,
>> > @@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb,
>> > u64 db_bits)
>> >                                   ndev->self_reg->db_mask);
>> >  }
>> >
>> > -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
>> > -                          resource_size_t *db_size)
>> > +static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t
>> > *db_addr,
>> > +                          resource_size_t *db_size, u64 *db_data, int
>> > db_bit)
>> >  {
>> > +       u64 db_bits;
>> >         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>> >
>> > -       return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
>> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
>> > +                       return -EINVAL;
>> > +
>> > +       db_bits = BIT_ULL(db_bit);
>> > +
>> > +       if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
>> > +               return -EINVAL;
>> > +
>> > +       ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
>> >                             ndev->peer_reg->db_bell);
>> > +
>> > +       if (db_data) {
>> > +               *db_data = db_bits;
>> > +       }
>>
>> if (db_data)
>>         *db_data = db_bits;
>>
>>
>> > +
>> > +       return 0;
>> >  }
>> >
>> >  static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h
>> > b/drivers/ntb/hw/intel/ntb_hw_gen1.h
>> > index ad8ec14..544cf5c 100644
>> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
>> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
>> > @@ -147,6 +147,9 @@
>> >  int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int msix_max,
>> >                 int msix_shift, int total_shift);
>> >  enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
>> > +void ndev_db_addr(struct intel_ntb_dev *ndev,
>> > +                               phys_addr_t *db_addr, resource_size_t
>> > *db_size,
>> > +                               phys_addr_t reg_addr, unsigned long reg);
>> >  u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio);
>> >  int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
>> >                                 void __iomem *mmio);
>> > @@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum
>> > ntb_speed *speed,
>> >  u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector);
>> >  int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
>> >  int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
>> > -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
>> > -               resource_size_t *db_size);
>> >  int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);
>> >  int intel_ntb_spad_count(struct ntb_dev *ntb);
>> >  u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);
>> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c
>> > b/drivers/ntb/hw/intel/ntb_hw_gen3.c
>> > index b3fa247..b642c80 100644
>> > --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
>> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
>> > @@ -532,6 +532,34 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
>> > *ntb, int pidx, int idx,
>> >         return 0;
>> >  }
>> >
>> > +int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
>> > +                               resource_size_t *db_size, u64 *db_data,
>> > int db_bit)
>> > +{
>> > +       phys_addr_t db_addr_base;
>> > +       struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>> > +
>> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
>> > +               return -EINVAL;
>> > +
>> > +       if (unlikely(BIT_ULL(db_bit) & ~ntb_ndev(ntb)->db_valid_mask))
>> > +               return -EINVAL;
>> > +
>> > +       ndev_db_addr(ndev, &db_addr_base, db_size, ndev->peer_addr,
>> > +                               ndev->peer_reg->db_bell);
>> > +
>> > +       if (db_addr) {
>> > +               *db_addr = db_addr_base + (db_bit * 4);
>> > +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx db bit
>> > %d\n", *db_addr, db_bit);
>> > +       }
>> > +
>> > +       if (db_data) {
>> > +               *db_data = 1;
>> > +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit
>> > %d\n", *db_data, db_bit);
>> > +       }
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >  static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
>> >  {
>> >         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>> > @@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb,
>> > u64 db_bits)
>> >         .db_clear               = intel_ntb3_db_clear,
>> >         .db_set_mask            = intel_ntb_db_set_mask,
>> >         .db_clear_mask          = intel_ntb_db_clear_mask,
>> > -       .peer_db_addr           = intel_ntb_peer_db_addr,
>> > +       .peer_db_addr           = intel_ntb3_peer_db_addr,
>> >         .peer_db_set            = intel_ntb3_peer_db_set,
>> >         .spad_is_unsafe         = intel_ntb_spad_is_unsafe,
>> >         .spad_count             = intel_ntb_spad_count,
>> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> > b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> > index 5ee5f40..d95fa35 100644
>> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> > @@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct
>> > ntb_dev *ntb)
>> >
>> >  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>> >                                       phys_addr_t *db_addr,
>> > -                                     resource_size_t *db_size)
>> > +                                     resource_size_t *db_size,
>> > +                                     u64 *db_data,
>> > +                                     int db_bit)
>> >  {
>> >         struct switchtec_ntb *sndev = ntb_sndev(ntb);
>> >         unsigned long offset;
>> >
>> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
>> > +                       return -EINVAL;
>> > +
>> >         offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
>> >                 (unsigned long)sndev->stdev->mmio;
>> >
>> > @@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev
>> > *ntb,
>> >                 *db_addr = pci_resource_start(ntb->pdev, 0) + offset;
>> >         if (db_size)
>> >                 *db_size = sizeof(u32);
>> > +       if (db_data)
>> > +               *db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;
>> >
>> >         return 0;
>> >  }
>> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
>> > index 181d166..5c7c392 100644
>> > --- a/include/linux/ntb.h
>> > +++ b/include/linux/ntb.h
>> > @@ -296,7 +296,8 @@ struct ntb_dev_ops {
>> >         int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
>> >
>> >         int (*peer_db_addr)(struct ntb_dev *ntb,
>> > -                           phys_addr_t *db_addr, resource_size_t *db_size);
>> > +                           phys_addr_t *db_addr, resource_size_t
>> > *db_size, u64 *db_data,
>> > +                           int db_bit);
>> >         u64 (*peer_db_read)(struct ntb_dev *ntb);
>> >         int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
>> >         int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
>> > @@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev
>> > *ntb, u64 db_bits)
>> >   * @ntb:       NTB device context.
>> >   * @db_addr:   OUT - The address of the peer doorbell register.
>> >   * @db_size:   OUT - The number of bytes to write the peer doorbell
>> > register.
>> > + * @db_data:   OUT - The data of peer doorbell register
>> > + * @db_bit:            door bell bit number
>> >   *
>> >   * Return the address of the peer doorbell register.  This may be used, for
>> >   * example, by drivers that offload memory copy operations to a dma engine.
>> > @@ -1091,12 +1094,12 @@ static inline int ntb_db_clear_mask(struct
>> > ntb_dev *ntb, u64 db_bits)
>> >   */
>> >  static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
>> >                                    phys_addr_t *db_addr,
>> > -                                  resource_size_t *db_size)
>> > +                                  resource_size_t *db_size, u64
>> > *db_data, int db_bit)
>> >  {
>> >         if (!ntb->ops->peer_db_addr)
>> >                 return -EINVAL;
>> >
>> > -       return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
>> > +       return ntb->ops->peer_db_addr(ntb, db_addr, db_size, db_data,
>> > db_bit);
>> >  }
>> >
>> >  /**
>> > --
>> > 1.9.3
>> >
>> >
>> > On Wed, 23 Jan 2019 at 19:40, Dave Jiang <dave.jiang@intel.com
>> > <mailto:dave.jiang@intel.com>> wrote:
>> >
>> >
>> >
>> >     On 1/23/19 10:30 AM, Logan Gunthorpe wrote:
>> >     >
>> >     >
>> >     > On 2019-01-23 2:28 a.m., lravich@gmail.com
>> >     <mailto:lravich@gmail.com> wrote:
>> >     >>         .spad_count             = intel_ntb_spad_count,
>> >     >> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >     >> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >     >> index 5ee5f40..af01222 100644
>> >     >> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >     >> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >     >> @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct
>> >     ntb_dev
>> >     >> *ntb)
>> >     >>
>> >     >>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>> >     >>                                       phys_addr_t *db_addr,
>> >     >> -                                     resource_size_t *db_size)
>> >     >> +                                     resource_size_t *db_size,
>> >     >> +                                     u64 *db_data,
>> >     >> +                                     int db_bit)
>> >     >>  {
>> >     >
>> >     >
>> >     > The semantics of this interface are not clear because there are no
>> >     users
>> >     > in the kernel. But doesn't a correct implementation require you to set
>> >     > db_data here?
>> >
>> >     Cc Allen
>> >
>> >     Side comment. The only user of this function I am aware of is the out of
>> >     tree NTRDMA code.
>> >
>> >     >
>> >     > Logan
>> >     >
>> >
>> >
>> >
>> > --
>> > Leonid Ravich
>> >
>> > --
>> > You received this message because you are subscribed to the Google
>> > Groups "linux-ntb" group.
>> > To unsubscribe from this group and stop receiving emails from it, send
>> > an email to linux-ntb+unsubscribe@googlegroups.com
>> > <mailto:linux-ntb+unsubscribe@googlegroups.com>.
>> > To post to this group, send email to linux-ntb@googlegroups.com
>> > <mailto:linux-ntb@googlegroups.com>.
>> > To view this discussion on the web visit
>> > https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com
>> > <https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com?utm_medium=email&utm_source=footer>.
>> > For more options, visit https://groups.google.com/d/optout.
>>
>> --
>> You received this message because you are subscribed to a topic in the Google Groups "linux-ntb" group.
>> To unsubscribe from this topic, visit https://groups.google.com/d/topic/linux-ntb/fvSmCCPd7zo/unsubscribe.
>> To unsubscribe from this group and all its topics, send an email to linux-ntb+unsubscribe@googlegroups.com.
>> To post to this group, send email to linux-ntb@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/877b89c1-22bd-36bf-f7e1-ec85a9c63cb1%40intel.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
>
> --
> Leonid Ravich
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/CAPWoNkLPbjj-fhrtVt6%2BiS%2BQotrg17FpEjkUMvCRpeWrZ348Ng%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
