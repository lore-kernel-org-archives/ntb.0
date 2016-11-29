Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id s81si354714wmf.3.2016.11.29.09.15.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:15:56 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id 98so13272887lfs.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:15:56 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 01/22] NTB: Move link state API being first in sources
Date: Tue, 29 Nov 2016 20:15:56 +0300
Message-Id: <1480439777-1080-2-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Since link operations are usually performed before memory window access
operations, it's logically better to declared link-related API before any
other methods. Additionally it's good practice for readability to declare
NTB device callback methods of hadrware drivers with the same order as it's
done within ntb.h.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 137 ++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 68 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 6f47562..5d1f260 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -179,13 +179,13 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 
 /**
  * struct ntb_ctx_ops - ntb device operations
+ * @link_is_up:		See ntb_link_is_up().
+ * @link_enable:	See ntb_link_enable().
+ * @link_disable:	See ntb_link_disable().
  * @mw_count:		See ntb_mw_count().
  * @mw_get_range:	See ntb_mw_get_range().
  * @mw_set_trans:	See ntb_mw_set_trans().
  * @mw_clear_trans:	See ntb_mw_clear_trans().
- * @link_is_up:		See ntb_link_is_up().
- * @link_enable:	See ntb_link_enable().
- * @link_disable:	See ntb_link_disable().
  * @db_is_unsafe:	See ntb_db_is_unsafe().
  * @db_valid_mask:	See ntb_db_valid_mask().
  * @db_vector_count:	See ntb_db_vector_count().
@@ -212,6 +212,12 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @peer_spad_write:	See ntb_peer_spad_write().
  */
 struct ntb_dev_ops {
+	int (*link_is_up)(struct ntb_dev *ntb,
+			  enum ntb_speed *speed, enum ntb_width *width);
+	int (*link_enable)(struct ntb_dev *ntb,
+			   enum ntb_speed max_speed, enum ntb_width max_width);
+	int (*link_disable)(struct ntb_dev *ntb);
+
 	int (*mw_count)(struct ntb_dev *ntb);
 	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
 			    phys_addr_t *base, resource_size_t *size,
@@ -220,12 +226,6 @@ struct ntb_dev_ops {
 			    dma_addr_t addr, resource_size_t size);
 	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
 
-	int (*link_is_up)(struct ntb_dev *ntb,
-			  enum ntb_speed *speed, enum ntb_width *width);
-	int (*link_enable)(struct ntb_dev *ntb,
-			   enum ntb_speed max_speed, enum ntb_width max_width);
-	int (*link_disable)(struct ntb_dev *ntb);
-
 	int (*db_is_unsafe)(struct ntb_dev *ntb);
 	u64 (*db_valid_mask)(struct ntb_dev *ntb);
 	int (*db_vector_count)(struct ntb_dev *ntb);
@@ -265,13 +265,14 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 {
 	/* commented callbacks are not required: */
 	return
+		ops->link_is_up				&&
+		ops->link_enable			&&
+		ops->link_disable			&&
 		ops->mw_count				&&
 		ops->mw_get_range			&&
 		ops->mw_set_trans			&&
 		/* ops->mw_clear_trans			&& */
-		ops->link_is_up				&&
-		ops->link_enable			&&
-		ops->link_disable			&&
+
 		/* ops->db_is_unsafe			&& */
 		ops->db_valid_mask			&&
 
@@ -441,6 +442,62 @@ void ntb_link_event(struct ntb_dev *ntb);
 void ntb_db_event(struct ntb_dev *ntb, int vector);
 
 /**
+ * ntb_link_is_up() - get the current ntb link state
+ * @ntb:	NTB device context.
+ * @speed:	OUT - The link speed expressed as PCIe generation number.
+ * @width:	OUT - The link width expressed as the number of PCIe lanes.
+ *
+ * Get the current state of the ntb link.  It is recommended to query the link
+ * state once after every link event.  It is safe to query the link state in
+ * the context of the link event callback.
+ *
+ * Return: One if the link is up, zero if the link is down, otherwise a
+ *		negative value indicating the error number.
+ */
+static inline int ntb_link_is_up(struct ntb_dev *ntb,
+				 enum ntb_speed *speed, enum ntb_width *width)
+{
+	return ntb->ops->link_is_up(ntb, speed, width);
+}
+
+/**
+ * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ * @max_speed:	The maximum link speed expressed as PCIe generation number.
+ * @max_width:	The maximum link width expressed as the number of PCIe lanes.
+ *
+ * Enable the link on the secondary side of the ntb.  This can only be done
+ * from the primary side of the ntb in primary or b2b topology.  The ntb device
+ * should train the link to its maximum speed and width, or the requested speed
+ * and width, whichever is smaller, if supported.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_enable(struct ntb_dev *ntb,
+				  enum ntb_speed max_speed,
+				  enum ntb_width max_width)
+{
+	return ntb->ops->link_enable(ntb, max_speed, max_width);
+}
+
+/**
+ * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ *
+ * Disable the link on the secondary side of the ntb.  This can only be
+ * done from the primary side of the ntb in primary or b2b topology.  The ntb
+ * device should disable the link.  Returning from this call must indicate that
+ * a barrier has passed, though with no more writes may pass in either
+ * direction across the link, except if this call returns an error number.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_disable(struct ntb_dev *ntb)
+{
+	return ntb->ops->link_disable(ntb);
+}
+
+/**
  * ntb_mw_count() - get the number of memory windows
  * @ntb:	NTB device context.
  *
@@ -517,62 +574,6 @@ static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
 }
 
 /**
- * ntb_link_is_up() - get the current ntb link state
- * @ntb:	NTB device context.
- * @speed:	OUT - The link speed expressed as PCIe generation number.
- * @width:	OUT - The link width expressed as the number of PCIe lanes.
- *
- * Get the current state of the ntb link.  It is recommended to query the link
- * state once after every link event.  It is safe to query the link state in
- * the context of the link event callback.
- *
- * Return: One if the link is up, zero if the link is down, otherwise a
- *		negative value indicating the error number.
- */
-static inline int ntb_link_is_up(struct ntb_dev *ntb,
-				 enum ntb_speed *speed, enum ntb_width *width)
-{
-	return ntb->ops->link_is_up(ntb, speed, width);
-}
-
-/**
- * ntb_link_enable() - enable the link on the secondary side of the ntb
- * @ntb:	NTB device context.
- * @max_speed:	The maximum link speed expressed as PCIe generation number.
- * @max_width:	The maximum link width expressed as the number of PCIe lanes.
- *
- * Enable the link on the secondary side of the ntb.  This can only be done
- * from the primary side of the ntb in primary or b2b topology.  The ntb device
- * should train the link to its maximum speed and width, or the requested speed
- * and width, whichever is smaller, if supported.
- *
- * Return: Zero on success, otherwise an error number.
- */
-static inline int ntb_link_enable(struct ntb_dev *ntb,
-				  enum ntb_speed max_speed,
-				  enum ntb_width max_width)
-{
-	return ntb->ops->link_enable(ntb, max_speed, max_width);
-}
-
-/**
- * ntb_link_disable() - disable the link on the secondary side of the ntb
- * @ntb:	NTB device context.
- *
- * Disable the link on the secondary side of the ntb.  This can only be
- * done from the primary side of the ntb in primary or b2b topology.  The ntb
- * device should disable the link.  Returning from this call must indicate that
- * a barrier has passed, though with no more writes may pass in either
- * direction across the link, except if this call returns an error number.
- *
- * Return: Zero on success, otherwise an error number.
- */
-static inline int ntb_link_disable(struct ntb_dev *ntb)
-{
-	return ntb->ops->link_disable(ntb);
-}
-
-/**
  * ntb_db_is_unsafe() - check if it is safe to use hardware doorbell
  * @ntb:	NTB device context.
  *
-- 
2.6.6

