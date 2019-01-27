Return-Path: <lravich@gmail.com>
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com. [2607:f8b0:4864:20::142])
        by gmr-mx.google.com with ESMTPS id w33si1639384ybi.2.2019.01.27.00.13.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 00:13:07 -0800 (PST)
Received: by mail-it1-x142.google.com with SMTP id m8so8432625itk.0
        for <linux-ntb@googlegroups.com>; Sun, 27 Jan 2019 00:13:07 -0800 (PST)
MIME-Version: 1.0
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com> <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
 <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com> <877b89c1-22bd-36bf-f7e1-ec85a9c63cb1@intel.com>
In-Reply-To: <877b89c1-22bd-36bf-f7e1-ec85a9c63cb1@intel.com>
From: Leon Ravich <lravich@gmail.com>
Date: Sun, 27 Jan 2019 10:12:49 +0200
Message-ID: <CAPWoNkLPbjj-fhrtVt6+iS+Qotrg17FpEjkUMvCRpeWrZ348Ng@mail.gmail.com>
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
Content-Type: multipart/alternative; boundary="00000000000045d7ca05806c21e6"
To: Dave Jiang <dave.jiang@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>, "Hubbe, Allen" <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

--00000000000045d7ca05806c21e6
Content-Type: text/plain; charset="UTF-8"

Sorry for styling issues, this is my first commit to this community ,
attaching fixed commit after passing scripts/checkpatch.pl

Thanks, Dave, Logan and Allen

From aa9fde25f063c8254f59e705caeb102ecf47dd9a Mon Sep 17 00:00:00 2001
From: Leonid Ravich <Leonid.Ravich@emc.com>
Date: Tue, 22 Jan 2019 15:20:56 +0200
Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and db_data

NTB door bell usage depends on NTB hardware.

ex: intel NTB gen1 has one peer door bell register which can be controlled
by the bitmap writen to it, while Intel NTB gen3 has a registers
per door bell and the data trigering the each door bell is always 1.

therefore exposing only peer door bell address forcing the user
to be aware of such low level details

Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 33
++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
 include/linux/ntb.h                    | 10 +++++++---
 5 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c
b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f..bb57ec2 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
        return ndev->reg->mw_bar[idx];
 }

-static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
+void ndev_db_addr(struct intel_ntb_dev *ndev,
                               phys_addr_t *db_addr, resource_size_t
*db_size,
                               phys_addr_t reg_addr, unsigned long reg)
 {
@@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev
*ndev,
                *db_size = ndev->reg->db_size;
                dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n",
*db_size);
        }
-
-       return 0;
 }

 u64 ndev_db_read(struct intel_ntb_dev *ndev,
@@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb,
u64 db_bits)
                                  ndev->self_reg->db_mask);
 }

-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-                          resource_size_t *db_size)
+static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t
*db_addr,
+                          resource_size_t *db_size, u64 *db_data, int
db_bit)
 {
+       u64 db_bits;
        struct intel_ntb_dev *ndev = ntb_ndev(ntb);

-       return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
+       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+               return -EINVAL;
+
+       db_bits = BIT_ULL(db_bit);
+
+       if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
+               return -EINVAL;
+
+       ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
                            ndev->peer_reg->db_bell);
+
+       if (db_data)
+               *db_data = db_bits;
+
+
+       return 0;
 }

 static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h
b/drivers/ntb/hw/intel/ntb_hw_gen1.h
index ad8ec14..544cf5c 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
@@ -147,6 +147,9 @@
 int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int msix_max,
                int msix_shift, int total_shift);
 enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
+void ndev_db_addr(struct intel_ntb_dev *ndev,
+                               phys_addr_t *db_addr, resource_size_t
*db_size,
+                               phys_addr_t reg_addr, unsigned long reg);
 u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio);
 int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
                                void __iomem *mmio);
@@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum
ntb_speed *speed,
 u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector);
 int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
 int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-               resource_size_t *db_size);
 int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);
 int intel_ntb_spad_count(struct ntb_dev *ntb);
 u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c
b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index b3fa247..f475b56 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -532,6 +532,37 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
*ntb, int pidx, int idx,
        return 0;
 }

+int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+                               resource_size_t *db_size,
+                               u64 *db_data, int db_bit)
+{
+       phys_addr_t db_addr_base;
+       struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+
+       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+               return -EINVAL;
+
+       if (unlikely(BIT_ULL(db_bit) & ~ntb_ndev(ntb)->db_valid_mask))
+               return -EINVAL;
+
+       ndev_db_addr(ndev, &db_addr_base, db_size, ndev->peer_addr,
+                               ndev->peer_reg->db_bell);
+
+       if (db_addr) {
+               *db_addr = db_addr_base + (db_bit * 4);
+               dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx db bit
%d\n",
+                               *db_addr, db_bit);
+       }
+
+       if (db_data) {
+               *db_data = 1;
+               dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit
%d\n",
+                               *db_data, db_bit);
+       }
+
+       return 0;
+}
+
 static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
        struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -584,7 +615,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb, u64
db_bits)
        .db_clear               = intel_ntb3_db_clear,
        .db_set_mask            = intel_ntb_db_set_mask,
        .db_clear_mask          = intel_ntb_db_clear_mask,
-       .peer_db_addr           = intel_ntb_peer_db_addr,
+       .peer_db_addr           = intel_ntb3_peer_db_addr,
        .peer_db_set            = intel_ntb3_peer_db_set,
        .spad_is_unsafe         = intel_ntb_spad_is_unsafe,
        .spad_count             = intel_ntb_spad_count,
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40..9fa1b99 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev
*ntb)

 static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
                                      phys_addr_t *db_addr,
