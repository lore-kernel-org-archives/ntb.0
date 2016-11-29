Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id l19si533436wmg.0.2016.11.29.09.16.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:11 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id p100so13315551lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:11 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 15/22] NTB AMD: Add port-related NTB API callback methods
Date: Tue, 29 Nov 2016 20:16:10 +0300
Message-Id: <1480439777-1080-16-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 72 ++++++++++++++++++++++++++++++-----------
 drivers/ntb/hw/amd/ntb_hw_amd.h | 10 ++++++
 2 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 6704327..b7c9f67 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -71,6 +71,33 @@ MODULE_AUTHOR("AMD Inc.");
 static const struct file_operations amd_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
 
+static int amd_ntb_port_number(struct ntb_dev *ntb)
+{
+	return ntb->port;
+}
+
+static int amd_ntb_peer_port_count(struct ntb_dev *ntb)
+{
+	return NTB_PEER_CNT;
+}
+
+static int amd_ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
+{
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
+	return (ntb->port == NTB_PORT_PRI ? NTB_PORT_SEC : NTB_PORT_PRI);
+}
+
+static int amd_ntb_peer_port_idx(struct ntb_dev *ntb, int port)
+{
+	if ((ntb->port == NTB_PORT_PRI && port != NTB_PORT_SEC) ||
+	    (ntb->port == NTB_PORT_SEC && port != NTB_PORT_PRI))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
 	if (!ndev->peer_sta)
@@ -90,7 +117,7 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
 	return 0;
 }
 
-static int amd_ntb_link_is_up(struct ntb_dev *ntb,
+static u64 amd_ntb_link_is_up(struct ntb_dev *ntb,
 			      enum ntb_speed *speed,
 			      enum ntb_width *width)
 {
@@ -130,7 +157,7 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 	ndev->int_mask &= ~AMD_EVENT_INTMASK;
 	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
+	if (ndev->ntb.port == NTB_PORT_SEC)
 		return -EINVAL;
 	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
 
@@ -151,7 +178,7 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 	ndev->int_mask |= AMD_EVENT_INTMASK;
 	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
+	if (ndev->ntb.port == NTB_PORT_SEC)
 		return -EINVAL;
 	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
 
@@ -431,6 +458,10 @@ static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
 }
 
 static const struct ntb_dev_ops amd_ntb_ops = {
+	.port_number		= amd_ntb_port_number,
+	.peer_port_count	= amd_ntb_peer_port_count,
+	.peer_port_number	= amd_ntb_peer_port_number,
+	.peer_port_idx		= amd_ntb_peer_port_idx,
 	.link_is_up		= amd_ntb_link_is_up,
 	.link_enable		= amd_ntb_link_enable,
 	.link_disable		= amd_ntb_link_disable,
@@ -697,8 +728,8 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 			 "NTB Device Information:\n");
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Connection Topology -\t%s\n",
-			 ntb_topo_string(ndev->ntb.topo));
+			 "Connection Topology -\t%s:%d\n",
+			 ntb_topo_string(ndev->ntb.topo), ndev->ntb.port);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "LNK STA -\t\t%#06x\n", ndev->lnk_sta);
@@ -797,6 +828,7 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 {
 	ndev->ntb.pdev = pdev;
 	ndev->ntb.topo = NTB_TOPO_NONE;
+	ndev->ntb.port = NTB_PORT_NONE;
 	ndev->ntb.ops = &amd_ntb_ops;
 	ndev->int_mask = AMD_EVENT_INTMASK;
 	spin_lock_init(&ndev->db_mask_lock);
@@ -876,23 +908,23 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 	ndev->spad_count = AMD_SPADS_CNT;
 	ndev->db_count = AMD_DB_CNT;
 
-	switch (ndev->ntb.topo) {
-	case NTB_TOPO_PRI:
-	case NTB_TOPO_SEC:
+	if (ndev->ntb.topo == NTB_TOPO_P2P) {
 		ndev->spad_count >>= 1;
-		if (ndev->ntb.topo == NTB_TOPO_PRI) {
+		if (ndev->ntb.port == NTB_PORT_PRI) {
 			ndev->self_spad = 0;
 			ndev->peer_spad = 0x20;
-		} else {
+		} else if (ndev->ntb.port == NTB_PORT_SEC) {
 			ndev->self_spad = 0x20;
 			ndev->peer_spad = 0;
+		} else {
+			dev_err(ndev_dev(ndev), "Invalid topology port %d.\n",
+				ndev->ntb.port);
+			return -EINVAL;
 		}
 
 		INIT_DELAYED_WORK(&ndev->hb_timer, amd_link_hb);
 		schedule_delayed_work(&ndev->hb_timer, AMD_LINK_HB_TIMEOUT);
-
-		break;
-	default:
+	} else {
 		dev_err(ndev_dev(ndev), "AMD NTB does not support B2B mode.\n");
 		return -EINVAL;
 	}
@@ -905,16 +937,18 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 	return 0;
 }
 
-static enum ntb_topo amd_get_topo(struct amd_ntb_dev *ndev)
+static void amd_init_topo(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->self_mmio;
 	u32 info;
 
+	ndev->ntb.topo = NTB_TOPO_P2P;
+
 	info = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (info & AMD_SIDE_MASK)
-		return NTB_TOPO_SEC;
+		ndev->ntb.port = NTB_PORT_SEC;
 	else
-		return NTB_TOPO_PRI;
+		ndev->ntb.port = NTB_PORT_PRI;
 }
 
 static int amd_init_dev(struct amd_ntb_dev *ndev)
@@ -924,9 +958,9 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 
 	pdev = ndev_pdev(ndev);
 
-	ndev->ntb.topo = amd_get_topo(ndev);
-	dev_dbg(ndev_dev(ndev), "AMD NTB topo is %s\n",
-		ntb_topo_string(ndev->ntb.topo));
+	amd_init_topo(ndev);
+	dev_dbg(ndev_dev(ndev), "AMD NTB topo is %s:%d\n",
+		ntb_topo_string(ndev->ntb.topo), ndev->ntb.port);
 
 	rc = amd_init_ntb(ndev);
 	if (rc)
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 2eac3cd..993e053 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -62,6 +62,10 @@
 #define NTB_LNK_STA_SPEED(x)	(((x) & NTB_LNK_STA_SPEED_MASK) >> 16)
 #define NTB_LNK_STA_WIDTH(x)	(((x) & NTB_LNK_STA_WIDTH_MASK) >> 20)
 
+/* port related constants */
+#define NTB_PEER_CNT			(1)
+#define NTB_PIDX_MAX			(0)
+
 #ifndef read64
 #ifdef readq
 #define read64 readq
@@ -167,6 +171,12 @@ enum {
 	AMD_PEER_OFFSET		= 0x400,
 };
 
+enum amd_ntb_port {
+	NTB_PORT_NONE = -1,
+	NTB_PORT_PRI,
+	NTB_PORT_SEC
+};
+
 struct amd_ntb_dev;
 
 struct amd_ntb_vec {
-- 
2.6.6

