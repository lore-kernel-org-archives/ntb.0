Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com. [2a00:1450:4010:c07::231])
        by gmr-mx.google.com with ESMTPS id n75si353078ljb.0.2017.12.06.06.32.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:15 -0800 (PST)
Received: by mail-lf0-x231.google.com with SMTP id t197so4450677lfe.7
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:15 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 01/15] NTB: Rename NTB messaging API methods
Date: Wed,  6 Dec 2017 17:31:52 +0300
Message-Id: <20171206143206.14665-2-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

There is a common methods signature form used over all the NTB API
like functions naming scheme, arguments names and order, etc.
Recently added NTB messaging API IO callbacks were named a bit
different so should be renamed to be in compliance with the rest
of the API.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 27 ++++++++++++---------------
 include/linux/ntb.h             | 34 ++++++++++++++++------------------
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0cd79f367f7c..24040317bb9c 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1744,20 +1744,19 @@ static int idt_ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
  * idt_ntb_msg_read() - read message register with specified index
  *			(NTB API callback)
  * @ntb:	NTB device context.
- * @midx:	Message register index
  * @pidx:	OUT - Port index of peer device a message retrieved from
- * @msg:	OUT - Data
+ * @midx:	Message register index
  *
  * Read data from the specified message register and source register.
  *
- * Return: zero on success, negative error if invalid argument passed.
+ * Return: inbound message register value.
  */
-static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
+static u32 idt_ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
 {
 	struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
 
 	if (midx < 0 || IDT_MSG_CNT <= midx)
-		return -EINVAL;
+		return ~(u32)0;
 
 	/* Retrieve source port index of the message */
 	if (pidx != NULL) {
@@ -1772,18 +1771,15 @@ static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
 	}
 
 	/* Retrieve data of the corresponding message register */
-	if (msg != NULL)
-		*msg = idt_nt_read(ndev, ntdata_tbl.msgs[midx].in);
-
-	return 0;
+	return idt_nt_read(ndev, ntdata_tbl.msgs[midx].in);
 }
 
 /*
- * idt_ntb_msg_write() - write data to the specified message register
- *			 (NTB API callback)
+ * idt_ntb_peer_msg_write() - write data to the specified message register
+ *			      (NTB API callback)
  * @ntb:	NTB device context.
- * @midx:	Message register index
  * @pidx:	Port index of peer device a message being sent to
+ * @midx:	Message register index
  * @msg:	Data to send
  *
  * Just try to send data to a peer. Message status register should be
@@ -1791,7 +1787,8 @@ static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
  *
  * Return: zero on success, negative error if invalid argument passed.
  */
-static int idt_ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx, u32 msg)
+static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
+				  u32 msg)
 {
 	struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
 	unsigned long irqflags;
@@ -2058,7 +2055,7 @@ static const struct ntb_dev_ops idt_ntb_ops = {
 	.msg_set_mask		= idt_ntb_msg_set_mask,
 	.msg_clear_mask		= idt_ntb_msg_clear_mask,
 	.msg_read		= idt_ntb_msg_read,
-	.msg_write		= idt_ntb_msg_write
+	.peer_msg_write		= idt_ntb_peer_msg_write
 };
 
 /*
@@ -2269,7 +2266,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 		 "Message data:\n");
 	for (idx = 0; idx < IDT_MSG_CNT; idx++) {
 		int src;
-		(void)idt_ntb_msg_read(&ndev->ntb, idx, &src, &data);
+		data = idt_ntb_msg_read(&ndev->ntb, &src, idx);
 		off += scnprintf(strbuf + off, size - off,
 			"\t%hhu. 0x%08x from peer %hhu (Port %hhu)\n",
 			idx, data, src, ndev->peers[src].port);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index ea3be7275a5e..21b1826a0953 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -253,7 +253,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_set_mask:	See ntb_msg_set_mask().
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
- * @msg_write:		See ntb_msg_write().
+ * @peer_msg_write:	See ntb_peer_msg_write().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -324,8 +324,8 @@ struct ntb_dev_ops {
 	int (*msg_clear_sts)(struct ntb_dev *ntb, u64 sts_bits);
 	int (*msg_set_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
-	int (*msg_read)(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg);
-	int (*msg_write)(struct ntb_dev *ntb, int midx, int pidx, u32 msg);
+	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
+	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -387,7 +387,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_set_mask == !ops->msg_count	&& */
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
-		!ops->msg_write == !ops->msg_count		&&
+		!ops->peer_msg_write == !ops->msg_count		&&
 		1;
 }
 
@@ -1462,31 +1462,29 @@ static inline int ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
 }
 
 /**
- * ntb_msg_read() - read message register with specified index
+ * ntb_msg_read() - read inbound message register with specified index
  * @ntb:	NTB device context.
- * @midx:	Message register index
  * @pidx:	OUT - Port index of peer device a message retrieved from
- * @msg:	OUT - Data
+ * @midx:	Message register index
  *
  * Read data from the specified message register. Source port index of a
  * message is retrieved as well.
  *
- * Return: Zero on success, otherwise a negative error number.
+ * Return: The value of the inbound message register.
  */
-static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
-			       u32 *msg)
+static inline u32 ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
 {
 	if (!ntb->ops->msg_read)
-		return -EINVAL;
+		return ~(u32)0;
 
-	return ntb->ops->msg_read(ntb, midx, pidx, msg);
+	return ntb->ops->msg_read(ntb, pidx, midx);
 }
 
 /**
- * ntb_msg_write() - write data to the specified message register
+ * ntb_peer_msg_write() - write data to the specified peer message register
  * @ntb:	NTB device context.
- * @midx:	Message register index
  * @pidx:	Port index of peer device a message being sent to
+ * @midx:	Message register index
  * @msg:	Data to send
  *
  * Send data to a specified peer device using the defined message register.
@@ -1495,13 +1493,13 @@ static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
  *
  * Return: Zero on success, otherwise a negative error number.
  */
-static inline int ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx,
-				u32 msg)
+static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
+				     u32 msg)
 {
-	if (!ntb->ops->msg_write)
+	if (!ntb->ops->peer_msg_write)
 		return -EINVAL;
 
-	return ntb->ops->msg_write(ntb, midx, pidx, msg);
+	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
 #endif
-- 
2.12.0

