Return-Path: <lravich@gmail.com>
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com. [2607:f8b0:4864:20::d2c])
        by gmr-mx.google.com with ESMTPS id h27si883230ywk.1.2019.01.24.05.51.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 05:51:35 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id t24so4800153ioi.0
        for <linux-ntb@googlegroups.com>; Thu, 24 Jan 2019 05:51:35 -0800 (PST)
MIME-Version: 1.0
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com> <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
In-Reply-To: <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
From: Leon Ravich <lravich@gmail.com>
Date: Thu, 24 Jan 2019 15:51:18 +0200
Message-ID: <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com>
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
Content-Type: multipart/alternative; boundary="0000000000003b9c3e0580348233"
To: Dave Jiang <dave.jiang@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>, "Hubbe, Allen" <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

--0000000000003b9c3e0580348233
Content-Type: text/plain; charset="UTF-8"

added missed functionality to switchtec driver, I hope its OK the way I
sent the fix .

Thanks,
Leonid

From a04eb9162aa347a885104aaef9dcf2af1884b8c2 Mon Sep 17 00:00:00 2001
From: Leonid Ravich <Leonid.Ravich@emc.com>
Date: Tue, 22 Jan 2019 15:20:56 +0200
Subject: [PATCH] NTB: add new parameter to peer_db_addr() db_bit and db_data

NTB door bell usage depends on NTB hardware.

ex: intel NTB gen1 has one peer door bell register which can be controled
by the bitmap writen to it, while Intel NTB gen3 has a registes
per door bell and the data trigering the each door bell is always 1.

therefore exposing only peer door bell address forcing the user to be aware
of such
low level details


Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>

---
 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 30 +++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
 include/linux/ntb.h                    |  9 ++++++---
 5 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c
b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f..fcccc7c 100644
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
+                       return -EINVAL;
+
+       db_bits = BIT_ULL(db_bit);
+
+       if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
+               return -EINVAL;
+
+       ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
                            ndev->peer_reg->db_bell);
+
+       if (db_data) {
+               *db_data = db_bits;
+       }
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
index b3fa247..b642c80 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -532,6 +532,34 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
*ntb, int pidx, int idx,
        return 0;
 }

+int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+                               resource_size_t *db_size, u64 *db_data, int
db_bit)
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
%d\n", *db_addr, db_bit);
+       }
+
+       if (db_data) {
+               *db_data = 1;
+               dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit
%d\n", *db_data, db_bit);
+       }
+
+       return 0;
+}
+
 static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
        struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb, u64
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
index 5ee5f40..d95fa35 100644
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
+                       return -EINVAL;
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
index 181d166..5c7c392 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -296,7 +296,8 @@ struct ntb_dev_ops {
        int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);

        int (*peer_db_addr)(struct ntb_dev *ntb,
-                           phys_addr_t *db_addr, resource_size_t *db_size);
+                           phys_addr_t *db_addr, resource_size_t *db_size,
u64 *db_data,
+                           int db_bit);
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
@@ -1091,12 +1094,12 @@ static inline int ntb_db_clear_mask(struct ntb_dev
*ntb, u64 db_bits)
  */
 static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
                                   phys_addr_t *db_addr,
-                                  resource_size_t *db_size)
+                                  resource_size_t *db_size, u64 *db_data,
int db_bit)
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


On Wed, 23 Jan 2019 at 19:40, Dave Jiang <dave.jiang@intel.com> wrote:

