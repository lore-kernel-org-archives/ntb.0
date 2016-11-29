Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id l19si533447wmg.0.2016.11.29.09.16.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:10 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id p100so13315559lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:10 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 14/22] NTB AMD: Move link-related methods being first in the driver
Date: Tue, 29 Nov 2016 20:16:09 +0300
Message-Id: <1480439777-1080-15-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

See patch 01 for reasoning of this movement.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 188 ++++++++++++++++++++--------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

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
-- 
2.6.6

