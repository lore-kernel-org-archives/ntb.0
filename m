Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 83si127422oii.3.2017.11.29.09.55.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:52 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:27 -0700
Message-Id: <20171129175530.31032-5-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 4/7] ntb_hw_switchtec: Make switchtec_ntb_init_req_id_table() more general
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This is a prep patch in order to support the crosslink feature which
will require the driver to setup the requester ID table in another
partition as well as it's own. To aid this, create a helper function
which sets up the requester IDs from an array.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 92 +++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index b18e938312e1..4adc32fe035a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -887,6 +887,55 @@ static int config_rsvd_lut_win(struct switchtec_ntb *sndev,
 	return 0;
 }
 
+static int config_req_id_table(struct switchtec_ntb *sndev,
+			       struct ntb_ctrl_regs __iomem *mmio_ctrl,
+			       int *req_ids, int count)
+{
+	int i, rc = 0;
+	u32 error;
+	u32 proxy_id;
+
+	if (ioread32(&mmio_ctrl->req_id_table_size) < count) {
+		dev_err(&sndev->stdev->dev,
+			"Not enough requester IDs available.\n");
+		return -EFAULT;
+	}
+
+	rc = switchtec_ntb_part_op(sndev, mmio_ctrl,
+				   NTB_CTRL_PART_OP_LOCK,
+				   NTB_CTRL_PART_STATUS_LOCKED);
+	if (rc)
+		return rc;
+
+	iowrite32(NTB_PART_CTRL_ID_PROT_DIS,
+		  &mmio_ctrl->partition_ctrl);
+
+	for (i = 0; i < count; i++) {
+		iowrite32(req_ids[i] << 16 | NTB_CTRL_REQ_ID_EN,
+			  &mmio_ctrl->req_id_table[i]);
+
+		proxy_id = ioread32(&mmio_ctrl->req_id_table[i]);
+		dev_dbg(&sndev->stdev->dev,
+			"Requester ID %02X:%02X.%X -> BB:%02X.%X\n",
+			req_ids[i] >> 8, (req_ids[i] >> 3) & 0x1F,
+			req_ids[i] & 0x7, (proxy_id >> 4) & 0x1F,
+			(proxy_id >> 1) & 0x7);
+	}
+
+	rc = switchtec_ntb_part_op(sndev, mmio_ctrl,
+				   NTB_CTRL_PART_OP_CFG,
+				   NTB_CTRL_PART_STATUS_NORMAL);
+
+	if (rc == -EIO) {
+		error = ioread32(&mmio_ctrl->req_id_error);
+		dev_err(&sndev->stdev->dev,
+			"Error setting up the requester ID table: %08x\n",
+			error);
+	}
+
+	return 0;
+}
+
 static int map_bars(int *map, struct ntb_ctrl_regs __iomem *ctrl)
 {
 	int i;
@@ -968,52 +1017,23 @@ static void switchtec_ntb_init_msgs(struct switchtec_ntb *sndev)
 			  &sndev->mmio_self_dbmsg->imsg[i]);
 }
 
-static int switchtec_ntb_init_req_id_table(struct switchtec_ntb *sndev)
+static int
+switchtec_ntb_init_req_id_table(struct switchtec_ntb *sndev)
 {
-	int rc = 0;
-	u16 req_id;
-	u32 error;
-
-	req_id = ioread16(&sndev->mmio_ntb->requester_id);
-
-	if (ioread32(&sndev->mmio_self_ctrl->req_id_table_size) < 2) {
-		dev_err(&sndev->stdev->dev,
-			"Not enough requester IDs available\n");
-		return -EFAULT;
-	}
-
-	rc = switchtec_ntb_part_op(sndev, sndev->mmio_self_ctrl,
-				   NTB_CTRL_PART_OP_LOCK,
-				   NTB_CTRL_PART_STATUS_LOCKED);
-	if (rc)
-		return rc;
-
-	iowrite32(NTB_PART_CTRL_ID_PROT_DIS,
-		  &sndev->mmio_self_ctrl->partition_ctrl);
+	int req_ids[2];
 
 	/*
 	 * Root Complex Requester ID (which is 0:00.0)
 	 */
-	iowrite32(0 << 16 | NTB_CTRL_REQ_ID_EN,
-		  &sndev->mmio_self_ctrl->req_id_table[0]);
+	req_ids[0] = 0;
 
 	/*
 	 * Host Bridge Requester ID (as read from the mmap address)
 	 */
-	iowrite32(req_id << 16 | NTB_CTRL_REQ_ID_EN,
-		  &sndev->mmio_self_ctrl->req_id_table[1]);
-
-	rc = switchtec_ntb_part_op(sndev, sndev->mmio_self_ctrl,
-				   NTB_CTRL_PART_OP_CFG,
-				   NTB_CTRL_PART_STATUS_NORMAL);
-	if (rc == -EIO) {
-		error = ioread32(&sndev->mmio_self_ctrl->req_id_error);
-		dev_err(&sndev->stdev->dev,
-			"Error setting up the requester ID table: %08x\n",
-			error);
-	}
+	req_ids[1] = ioread16(&sndev->mmio_ntb->requester_id);
 
-	return rc;
+	return config_req_id_table(sndev, sndev->mmio_self_ctrl, req_ids,
+				   ARRAY_SIZE(req_ids));
 }
 
 static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
-- 
2.11.0