>
>
> On 1/23/19 10:30 AM, Logan Gunthorpe wrote:
> >
> >
> > On 2019-01-23 2:28 a.m., lravich@gmail.com wrote:
> >>         .spad_count             = intel_ntb_spad_count,
> >> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >> index 5ee5f40..af01222 100644
> >> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> >> @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct
> ntb_dev
> >> *ntb)
> >>
> >>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
> >>                                       phys_addr_t *db_addr,
> >> -                                     resource_size_t *db_size)
> >> +                                     resource_size_t *db_size,
> >> +                                     u64 *db_data,
> >> +                                     int db_bit)
> >>  {
> >
> >
> > The semantics of this interface are not clear because there are no users
> > in the kernel. But doesn't a correct implementation require you to set
> > db_data here?
>
> Cc Allen
>
> Side comment. The only user of this function I am aware of is the out of
> tree NTRDMA code.
>
> >
> > Logan
> >
>


-- 
Leonid Ravich

--0000000000003b9c3e0580348233
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div>added missed functionality to switchtec dri=
ver, I hope its OK the way I sent the fix .</div><div><br></div><div>Thanks=
,</div><div>Leonid=C2=A0</div><div><br></div><div>From a04eb9162aa347a88510=
4aaef9dcf2af1884b8c2 Mon Sep 17 00:00:00 2001</div><div>From: Leonid Ravich=
 &lt;<a href=3D"mailto:Leonid.Ravich@emc.com">Leonid.Ravich@emc.com</a>&gt;=
</div><div>Date: Tue, 22 Jan 2019 15:20:56 +0200</div><div>Subject: [PATCH]=
 NTB: add new parameter to peer_db_addr() db_bit and db_data</div><div><br>=
</div><div>NTB door bell usage depends on NTB hardware.</div><div><br></div=
><div>ex: intel NTB gen1 has one peer door bell register which can be contr=
oled</div><div>by the bitmap writen to it, while Intel NTB gen3 has a regis=
tes</div><div>per door bell and the data trigering the each door bell is al=
ways 1.</div><div><br></div><div>therefore exposing only peer door bell add=
ress forcing the user to be aware of such</div><div>low level details</div>=
<div><br></div><div><br></div><div>Signed-off-by: Leonid Ravich &lt;<a href=
=3D"mailto:Leonid.Ravich@emc.com">Leonid.Ravich@emc.com</a>&gt;</div><div>C=
c: Allen Hubbe &lt;<a href=3D"mailto:allenbh@gmail.com">allenbh@gmail.com</=
a>&gt;</div><div>Cc: Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltatee.=
com">logang@deltatee.com</a>&gt;</div><div><br></div><div>---</div><div>=C2=
=A0drivers/ntb/hw/intel/ntb_hw_gen1.c=C2=A0 =C2=A0 =C2=A0| 25 +++++++++++++=
++++++------</div><div>=C2=A0drivers/ntb/hw/intel/ntb_hw_gen1.h=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 5 +++--</div><div>=C2=A0drivers/ntb/hw/intel/ntb_hw_gen3.=
c=C2=A0 =C2=A0 =C2=A0| 30 +++++++++++++++++++++++++++++-</div><div>=C2=A0dr=
ivers/ntb/hw/mscc/ntb_hw_switchtec.c |=C2=A0 9 ++++++++-</div><div>=C2=A0in=
clude/linux/ntb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 9 ++++++---</div><div>=C2=A05 files changed, 65 inser=
tions(+), 13 deletions(-)</div><div><br></div><div>diff --git a/drivers/ntb=
/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c</div><div>inde=
x 2ad263f..fcccc7c 100644</div><div>--- a/drivers/ntb/hw/intel/ntb_hw_gen1.=
c</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c</div><div>@@ -180,7 +1=
80,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ndev-&gt;reg-&gt;mw_bar[idx];</div><div>=
=C2=A0}</div><div>=C2=A0</div><div>-static inline int ndev_db_addr(struct i=
ntel_ntb_dev *ndev,</div><div>+void ndev_db_addr(struct intel_ntb_dev *ndev=
,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, resou=
rce_size_t *db_size,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_a=
ddr_t reg_addr, unsigned long reg)</div><div>=C2=A0{</div><div>@@ -196,8 +1=
96,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_size =3D ndev=
-&gt;reg-&gt;db_size;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dev_dbg(&amp;ndev-&gt;ntb.pdev-&gt;dev, &quot;Peer db size %l=
lx\n&quot;, *db_size);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>-<=
/div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;</div><div>=C2=A0}</div><div=
>=C2=A0</div><div>=C2=A0u64 ndev_db_read(struct intel_ntb_dev *ndev,</div><=
div>@@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb=
, u64 db_bits)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-=
&gt;self_reg-&gt;db_mask);</div><div>=C2=A0}</div><div>=C2=A0</div><div>-in=
t intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,</div><d=
iv>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)</div><div><div>+static int i=
ntel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,</div><div>=
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 resource_size_t *db_size, u64 *db_data, int db_bit)</div>=
<div>=C2=A0{</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 db_bits;</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);</=
div><div>=C2=A0</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ndev_db_addr(n=
dev, db_addr, db_size, ndev-&gt;peer_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_LONG))</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -EINVAL;</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0db_bit=
s =3D BIT_ULL(db_bit);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (unlikely(db_bits &amp; ~ntb_ndev(ntb)-&gt;db_valid_mask))</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</div><d=
iv>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, db_addr, db_s=
ize, ndev-&gt;peer_addr,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;peer_r=
eg-&gt;db_bell);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_d=
ata) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*d=
b_data =3D db_bits;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</di=
v><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;</div><div>=C2=A0}</div><div>=
=C2=A0</div><div>=C2=A0static int intel_ntb_peer_db_set(struct ntb_dev *ntb=
, u64 db_bits)</div><div>diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/=
drivers/ntb/hw/intel/ntb_hw_gen1.h</div><div>index ad8ec14..544cf5c 100644<=
/div><div>--- a/drivers/ntb/hw/intel/ntb_hw_gen1.h</div><div>+++ b/drivers/=
ntb/hw/intel/ntb_hw_gen1.h</div><div>@@ -147,6 +147,9 @@</div><div>=C2=A0in=
t ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int msix_max,</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msix_shi=
ft, int total_shift);</div><div>=C2=A0enum ntb_topo xeon_ppd_topo(struct in=
tel_ntb_dev *ndev, u8 ppd);</div><div>+void ndev_db_addr(struct intel_ntb_d=
ev *ndev,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_=
addr, resource_size_t *db_size,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0phys_addr_t reg_addr, unsigned long reg);</div><div>=C2=A0u64 ndev_db=
_read(struct intel_ntb_dev *ndev, void __iomem *mmio);</div><div>=C2=A0int =
ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio);</div><div>@@ -166,8 +169,6=
 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum ntb_speed *speed,</d=
