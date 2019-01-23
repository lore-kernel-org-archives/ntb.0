Date: Wed, 23 Jan 2019 01:28:21 -0800 (PST)
From: lravich@gmail.com
Message-Id: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
Subject: [PATCH] Missing functionality of  ntb_peer_db_addr() API
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3001_1493087038.1548235701049"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_3001_1493087038.1548235701049
Content-Type: multipart/alternative; 
	boundary="----=_Part_3002_1742364161.1548235701049"

------=_Part_3002_1742364161.1548235701049
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

NTB door bell usage depends on NTB hardware.

ex: intel NTB gen1 has one peer door bell register which can be controled
by the bitmap writen to it, while Intel NTB gen3 has a registes
per door bell and the data trigering the each door bell is always 1.

therefore exposing only peer door bell address forcing the user to be aware 
of such
low level details

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 30 +++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  4 +++-
 include/linux/ntb.h                    |  9 ++++++---
 5 files changed, 60 insertions(+), 13 deletions(-)

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
index 5ee5f40..af01222 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev 
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



------=_Part_3002_1742364161.1548235701049
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>NTB door bell usage depends on NTB hardware.</div><di=
v><br></div><div>ex: intel NTB gen1 has one peer door bell register which c=
an be controled</div><div>by the bitmap writen to it, while Intel NTB gen3 =
has a registes</div><div>per door bell and the data trigering the each door=
 bell is always 1.</div><div><br></div><div>therefore exposing only peer do=
or bell address forcing the user to be aware of such</div><div>low level de=
tails</div><div><br></div><div>Signed-off-by: Leonid Ravich &lt;Leonid.Ravi=
ch@emc.com&gt;</div><div>---</div><div>=C2=A0drivers/ntb/hw/intel/ntb_hw_ge=
n1.c=C2=A0 =C2=A0 =C2=A0| 25 +++++++++++++++++++------</div><div>=C2=A0driv=
ers/ntb/hw/intel/ntb_hw_gen1.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++--</div><div=
>=C2=A0drivers/ntb/hw/intel/ntb_hw_gen3.c=C2=A0 =C2=A0 =C2=A0| 30 +++++++++=
++++++++++++++++++++-</div><div>=C2=A0drivers/ntb/hw/mscc/ntb_hw_switchtec.=
c |=C2=A0 4 +++-</div><div>=C2=A0include/linux/ntb.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++---</div><=
div>=C2=A05 files changed, 60 insertions(+), 13 deletions(-)</div><div><br>=
</div><div>diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw=
/intel/ntb_hw_gen1.c</div><div>index 2ad263f..fcccc7c 100644</div><div>--- =
a/drivers/ntb/hw/intel/ntb_hw_gen1.c</div><div>+++ b/drivers/ntb/hw/intel/n=
tb_hw_gen1.c</div><div>@@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_=
ntb_dev *ndev, int idx)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ndev-&=
gt;reg-&gt;mw_bar[idx];</div><div>=C2=A0}</div><div>=C2=A0</div><div>-stati=
c inline int ndev_db_addr(struct intel_ntb_dev *ndev,</div><div>+void ndev_=
db_addr(struct intel_ntb_dev *ndev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0phys_addr_t *db_addr, resource_size_t *db_size,</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t reg_addr, unsigned long reg)</di=
v><div>=C2=A0{</div><div>@@ -196,8 +196,6 @@ static inline int ndev_db_addr=
(struct intel_ntb_dev *ndev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *db_size =3D ndev-&gt;reg-&gt;db_size;</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&amp;ndev-&gt;=
ntb.pdev-&gt;dev, &quot;Peer db size %llx\n&quot;, *db_size);</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>-</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0u64 ndev_db=
_read(struct intel_ntb_dev *ndev,</div><div>@@ -1111,13 +1109,28 @@ int int=
el_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;self_reg-&gt;db_mask);</div><di=
v>=C2=A0}</div><div>=C2=A0</div><div>-int intel_ntb_peer_db_addr(struct ntb=
_dev *ntb, phys_addr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t=
 *db_size)</div><div><div>+static int intel_ntb_peer_db_addr(struct ntb_dev=
 *ntb, phys_addr_t *db_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size_t *db=
_size, u64 *db_data, int db_bit)</div><div>=C2=A0{</div><div>+=C2=A0 =C2=A0=
 =C2=A0 =C2=A0u64 db_bits;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct int=
el_ntb_dev *ndev =3D ntb_ndev(ntb);</div><div>=C2=A0</div><div>-=C2=A0 =C2=
=A0 =C2=A0 =C2=A0return ndev_db_addr(ndev, db_addr, db_size, ndev-&gt;peer_=
addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BIT=
S_PER_LONG_LONG))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</div><div>+</div><div=
>+=C2=A0 =C2=A0 =C2=A0 =C2=A0db_bits =3D BIT_ULL(db_bit);</div><div>+</div>=
<div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bits &amp; ~ntb_ndev(ntb)-=
&gt;db_valid_mask))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ndev_db_addr(ndev, db_addr, db_size, ndev-&gt;peer_addr,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ndev-&gt;peer_reg-&gt;db_bell);</div><div>+</div><=
div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data) {</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D db_bits;</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0;</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=A0static int =
intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)</div><div>diff --gi=
t a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen1.h=
</div><div>index ad8ec14..544cf5c 100644</div><div>--- a/drivers/ntb/hw/int=
el/ntb_hw_gen1.h</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h</div><d=
iv>@@ -147,6 +147,9 @@</div><div>=C2=A0int ndev_init_isr(struct intel_ntb_d=
ev *ndev, int msix_min, int msix_max,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int msix_shift, int total_shift);</div><div>=
=C2=A0enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);</div=
><div>+void ndev_db_addr(struct intel_ntb_dev *ndev,</div><div>+=C2=A0 =C2=
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
e);</div><div>=C2=A0int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);</div=
><div>=C2=A0int intel_ntb_spad_count(struct ntb_dev *ntb);</div><div>=C2=A0=
u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);</div><div>diff --git=
 a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c<=