-                                     resource_size_t *db_size)
+                                     resource_size_t *db_size,
+                                     u64 *db_data,
+                                     int db_bit)
 {
        struct switchtec_ntb *sndev = ntb_sndev(ntb);
        unsigned long offset;

+       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+               return -EINVAL;
+
        offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
                (unsigned long)sndev->stdev->mmio;

@@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev
*ntb,
                *db_addr = pci_resource_start(ntb->pdev, 0) + offset;
        if (db_size)
                *db_size = sizeof(u32);
+       if (db_data)
+               *db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;

        return 0;
 }
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 181d166..56a92e3 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -296,7 +296,8 @@ struct ntb_dev_ops {
        int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);

        int (*peer_db_addr)(struct ntb_dev *ntb,
-                           phys_addr_t *db_addr, resource_size_t *db_size);
+                           phys_addr_t *db_addr, resource_size_t *db_size,
+                               u64 *db_data, int db_bit);
        u64 (*peer_db_read)(struct ntb_dev *ntb);
        int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
        int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
@@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev
*ntb, u64 db_bits)
  * @ntb:       NTB device context.
  * @db_addr:   OUT - The address of the peer doorbell register.
  * @db_size:   OUT - The number of bytes to write the peer doorbell
register.
+ * @db_data:   OUT - The data of peer doorbell register
+ * @db_bit:            door bell bit number
  *
  * Return the address of the peer doorbell register.  This may be used, for
  * example, by drivers that offload memory copy operations to a dma engine.
@@ -1091,12 +1094,13 @@ static inline int ntb_db_clear_mask(struct ntb_dev
*ntb, u64 db_bits)
  */
 static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
                                   phys_addr_t *db_addr,
