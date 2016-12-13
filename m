Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id d199si364313wmd.1.2016.12.13.15.49.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:35 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id o20so216649lfg.3
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:35 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 9/9] NTB: Add ntb.h comments
Date: Wed, 14 Dec 2016 02:49:21 +0300
Message-Id: <1481672961-10753-10-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
 <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/ntb.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 6d46179..dab0a1b 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -326,12 +326,17 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 {
 	/* commented callbacks are not required: */
 	return
+		/* Port operations are required */
 		!ops->peer_port_count == !ops->port_number	&&
 		!ops->peer_port_number == !ops->port_number	&&
 		!ops->peer_port_idx == !ops->port_number	&&
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
@@ -341,12 +346,11 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->peer_mw_get_addr			&&
 		/* ops->peer_mw_clear_trans		&& */
 
+		/* Doorbell operations are mostly required */
 		/* ops->db_is_unsafe			&& */
 		ops->db_valid_mask			&&
-
 		/* both set, or both unset */
-		(!ops->db_vector_count == !ops->db_vector_mask) &&
-
+		(!ops->db_vector_count == !ops->db_vector_mask)	&&
 		ops->db_read				&&
 		/* ops->db_set				&& */
 		ops->db_clear				&&
@@ -360,6 +364,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* ops->peer_db_read_mask		&& */
 		/* ops->peer_db_set_mask		&& */
 		/* ops->peer_db_clear_mask		&& */
+
+		/* Scrachpads interface is optional */
 		/* !ops->spad_is_unsafe == !ops->spad_count	&& */
 		!ops->spad_read == !ops->spad_count		&&
 		!ops->spad_write == !ops->spad_count		&&
@@ -367,6 +373,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->peer_spad_read == !ops->spad_count	&& */
 		!ops->peer_spad_write == !ops->spad_count 	&&
 
+		/* Messaging interface is optional */
 		!ops->msg_inbits == !ops->msg_count		&&
 		!ops->msg_outbits == !ops->msg_count		&&
 		!ops->msg_read_sts == !ops->msg_count		&&
@@ -387,13 +394,12 @@ struct ntb_client {
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
  * @ops:		See &ntb_dev_ops.
  * @ctx:		See &ntb_ctx_ops.
@@ -414,7 +420,6 @@ struct ntb_dev {
 	/* block unregister until device is fully released */
 	struct completion		released;
 };
-
 #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
 
 /**
@@ -511,7 +516,7 @@ void ntb_link_event(struct ntb_dev *ntb);
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