/div><div>index b3fa247..b642c80 100644</div><div>--- a/drivers/ntb/hw/inte=
l/ntb_hw_gen3.c</div><div>+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c</div><di=
v>@@ -532,6 +532,34 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *n=
tb, int pidx, int idx,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;</div=
><div>=C2=A0}</div><div>=C2=A0+int intel_ntb3_peer_db_addr(struct ntb_dev *=
ntb, phys_addr_t *db_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0resource_size_t *db_size, u64 *db_data, int db_bit)</div><div>+{</div><d=
iv>+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t db_addr_base;</div><div>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);</div><div=
>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(db_bit &gt;=3D BITS_P=
ER_LONG_LONG))</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return -EINVAL;</div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(unlikely(BIT_ULL(db_bit) &amp; ~ntb_ndev(ntb)-&gt;db_valid_mask))</div><di=
v>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;</=
div><div>+</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ndev_db_addr(ndev, &amp;db=
_addr_base, db_size, ndev-&gt;peer_addr,</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ndev-&gt;peer_reg-&gt;db_bell);</div><div>+</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (db_addr) {</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_addr =3D db_addr_base + (db_bit * 4);</d=
iv><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&am=
p;ndev-&gt;ntb.pdev-&gt;dev, &quot;Peer db addr %llx db bit %d\n&quot;, *db=
_addr, db_bit);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><d=
iv>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db_data) {</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*db_data =3D 1;</div><div>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;ndev-&gt;ntb.pdev=
-&gt;dev, &quot;Peer db data %llx db bit %d\n&quot;, *db_data, db_bit);</di=
v><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>+</div><div>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 0;</div><div>+}</div><div>+</div><div>=C2=A0static int =
intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0{<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct intel_ntb_dev *ndev =3D ntb_nd=
ev(ntb);</div><div>@@ -584,7 +612,7 @@ static int intel_ntb3_db_clear(struc=
t ntb_dev *ntb, u64 db_bits)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_clea=
r=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb3_db_c=
lear,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .db_set_mask=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_ntb_db_set_mask,</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .db_clear_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_n=
tb_db_clear_mask,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D intel_ntb_peer_db_addr,</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0.peer_db_addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D intel_ntb3_peer_db_addr,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .p=
eer_db_set=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D intel_ntb3_peer_db_=
set,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_is_unsafe=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D intel_ntb_spad_is_unsafe,</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .spad_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
ntel_ntb_spad_count,</div><div>diff --git a/drivers/ntb/hw/mscc/ntb_hw_swit=
chtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><div>index 5ee5f40..a=
f01222 100644</div><div>--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><=
div>+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c</div><div>@@ -707,7 +707,9=
 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev *ntb)</div><div>=
