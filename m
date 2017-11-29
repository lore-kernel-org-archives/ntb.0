Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b36si141871uah.3.2017.11.29.09.55.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:55 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:30 -0700
Message-Id: <20171129175530.31032-8-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 7/7] ntb_hw_switchtec: Crosslink doorbells and messages
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

In a crosslink configuration doorbells and messages largely work the
same but the NTB registers must be accessed through the reserved LUT
window. Also, as a bonus, seeing there are now two independent sets of
NTB links, both partitions can actually use all 60 doorbell registers
instead of them having to be split into two for each partition.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 65 ++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 17db0f50bb22..145b31209f20 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -94,6 +94,7 @@ struct switchtec_ntb {
 	struct ntb_ctrl_regs __iomem *mmio_self_ctrl;
 	struct ntb_ctrl_regs __iomem *mmio_peer_ctrl;
 	struct ntb_dbmsg_regs __iomem *mmio_self_dbmsg;
+	struct ntb_dbmsg_regs __iomem *mmio_peer_dbmsg;
 
 	void __iomem *mmio_xlink_win;
 
@@ -188,10 +189,10 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 static int switchtec_ntb_send_msg(struct switchtec_ntb *sndev, int idx,
 				  u32 val)
 {
-	if (idx < 0 || idx >= ARRAY_SIZE(sndev->mmio_self_dbmsg->omsg))
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->mmio_peer_dbmsg->omsg))
 		return -EINVAL;
 
-	iowrite32(val, &sndev->mmio_self_dbmsg->omsg[idx].msg);
+	iowrite32(val, &sndev->mmio_peer_dbmsg->omsg[idx].msg);
 
 	return 0;
 }
@@ -474,6 +475,25 @@ static int crosslink_is_enabled(struct switchtec_ntb *sndev)
 	return ioread8(&inf->ntp_info[sndev->peer_partition].xlink_enabled);
 }
 
+static void crosslink_init_dbmsgs(struct switchtec_ntb *sndev)
+{
+	int i;
+	u32 msg_map = 0;
+
+	if (!crosslink_is_enabled(sndev))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sndev->mmio_peer_dbmsg->imsg); i++) {
+		int m = i | sndev->self_partition << 2;
+
+		msg_map |= m << i * 8;
+	}
+
+	iowrite32(msg_map, &sndev->mmio_peer_dbmsg->msg_map);
+	iowrite64(sndev->db_valid_mask << sndev->db_peer_shift,
+		  &sndev->mmio_peer_dbmsg->odb_mask);
+}
+
 enum {
 	LINK_MESSAGE = 0,
 	MSG_LINK_UP = 1,
@@ -504,6 +524,9 @@ static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
 		ntb_link_event(&sndev->ntb);
 		dev_info(&sndev->stdev->dev, "ntb link %s\n",
 			 link_sta ? "up" : "down");
+
+		if (link_sta)
+			crosslink_init_dbmsgs(sndev);
 	}
 }
 
@@ -649,7 +672,7 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 	unsigned long offset;
 
-	offset = (unsigned long)sndev->mmio_self_dbmsg->odb -
+	offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
 		(unsigned long)sndev->stdev->mmio;
 
 	offset += sndev->db_shift / 8;
@@ -667,7 +690,7 @@ static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 
 	iowrite64(db_bits << sndev->db_peer_shift,
-		  &sndev->mmio_self_dbmsg->odb);
+		  &sndev->mmio_peer_dbmsg->odb);
 
 	return 0;
 }
@@ -852,6 +875,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	sndev->mmio_self_ctrl = &sndev->mmio_ctrl[sndev->self_partition];
 	sndev->mmio_peer_ctrl = &sndev->mmio_ctrl[sndev->peer_partition];
 	sndev->mmio_self_dbmsg = &sndev->mmio_dbmsg[sndev->self_partition];
+	sndev->mmio_peer_dbmsg = sndev->mmio_self_dbmsg;
 
 	return 0;
 }
@@ -1072,6 +1096,7 @@ static int switchtec_ntb_init_crosslink(struct switchtec_ntb *sndev)
 	const int ntb_lut_idx = 1;
 	u64 bar_addrs[6];
 	u64 addr;
+	int offset;
 	int bar_cnt;
 
 	if (!crosslink_is_enabled(sndev))
@@ -1087,7 +1112,13 @@ static int switchtec_ntb_init_crosslink(struct switchtec_ntb *sndev)
 		return -EINVAL;
 	}
 
-	addr = bar_addrs[0];
+	addr = (bar_addrs[0] + SWITCHTEC_GAS_NTB_OFFSET +
+		SWITCHTEC_NTB_REG_DBMSG_OFFSET +
+		sizeof(struct ntb_dbmsg_regs) * sndev->peer_partition);
+
+	offset = addr & (LUT_SIZE - 1);
+	addr -= offset;
+
 	rc = config_rsvd_lut_win(sndev, sndev->mmio_self_ctrl, ntb_lut_idx,
 				 sndev->peer_partition, addr);
 	if (rc)
@@ -1109,8 +1140,11 @@ static int switchtec_ntb_init_crosslink(struct switchtec_ntb *sndev)
 		return rc;
 	}
 
+	sndev->mmio_peer_dbmsg = sndev->mmio_xlink_win + offset;
 	sndev->nr_rsvd_luts++;
 
+	crosslink_init_dbmsgs(sndev);
+
 	return 0;
 }
 
@@ -1163,24 +1197,35 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
  * shared among all partitions. So we must split them in half
  * (32 for each partition). However, the message interrupts are
  * also shared with the top 4 doorbells so we just limit this to
- * 28 doorbells per partition
+ * 28 doorbells per partition.
+ *
+ * In crosslink mode, each side has it's own dbmsg register so
+ * they can each use all 60 of the available doorbells.
  */
 static void switchtec_ntb_init_db(struct switchtec_ntb *sndev)
 {
-	sndev->db_valid_mask = 0x0FFFFFFF;
+	sndev->db_mask = 0x0FFFFFFFFFFFFFFFULL;
 
-	if (sndev->self_partition < sndev->peer_partition) {
+	if (sndev->mmio_peer_dbmsg != sndev->mmio_self_dbmsg) {
+		sndev->db_shift = 0;
+		sndev->db_peer_shift = 0;
+		sndev->db_valid_mask = sndev->db_mask;
+	} else if (sndev->self_partition < sndev->peer_partition) {
 		sndev->db_shift = 0;
 		sndev->db_peer_shift = 32;
+		sndev->db_valid_mask = 0x0FFFFFFF;
 	} else {
 		sndev->db_shift = 32;
 		sndev->db_peer_shift = 0;
+		sndev->db_valid_mask = 0x0FFFFFFF;
 	}
 
-	sndev->db_mask = 0x0FFFFFFFFFFFFFFFULL;
 	iowrite64(~sndev->db_mask, &sndev->mmio_self_dbmsg->idb_mask);
 	iowrite64(sndev->db_valid_mask << sndev->db_peer_shift,
-		  &sndev->mmio_self_dbmsg->odb_mask);
+		  &sndev->mmio_peer_dbmsg->odb_mask);
+
+	dev_dbg(&sndev->stdev->dev, "dbs: shift %d/%d, mask %016llx\n",
+		sndev->db_shift, sndev->db_peer_shift, sndev->db_valid_mask);
 }
 
 static void switchtec_ntb_init_msgs(struct switchtec_ntb *sndev)
-- 
2.11.0