iv><div>=C2=A0u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vect=
or);</div><div>=C2=A0int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_=
bits);</div><div>=C2=A0int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64=
 db_bits);</div><div>-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_=
addr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0resource_size_t *db_size);</div><div>=C2=A0int intel_ntb_spad_is_=
unsafe(struct ntb_dev *ntb);</div><div>=C2=A0int intel_ntb_spad_count(struc=
t ntb_dev *ntb);</div><div>=C2=A0u32 intel_ntb_spad_read(struct ntb_dev *nt=
b, int idx);</div><div>diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/dr=
ivers/ntb/hw/intel/ntb_hw_gen3.c</div><div>index b3fa247..b642c80 100644</d=
iv><div>--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c</div><div>+++ b/drivers/nt=
b/hw/intel/ntb_hw_gen3.c</div><div>@@ -532,6 +532,34 @@ static int intel_nt=
b3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,</div></div><div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;</div><div>=C2=A0}</div><div>=C2=A0<=
/div><div>+int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db=
_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_=
size, u64 *db_data, int db_bit)</div><div>+{</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0phys_addr_t db_addr_base;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct intel_ntb_dev *ndev =3D ntb_ndev(ntb);</div><div>+</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_LONG))</div><=
div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;=
</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(BIT_ULL(db_=
bit) &amp; ~ntb_ndev(ntb)-&gt;db_valid_mask))</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</div><div>+</div><div=
>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, &amp;db_addr_base, db_size,=
 ndev-&gt;peer_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ndev-&=
gt;peer_reg-&gt;db_bell);</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (db_addr) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*db_addr =3D db_addr_base + (db_bit * 4);</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;ndev-&gt;ntb.pdev=
-&gt;dev, &quot;Peer db addr %llx db bit %d\n&quot;, *db_addr, db_bit);</di=
v><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (db_data) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*db_data =3D 1;</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;ndev-&gt;ntb.pdev-&gt;dev, &quot;Pe=
er db data %llx db bit %d\n&quot;, *db_data, db_bit);</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 0;</div><div>+}</div><div>+</div><div>=C2=A0static int intel_ntb3_peer_db_=
set(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0{</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);</div><di=
v>@@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb, u=
64 db_bits)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_clear=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb3_db_clear,</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_set_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D intel_ntb_db_set_mask,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .d=
b_clear_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_ntb_db_clear_mask,=
</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D intel_ntb_peer_db_addr,</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D inte=
l_ntb3_peer_db_addr,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .peer_db_set=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_ntb3_peer_db_set,</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_is_unsafe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D intel_ntb_spad_is_unsafe,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
spad_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_spa=
d_count,</div><div>diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/dr=
ivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><div>index 5ee5f40..d95fa35 10064=
4</div><div>--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><div>+++ b/dr=
ivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><div>@@ -707,11 +707,16 @@ static=
 u64 switchtec_ntb_db_read_mask(struct ntb_dev *ntb)</div><div>=C2=A0</div>=