=C2=A0</div><div>=C2=A0static int switchtec_ntb_peer_db_addr(struct ntb_dev=
 *ntb,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 phys_addr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0resource_size_t *db_size)</div><div>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size_t *db_size,</div><di=
v>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 *db_data,=
</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int db=
_bit)</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct switch=
tec_ntb *sndev =3D ntb_sndev(ntb);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 un=
signed long offset;</div><div>diff --git a/include/linux/ntb.h b/include/li=
nux/ntb.h</div><div>index 181d166..5c7c392 100644</div><div>--- a/include/l=
inux/ntb.h</div><div>+++ b/include/linux/ntb.h</div></div><div><br></div><d=
iv><div>@@ -296,7 +296,8 @@ struct ntb_dev_ops {</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);</div>=
<div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_addr)(struc=
t ntb_dev *ntb,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_addr, reso=
urce_size_t *db_size);</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t *db_add=
r, resource_size_t *db_size, u64 *db_data,</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int db_bit);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 (*peer_db_read)(s=
truct ntb_dev *ntb);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*peer_db_se=
t)(struct ntb_dev *ntb, u64 db_bits);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);</div><div>@@ -1078=
,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 =
db_bits)</div><div>=C2=A0 * @ntb:=C2=A0 =C2=A0 =C2=A0 =C2=A0NTB device cont=
ext.</div><div>=C2=A0 * @db_addr:=C2=A0 =C2=A0OUT - The address of the peer=
 doorbell register.</div><div>=C2=A0 * @db_size:=C2=A0 =C2=A0OUT - The numb=
er of bytes to write the peer doorbell register.</div><div>+ * @db_data:=C2=
=A0 =C2=A0OUT - The data of peer doorbell register</div><div>+ * @db_bit:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 door bell bit number</div><div>=
=C2=A0 *</div><div>=C2=A0 * Return the address of the peer doorbell registe=
r.=C2=A0 This may be used, for</div><div>=C2=A0 * example, by drivers that =
offload memory copy operations to a dma engine.</div><div>@@ -1091,12 +1094=
,12 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits=
)</div><div>=C2=A0 */</div><div>=C2=A0static inline int ntb_peer_db_addr(st=
ruct ntb_dev *ntb,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0phys_addr_t *db_addr,</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 resource_size_t *db_size)</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 resource_size_t *db_size, u64 *db_data, int db_bit)</div>=
<div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ntb-&gt;ops-&gt;pee=
r_db_addr)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -EINVAL;</div><div>=C2=A0</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0=
return ntb-&gt;ops-&gt;peer_db_addr(ntb, db_addr, db_size);</div><div>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0return ntb-&gt;ops-&gt;peer_db_addr(ntb, db_addr, d=
b_size, db_data, db_bit);</div><div>=C2=A0}</div><div>=C2=A0</div><div>=C2=
=A0/**</div></div><div><br></div><div><br></div></div>
------=_Part_3002_1742364161.1548235701049--

------=_Part_3001_1493087038.1548235701049--
