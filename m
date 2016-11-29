Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id s81si354714wmf.3.2016.11.29.09.16.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:00 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id 98so13272887lfs.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:00 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 05/22] NTB: Alter Scratchpads NTB API to support multi-ports interface
Date: Tue, 29 Nov 2016 20:16:00 +0300
Message-Id: <1480439777-1080-6-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Even though there is no any real NTB hardware, which would have both more
than two ports and Scratchpad registers, it is logically correct to have
Scratchpad API accepting a peer port index as well. Intel/AMD drivers used
to utilize Primary and Secondary topology to split Scratchpad between
connected root devices. Since port-index API replaced Primary and Secondary
topology, Intel/AMD NTB hadrware drivers can use device port to determine
which Scratchpad registers actually belong to local and peer devices.
The same approach can be used if some potential hardware in future will be
multi-port and have some set of Scratchpads.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 59de1f6..fc9d034 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -268,13 +268,14 @@ struct ntb_dev_ops {
 	int (*spad_is_unsafe)(struct ntb_dev *ntb);
 	int (*spad_count)(struct ntb_dev *ntb);
 
-	u32 (*spad_read)(struct ntb_dev *ntb, int idx);
-	int (*spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+	u32 (*spad_read)(struct ntb_dev *ntb, int sidx);
+	int (*spad_write)(struct ntb_dev *ntb, int sidx, u32 val);
 
-	int (*peer_spad_addr)(struct ntb_dev *ntb, int idx,
+	int (*peer_spad_addr)(struct ntb_dev *ntb, int pidx, int sidx,
 			      phys_addr_t *spad_addr);
-	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
-	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+	u32 (*peer_spad_read)(struct ntb_dev *ntb, int pidx, int sidx);
+	int (*peer_spad_write)(struct ntb_dev *ntb, int pidx, int sidx,
+			       u32 val);
 
 	int (*msg_count)(struct ntb_dev *ntb);
 	u64 (*msg_inbits)(struct ntb_dev *ntb);
@@ -1201,6 +1202,7 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
  * @ntb:	NTB device context.
  *
  * Hardware and topology may support a different number of scratchpads.
+ * Although it must be the same for all ports per NTB device.
  *
  * Return: the number of scratchpads.
  */
@@ -1215,42 +1217,43 @@ static inline int ntb_spad_count(struct ntb_dev *ntb)
 /**
  * ntb_spad_read() - read the local scratchpad register
  * @ntb:	NTB device context.
- * @idx:	Scratchpad index.
+ * @sidx:	Scratchpad index.
  *
  * Read the local scratchpad register, and return the value.
  *
  * Return: The value of the local scratchpad register.
  */
-static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
+static inline u32 ntb_spad_read(struct ntb_dev *ntb, int sidx)
 {
 	if (!ntb->ops->spad_read)
 		return ~(u32)0;
 
-	return ntb->ops->spad_read(ntb, idx);
+	return ntb->ops->spad_read(ntb, sidx);
 }
 
 /**
  * ntb_spad_write() - write the local scratchpad register
  * @ntb:	NTB device context.
- * @idx:	Scratchpad index.
+ * @sidx:	Scratchpad index.
  * @val:	Scratchpad value.
  *
  * Write the value to the local scratchpad register.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
 {
 	if (!ntb->ops->spad_write)
 		return -EINVAL;
 
-	return ntb->ops->spad_write(ntb, idx, val);
+	return ntb->ops->spad_write(ntb, sidx, val);
 }
 
 /**
  * ntb_peer_spad_addr() - address of the peer scratchpad register
  * @ntb:	NTB device context.
- * @idx:	Scratchpad index.
+ * @pidx:	Port index of peer device.
+ * @sidx:	Scratchpad index.
  * @spad_addr:	OUT - The address of the peer scratchpad register.
  *
  * Return the address of the peer doorbell register.  This may be used, for
@@ -1258,48 +1261,51 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
+static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
 				     phys_addr_t *spad_addr)
 {
 	if (!ntb->ops->peer_spad_addr)
 		return -EINVAL;
 
-	return ntb->ops->peer_spad_addr(ntb, idx, spad_addr);
+	return ntb->ops->peer_spad_addr(ntb, pidx, sidx, spad_addr);
 }
 
 /**
  * ntb_peer_spad_read() - read the peer scratchpad register
  * @ntb:	NTB device context.
- * @idx:	Scratchpad index.
+ * @pidx:	Port index of peer device.
+ * @sidx:	Scratchpad index.
  *
  * Read the peer scratchpad register, and return the value.
  *
  * Return: The value of the local scratchpad register.
  */
-static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
 {
 	if (!ntb->ops->peer_spad_read)
 		return ~(u32)0;
 
-	return ntb->ops->peer_spad_read(ntb, idx);
+	return ntb->ops->peer_spad_read(ntb, pidx, sidx);
 }
 
 /**
  * ntb_peer_spad_write() - write the peer scratchpad register
  * @ntb:	NTB device context.
- * @idx:	Scratchpad index.
+ * @pidx:	Port index of peer device.
+ * @sidx:	Scratchpad index.
  * @val:	Scratchpad value.
  *
  * Write the value to the peer scratchpad register.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int pidx, int sidx,
+				      u32 val)
 {
 	if (!ntb->ops->peer_spad_write)
 		return -EINVAL;
 
-	return ntb->ops->peer_spad_write(ntb, idx, val);
+	return ntb->ops->peer_spad_write(ntb, pidx, sidx, val);
 }
 
 /**
-- 
2.6.6

