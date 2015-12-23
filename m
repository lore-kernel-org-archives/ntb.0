Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0096.outbound.protection.outlook.com. [157.56.110.96])
        by gmr-mx.google.com with ESMTPS id z6si3070269ywb.1.2015.12.23.00.44.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 00:44:48 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V2 3/3] NTB: Add flush_req and wakeup interface
Date: Wed, 23 Dec 2015 21:43:24 +0800
Message-ID: <1450878204-9383-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

AMD NTB support two features: flush pending requests and wakeup
opposite side from low power state. This patch add two interface
to support these features.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 40 ++++++++++++++++++++++++++++++++++++++--
 drivers/ntb/hw/amd/ntb_hw_amd.h |  2 ++
 include/linux/ntb.h             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index cedac8d..6ca0191 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -93,6 +93,8 @@ static const struct ntb_dev_ops amd_ntb_ops = {
 	.peer_spad_addr		= amd_ntb_peer_spad_addr,
 	.peer_spad_read		= amd_ntb_peer_spad_read,
 	.peer_spad_write	= amd_ntb_peer_spad_write,
+	.flush_req		= amd_ntb_flush_req,
+	.peer_wakeup		= amd_ntb_wakeup_peer_side,
 };
 
 static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
@@ -489,7 +491,6 @@ static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
 	ndev->peer_sta |= bit;
 }
 
-#ifdef CONFIG_PM
 /*
  * flush the requests to peer side
  */
@@ -513,7 +514,42 @@ static int amd_flush_peer_requests(struct amd_ntb_dev *ndev)
 
 	return 0;
 }
-#endif
+
+static int amd_ntb_flush_req(struct ntb_dev *ntb)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+
+	return amd_flush_peer_requests(ndev);
+}
+
+/*
+ * wake up the peer side
+ */
+static int amd_wakeup_peer_side(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 reg;
+
+	if (!amd_link_is_up(ndev)) {
+		dev_warn(ndev_dev(ndev), "link is down.\n");
+		return -EINVAL;
+	}
+
+	reg = NTB_READ_REG(mmio, PMSGTRIG);
+	reg |= 0x1;
+	NTB_WRITE_REG(mmio, reg, PMSGTRIG);
+
+	wait_for_completion(&ndev->wakeup_cmpl);
+
+	return 0;
+}
+
+static int amd_ntb_wakeup_peer_side(struct ntb_dev *ntb)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+
+	return amd_wakeup_peer_side(ndev);
+}
 
 static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 {
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 6005040..acf1d57 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -260,4 +260,6 @@ static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
 					phys_addr_t *spad_addr);
 static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx);
 static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val);
+static int amd_ntb_flush_req(struct ntb_dev *ntb);
+static int amd_ntb_wakeup_peer_side(struct ntb_dev *ntb);
 #endif
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index f798e2a..ada98be 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -210,6 +210,8 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @peer_spad_addr:	See ntb_peer_spad_addr().
  * @peer_spad_read:	See ntb_peer_spad_read().
  * @peer_spad_write:	See ntb_peer_spad_write().
+ * @flush_req:		See ntb_flush_requests().
+ * @peer_wakeup:	See ntb_wakeup_peer_side().
  */
 struct ntb_dev_ops {
 	int (*mw_count)(struct ntb_dev *ntb);
@@ -259,6 +261,9 @@ struct ntb_dev_ops {
 			      phys_addr_t *spad_addr);
 	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
 	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+
+	int (*flush_req)(struct ntb_dev *ntb);
+	int (*peer_wakeup)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -980,4 +985,34 @@ static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 	return ntb->ops->peer_spad_write(ntb, idx, val);
 }
 
+/**
+ * ntb_flush_requests() - flush all pending requests
+ * @ntb:	NTB device context.
+ *
+ * For some usage, one side of NTB need to first make sure that all previous
+ * requests have been completed and then execute next step such as power down,
+ * or device removed.
+ * NOTE: This function may go to sleep, so can't call it in interrupt context.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_flush_requests(struct ntb_dev *ntb)
+{
+	return ntb->ops->flush_req(ntb);
+}
+
+/**
+ * ntb_wakeup_peer_side() - wakeup peer side of NTB.
+ * @ntb:	NTB device context.
+ *
+ * Provide a mechanism that wakeup opposite side from low power state.
+ * NOTE: This function may go to sleep, so can't call it in interrupt context.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_wakeup_peer_side(struct ntb_dev *ntb)
+{
+	return ntb->ops->peer_wakeup(ntb);
+}
+
 #endif
-- 
1.9.1

