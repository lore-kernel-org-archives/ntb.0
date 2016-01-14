Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0092.outbound.protection.outlook.com. [65.55.169.92])
        by gmr-mx.google.com with ESMTPS id k15si1760168igt.3.2016.01.13.22.46.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 22:46:04 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V3 2/2] NTB: Add support for flush request interface
Date: Thu, 14 Jan 2016 19:44:21 +0800
Message-ID: <1452771861-16990-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

AMD NTB support flush pending requests feature in some cases,
like as device remove or suspend.

This patch add one interface to support the feature. When flushing
request, AMD LLD driver use similar method of SATA or block device
to waiting for completion of flush event.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/amd/ntb_hw_amd.h |  3 +++
 include/linux/ntb.h             | 22 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 8df6d7b..344fbcd 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -93,6 +93,7 @@ static const struct ntb_dev_ops amd_ntb_ops = {
 	.peer_spad_addr		= amd_ntb_peer_spad_addr,
 	.peer_spad_read		= amd_ntb_peer_spad_read,
 	.peer_spad_write	= amd_ntb_peer_spad_write,
+	.flush_req		= amd_ntb_flush_req,
 };
 
 static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
@@ -492,6 +493,37 @@ static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
 	ndev->peer_sta |= bit;
 }
 
+/*
+ * flush the requests to peer side
+ */
+static int amd_flush_peer_requests(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 reg;
+
+	if (!amd_link_is_up(ndev)) {
+		dev_err(ndev_dev(ndev), "link is down.\n");
+		return -EINVAL;
+	}
+
+	reg = readl(mmio + AMD_FLUSHTRIG_OFFSET);
+	reg |= 0x1;
+	writel(reg, mmio + AMD_FLUSHTRIG_OFFSET);
+
+	wait_for_completion(&ndev->flush_cmpl);
+
+	reinit_completion(&ndev->flush_cmpl);
+
+	return 0;
+}
+
+static int amd_ntb_flush_req(struct ntb_dev *ntb)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+
+	return amd_flush_peer_requests(ndev);
+}
+
 static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 {
 	void __iomem *mmio = ndev->self_mmio;
@@ -506,7 +538,8 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	status &= AMD_EVENT_INTMASK;
 	switch (status) {
 	case AMD_PEER_FLUSH_EVENT:
-		dev_info(ndev_dev(ndev), "Flush is done.\n");
+		dev_dbg(ndev_dev(ndev), "Flush is done.\n");
+		complete(&ndev->flush_cmpl);
 		break;
 	case AMD_PEER_RESET_EVENT:
 		amd_ack_SMU(ndev, AMD_PEER_RESET_EVENT);
@@ -832,6 +865,7 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 	ndev->ntb.topo = NTB_TOPO_NONE;
 	ndev->ntb.ops = &amd_ntb_ops;
 	ndev->int_mask = AMD_EVENT_INTMASK;
+	init_completion(&ndev->flush_cmpl);
 	spin_lock_init(&ndev->db_mask_lock);
 }
 
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 31021c0..1054299 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -200,6 +200,8 @@ struct amd_ntb_dev {
 	unsigned int self_spad;
 	unsigned int peer_spad;
 
+	struct completion flush_cmpl;
+
 	struct delayed_work hb_timer;
 
 	struct dentry *debugfs_dir;
@@ -243,4 +245,5 @@ static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
 					phys_addr_t *spad_addr);
 static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx);
 static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val);
+static int amd_ntb_flush_req(struct ntb_dev *ntb);
 #endif
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index f798e2a..6d443f4 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -210,6 +210,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @peer_spad_addr:	See ntb_peer_spad_addr().
  * @peer_spad_read:	See ntb_peer_spad_read().
  * @peer_spad_write:	See ntb_peer_spad_write().
+ * @flush_req:		See ntb_flush_request().
  */
 struct ntb_dev_ops {
 	int (*mw_count)(struct ntb_dev *ntb);
@@ -259,6 +260,8 @@ struct ntb_dev_ops {
 			      phys_addr_t *spad_addr);
 	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
 	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+
+	int (*flush_req)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -980,4 +983,23 @@ static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
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
+	if (!ntb->ops->flush_req)
+		return 0;
+
+	return ntb->ops->flush_req(ntb);
+}
+
 #endif
-- 
1.9.1