-                                  resource_size_t *db_size)
+                                  resource_size_t *db_size,
+                                  u64 *db_data, int db_bit)
 {
        if (!ntb->ops->peer_db_addr)
                return -EINVAL;

-       return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
+       return ntb->ops->peer_db_addr(ntb, db_addr, db_size, db_data,
db_bit);
 }

 /**
-- 
1.9.3


On Thu, 24 Jan 2019 at 18:56, Dave Jiang <dave.jiang@intel.com> wrote:

>
>
> On 1/24/19 6:51 AM, Leon Ravich wrote:
> > added missed functionality to switchtec driver, I hope its OK the way I
> > sent the fix .
> >
> > Thanks,
> > Leonid
> >
> > From a04eb9162aa347a885104aaef9dcf2af1884b8c2 Mon Sep 17 00:00:00 2001
> > From: Leonid Ravich <Leonid.Ravich@emc.com <mailto:Leonid.Ravich@emc.com
> >>
> > Date: Tue, 22 Jan 2019 15:20:56 +0200
> > Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and
> db_data
> >
> > NTB door bell usage depends on NTB hardware.
> >
> > ex: intel NTB gen1 has one peer door bell register which can be controled
> > by the bitmap writen to it, while Intel NTB gen3 has a registes
> > per door bell and the data trigering the each door bell is always 1.
> >
> > therefore exposing only peer door bell address forcing the user to be
> > aware of such
> > low level details
> >
> >
> > Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com
> > <mailto:Leonid.Ravich@emc.com>>
> > Cc: Allen Hubbe <allenbh@gmail.com <mailto:allenbh@gmail.com>>
> > Cc: Logan Gunthorpe <logang@deltatee.com <mailto:logang@deltatee.com>>
>
> Just tiny nit below.
> Otherwise Acked-by: Dave Jiang <dave.jiang@intel.com>
>
>
> >
> > ---
> >  drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
> >  drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
> >  drivers/ntb/hw/intel/ntb_hw_gen3.c     | 30
> +++++++++++++++++++++++++++++-
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
> >  include/linux/ntb.h                    |  9 ++++++---
> >  5 files changed, 65 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > index 2ad263f..fcccc7c 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > @@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int
> idx)
> >         return ndev->reg->mw_bar[idx];
> >  }
> >
> > -static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
> > +void ndev_db_addr(struct intel_ntb_dev *ndev,
> >                                phys_addr_t *db_addr, resource_size_t
> > *db_size,
> >                                phys_addr_t reg_addr, unsigned long reg)
> >  {
> > @@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev
> > *ndev,
> >                 *db_size = ndev->reg->db_size;
> >                 dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n",
> > *db_size);
> >         }
> > -
> > -       return 0;
> >  }
> >
> >  u64 ndev_db_read(struct intel_ntb_dev *ndev,
> > @@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb,
> > u64 db_bits)
> >                                   ndev->self_reg->db_mask);
> >  }
> >
> > -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> > -                          resource_size_t *db_size)
> > +static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t
> > *db_addr,
> > +                          resource_size_t *db_size, u64 *db_data, int
> > db_bit)
> >  {
> > +       u64 db_bits;
> >         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> >
> > -       return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> > +                       return -EINVAL;
> > +
> > +       db_bits = BIT_ULL(db_bit);
> > +
> > +       if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
> > +               return -EINVAL;
> > +
> > +       ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
> >                             ndev->peer_reg->db_bell);
> > +
> > +       if (db_data) {
> > +               *db_data = db_bits;
> > +       }
>
> if (db_data)
>         *db_data = db_bits;
>
>
> > +
> > +       return 0;
> >  }
> >
> >  static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h
> > b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> > index ad8ec14..544cf5c 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
> > @@ -147,6 +147,9 @@
> >  int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int
> msix_max,
> >                 int msix_shift, int total_shift);
> >  enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
> > +void ndev_db_addr(struct intel_ntb_dev *ndev,
> > +                               phys_addr_t *db_addr, resource_size_t
> > *db_size,
> > +                               phys_addr_t reg_addr, unsigned long reg);
> >  u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio);
> >  int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
> >                                 void __iomem *mmio);
> > @@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum
> > ntb_speed *speed,
> >  u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector);
> >  int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
> >  int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
> > -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> > -               resource_size_t *db_size);
> >  int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);
> >  int intel_ntb_spad_count(struct ntb_dev *ntb);
> >  u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> > b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> > index b3fa247..b642c80 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> > @@ -532,6 +532,34 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
> > *ntb, int pidx, int idx,
> >         return 0;
> >  }
> >
> > +int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> > +                               resource_size_t *db_size, u64 *db_data,
> > int db_bit)
> > +{
> > +       phys_addr_t db_addr_base;
> > +       struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> > +
> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> > +               return -EINVAL;
> > +
> > +       if (unlikely(BIT_ULL(db_bit) & ~ntb_ndev(ntb)->db_valid_mask))
> > +               return -EINVAL;
> > +
> > +       ndev_db_addr(ndev, &db_addr_base, db_size, ndev->peer_addr,
> > +                               ndev->peer_reg->db_bell);
> > +
> > +       if (db_addr) {
> > +               *db_addr = db_addr_base + (db_bit * 4);
> > +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx db bit
> > %d\n", *db_addr, db_bit);
> > +       }
> > +
> > +       if (db_data) {
> > +               *db_data = 1;
> > +               dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit
> > %d\n", *db_data, db_bit);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
> >  {
> >         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> > @@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb,
> > u64 db_bits)
> >         .db_clear               = intel_ntb3_db_clear,
> >         .db_set_mask            = intel_ntb_db_set_mask,
> >         .db_clear_mask          = intel_ntb_db_clear_mask,
> > -       .peer_db_addr           = intel_ntb_peer_db_addr,
> > +       .peer_db_addr           = intel_ntb3_peer_db_addr,
> >         .peer_db_set            = intel_ntb3_peer_db_set,
> >         .spad_is_unsafe         = intel_ntb_spad_is_unsafe,
> >         .spad_count             = intel_ntb_spad_count,
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index 5ee5f40..d95fa35 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct
> > ntb_dev *ntb)
> >
> >  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
> >                                       phys_addr_t *db_addr,
> > -                                     resource_size_t *db_size)
> > +                                     resource_size_t *db_size,
> > +                                     u64 *db_data,
> > +                                     int db_bit)
> >  {
> >         struct switchtec_ntb *sndev = ntb_sndev(ntb);
> >         unsigned long offset;
> >
> > +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> > +                       return -EINVAL;
> > +
> >         offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
> >                 (unsigned long)sndev->stdev->mmio;
> >
> > @@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev
> > *ntb,
> >                 *db_addr = pci_resource_start(ntb->pdev, 0) + offset;
> >         if (db_size)
> >                 *db_size = sizeof(u32);
> > +       if (db_data)
> > +               *db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;
> >
> >         return 0;
> >  }
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index 181d166..5c7c392 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -296,7 +296,8 @@ struct ntb_dev_ops {
> >         int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
> >
> >         int (*peer_db_addr)(struct ntb_dev *ntb,
> > -                           phys_addr_t *db_addr, resource_size_t
> *db_size);
> > +                           phys_addr_t *db_addr, resource_size_t
> > *db_size, u64 *db_data,
> > +                           int db_bit);
> >         u64 (*peer_db_read)(struct ntb_dev *ntb);
> >         int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
> >         int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
> > @@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev
> > *ntb, u64 db_bits)
> >   * @ntb:       NTB device context.
> >   * @db_addr:   OUT - The address of the peer doorbell register.
> >   * @db_size:   OUT - The number of bytes to write the peer doorbell
> > register.
> > + * @db_data:   OUT - The data of peer doorbell register
> > + * @db_bit:            door bell bit number
> >   *
> >   * Return the address of the peer doorbell register.  This may be used,
> for
> >   * example, by drivers that offload memory copy operations to a dma
> engine.
> > @@ -1091,12 +1094,12 @@ static inline int ntb_db_clear_mask(struct
> > ntb_dev *ntb, u64 db_bits)
> >   */
> >  static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
> >                                    phys_addr_t *db_addr,
> > -                                  resource_size_t *db_size)
> > +                                  resource_size_t *db_size, u64
> > *db_data, int db_bit)
> >  {
> >         if (!ntb->ops->peer_db_addr)
> >                 return -EINVAL;
> >
> > -       return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
> > +       return ntb->ops->peer_db_addr(ntb, db_addr, db_size, db_data,
> > db_bit);
> >  }
> >
> >  /**
> > --
> > 1.9.3
> >
> >
> > On Wed, 23 Jan 2019 at 19:40, Dave Jiang <dave.jiang@intel.com
> > <mailto:dave.jiang@intel.com>> wrote:
> >
> >
> >
> >     On 1/23/19 10:30 AM, Logan Gunthorpe wrote:
> >     >
> >     >
> >     > On 2019-01-23 2:28 a.m., lravich@gmail.com
> >     <mailto:lravich@gmail.com> wrote:
> >     >>         .spad_count             = intel_ntb_spad_count,
> >     >> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >     >> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >     >> index 5ee5f40..af01222 100644
> >     >> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >     >> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >     >> @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct
> >     ntb_dev
> >     >> *ntb)
> >     >>
> >     >>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
> >     >>                                       phys_addr_t *db_addr,
> >     >> -                                     resource_size_t *db_size)
> >     >> +                                     resource_size_t *db_size,
> >     >> +                                     u64 *db_data,
> >     >> +                                     int db_bit)
> >     >>  {
> >     >
> >     >
> >     > The semantics of this interface are not clear because there are no
> >     users
> >     > in the kernel. But doesn't a correct implementation require you to
> set
> >     > db_data here?
> >
> >     Cc Allen
> >
> >     Side comment. The only user of this function I am aware of is the
> out of
> >     tree NTRDMA code.
> >
> >     >
> >     > Logan
> >     >
> >
> >
> >
> > --
> > Leonid Ravich
> >
> > --
> > You received this message because you are subscribed to the Google
> > Groups "linux-ntb" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> > an email to linux-ntb+unsubscribe@googlegroups.com
> > <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> > To post to this group, send email to linux-ntb@googlegroups.com
> > <mailto:linux-ntb@googlegroups.com>.
> > To view this discussion on the web visit
> >
> https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com
> > <
> https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com?utm_medium=email&utm_source=footer
> >.
> > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to a topic in the
> Google Groups "linux-ntb" group.
> To unsubscribe from this topic, visit
> https://groups.google.com/d/topic/linux-ntb/fvSmCCPd7zo/unsubscribe.
> To unsubscribe from this group and all its topics, send an email to
> linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/877b89c1-22bd-36bf-f7e1-ec85a9c63cb1%40intel.com
> .
> For more options, visit https://groups.google.com/d/optout.
>


-- 
Leonid Ravich

--00000000000045d7ca05806c21e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Sorry for styling issues, this =
is my first commit to this community ,=C2=A0 attaching fixed commit after p=
assing scripts/<a href=3D"http://checkpatch.pl">checkpatch.pl</a></div><div=
 dir=3D"ltr"><br></div><div dir=3D"ltr">Thanks, Dave, Logan and Allen<br><d=
iv><br></div><div><div>From aa9fde25f063c8254f59e705caeb102ecf47dd9a Mon Se=
p 17 00:00:00 2001</div><div>From: Leonid Ravich &lt;<a href=3D"mailto:Leon=
id.Ravich@emc.com">Leonid.Ravich@emc.com</a>&gt;</div><div>Date: Tue, 22 Ja=
n 2019 15:20:56 +0200</div><div>Subject: [PATCH] NTB: add new parameter to =
peer_db_addr() db_bit and db_data</div><div><br></div><div>NTB door bell us=
age depends on NTB hardware.</div><div><br></div><div>ex: intel NTB gen1 ha=
s one peer door bell register which can be controlled</div><div>by the bitm=
ap writen to it, while Intel NTB gen3 has a registers</div><div>per door be=
ll and the data trigering the each door bell is always 1.</div><div><br></d=
iv><div>therefore exposing only peer door bell address forcing the user</di=
v><div>to be aware of such low level details</div><div><br></div><div>Cc: A=
llen Hubbe &lt;<a href=3D"mailto:allenbh@gmail.com">allenbh@gmail.com</a>&g=
t;</div><div>Cc: Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltatee.com"=
>logang@deltatee.com</a>&gt;</div><div>Signed-off-by: Leonid Ravich &lt;<a =
href=3D"mailto:Leonid.Ravich@emc.com">Leonid.Ravich@emc.com</a>&gt;</div><d=
iv>---</div><div>=C2=A0drivers/ntb/hw/intel/ntb_hw_gen1.c=C2=A0 =C2=A0 =C2=
=A0| 25 +++++++++++++++++++------</div><div>=C2=A0drivers/ntb/hw/intel/ntb_=
hw_gen1.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++--</div><div>=C2=A0drivers/ntb/hw=
/intel/ntb_hw_gen3.c=C2=A0 =C2=A0 =C2=A0| 33 ++++++++++++++++++++++++++++++=
++-</div><div>=C2=A0drivers/ntb/hw/mscc/ntb_hw_switchtec.c |=C2=A0 9 ++++++=
++-</div><div>=C2=A0include/linux/ntb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +++++++---</div><div>=C2=A05 files =
changed, 69 insertions(+), 13 deletions(-)</div><div><br></div><div>diff --=
git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1=
.c</div><div>index 2ad263f..bb57ec2 100644</div><div>--- a/drivers/ntb/hw/i=
ntel/ntb_hw_gen1.c</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c</div>=
<div>@@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int=
 idx)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ndev-&gt;reg-&gt;mw_bar[=
idx];</div><div>=C2=A0}</div><div>=C2=A0</div><div>-static inline int ndev_=
db_addr(struct intel_ntb_dev *ndev,</div><div>+void ndev_db_addr(struct int=
el_ntb_dev *ndev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr=
_t *db_addr, resource_size_t *db_size,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0phys_addr_t reg_addr, unsigned long reg)</div><div>=C2=A0{</di=
v><div>@@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_=
dev *ndev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *db_size =3D ndev-&gt;reg-&gt;db_size;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&amp;ndev-&gt;ntb.pdev-&gt;dev, =
&quot;Peer db size %llx\n&quot;, *db_size);</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }</div><div>-</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;</div><=
div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0u64 ndev_db_read(struct intel_=
ntb_dev *ndev,</div><div>@@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mas=
k(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ndev-&gt;self_reg-&gt;db_mask);</div><div>=C2=A0}</div><d=
iv>=C2=A0</div><div>-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_a=
ddr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)</div><=
/div><div><div>+static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys=
_addr_t *db_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size, u64=
 *db_data, int db_bit)</div><div>=C2=A0{</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0u64 db_bits;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_ntb_d=
ev *ndev =3D ntb_ndev(ntb);</div><div>=C2=A0</div><div>-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ndev_db_addr(ndev, db_addr, db_size, ndev-&gt;peer_addr,</=
div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_L=
ONG_LONG))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -EINVAL;</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0db_bit=
s =3D BIT_ULL(db_bit);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (unlikely(db_bits &amp; ~ntb_ndev(ntb)-&gt;db_valid_mask))</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</div><d=
iv>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, db_addr, db_s=
ize, ndev-&gt;peer_addr,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;peer_r=
eg-&gt;db_bell);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_d=
ata)</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_=
data =3D db_bits;</div><div>+</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0static i=
nt intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)</div><div>diff -=
-git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen=
1.h</div><div>index ad8ec14..544cf5c 100644</div><div>--- a/drivers/ntb/hw/=
intel/ntb_hw_gen1.h</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h</div=
><div>@@ -147,6 +147,9 @@</div><div>=C2=A0int ndev_init_isr(struct intel_nt=
b_dev *ndev, int msix_min, int msix_max,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msix_shift, int total_shift);</div><div=
>=C2=A0enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);</di=
v><div>+void ndev_db_addr(struct intel_ntb_dev *ndev,</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resource_size_t *db_size,<=
/div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t reg_addr, unsig=
ned long reg);</div><div>=C2=A0u64 ndev_db_read(struct intel_ntb_dev *ndev,=
 void __iomem *mmio);</div><div>=C2=A0int ndev_db_write(struct intel_ntb_de=
v *ndev, u64 db_bits,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void =
__iomem *mmio);</div><div>@@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(stru=
ct ntb_dev *ntb, enum ntb_speed *speed,</div><div>=C2=A0u64 intel_ntb_db_ve=
ctor_mask(struct ntb_dev *ntb, int db_vector);</div><div>=C2=A0int intel_nt=
b_db_set_mask(struct ntb_dev *ntb, u64 db_bits);</div><div>=C2=A0int intel_=
ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);</div><div>-int intel_n=
tb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,</div><div>-=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_siz=
e);</div></div><div><div>=C2=A0int intel_ntb_spad_is_unsafe(struct ntb_dev =
*ntb);</div><div>=C2=A0int intel_ntb_spad_count(struct ntb_dev *ntb);</div>=
<div>=C2=A0u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);</div><div=
>diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb=
_hw_gen3.c</div><div>index b3fa247..f475b56 100644</div><div>--- a/drivers/=
ntb/hw/intel/ntb_hw_gen3.c</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen3=
.c</div><div>@@ -532,6 +532,37 @@ static int intel_ntb3_mw_set_trans(struct=
 ntb_dev *ntb, int pidx, int idx,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>+int intel_ntb3_peer_db=
_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_size,</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data, int db_bit)</div><div>+{</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t db_addr_base;</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);</div><div>+<=
/div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_=
LONG_LONG))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -EINVAL;</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (un=
likely(BIT_ULL(db_bit) &amp; ~ntb_ndev(ntb)-&gt;db_valid_mask))</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</div=
><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, &amp;db_ad=
dr_base, db_size, ndev-&gt;peer_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ndev-&gt;peer_reg-&gt;db_bell);</div><div>+</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (db_addr) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*db_addr =3D db_addr_base + (db_bit * 4);</div><=
div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;nd=
ev-&gt;ntb.pdev-&gt;dev, &quot;Peer db addr %llx db bit %d\n&quot;,</div><d=
iv>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_addr, db_bit);</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (db_data) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*db_data =3D 1;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dev_dbg(&amp;ndev-&gt;ntb.pdev-&gt;dev, &quot;Peer db data=
 %llx db bit %d\n&quot;,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*d=
b_data, db_bit);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><=
div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;</div><div>+}</div><div>+</div></d=
iv><div><div>=C2=A0static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u=
64 db_bits)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct =
intel_ntb_dev *ndev =3D ntb_ndev(ntb);</div><div>@@ -584,7 +615,7 @@ static=
 int intel_ntb3_db_clear(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .db_clear=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D intel_ntb3_db_clear,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 .db_set_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_ntb_db_set=
_mask,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_clear_mask=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D intel_ntb_db_clear_mask,</div><div>-=C2=A0 =C2=A0 =
=C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D inte=
l_ntb_peer_db_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb3_peer_db_addr,</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .peer_db_set=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D intel_ntb3_peer_db_set,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .spad_is_unsafe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_is_=
unsafe,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_count=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_count,</div><div>diff --g=
it a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_sw=
itchtec.c</div><div>index 5ee5f40..9fa1b99 100644</div><div>--- a/drivers/n=
tb/hw/mscc/ntb_hw_switchtec.c</div><div>+++ b/drivers/ntb/hw/mscc/ntb_hw_sw=
itchtec.c</div><div>@@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_=
mask(struct ntb_dev *ntb)</div><div>=C2=A0</div><div>=C2=A0static int switc=
htec_ntb_peer_db_addr(struct ntb_dev *ntb,</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addr_t *db_addr,</div><div>-=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_=
size)</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0resource_size_t *db_size,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db_bit)</div><div>=C2=A0{</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct switchtec_ntb *sndev =3D ntb_sndev(ntb);=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long offset;</div><div>=C2=
=A0</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_=
PER_LONG_LONG))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;</div><div>+</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 of=
fset =3D (unsigned long)sndev-&gt;mmio_peer_dbmsg-&gt;odb -</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long)sndev-&=
gt;stdev-&gt;mmio;</div><div>=C2=A0</div><div>@@ -721,6 +726,8 @@ static in=
t switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_addr =3D pci_resource_start(n=
tb-&gt;pdev, 0) + offset;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (db_size=
)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_siz=
e =3D sizeof(u32);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data)</div>=
<div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D B=
IT_ULL(db_bit) &lt;&lt; sndev-&gt;db_peer_shift;</div><div>=C2=A0</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;</div><div>=C2=A0}</div></div><div><d=
iv>diff --git a/include/linux/ntb.h b/include/linux/ntb.h</div><div>index 1=
81d166..56a92e3 100644</div><div>--- a/include/linux/ntb.h</div><div>+++ b/=
include/linux/ntb.h</div><div>@@ -296,7 +296,8 @@ struct ntb_dev_ops {</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*db_clear_mask)(struct ntb_dev *ntb,=
 u64 db_bits);</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (=
*peer_db_addr)(struct ntb_dev *ntb,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_a=
ddr_t *db_addr, resource_size_t *db_size);</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0phys_addr_t *db_addr, resource_size_t *db_size,</div><div>+=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data, int db_bit);</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 u64 (*peer_db_read)(struct ntb_dev *ntb);</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_clear)(struct ntb_dev *=
ntb, u64 db_bits);</div><div>@@ -1078,6 +1079,8 @@ static inline int ntb_db=
_clear_mask(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0 * @ntb:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0NTB device context.</div><div>=C2=A0 * @db_addr:=C2=
=A0 =C2=A0OUT - The address of the peer doorbell register.</div><div>=C2=A0=
 * @db_size:=C2=A0 =C2=A0OUT - The number of bytes to write the peer doorbe=
ll register.</div><div>+ * @db_data:=C2=A0 =C2=A0OUT - The data of peer doo=
rbell register</div><div>+ * @db_bit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 door bell bit number</div><div>=C2=A0 *</div><div>=C2=A0 * Return the a=
ddress of the peer doorbell register.=C2=A0 This may be used, for</div><div=
>=C2=A0 * example, by drivers that offload memory copy operations to a dma =
engine.</div><div>@@ -1091,12 +1094,13 @@ static inline int ntb_db_clear_ma=
sk(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0 */</div><div>=C2=A0st=
atic inline int ntb_peer_db_addr(struct ntb_dev *ntb,</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr,</div><div>-=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)</di=
v><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_si=
ze,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 *db_data, i=
nt db_bit)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ntb=
-&gt;ops-&gt;peer_db_addr)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -EINVAL;</div><div>=C2=A0</div><div>-=C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, db_addr, db_size);</=
div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(nt=
b, db_addr, db_size, db_data, db_bit);</div><div>=C2=A0}</div><div>=C2=A0</=
div><div>=C2=A0/**</div><div>--=C2=A0</div><div>1.9.3</div></div><div><br><=
/div></div></div></div></div></div></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 24 Jan 2019 at 18:56, Dave=
 Jiang &lt;<a href=3D"mailto:dave.jiang@intel.com">dave.jiang@intel.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 1/24/19 6:51 AM, Leon Ravich wrote:<br>
&gt; added missed functionality to switchtec driver, I hope its OK the way =
I<br>
&gt; sent the fix .<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Leonid=C2=A0<br>
&gt; <br>
&gt; From a04eb9162aa347a885104aaef9dcf2af1884b8c2 Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Leonid Ravich &lt;<a href=3D"mailto:Leonid.Ravich@emc.com" targe=
t=3D"_blank">Leonid.Ravich@emc.com</a> &lt;mailto:<a href=3D"mailto:Leonid.=
Ravich@emc.com" target=3D"_blank">Leonid.Ravich@emc.com</a>&gt;&gt;<br>
&gt; Date: Tue, 22 Jan 2019 15:20:56 +0200<br>
&gt; Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and d=
b_data<br>
&gt; <br>
&gt; NTB door bell usage depends on NTB hardware.<br>
&gt; <br>
&gt; ex: intel NTB gen1 has one peer door bell register which can be contro=
led<br>
&gt; by the bitmap writen to it, while Intel NTB gen3 has a registes<br>
&gt; per door bell and the data trigering the each door bell is always 1.<b=
r>
&gt; <br>
&gt; therefore exposing only peer door bell address forcing the user to be<=
br>
&gt; aware of such<br>
&gt; low level details<br>
&gt; <br>
&gt; <br>
&gt; Signed-off-by: Leonid Ravich &lt;<a href=3D"mailto:Leonid.Ravich@emc.c=
om" target=3D"_blank">Leonid.Ravich@emc.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:Leonid.Ravich@emc.com" target=3D"_blank">=
Leonid.Ravich@emc.com</a>&gt;&gt;<br>
&gt; Cc: Allen Hubbe &lt;<a href=3D"mailto:allenbh@gmail.com" target=3D"_bl=
ank">allenbh@gmail.com</a> &lt;mailto:<a href=3D"mailto:allenbh@gmail.com" =
target=3D"_blank">allenbh@gmail.com</a>&gt;&gt;<br>
&gt; Cc: Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltatee.com" target=
=3D"_blank">logang@deltatee.com</a> &lt;mailto:<a href=3D"mailto:logang@del=
tatee.com" target=3D"_blank">logang@deltatee.com</a>&gt;&gt;<br>
<br>
Just tiny nit below.<br>
Otherwise Acked-by: Dave Jiang &lt;<a href=3D"mailto:dave.jiang@intel.com" =
target=3D"_blank">dave.jiang@intel.com</a>&gt;<br>
<br>
<br>
&gt; <br>
&gt; ---<br>
&gt; =C2=A0drivers/ntb/hw/intel/ntb_hw_gen1.c=C2=A0 =C2=A0 =C2=A0| 25 +++++=
++++++++++++++------<br>
&gt; =C2=A0drivers/ntb/hw/intel/ntb_hw_gen1.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 =
+++--<br>
&gt; =C2=A0drivers/ntb/hw/intel/ntb_hw_gen3.c=C2=A0 =C2=A0 =C2=A0| 30 +++++=
++++++++++++++++++++++++-<br>
&gt; =C2=A0drivers/ntb/hw/mscc/ntb_hw_switchtec.c |=C2=A0 9 ++++++++-<br>
&gt; =C2=A0include/linux/ntb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++---<br>
&gt; =C2=A05 files changed, 65 insertions(+), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c<br>
&gt; b/drivers/ntb/hw/intel/ntb_hw_gen1.c<br>
&gt; index 2ad263f..fcccc7c 100644<br>
&gt; --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c<br>
&gt; +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c<br>
&gt; @@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int=
 idx)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ndev-&gt;reg-&gt;mw_bar[idx];<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -static inline int ndev_db_addr(struct intel_ntb_dev *ndev,<br>
&gt; +void ndev_db_addr(struct intel_ntb_dev *ndev,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resource_siz=
e_t<br>
&gt; *db_size,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t reg_addr, unsigned lon=
g reg)<br>
&gt; =C2=A0{<br>
&gt; @@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_de=
v<br>
&gt; *ndev,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_size =3D n=
dev-&gt;reg-&gt;db_size;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&amp;n=
dev-&gt;ntb.pdev-&gt;dev, &quot;Peer db size %llx\n&quot;,<br>
&gt; *db_size);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0u64 ndev_db_read(struct intel_ntb_dev *ndev,<br>
&gt; @@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *nt=
b,<br>
&gt; u64 db_bits)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;self_reg-&gt;db_m=
ask);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)<br>
&gt; +static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t<br=
>
&gt; *db_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size, u64 *db_data, int<br>
&gt; db_bit)<br>
&gt; =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 db_bits;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_ntb_dev *ndev =3D ntb_ndev(nt=
b);<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ndev_db_addr(ndev, db_addr, db_size=
, ndev-&gt;peer_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_=
LONG))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0db_bits =3D BIT_ULL(db_bit);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bits &amp; ~ntb_ndev(ntb)-=
&gt;db_valid_mask))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, db_addr, db_size, ndev-=
&gt;peer_addr,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;peer_reg-&gt;db_bell);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D d=
b_bits;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
if (db_data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_data =3D db_bits;<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bit=
s)<br>
&gt; diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h<br>
&gt; b/drivers/ntb/hw/intel/ntb_hw_gen1.h<br>
&gt; index ad8ec14..544cf5c 100644<br>
&gt; --- a/drivers/ntb/hw/intel/ntb_hw_gen1.h<br>
&gt; +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h<br>
&gt; @@ -147,6 +147,9 @@<br>
&gt; =C2=A0int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int =
msix_max,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msix_shift=
, int total_shift);<br>
&gt; =C2=A0enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);=
<br>
&gt; +void ndev_db_addr(struct intel_ntb_dev *ndev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resource_si=
ze_t<br>
&gt; *db_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t reg_addr, unsigned lo=
ng reg);<br>
&gt; =C2=A0u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio)=
;<br>
&gt; =C2=A0int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio);<br>
&gt; @@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum=
<br>
&gt; ntb_speed *speed,<br>
&gt; =C2=A0u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)=
;<br>
&gt; =C2=A0int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);<br>
&gt; =C2=A0int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);<b=
r>
&gt; -int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_=
t *db_size);<br>
&gt; =C2=A0int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);<br>
&gt; =C2=A0int intel_ntb_spad_count(struct ntb_dev *ntb);<br>
&gt; =C2=A0u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);<br>
&gt; diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c<br>
&gt; b/drivers/ntb/hw/intel/ntb_hw_gen3.c<br>
&gt; index b3fa247..b642c80 100644<br>
&gt; --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c<br>
&gt; +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c<br>
&gt; @@ -532,6 +532,34 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev=
<br>
&gt; *ntb, int pidx, int idx,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; +int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_size, u64 *db=
_data,<br>
&gt; int db_bit)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t db_addr_base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct intel_ntb_dev *ndev =3D ntb_ndev(nt=
b);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_=
LONG))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(BIT_ULL(db_bit) &amp; ~ntb_nd=
ev(ntb)-&gt;db_valid_mask))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, &amp;db_addr_base, db_s=
ize, ndev-&gt;peer_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ndev-&gt;peer_reg-&gt;db_bell);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_addr =3D d=
b_addr_base + (db_bit * 4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;n=
dev-&gt;ntb.pdev-&gt;dev, &quot;Peer db addr %llx db bit<br>
&gt; %d\n&quot;, *db_addr, db_bit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D 1=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;n=
dev-&gt;ntb.pdev-&gt;dev, &quot;Peer db data %llx db bit<br>
&gt; %d\n&quot;, *db_data, db_bit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; =C2=A0static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bi=
ts)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_ntb_dev *ndev =3D ntb_ndev(nt=
b);<br>
&gt; @@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb=
,<br>
&gt; u64 db_bits)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_clear=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb3_db_clear,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_set_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D intel_ntb_db_set_mask,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_clear_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D intel_ntb_db_clear_mask,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D intel_ntb_peer_db_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D intel_ntb3_peer_db_addr,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .peer_db_set=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D intel_ntb3_peer_db_set,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_is_unsafe=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D intel_ntb_spad_is_unsafe,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_count,<br>
&gt; diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt; b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt; index 5ee5f40..d95fa35 100644<br>
&gt; --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt; +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt; @@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct<br>
&gt; ntb_dev *ntb)<br>
&gt; =C2=A0<br>
&gt; =C2=A0static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addr_t =
*db_addr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_siz=
e_t *db_size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_siz=
e_t *db_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db_bit)<=
br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct switchtec_ntb *sndev =3D ntb_sndev(=
ntb);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long offset;<br>
&gt; =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_=
LONG))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D (unsigned long)sndev-&gt;mmio_p=
eer_dbmsg-&gt;odb -<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long=
)sndev-&gt;stdev-&gt;mmio;<br>
&gt; =C2=A0<br>
&gt; @@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_d=
ev<br>
&gt; *ntb,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_addr =3D p=
ci_resource_start(ntb-&gt;pdev, 0) + offset;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (db_size)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_size =3D s=
izeof(u32);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D B=
IT_ULL(db_bit) &lt;&lt; sndev-&gt;db_peer_shift;<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; =C2=A0}<br>
&gt; diff --git a/include/linux/ntb.h b/include/linux/ntb.h<br>
&gt; index 181d166..5c7c392 100644<br>
&gt; --- a/include/linux/ntb.h<br>
&gt; +++ b/include/linux/ntb.h<br>
&gt; @@ -296,7 +296,8 @@ struct ntb_dev_ops {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*db_clear_mask)(struct ntb_dev *ntb, =
u64 db_bits);<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_addr)(struct ntb_dev *ntb,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resource_size_t *db_size)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resource_size_t<br>
&gt; *db_size, u64 *db_data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db_bit);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 (*peer_db_read)(struct ntb_dev *ntb);<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_set)(struct ntb_dev *ntb, u6=
4 db_bits);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_clear)(struct ntb_dev *ntb, =
u64 db_bits);<br>
&gt; @@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_d=
ev<br>
&gt; *ntb, u64 db_bits)<br>
&gt; =C2=A0 * @ntb:=C2=A0 =C2=A0 =C2=A0 =C2=A0NTB device context.<br>
&gt; =C2=A0 * @db_addr:=C2=A0 =C2=A0OUT - The address of the peer doorbell =
register.<br>
&gt; =C2=A0 * @db_size:=C2=A0 =C2=A0OUT - The number of bytes to write the =
peer doorbell<br>
&gt; register.<br>
&gt; + * @db_data:=C2=A0 =C2=A0OUT - The data of peer doorbell register<br>
&gt; + * @db_bit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 door bell bit nu=
mber<br>
&gt; =C2=A0 *<br>
&gt; =C2=A0 * Return the address of the peer doorbell register.=C2=A0 This =
may be used, for<br>
&gt; =C2=A0 * example, by drivers that offload memory copy operations to a =
dma engine.<br>
&gt; @@ -1091,12 +1094,12 @@ static inline int ntb_db_clear_mask(struct<br>
&gt; ntb_dev *ntb, u64 db_bits)<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0static inline int ntb_peer_db_addr(struct ntb_dev *ntb,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size,=
 u64<br>
&gt; *db_data, int db_bit)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ntb-&gt;ops-&gt;peer_db_addr)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL=
;<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, d=
b_addr, db_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, d=
b_addr, db_size, db_data,<br>
&gt; db_bit);<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0/**<br>
&gt; --=C2=A0<br>
&gt; 1.9.3<br>
&gt; <br>
&gt; <br>
&gt; On Wed, 23 Jan 2019 at 19:40, Dave Jiang &lt;<a href=3D"mailto:dave.ji=
ang@intel.com" target=3D"_blank">dave.jiang@intel.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:dave.jiang@intel.com" target=3D"_blank">d=
ave.jiang@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/23/19 10:30 AM, Logan Gunthorpe wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On 2019-01-23 2:28 a.m., <a href=3D"mailto:lra=
vich@gmail.com" target=3D"_blank">lravich@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:lravich@gmail.com" tar=
get=3D"_blank">lravich@gmail.com</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.spad_cou=
nt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_count,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; diff --git a/drivers/ntb/hw/mscc/ntb_hw_sw=
itchtec.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; index 5ee5f40..af01222 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; @@ -707,7 +707,9 @@ static u64 switchtec_n=
tb_db_read_mask(struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0ntb_dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; *ntb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 static int switchtec_ntb_peer_db_add=
r(struct ntb_dev *ntb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0resource_size_t *db_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0resource_size_t *db_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0u64 *db_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int db_bit)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The semantics of this interface are not clear =
because there are no<br>
&gt;=C2=A0 =C2=A0 =C2=A0users<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; in the kernel. But doesn&#39;t a correct imple=
mentation require you to set<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; db_data here?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Cc Allen<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Side comment. The only user of this function I am a=
ware of is the out of<br>
&gt;=C2=A0 =C2=A0 =C2=A0tree NTRDMA code.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Logan<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Leonid Ravich<br>
&gt; <br>
&gt; -- <br>
&gt; You received this message because you are subscribed to the Google<br>
&gt; Groups &quot;linux-ntb&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
<br>
&gt; an email to <a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com=
" target=3D"_blank">linux-ntb+unsubscribe@googlegroups.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com"=
 target=3D"_blank">linux-ntb+unsubscribe@googlegroups.com</a>&gt;.<br>
&gt; To post to this group, send email to <a href=3D"mailto:linux-ntb@googl=
egroups.com" target=3D"_blank">linux-ntb@googlegroups.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:linux-ntb@googlegroups.com" target=3D"_bl=
ank">linux-ntb@googlegroups.com</a>&gt;.<br>
&gt; To view this discussion on the web visit<br>
&gt; <a href=3D"https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-v=
BVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2=
h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com</a><br>
&gt; &lt;<a href=3D"https://groups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D=
2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ%40mail.gmail.com?utm_medium=3Dem=
ail&amp;utm_source=3Dfooter" rel=3D"noreferrer" target=3D"_blank">https://g=
roups.google.com/d/msgid/linux-ntb/CAPWoNkL%3D2h-vBVBHG1J0pB_W2KpO0FHTqj3h0=
7UhHXidjADSPQ%40mail.gmail.com?utm_medium=3Demail&amp;utm_source=3Dfooter</=
a>&gt;.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/optout</a=
>.<br>
<br>
-- <br>
You received this message because you are subscribed to a topic in the Goog=
le Groups &quot;linux-ntb&quot; group.<br>
To unsubscribe from this topic, visit <a href=3D"https://groups.google.com/=
d/topic/linux-ntb/fvSmCCPd7zo/unsubscribe" rel=3D"noreferrer" target=3D"_bl=
ank">https://groups.google.com/d/topic/linux-ntb/fvSmCCPd7zo/unsubscribe</a=
>.<br>
To unsubscribe from this group and all its topics, send an email to <a href=
=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com" target=3D"_blank">linu=
x-ntb+unsubscribe@googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com" target=3D"_blank">linux-ntb@googlegroups.com</a>.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/877b89c1-22bd-36bf-f7e1-ec85a9c63cb1%40intel.com" rel=
=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/msgid/linux-n=
tb/877b89c1-22bd-36bf-f7e1-ec85a9c63cb1%40intel.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" rel=
=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/optout</a>.<b=
r>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Leonid Ravich<br></div></div>

--00000000000045d7ca05806c21e6--