<div>=C2=A0static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addr_t =
*db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0resource_size_t *db_size)</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_size,</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data,</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db_bit)</div=
></div><div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct switc=
htec_ntb *sndev =3D ntb_sndev(ntb);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
nsigned long offset;</div><div>=C2=A0</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (unlikely(db_bit &gt;=3D BITS_PER_LONG_LONG))</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn -EINVAL;</div><div>+</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D =
(unsigned long)sndev-&gt;mmio_peer_dbmsg-&gt;odb -</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned long)sndev-&gt;stdev-&g=
t;mmio;</div><div>=C2=A0</div><div>@@ -721,6 +726,8 @@ static int switchtec=
_ntb_peer_db_addr(struct ntb_dev *ntb,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_addr =3D pci_resource_start(ntb-&gt;pde=
v, 0) + offset;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (db_size)</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *db_size =3D size=
of(u32);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data)</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D BIT_ULL(db=
_bit) &lt;&lt; sndev-&gt;db_peer_shift;</div><div>=C2=A0</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return 0;</div><div>=C2=A0}</div><div>diff --git a/inc=
lude/linux/ntb.h b/include/linux/ntb.h</div><div>index 181d166..5c7c392 100=
644</div><div>--- a/include/linux/ntb.h</div><div>+++ b/include/linux/ntb.h=
</div><div>@@ -296,7 +296,8 @@ struct ntb_dev_ops {</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);</div=
><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_addr)(stru=
ct ntb_dev *ntb,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, r=
esource_size_t *db_size);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_=
addr, resource_size_t *db_size, u64 *db_data,</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int db_bit);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 (*peer_db_read=
)(struct ntb_dev *ntb);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db=
_set)(struct ntb_dev *ntb, u64 db_bits);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);</div><div>@@ -1=
078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u=
64 db_bits)</div><div>=C2=A0 * @ntb:=C2=A0 =C2=A0 =C2=A0 =C2=A0NTB device c=
ontext.</div><div>=C2=A0 * @db_addr:=C2=A0 =C2=A0OUT - The address of the p=
eer doorbell register.</div><div>=C2=A0 * @db_size:=C2=A0 =C2=A0OUT - The n=
umber of bytes to write the peer doorbell register.</div><div>+ * @db_data:=
=C2=A0 =C2=A0OUT - The data of peer doorbell register</div><div>+ * @db_bit=
:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 door bell bit number</div><div>=
=C2=A0 *</div><div>=C2=A0 * Return the address of the peer doorbell registe=
r.=C2=A0 This may be used, for</div><div>=C2=A0 * example, by drivers that =
offload memory copy operations to a dma engine.</div><div>@@ -1091,12 +1094=
,12 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits=
)</div><div>=C2=A0 */</div></div><div><div>=C2=A0static inline int ntb_peer=
_db_addr(struct ntb_dev *ntb,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0phys_addr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size)</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db_size, u64 *db_data, int db_=
bit)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ntb-&gt;o=
ps-&gt;peer_db_addr)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -EINVAL;</div><div>=C2=A0</div><div>-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, db_addr, db_size);</div>=
<div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, d=
b_addr, db_size, db_data, db_bit);</div><div>=C2=A0}</div><div>=C2=A0</div>=
<div>=C2=A0/**</div><div>--=C2=A0</div><div>1.9.3</div></div><div><br></div=
></div></div></div></div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, 23 Jan 2019 at 19:40, Dave Jiang &lt=
;<a href=3D"mailto:dave.jiang@intel.com">dave.jiang@intel.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 1/23/19 10:30 AM, Logan Gunthorpe wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2019-01-23 2:28 a.m., <a href=3D"mailto:lravich@gmail.com" target=
=3D"_blank">lravich@gmail.com</a> wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.spad_count=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_count,<br>
&gt;&gt; diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c <br>
&gt;&gt; b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt;&gt; index 5ee5f40..af01222 100644<br>
&gt;&gt; --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt;&gt; +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c<br>
&gt;&gt; @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct n=
tb_dev <br>
&gt;&gt; *ntb)<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ph=
ys_addr_t *db_addr,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resour=
ce_size_t *db_size)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resour=
ce_size_t *db_size,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 *d=
b_data,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db=
_bit)<br>
&gt;&gt;=C2=A0 {<br>
&gt; <br>
&gt; <br>
&gt; The semantics of this interface are not clear because there are no use=
rs<br>
&gt; in the kernel. But doesn&#39;t a correct implementation require you to=
 set<br>
&gt; db_data here?<br>
<br>
Cc Allen<br>
<br>
Side comment. The only user of this function I am aware of is the out of<br=
>
tree NTRDMA code.<br>
<br>
&gt; <br>
&gt; Logan<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Leonid Ravich<br></div></div>

--0000000000003b9c3e0580348233--
