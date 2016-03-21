Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id k13si1916590ywe.1.2016.03.21.06.51.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 06:51:27 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 1/2] NTB: Make _addr functions optional in the API
Date: Mon, 21 Mar 2016 04:53:13 -0400
Message-Id: <17b414e0af3e8caf31b3b3aa5dddb842ef397c1a.1458550127.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

The functions ntb_peer_db_addr and ntb_peer_spad_addr were required by
the api.  The functions already support returning an error, so any
existing calling code should already check for it.  Any existing code
using drivers that implement the functions will not be affected.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 include/linux/ntb.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index f798e2afba88..6f47562d477b 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -284,7 +284,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* ops->db_read_mask			&& */
 		ops->db_set_mask			&&
 		ops->db_clear_mask			&&
-		ops->peer_db_addr			&&
+		/* ops->peer_db_addr			&& */
 		/* ops->peer_db_read			&& */
 		ops->peer_db_set			&&
 		/* ops->peer_db_clear			&& */
@@ -295,7 +295,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->spad_count				&&
 		ops->spad_read				&&
 		ops->spad_write				&&
-		ops->peer_spad_addr			&&
+		/* ops->peer_spad_addr			&& */
 		/* ops->peer_spad_read			&& */
 		ops->peer_spad_write			&&
 		1;
@@ -757,6 +757,9 @@ static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
 				   phys_addr_t *db_addr,
 				   resource_size_t *db_size)
 {
+	if (!ntb->ops->peer_db_addr)
+		return -EINVAL;
+
 	return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
 }
 
@@ -948,6 +951,9 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
 				     phys_addr_t *spad_addr)
 {
+	if (!ntb->ops->peer_spad_addr)
+		return -EINVAL;
+
 	return ntb->ops->peer_spad_addr(ntb, idx, spad_addr);
 }
 
-- 
2.7.0

