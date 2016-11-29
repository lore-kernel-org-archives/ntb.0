Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id l130si351933wmf.0.2016.11.29.09.16.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:05 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id p100so13315455lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:05 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 09/22] NTB Intel: Move link-related methods being first in the driver
Date: Tue, 29 Nov 2016 20:16:04 +0300
Message-Id: <1480439777-1080-10-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

See patch 01 for reasoning of this movement.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 162 ++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 7310a26..d3da0ce 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -836,6 +836,84 @@ static void ndev_deinit_debugfs(struct intel_ntb_dev *ndev)
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
@@ -972,84 +1050,6 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
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
@@ -2259,12 +2259,12 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
 
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
-- 
2.6.6

