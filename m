Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id i184si358556wmf.1.2016.11.29.09.16.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:02 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id o20so13312739lfg.3
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:02 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 07/22] NTB: Fix a few ntb.h issues
Date: Tue, 29 Nov 2016 20:16:02 +0300
Message-Id: <1480439777-1080-8-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Fix some minor issues found in ntb.h file.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index a59a155..8b19327 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -90,6 +90,7 @@ static inline char *ntb_topo_string(enum ntb_topo topo)
  * @NTB_SPEED_GEN1:	Link is trained to gen1 speed.
  * @NTB_SPEED_GEN2:	Link is trained to gen2 speed.
  * @NTB_SPEED_GEN3:	Link is trained to gen3 speed.
+ * @NTB_SPEED_GEN4:	Link is trained to gen4 speed.
  */
 enum ntb_speed {
 	NTB_SPEED_AUTO = -1,
@@ -97,6 +98,7 @@ enum ntb_speed {
 	NTB_SPEED_GEN1 = 1,
 	NTB_SPEED_GEN2 = 2,
 	NTB_SPEED_GEN3 = 3,
+	NTB_SPEED_GEN4 = 4
 };
 
 /**
@@ -292,13 +294,18 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 {
 	/* commented callbacks are not required: */
 	return
+		/* Port operations are required */
 		ops->port_number			&&
 		ops->peer_port_count			&&
 		ops->peer_port_number			&&
 		ops->peer_port_idx			&&
+
+		/* Link operations are requiered */
 		ops->link_is_up				&&
 		ops->link_enable			&&
 		ops->link_disable			&&
+
+		/* One or both MW interfaces should be developed */
 		ops->mw_count				&&
 		ops->mw_get_align			&&
 		(ops->mw_set_trans			||
@@ -308,12 +315,11 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->peer_mw_get_addr			&&
 		/* ops->peer_mw_clear_trans		&& */
 
+		/* Doorbell operations are mostly required */
 		/* ops->db_is_unsafe			&& */
 		ops->db_valid_mask			&&
-
 		/* both set, or both unset */
 		(!ops->db_vector_count == !ops->db_vector_mask) &&
-
 		ops->db_read				&&
 		/* ops->db_set				&& */
 		ops->db_clear				&&
@@ -327,6 +333,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* ops->peer_db_read_mask		&& */
 		/* ops->peer_db_set_mask		&& */
 		/* ops->peer_db_clear_mask		&& */
+
+		/* Scrachpad or messaging interfaces should be developed */
 		((/* ops->spad_is_unsafe		&& */
 		  ops->spad_count			&&
 		  ops->spad_read			&&
@@ -355,13 +363,12 @@ struct ntb_client {
 	struct device_driver		drv;
 	const struct ntb_client_ops	ops;
 };
-
 #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
 
 /**
  * struct ntb_device - ntb device
  * @dev:		Linux device object.
- * @pdev:		Pci device entry of the ntb.
+ * @pdev:		PCI device entry of the ntb.
  * @topo:		Detected topology of the ntb.
  * @port:		Local port of the ntb.
  * @ops:		See &ntb_dev_ops.
@@ -384,7 +391,6 @@ struct ntb_dev {
 	/* block unregister until device is fully released */
 	struct completion		released;
 };
-
 #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
 
 /**
@@ -481,7 +487,7 @@ void ntb_link_event(struct ntb_dev *ntb);
  * multiple interrupt vectors for doorbells, the vector number indicates which
  * vector received the interrupt.  The vector number is relative to the first
  * vector used for doorbells, starting at zero, and must be less than
- ** ntb_db_vector_count().  The driver may call ntb_db_read() to check which
+ * ntb_db_vector_count().  The driver may call ntb_db_read() to check which
  * doorbell bits need service, and ntb_db_vector_mask() to determine which of
  * those bits are associated with the vector number.
  */
-- 
2.6.6

