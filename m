Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id d6si501216wmd.0.2016.11.29.09.16.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:06 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id p100so13315579lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:06 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 10/22] NTB Intel: Add port-related NTB API callback methods
Date: Tue, 29 Nov 2016 20:16:05 +0300
Message-Id: <1480439777-1080-11-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 195 +++++++++++++++++++++---------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  10 ++
 2 files changed, 124 insertions(+), 81 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index d3da0ce..724ccfe 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -213,7 +213,7 @@ static inline void ndev_reset_unsafe_flags(struct intel_ntb_dev *ndev)
 
 	/* Only B2B has a workaround to avoid SDOORBELL */
 	if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP)
-		if (!ntb_topo_is_b2b(ndev->ntb.topo))
+		if (ndev->ntb.topo != NTB_TOPO_B2B)
 			ndev->unsafe_flags |= NTB_UNSAFE_DB;
 
 	/* No low level workaround to avoid SB01BASE */
@@ -574,8 +574,8 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 			 "NTB Device Information:\n");
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Connection Topology -\t%s\n",
-			 ntb_topo_string(ndev->ntb.topo));
+			 "Connection Topology -\t%s:%d\n",
+			 ntb_topo_string(ndev->ntb.topo), ndev->ntb.port);
 
 	if (ndev->b2b_idx != UINT_MAX) {
 		off += scnprintf(buf + off, buf_size - off,
@@ -707,7 +707,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	}
 
 	if (pdev_is_xeon(pdev)) {
-		if (ntb_topo_is_b2b(ndev->ntb.topo)) {
+		if (ndev->ntb.topo == NTB_TOPO_B2B) {
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Outgoing B2B XLAT:\n");
 
@@ -836,7 +836,34 @@ static void ndev_deinit_debugfs(struct intel_ntb_dev *ndev)
 	debugfs_remove_recursive(ndev->debugfs_dir);
 }
 
-static int intel_ntb_link_is_up(struct ntb_dev *ntb,
+static int intel_ntb_port_number(struct ntb_dev *ntb)
+{
+	return ntb->port;
+}
+
+static int intel_ntb_peer_port_count(struct ntb_dev *ntb)
+{
+	return NTB_PEER_CNT;
+}
+
+static int intel_ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
+{
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
+	return (ntb->port == NTB_PORT_PRI ? NTB_PORT_SEC : NTB_PORT_PRI);
+}
+
+static int intel_ntb_peer_port_idx(struct ntb_dev *ntb, int port)
+{
+	if ((ntb->port == NTB_PORT_PRI && port != NTB_PORT_SEC) ||
+	    (ntb->port == NTB_PORT_SEC && port != NTB_PORT_PRI))
+		return -EINVAL;
+
+	return 0;
+}
+
+static u64 intel_ntb_link_is_up(struct ntb_dev *ntb,
 				enum ntb_speed *speed,
 				enum ntb_width *width)
 {
@@ -868,7 +895,7 @@ static int intel_ntb_link_enable(struct ntb_dev *ntb,
 
 	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
+	if (ndev->ntb.topo == NTB_TOPO_P2P && ndev->ntb.port == NTB_PORT_SEC)
 		return -EINVAL;
 
 	dev_dbg(ndev_dev(ndev),
@@ -897,7 +924,7 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
 
 	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
+	if (ndev->ntb.topo == NTB_TOPO_P2P && ndev->ntb.port == NTB_PORT_SEC)
 		return -EINVAL;
 
 	dev_dbg(ndev_dev(ndev), "Disabling link\n");
@@ -1241,27 +1268,32 @@ static int atom_link_is_err(struct intel_ntb_dev *ndev)
 	return 0;
 }
 
-static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
+static inline int atom_ppd_init_topo(struct intel_ntb_dev *ndev, u32 ppd)
 {
 	switch (ppd & ATOM_PPD_TOPO_MASK) {
 	case ATOM_PPD_TOPO_B2B_USD:
 		dev_dbg(ndev_dev(ndev), "PPD %d B2B USD\n", ppd);
-		return NTB_TOPO_B2B_USD;
-
+		ndev->ntb.topo = NTB_TOPO_B2B;
+		ndev->ntb.port = NTB_PORT_PRI;
+		return 0;
 	case ATOM_PPD_TOPO_B2B_DSD:
 		dev_dbg(ndev_dev(ndev), "PPD %d B2B DSD\n", ppd);
-		return NTB_TOPO_B2B_DSD;
+		ndev->ntb.topo = NTB_TOPO_B2B;
+		ndev->ntb.port = NTB_PORT_SEC;
+		return 0;
 
 	case ATOM_PPD_TOPO_PRI_USD:
 	case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
 	case ATOM_PPD_TOPO_SEC_USD:
 	case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
-		dev_dbg(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
-		return NTB_TOPO_NONE;
+		dev_err(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
+		ndev->ntb.topo = NTB_TOPO_NONE;
+		ndev->ntb.port = NTB_PORT_NONE;
+		return -EINVAL;
 	}
 
-	dev_dbg(ndev_dev(ndev), "PPD %d invalid\n", ppd);
-	return NTB_TOPO_NONE;
+	dev_err(ndev_dev(ndev), "PPD %d invalid\n", ppd);
+	return -EINVAL;
 }
 
 static void atom_link_hb(struct work_struct *work)
@@ -1369,9 +1401,7 @@ static int atom_init_ntb(struct intel_ntb_dev *ndev)
 	ndev->spad_count = ATOM_SPAD_COUNT;
 	ndev->db_count = ATOM_DB_COUNT;
 
-	switch (ndev->ntb.topo) {
-	case NTB_TOPO_B2B_USD:
-	case NTB_TOPO_B2B_DSD:
+	if (ndev->ntb.topo == NTB_TOPO_B2B) {
 		ndev->self_reg = &atom_pri_reg;
 		ndev->peer_reg = &atom_b2b_reg;
 		ndev->xlat_reg = &atom_sec_xlat;
@@ -1379,12 +1409,8 @@ static int atom_init_ntb(struct intel_ntb_dev *ndev)
 		/* Enable Bus Master and Memory Space on the secondary side */
 		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
 			  ndev->self_mmio + ATOM_SPCICMD_OFFSET);
-
-		break;
-
-	default:
+	} else
 		return -EINVAL;
-	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
@@ -1400,9 +1426,9 @@ static int atom_init_dev(struct intel_ntb_dev *ndev)
 	if (rc)
 		return -EIO;
 
-	ndev->ntb.topo = atom_ppd_topo(ndev, ppd);
-	if (ndev->ntb.topo == NTB_TOPO_NONE)
-		return -EINVAL;
+	rc = atom_ppd_init_topo(ndev, ppd);
+	if (rc)
+		return rc;
 
 	rc = atom_init_ntb(ndev);
 	if (rc)
@@ -1412,7 +1438,7 @@ static int atom_init_dev(struct intel_ntb_dev *ndev)
 	if (rc)
 		return rc;
 
-	if (ndev->ntb.topo != NTB_TOPO_SEC) {
+	if (ndev->ntb.port != NTB_PORT_SEC) {
 		/* Initiate PCI-E link training */
 		rc = pci_write_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET,
 					    ppd | ATOM_PPD_INIT_LINK);
@@ -1464,31 +1490,37 @@ static int xeon_poll_link(struct intel_ntb_dev *ndev)
 
 static int xeon_link_is_up(struct intel_ntb_dev *ndev)
 {
-	if (ndev->ntb.topo == NTB_TOPO_SEC)
+	if (ndev->ntb.port == NTB_PORT_SEC)
 		return 1;
 
 	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
 }
 
-static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
+static inline int xeon_ppd_init_topo(struct intel_ntb_dev *ndev, u8 ppd)
 {
 	switch (ppd & XEON_PPD_TOPO_MASK) {
 	case XEON_PPD_TOPO_B2B_USD:
-		return NTB_TOPO_B2B_USD;
-
+		ndev->ntb.topo = NTB_TOPO_B2B;
+		ndev->ntb.port = NTB_PORT_PRI;
+		return 0;
 	case XEON_PPD_TOPO_B2B_DSD:
-		return NTB_TOPO_B2B_DSD;
-
+		ndev->ntb.topo = NTB_TOPO_B2B;
+		ndev->ntb.port = NTB_PORT_SEC;
+		return 0;
 	case XEON_PPD_TOPO_PRI_USD:
 	case XEON_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
-		return NTB_TOPO_PRI;
-
+		ndev->ntb.topo = NTB_TOPO_P2P;
+		ndev->ntb.port = NTB_PORT_PRI;
+		return 0;
 	case XEON_PPD_TOPO_SEC_USD:
 	case XEON_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
-		return NTB_TOPO_SEC;
+		ndev->ntb.topo = NTB_TOPO_P2P;
+		ndev->ntb.port = NTB_PORT_SEC;
+		return 0;
 	}
 
-	return NTB_TOPO_NONE;
+	dev_err(ndev_dev(ndev), "PPD %d invalid\n", ppd);
+	return -EINVAL;
 }
 
 static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
@@ -1776,39 +1808,39 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 	ndev->db_count = XEON_DB_COUNT;
 	ndev->db_link_mask = XEON_DB_LINK_BIT;
 
-	switch (ndev->ntb.topo) {
-	case NTB_TOPO_PRI:
-		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
-			return -EINVAL;
-		}
-
-		/* enable link to allow secondary side device to appear */
-		ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
-		ntb_ctl &= ~NTB_CTL_DISABLE;
-		iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
-
-		/* use half the spads for the peer */
-		ndev->spad_count >>= 1;
-		ndev->self_reg = &xeon_pri_reg;
-		ndev->peer_reg = &xeon_sec_reg;
-		ndev->xlat_reg = &xeon_sec_xlat;
-		break;
+	if (ndev->ntb.topo == NTB_TOPO_P2P) {
+		if (ndev->ntb.port == NTB_PORT_PRI) {
+			if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
+				dev_err(ndev_dev(ndev),
+					"NTB Primary config disabled\n");
+				return -EINVAL;
+			}
 
-	case NTB_TOPO_SEC:
-		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			dev_err(ndev_dev(ndev), "NTB Secondary config disabled\n");
-			return -EINVAL;
+			/* enable link to allow secondary side dev to appear */
+			ntb_ctl = ioread32(ndev->self_mmio +
+					   ndev->reg->ntb_ctl);
+			ntb_ctl &= ~NTB_CTL_DISABLE;
+			iowrite32(ntb_ctl, ndev->self_mmio +
+				  ndev->reg->ntb_ctl);
+
+			/* use half the spads for the peer */
+			ndev->spad_count >>= 1;
+			ndev->self_reg = &xeon_pri_reg;
+			ndev->peer_reg = &xeon_sec_reg;
+			ndev->xlat_reg = &xeon_sec_xlat;
+		} else {
+			if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
+				dev_err(ndev_dev(ndev),
+					"NTB Secondary config disabled\n");
+				return -EINVAL;
+			}
+			/* use half the spads for the peer */
+			ndev->spad_count >>= 1;
+			ndev->self_reg = &xeon_sec_reg;
+			ndev->peer_reg = &xeon_pri_reg;
+			ndev->xlat_reg = &xeon_pri_xlat;
 		}
-		/* use half the spads for the peer */
-		ndev->spad_count >>= 1;
-		ndev->self_reg = &xeon_sec_reg;
-		ndev->peer_reg = &xeon_pri_reg;
-		ndev->xlat_reg = &xeon_pri_xlat;
-		break;
-
-	case NTB_TOPO_B2B_USD:
-	case NTB_TOPO_B2B_DSD:
+	} else {
 		ndev->self_reg = &xeon_pri_reg;
 		ndev->peer_reg = &xeon_b2b_reg;
 		ndev->xlat_reg = &xeon_sec_xlat;
@@ -1833,11 +1865,12 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 				b2b_mw_idx, ndev->b2b_idx);
 
 		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
-			dev_warn(ndev_dev(ndev), "Reduce doorbell count by 1\n");
+			dev_warn(ndev_dev(ndev),
+				"Reduce doorbell count by 1\n");
 			ndev->db_count -= 1;
 		}
 
-		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
+		if (ndev->ntb.port == NTB_PORT_PRI) {
 			rc = xeon_setup_b2b_mw(ndev,
 					       &xeon_b2b_dsd_addr,
 					       &xeon_b2b_usd_addr);
@@ -1852,11 +1885,6 @@ static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 		/* Enable Bus Master and Memory Space on the secondary side */
 		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
 			  ndev->self_mmio + XEON_SPCICMD_OFFSET);
-
-		break;
-
-	default:
-		return -EINVAL;
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
@@ -1949,13 +1977,13 @@ static int xeon_init_dev(struct intel_ntb_dev *ndev)
 	if (rc)
 		return -EIO;
 
-	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
-	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
-		ntb_topo_string(ndev->ntb.topo));
-	if (ndev->ntb.topo == NTB_TOPO_NONE)
-		return -EINVAL;
+	rc = xeon_ppd_init_topo(ndev, ppd);
+	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s:%d\n", ppd,
+		ntb_topo_string(ndev->ntb.topo), ndev->ntb.port);
+	if (rc)
+		return rc;
 
-	if (ndev->ntb.topo != NTB_TOPO_SEC) {
+	if (ndev->ntb.topo != NTB_TOPO_P2P && ndev->ntb.port != NTB_PORT_SEC) {
 		ndev->bar4_split = xeon_ppd_bar4_split(ndev, ppd);
 		dev_dbg(ndev_dev(ndev), "ppd %#x bar4_split %d\n",
 			ppd, ndev->bar4_split);
@@ -2055,6 +2083,7 @@ static inline void ndev_init_struct(struct intel_ntb_dev *ndev,
 {
 	ndev->ntb.pdev = pdev;
 	ndev->ntb.topo = NTB_TOPO_NONE;
+	ndev->ntb.port = NTB_PORT_NONE;
 	ndev->ntb.ops = &intel_ntb_ops;
 
 	ndev->b2b_off = 0;
@@ -2259,6 +2288,10 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
 
 /* operations for primary side of local ntb */
 static const struct ntb_dev_ops intel_ntb_ops = {
+	.port_number		= intel_ntb_port_number,
+	.peer_port_count	= intel_ntb_peer_port_count,
+	.peer_port_number	= intel_ntb_peer_port_number,
+	.peer_port_idx		= intel_ntb_peer_port_idx,
 	.link_is_up		= intel_ntb_link_is_up,
 	.link_enable		= intel_ntb_link_enable,
 	.link_disable		= intel_ntb_link_disable,
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 3ec149c..7f1da03 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -248,6 +248,16 @@
 #define NTB_BAR_MASK_64			~(0xfull)
 #define NTB_BAR_MASK_32			~(0xfu)
 
+/* port related constants */
+#define NTB_PEER_CNT			(1)
+#define NTB_PIDX_MAX			(0)
+
+enum intel_ntb_port {
+	NTB_PORT_NONE = -1,
+	NTB_PORT_PRI,
+	NTB_PORT_SEC
+};
+
 struct intel_ntb_dev;
 
 struct intel_ntb_reg {
-- 
2.6.6

