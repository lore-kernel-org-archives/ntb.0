Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id h23si897631wmi.1.2016.12.13.15.49.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:33 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id p100so220325lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:33 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 6/9] NTB: Add Messaging NTB API
Date: Wed, 14 Dec 2016 02:49:18 +0300
Message-Id: <1481672961-10753-7-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
 <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Some IDT NTB-capable PCIe-switches have message registers to communicate with
peer devices. This patch adds new NTB API callback methods, which can be used
to utilize these registers functionality:
 ntb_msg_count(); - get number of message registers
 ntb_msg_inbits(); - get bitfield of inbound message registers status
 ntb_msg_outbits(); - get bitfield of outbound message registers status
 ntb_msg_read_sts(); - read the inbound and outbound message registers status
 ntb_msg_clear_sts(); - clear status bits of message registers
 ntb_msg_set_mask(); - mask interrupts raised by status bits of message
registers.
 ntb_msg_clear_mask(); - clear interrupts mask bits of message registers
 ntb_msg_read(midx, *pidx); - read message register with specified index,
additionally getting peer port index which data received from
 ntb_msg_write(midx, pidx); - write data to the specified message register
sending it to the passed peer device connected over a pidx port
 ntb_msg_event(); - notify driver context of a new message event

Of course there is hardware which doesn't support Message registers, so
this API is made optional.

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/ntb.c   |  13 ++++
 include/linux/ntb.h | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2551bb2..03b80d8 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -193,6 +193,19 @@ void ntb_db_event(struct ntb_dev *ntb, int vector)
 }
 EXPORT_SYMBOL(ntb_db_event);
 
