Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t197si226899itf.2.2017.11.29.09.55.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:53 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:24 -0700
Message-Id: <20171129175530.31032-2-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 1/7] ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

From: Kelvin Cao <kelvin.cao@microsemi.com>

Allow using Switchtec NTB in setups that have more than two partitions.
Note: this does not enable having multi-host communication, it only
allows for a single NTB link between two hosts in a network that might
have more than two.

Use following logic to determine the NT peer partition:

1) If there are 2 partitions, and the target vector is set in
   the Switchtec configuration, use the partition specified in target
   vector.
2) If there are 2 partitions and target vector is unset
   use the only other partition as specified in the NT EP map.
3) If there are more than 2 partitions and target vector is set
   use the other partition specified in target vector.
4) If there are more than 2 partitions and target vector is unset,
   this is invalid and report an error.

Signed-off-by: Kelvin Cao <kelvin.cao@microsemi.com>
[logang@deltatee.com: commit message fleshed out]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 57 ++++++++++++++++++++++++++++------
 include/linux/switchtec.h              |  8 +++++
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 709f37fbe232..088ae220ecb4 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -777,9 +777,12 @@ static const struct ntb_dev_ops switchtec_ntb_ops = {
 	.peer_spad_addr		= switchtec_ntb_peer_spad_addr,
 };
 
-static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
+static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 {
+	u64 tpart_vec;
+	int self;
 	u64 part_map;
+	int bit;
 
 	sndev->ntb.pdev = sndev->stdev->pdev;
 	sndev->ntb.topo = NTB_TOPO_SWITCH;
@@ -788,13 +791,47 @@ static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	sndev->self_partition = sndev->stdev->partition;
 
 	sndev->mmio_ntb = sndev->stdev->mmio_ntb;
+
+	self = sndev->self_partition;
+	tpart_vec = ioread32(&sndev->mmio_ntb->ntp_info[self].target_part_high);
+	tpart_vec <<= 32;
+	tpart_vec |= ioread32(&sndev->mmio_ntb->ntp_info[self].target_part_low);
+
 	part_map = ioread64(&sndev->mmio_ntb->ep_map);
 	part_map &= ~(1 << sndev->self_partition);
-	sndev->peer_partition = ffs(part_map) - 1;
 
-	dev_dbg(&sndev->stdev->dev, "Partition ID %d of %d (%llx)\n",
-		sndev->self_partition, sndev->stdev->partition_count,
-		part_map);
+	if (!ffs(tpart_vec)) {
+		if (sndev->stdev->partition_count != 2) {
+			dev_err(&sndev->stdev->dev,
+				"ntb target partition not defined\n");
+			return -ENODEV;
+		}
+
+		bit = ffs(part_map);
+		if (!bit) {
+			dev_err(&sndev->stdev->dev,
+				"peer partition is not NT partition\n");
+			return -ENODEV;
+		}
+
+		sndev->peer_partition = bit - 1;
+	} else {
+		if (ffs(tpart_vec) != fls(tpart_vec)) {
+			dev_err(&sndev->stdev->dev,
+				"ntb driver only supports 1 pair of 1-1 ntb mapping\n");
+			return -ENODEV;
+		}
+
+		sndev->peer_partition = ffs(tpart_vec) - 1;
+		if (!(part_map && (1 << sndev->peer_partition))) {
+			dev_err(&sndev->stdev->dev,
+				"ntb target partition is not NT partition\n");
+			return -ENODEV;
+		}
+	}
+
+	dev_dbg(&sndev->stdev->dev, "Partition ID %d of %d\n",
+		sndev->self_partition, sndev->stdev->partition_count);
 
 	sndev->mmio_ctrl = (void * __iomem)sndev->mmio_ntb +
 		SWITCHTEC_NTB_REG_CTRL_OFFSET;
@@ -804,6 +841,8 @@ static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	sndev->mmio_self_ctrl = &sndev->mmio_ctrl[sndev->self_partition];
 	sndev->mmio_peer_ctrl = &sndev->mmio_ctrl[sndev->peer_partition];
 	sndev->mmio_self_dbmsg = &sndev->mmio_dbmsg[sndev->self_partition];
+
+	return 0;
 }
 
 static int map_bars(int *map, struct ntb_ctrl_regs __iomem *ctrl)
@@ -1135,15 +1174,15 @@ static int switchtec_ntb_add(struct device *dev,
 	if (stdev->pdev->class != MICROSEMI_NTB_CLASSCODE)
 		return -ENODEV;
 
-	if (stdev->partition_count != 2)
-		dev_warn(dev, "ntb driver only supports 2 partitions\n");
-
 	sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
 	if (!sndev)
 		return -ENOMEM;
 
 	sndev->stdev = stdev;
-	switchtec_ntb_init_sndev(sndev);
+	rc = switchtec_ntb_init_sndev(sndev);
+	if (rc)
+		goto free_and_exit;
+
 	switchtec_ntb_init_mw(sndev);
 	switchtec_ntb_init_db(sndev);
 	switchtec_ntb_init_msgs(sndev);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 09d73d0d1aa8..d4a7c18b42cf 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -168,6 +168,14 @@ struct ntb_info_regs {
 	u16 reserved1;
 	u64 ep_map;
 	u16 requester_id;
+	u16 reserved2;
+	u32 reserved3[4];
+	struct nt_partition_info {
+		u32 xlink_enabled;
+		u32 target_part_low;
+		u32 target_part_high;
+		u32 reserved;
+	} ntp_info[48];
 } __packed;
 
 struct part_cfg_regs {
-- 
2.11.0

