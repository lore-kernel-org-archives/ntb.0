Return-Path: <fancer.lancer@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id d199si2744655wmd.1.2016.12.12.13.09.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 13:09:11 -0800 (PST)
Received: by mail-wm0-x241.google.com with SMTP id a20so13900631wme.2
        for <linux-ntb@googlegroups.com>; Mon, 12 Dec 2016 13:09:11 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 1/9] NTB: Make link-state API being declared first
Date: Tue, 13 Dec 2016 00:08:14 +0300
Message-Id: <1481576902-21091-2-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
 <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
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
 drivers/ntb/hw/amd/ntb_hw_amd.c     | 188 ++++++++++++++++++------------------
 drivers/ntb/hw/intel/ntb_hw_intel.c | 168 ++++++++++++++++----------------
 include/linux/ntb.h                 | 137 +++++++++++++-------------
 3 files changed, 247 insertions(+), 246 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 6ccba0d..6704327 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -71,6 +71,97 @@ MODULE_AUTHOR("AMD Inc.");
 static const struct file_operations amd_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
 
+static int amd_link_is_up(struct amd_ntb_dev *ndev)
+{
+	if (!ndev->peer_sta)
+		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
+
+	/* If peer_sta is reset or D0 event, the ISR has
+	 * started a timer to check link status of hardware.
+	 * So here just clear status bit. And if peer_sta is
+	 * D3 or PME_TO, D0/reset event will be happened when
+	 * system wakeup/poweron, so do nothing here.
+	 */
+	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
+		ndev->peer_sta &= ~AMD_PEER_RESET_EVENT;
+	else if (ndev->peer_sta & AMD_PEER_D0_EVENT)
+		ndev->peer_sta = 0;
+
+	return 0;
+}
+
+static int amd_ntb_link_is_up(struct ntb_dev *ntb,
+			      enum ntb_speed *speed,
+			      enum ntb_width *width)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	int ret = 0;
+
+	if (amd_link_is_up(ndev)) {
+		if (speed)
+			*speed = NTB_LNK_STA_SPEED(ndev->lnk_sta);
+		if (width)
+			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
+
+		dev_dbg(ndev_dev(ndev), "link is up.\n");
+
+		ret = 1;
+	} else {
+		if (speed)
+			*speed = NTB_SPEED_NONE;
+		if (width)
+			*width = NTB_WIDTH_NONE;
+
+		dev_dbg(ndev_dev(ndev), "link is down.\n");
+	}
+
+	return ret;
+}
+
+static int amd_ntb_link_enable(struct ntb_dev *ntb,
+			       enum ntb_speed max_speed,
+			       enum ntb_width max_width)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	/* Enable event interrupt */
+	ndev->int_mask &= ~AMD_EVENT_INTMASK;
+	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
+	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
+
+	return 0;
+}
+
+static int amd_ntb_link_disable(struct ntb_dev *ntb)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	/* Disable event interrupt */
+	ndev->int_mask |= AMD_EVENT_INTMASK;
+	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
+	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
+
+	return 0;
+}
+
 static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
 {
 	if (idx < 0 || idx > ndev->mw_count)
@@ -194,97 +285,6 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
-static int amd_link_is_up(struct amd_ntb_dev *ndev)
-{
-	if (!ndev->peer_sta)
-		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
-
-	/* If peer_sta is reset or D0 event, the ISR has
-	 * started a timer to check link status of hardware.
-	 * So here just clear status bit. And if peer_sta is
-	 * D3 or PME_TO, D0/reset event will be happened when
-	 * system wakeup/poweron, so do nothing here.
-	 */
-	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
-		ndev->peer_sta &= ~AMD_PEER_RESET_EVENT;
-	else if (ndev->peer_sta & AMD_PEER_D0_EVENT)
-		ndev->peer_sta = 0;
-
-	return 0;
-}
-
-static int amd_ntb_link_is_up(struct ntb_dev *ntb,
-			      enum ntb_speed *speed,
-			      enum ntb_width *width)
-{
-	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
-	int ret = 0;
-
-	if (amd_link_is_up(ndev)) {
-		if (speed)
-			*speed = NTB_LNK_STA_SPEED(ndev->lnk_sta);
-		if (width)
-			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
-
-		dev_dbg(ndev_dev(ndev), "link is up.\n");
-
-		ret = 1;
-	} else {
-		if (speed)
-			*speed = NTB_SPEED_NONE;
-		if (width)
-			*width = NTB_WIDTH_NONE;
-
-		dev_dbg(ndev_dev(ndev), "link is down.\n");
-	}
-
-	return ret;
-}
-
-static int amd_ntb_link_enable(struct ntb_dev *ntb,
-			       enum ntb_speed max_speed,
-			       enum ntb_width max_width)
-{
-	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
-	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
-
-	/* Enable event interrupt */
-	ndev->int_mask &= ~AMD_EVENT_INTMASK;
-	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
-
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
-		return -EINVAL;
-	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
-
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
-	return 0;
-}
-
-static int amd_ntb_link_disable(struct ntb_dev *ntb)
-{
-	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
-	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
-
-	/* Disable event interrupt */
-	ndev->int_mask |= AMD_EVENT_INTMASK;
-	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
-
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
-		return -EINVAL;
-	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
-
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
-	return 0;
-}
-
 static u64 amd_ntb_db_valid_mask(struct ntb_dev *ntb)
 {
 	return ntb_ndev(ntb)->db_valid_mask;
@@ -431,12 +431,12 @@ static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
 }
 
 static const struct ntb_dev_ops amd_ntb_ops = {
-	.mw_count		= amd_ntb_mw_count,
-	.mw_get_range		= amd_ntb_mw_get_range,
-	.mw_set_trans		= amd_ntb_mw_set_trans,
 	.link_is_up		= amd_ntb_link_is_up,
 	.link_enable		= amd_ntb_link_enable,
 	.link_disable		= amd_ntb_link_disable,
+	.mw_count		= amd_ntb_mw_count,
+	.mw_get_range		= amd_ntb_mw_get_range,
+	.mw_set_trans		= amd_ntb_mw_set_trans,
 	.db_valid_mask		= amd_ntb_db_valid_mask,
 	.db_vector_count	= amd_ntb_db_vector_count,
 	.db_vector_mask		= amd_ntb_db_vector_mask,
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index d2ce280..68d9908 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1035,6 +1035,84 @@ static void ndev_deinit_debugfs(struct intel_ntb_dev *ndev)
 	debugfs_remove_recursive(ndev->debugfs_dir);
 }
 
+static int intel_ntb_link_is_up(struct ntb_dev *ntb,
+				enum ntb_speed *speed,
+				enum ntb_width *width)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+
+	if (ndev->reg->link_is_up(ndev)) {
+		if (speed)
+			*speed = NTB_LNK_STA_SPEED(ndev->lnk_sta);
+		if (width)
+			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
+		return 1;
+	} else {
+		/* TODO MAYBE: is it possible to observe the link speed and
+		 * width while link is training? */
+		if (speed)
+			*speed = NTB_SPEED_NONE;
+		if (width)
+			*width = NTB_WIDTH_NONE;
+		return 0;
+	}
+}
+
+static int intel_ntb_link_enable(struct ntb_dev *ntb,
+				 enum ntb_speed max_speed,
+				 enum ntb_width max_width)
+{
+	struct intel_ntb_dev *ndev;
+	u32 ntb_ctl;
+
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
+
+	dev_dbg(ndev_dev(ndev),
+		"Enabling link with max_speed %d max_width %d\n",
+		max_speed, max_width);
+	if (max_speed != NTB_SPEED_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
+	if (max_width != NTB_WIDTH_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
+
+	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
+	ntb_ctl |= NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP;
+	ntb_ctl |= NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP;
+	if (ndev->bar4_split)
+		ntb_ctl |= NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP;
+	iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
+
+	return 0;
+}
+
+static int intel_ntb_link_disable(struct ntb_dev *ntb)
+{
+	struct intel_ntb_dev *ndev;
+	u32 ntb_cntl;
+
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
+
+	dev_dbg(ndev_dev(ndev), "Disabling link\n");
+
+	/* Bring NTB link down */
+	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+	ntb_cntl &= ~(NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP);
+	ntb_cntl &= ~(NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP);
+	if (ndev->bar4_split)
+		ntb_cntl &= ~(NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP);
+	ntb_cntl |= NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK;
+	iowrite32(ntb_cntl, ndev->self_mmio + ndev->reg->ntb_ctl);
+
+	return 0;
+}
+
 static int intel_ntb_mw_count(struct ntb_dev *ntb)
 {
 	return ntb_ndev(ntb)->mw_count;
@@ -1171,84 +1249,6 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
-static int intel_ntb_link_is_up(struct ntb_dev *ntb,
-				enum ntb_speed *speed,
-				enum ntb_width *width)
-{
-	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
-
-	if (ndev->reg->link_is_up(ndev)) {
-		if (speed)
-			*speed = NTB_LNK_STA_SPEED(ndev->lnk_sta);
-		if (width)
-			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
-		return 1;
-	} else {
-		/* TODO MAYBE: is it possible to observe the link speed and
-		 * width while link is training? */
-		if (speed)
-			*speed = NTB_SPEED_NONE;
-		if (width)
-			*width = NTB_WIDTH_NONE;
-		return 0;
-	}
-}
-
-static int intel_ntb_link_enable(struct ntb_dev *ntb,
-				 enum ntb_speed max_speed,
-				 enum ntb_width max_width)
-{
-	struct intel_ntb_dev *ndev;
-	u32 ntb_ctl;
-
-	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
-
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
-		return -EINVAL;
-
-	dev_dbg(ndev_dev(ndev),
-		"Enabling link with max_speed %d max_width %d\n",
-		max_speed, max_width);
-	if (max_speed != NTB_SPEED_AUTO)
-		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
-	if (max_width != NTB_WIDTH_AUTO)
-		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
-
-	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
-	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
-	ntb_ctl |= NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP;
-	ntb_ctl |= NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP;
-	if (ndev->bar4_split)
-		ntb_ctl |= NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP;
-	iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
-
-	return 0;
-}
-
-static int intel_ntb_link_disable(struct ntb_dev *ntb)
-{
-	struct intel_ntb_dev *ndev;
-	u32 ntb_cntl;
-
-	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
-
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
-		return -EINVAL;
-
-	dev_dbg(ndev_dev(ndev), "Disabling link\n");
-
-	/* Bring NTB link down */
-	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
-	ntb_cntl &= ~(NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP);
-	ntb_cntl &= ~(NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP);
-	if (ndev->bar4_split)
-		ntb_cntl &= ~(NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP);
-	ntb_cntl |= NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK;
-	iowrite32(ntb_cntl, ndev->self_mmio + ndev->reg->ntb_ctl);
-
-	return 0;
-}
-
 static int intel_ntb_db_is_unsafe(struct ntb_dev *ntb)
 {
 	return ndev_ignore_unsafe(ntb_ndev(ntb), NTB_UNSAFE_DB);
@@ -2883,12 +2883,12 @@ static const struct intel_ntb_xlat_reg skx_sec_xlat = {
 
 /* operations for primary side of local ntb */
 static const struct ntb_dev_ops intel_ntb_ops = {
-	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
-	.mw_set_trans		= intel_ntb_mw_set_trans,
 	.link_is_up		= intel_ntb_link_is_up,
 	.link_enable		= intel_ntb_link_enable,
 	.link_disable		= intel_ntb_link_disable,
+	.mw_count		= intel_ntb_mw_count,
+	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_set_trans		= intel_ntb_mw_set_trans,
 	.db_is_unsafe		= intel_ntb_db_is_unsafe,
 	.db_valid_mask		= intel_ntb_db_valid_mask,
 	.db_vector_count	= intel_ntb_db_vector_count,
@@ -2909,12 +2909,12 @@ static const struct ntb_dev_ops intel_ntb_ops = {
 };
 
 static const struct ntb_dev_ops intel_ntb3_ops = {
-	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
-	.mw_set_trans		= intel_ntb3_mw_set_trans,
 	.link_is_up		= intel_ntb_link_is_up,
 	.link_enable		= intel_ntb3_link_enable,
 	.link_disable		= intel_ntb_link_disable,
+	.mw_count		= intel_ntb_mw_count,
+	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_set_trans		= intel_ntb3_mw_set_trans,
 	.db_valid_mask		= intel_ntb_db_valid_mask,
 	.db_vector_count	= intel_ntb_db_vector_count,
 	.db_vector_mask		= intel_ntb_db_vector_mask,
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