+void ntb_msg_event(struct ntb_dev *ntb)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		if (ntb->ctx_ops && ntb->ctx_ops->msg_event)
+			ntb->ctx_ops->msg_event(ntb->ctx);
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+}
+EXPORT_SYMBOL(ntb_msg_event);
+
 int ntb_default_port_number(struct ntb_dev *ntb)
 {
 	switch (ntb->topo) {
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index a54e2be..76c56d5 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -178,10 +178,12 @@ static inline int ntb_client_ops_is_valid(const struct ntb_client_ops *ops)
  * struct ntb_ctx_ops - ntb driver context operations
  * @link_event:		See ntb_link_event().
  * @db_event:		See ntb_db_event().
+ * @msg_event:		See ntb_msg_event().
  */
 struct ntb_ctx_ops {
 	void (*link_event)(void *ctx);
 	void (*db_event)(void *ctx, int db_vector);
+	void (*msg_event)(void *ctx);
 };
 
 static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
@@ -190,6 +192,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 	return
 		/* ops->link_event		&& */
 		/* ops->db_event		&& */
+		/* ops->msg_event		&& */
 		1;
 }
 
@@ -234,6 +237,15 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @peer_spad_addr:	See ntb_peer_spad_addr().
  * @peer_spad_read:	See ntb_peer_spad_read().
  * @peer_spad_write:	See ntb_peer_spad_write().
+ * @msg_count:		See ntb_msg_count().
+ * @msg_inbits:		See ntb_msg_inbits().
+ * @msg_outbits:	See ntb_msg_outbits().
+ * @msg_read_sts:	See ntb_msg_read_sts().
+ * @msg_clear_sts:	See ntb_msg_clear_sts().
+ * @msg_set_mask:	See ntb_msg_set_mask().
+ * @msg_clear_mask:	See ntb_msg_clear_mask().
+ * @msg_read:		See ntb_msg_read().
+ * @msg_write:		See ntb_msg_write().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -296,6 +308,16 @@ struct ntb_dev_ops {
 	u32 (*peer_spad_read)(struct ntb_dev *ntb, int pidx, int sidx);
 	int (*peer_spad_write)(struct ntb_dev *ntb, int pidx, int sidx,
 			       u32 val);
+
+	int (*msg_count)(struct ntb_dev *ntb);
+	u64 (*msg_inbits)(struct ntb_dev *ntb);
+	u64 (*msg_outbits)(struct ntb_dev *ntb);
+	u64 (*msg_read_sts)(struct ntb_dev *ntb);
+	int (*msg_clear_sts)(struct ntb_dev *ntb, u64 sts_bits);
+	int (*msg_set_mask)(struct ntb_dev *ntb, u64 mask_bits);
+	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
+	int (*msg_read)(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg);
+	int (*msg_write)(struct ntb_dev *ntb, int midx, int pidx, u32 msg);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -342,6 +364,15 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->peer_spad_addr == !ops->spad_count	&& */
 		/* !ops->peer_spad_read == !ops->spad_count	&& */
 		!ops->peer_spad_write == !ops->spad_count 	&&
+
+		!ops->msg_inbits == !ops->msg_count		&&
+		!ops->msg_outbits == !ops->msg_count		&&
+		!ops->msg_read_sts == !ops->msg_count		&&
+		!ops->msg_clear_sts == !ops->msg_count		&&
+		/* !ops->msg_set_mask == !ops->msg_count	&& */
+		/* !ops->msg_clear_mask == !ops->msg_count	&& */
+		!ops->msg_read == !ops->msg_count		&&
+		!ops->msg_write == !ops->msg_count		&&
 		1;
 }
 
@@ -485,6 +516,18 @@ void ntb_link_event(struct ntb_dev *ntb);
 void ntb_db_event(struct ntb_dev *ntb, int vector);
 
 /**
+ * ntb_msg_event() - notify driver context of a message event
+ * @ntb:	NTB device context.
+ *
+ * Notify the driver context of a message event.  If hardware supports
+ * message registers, this event indicates, that a new message arrived in
+ * some incoming message register or last sent message couldn't be delivered.
+ * The events can be masked/unmasked by the methods ntb_msg_set_mask() and
+ * ntb_msg_clear_mask().
+ */
+void ntb_msg_event(struct ntb_dev *ntb);
+
+/**
  * ntb_default_port_number() - get the default local port number
  * @ntb:	NTB device context.
  *
@@ -1282,4 +1325,166 @@ static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int pidx, int sidx,
 	return ntb->ops->peer_spad_write(ntb, pidx, sidx, val);
 }
 
+/**
+ * ntb_msg_count() - get the number of message registers
+ * @ntb:	NTB device context.
+ *
+ * Hardware may support a different number of message registers.
+ *
+ * Return: the number of message registers.
+ */
+static inline int ntb_msg_count(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->msg_count)
+		return 0;
+
+	return ntb->ops->msg_count(ntb);
+}
+
+/**
+ * ntb_msg_inbits() - get a bitfield of inbound message registers status
+ * @ntb:	NTB device context.
+ *
+ * The method returns the bitfield of status and mask registers, which related
+ * to inbound message registers.
+ *
+ * Return: bitfield of inbound message registers.
+ */
+static inline u64 ntb_msg_inbits(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->msg_inbits)
+		return 0;
+
+	return ntb->ops->msg_inbits(ntb);
+}
+
+/**
+ * ntb_msg_outbits() - get a bitfield of outbound message registers status
+ * @ntb:	NTB device context.
+ *
+ * The method returns the bitfield of status and mask registers, which related
+ * to outbound message registers.
+ *
+ * Return: bitfield of outbound message registers.
+ */
+static inline u64 ntb_msg_outbits(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->msg_outbits)
+		return 0;
+
+	return ntb->ops->msg_outbits(ntb);
+}
+
+/**
+ * ntb_msg_read_sts() - read the message registers status
+ * @ntb:	NTB device context.
+ *
+ * Read the status of message register. Inbound and outbound message registers
+ * related bits can be filtered by masks retrieved from ntb_msg_inbits() and
+ * ntb_msg_outbits().
+ *
+ * Return: status bits of message registers
+ */
+static inline u64 ntb_msg_read_sts(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->msg_read_sts)
+		return 0;
+
+	return ntb->ops->msg_read_sts(ntb);
+}
+
+/**
+ * ntb_msg_clear_sts() - clear status bits of message registers
+ * @ntb:	NTB device context.
+ * @sts_bits:	Status bits to clear.
+ *
+ * Clear bits in the status register.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_msg_clear_sts(struct ntb_dev *ntb, u64 sts_bits)
+{
+	if (!ntb->ops->msg_clear_sts)
+		return -EINVAL;
+
+	return ntb->ops->msg_clear_sts(ntb, sts_bits);
+}
+
+/**
+ * ntb_msg_set_mask() - set mask of message register status bits
+ * @ntb:	NTB device context.
+ * @mask_bits:	Mask bits.
+ *
+ * Mask the message registers status bits from raising the message event.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_msg_set_mask(struct ntb_dev *ntb, u64 mask_bits)
+{
+	if (!ntb->ops->msg_set_mask)
+		return -EINVAL;
+
+	return ntb->ops->msg_set_mask(ntb, mask_bits);
+}
+
+/**
+ * ntb_msg_clear_mask() - clear message registers mask
+ * @ntb:	NTB device context.
+ * @mask_bits:	Mask bits to clear.
+ *
+ * Clear bits in the message events mask register.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
+{
+	if (!ntb->ops->msg_clear_mask)
+		return -EINVAL;
+
+	return ntb->ops->msg_clear_mask(ntb, mask_bits);
+}
+
+/**
+ * ntb_msg_read() - read message register with specified index
+ * @ntb:	NTB device context.
+ * @midx:	Message register index
+ * @pidx:	OUT - Port index of peer device a message retrieved from
+ * @msg:	OUT - Data
+ *
+ * Read data from the specified message register. Source port index of a
+ * message is retrieved as well.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
+			       u32 *msg)
+{
+	if (!ntb->ops->msg_read)
+		return -EINVAL;
+
+	return ntb->ops->msg_read(ntb, midx, pidx, msg);
+}
+
+/**
+ * ntb_msg_write() - write data to the specified message register
+ * @ntb:	NTB device context.
+ * @midx:	Message register index
+ * @pidx:	Port index of peer device a message being sent to
+ * @msg:	Data to send
+ *
+ * Send data to a specified peer device using the defined message register.
+ * Message event can be raised if the midx registers isn't empty while
+ * calling this method and the corresponding interrupt isn't masked.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx,
+				u32 msg)
+{
+	if (!ntb->ops->msg_write)
+		return -EINVAL;
+
+	return ntb->ops->msg_write(ntb, midx, pidx, msg);
+}
+
 #endif
-- 
2.6.6

