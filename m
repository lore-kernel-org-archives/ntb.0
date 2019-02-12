Return-Path: <lravich@gmail.com>
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com. [2a00:1450:4864:20::435])
        by gmr-mx.google.com with ESMTPS id j12si72822wmh.2.2019.02.12.12.09.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:09:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v13so4159576wrw.5
        for <linux-ntb@googlegroups.com>; Tue, 12 Feb 2019 12:09:32 -0800 (PST)
Return-Path: <lravich@gmail.com>
Received: from leonid-Inspiron-3421 ([77.127.56.144])
        by smtp.gmail.com with ESMTPSA id u17sm11909279wrg.71.2019.02.12.12.09.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:09:30 -0800 (PST)
From: Leonid Ravich <lravich@gmail.com>
Date: Tue, 12 Feb 2019 22:09:28 +0200
Subject: [PATCH v2] NTB: add new parameter to peer_db_addr() db_bit and
 db_data
Message-ID: <20190212200928.GA8891@leonid-Inspiron-3421>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hey 
resending this with fixed patch format

--

NTB door bell usage depends on NTB hardware.

ex: intel NTB gen1 has one peer door bell register which can be controlled
by the bitmap writen to it, while Intel NTB gen3 has a registers
per door bell and the data trigering the each door bell is always 1.

therefore exposing only peer door bell address forcing the user
to be aware of such low level details

Acked-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 33 ++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  9 ++++++++-
 include/linux/ntb.h                    | 10 +++++++---
 5 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f..bb57ec2 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -180,7 +180,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
 	return ndev->reg->mw_bar[idx];
 }
 
-static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
+void ndev_db_addr(struct intel_ntb_dev *ndev,
 			       phys_addr_t *db_addr, resource_size_t *db_size,
 			       phys_addr_t reg_addr, unsigned long reg)
 {
@@ -196,8 +196,6 @@ static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
 		*db_size = ndev->reg->db_size;
 		dev_dbg(&ndev->ntb.pdev->dev, "Peer db size %llx\n", *db_size);
 	}
-
-	return 0;
 }
 
 u64 ndev_db_read(struct intel_ntb_dev *ndev,
@@ -1111,13 +1109,28 @@ int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
 				  ndev->self_reg->db_mask);
 }
 
-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-			   resource_size_t *db_size)
+static int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+			   resource_size_t *db_size, u64 *db_data, int db_bit)
 {
+	u64 db_bits;
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
+	if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+		return -EINVAL;
+
+	db_bits = BIT_ULL(db_bit);
+
+	if (unlikely(db_bits & ~ntb_ndev(ntb)->db_valid_mask))
+		return -EINVAL;
+
+	ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
 			    ndev->peer_reg->db_bell);
+
+	if (db_data)
+		*db_data = db_bits;
+
+
+	return 0;
 }
 
 static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen1.h
index ad8ec14..544cf5c 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
@@ -147,6 +147,9 @@
 int ndev_init_isr(struct intel_ntb_dev *ndev, int msix_min, int msix_max,
 		int msix_shift, int total_shift);
 enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
+void ndev_db_addr(struct intel_ntb_dev *ndev,
+				phys_addr_t *db_addr, resource_size_t *db_size,
+				phys_addr_t reg_addr, unsigned long reg);
 u64 ndev_db_read(struct intel_ntb_dev *ndev, void __iomem *mmio);
 int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
 				void __iomem *mmio);
@@ -166,8 +169,6 @@ u64 intel_ntb_link_is_up(struct ntb_dev *ntb, enum ntb_speed *speed,
 u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector);
 int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
 int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
-int intel_ntb_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-		resource_size_t *db_size);
 int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb);
 int intel_ntb_spad_count(struct ntb_dev *ntb);
 u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index b3fa247..f475b56 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -532,6 +532,37 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	return 0;
 }
 
+int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+				resource_size_t *db_size,
+				u64 *db_data, int db_bit)
+{
+	phys_addr_t db_addr_base;
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+
+	if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+		return -EINVAL;
+
+	if (unlikely(BIT_ULL(db_bit) & ~ntb_ndev(ntb)->db_valid_mask))
+		return -EINVAL;
+
+	ndev_db_addr(ndev, &db_addr_base, db_size, ndev->peer_addr,
+				ndev->peer_reg->db_bell);
+
+	if (db_addr) {
+		*db_addr = db_addr_base + (db_bit * 4);
+		dev_dbg(&ndev->ntb.pdev->dev, "Peer db addr %llx db bit %d\n",
+				*db_addr, db_bit);
+	}
+
+	if (db_data) {
+		*db_data = 1;
+		dev_dbg(&ndev->ntb.pdev->dev, "Peer db data %llx db bit %d\n",
+				*db_data, db_bit);
+	}
+
+	return 0;
+}
+
 static int intel_ntb3_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -584,7 +615,7 @@ static int intel_ntb3_db_clear(struct ntb_dev *ntb, u64 db_bits)
 	.db_clear		= intel_ntb3_db_clear,
 	.db_set_mask		= intel_ntb_db_set_mask,
 	.db_clear_mask		= intel_ntb_db_clear_mask,
-	.peer_db_addr		= intel_ntb_peer_db_addr,
+	.peer_db_addr		= intel_ntb3_peer_db_addr,
 	.peer_db_set		= intel_ntb3_peer_db_set,
 	.spad_is_unsafe		= intel_ntb_spad_is_unsafe,
 	.spad_count		= intel_ntb_spad_count,
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40..9fa1b99 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -707,11 +707,16 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev *ntb)
 
 static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
 				      phys_addr_t *db_addr,
-				      resource_size_t *db_size)
+				      resource_size_t *db_size,
+				      u64 *db_data,
+				      int db_bit)
 {
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 	unsigned long offset;
 
+	if (unlikely(db_bit >= BITS_PER_LONG_LONG))
+		return -EINVAL;
+
 	offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
 		(unsigned long)sndev->stdev->mmio;
 
@@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
 		*db_addr = pci_resource_start(ntb->pdev, 0) + offset;
 	if (db_size)
 		*db_size = sizeof(u32);
+	if (db_data)
+		*db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;
 
 	return 0;
 }
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 181d166..56a92e3 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -296,7 +296,8 @@ struct ntb_dev_ops {
 	int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
 
 	int (*peer_db_addr)(struct ntb_dev *ntb,
-			    phys_addr_t *db_addr, resource_size_t *db_size);
+			    phys_addr_t *db_addr, resource_size_t *db_size,
+				u64 *db_data, int db_bit);
 	u64 (*peer_db_read)(struct ntb_dev *ntb);
 	int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
 	int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
@@ -1078,6 +1079,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
  * @ntb:	NTB device context.
  * @db_addr:	OUT - The address of the peer doorbell register.
  * @db_size:	OUT - The number of bytes to write the peer doorbell register.
+ * @db_data:	OUT - The data of peer doorbell register
+ * @db_bit:		door bell bit number
  *
  * Return the address of the peer doorbell register.  This may be used, for
  * example, by drivers that offload memory copy operations to a dma engine.
@@ -1091,12 +1094,13 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
  */
 static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
 				   phys_addr_t *db_addr,
-				   resource_size_t *db_size)
+				   resource_size_t *db_size,
+				   u64 *db_data, int db_bit)
 {
 	if (!ntb->ops->peer_db_addr)
 		return -EINVAL;
 
-	return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
+	return ntb->ops->peer_db_addr(ntb, db_addr, db_size, db_data, db_bit);
 }
 
 /**
-- 
1.9.3

