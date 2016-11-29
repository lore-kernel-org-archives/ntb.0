Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id l130si351960wmf.0.2016.11.29.09.16.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:06 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id o20so13313190lfg.3
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:06 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 11/22] NTB Intel: Alter MW interface to fit new NTB API
Date: Tue, 29 Nov 2016 20:16:06 +0300
Message-Id: <1480439777-1080-12-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 79 ++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 724ccfe..c41da32 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -941,20 +941,26 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
-static int intel_ntb_mw_count(struct ntb_dev *ntb)
+static int intel_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				  phys_addr_t *base,
-				  resource_size_t *size,
-				  resource_size_t *align,
-				  resource_size_t *align_size)
+static int intel_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
+				  resource_size_t *addr_align,
+				  resource_size_t *size_align,
+				  resource_size_t *size_max)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	resource_size_t bar_size, mw_size;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
 		idx += 1;
 
@@ -962,24 +968,26 @@ static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 	if (bar < 0)
 		return bar;
 
-	if (base)
-		*base = pci_resource_start(ndev->ntb.pdev, bar) +
-			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+	bar_size = pci_resource_len(ndev->ntb.pdev, bar);
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) -
-			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+	if (idx == ndev->b2b_idx)
+		mw_size = bar_size - ndev->b2b_off;
+	else
+		mw_size = bar_size;
 
-	if (align)
-		*align = pci_resource_len(ndev->ntb.pdev, bar);
+	if (addr_align)
+		*addr_align = pci_resource_len(ndev->ntb.pdev, bar);
 
-	if (align_size)
-		*align_size = 1;
+	if (size_align)
+		*size_align = 1;
+
+	if (size_max)
+		*size_max = mw_size;
 
 	return 0;
 }
 
-static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				  dma_addr_t addr, resource_size_t size)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -989,6 +997,9 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	u64 base, limit, reg_val;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
 		idx += 1;
 
@@ -1077,6 +1088,36 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
+static int intel_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	/* Numbers of inbound and outbound memory windows match */
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int intel_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
+				     phys_addr_t *base, resource_size_t *size)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
+
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	if (base)
+		*base = pci_resource_start(ndev->ntb.pdev, bar) +
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+
+	if (size)
+		*size = pci_resource_len(ndev->ntb.pdev, bar) -
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+
+	return 0;
+}
+
 static int intel_ntb_db_is_unsafe(struct ntb_dev *ntb)
 {
 	return ndev_ignore_unsafe(ntb_ndev(ntb), NTB_UNSAFE_DB);
@@ -2296,8 +2337,10 @@ static const struct ntb_dev_ops intel_ntb_ops = {
 	.link_enable		= intel_ntb_link_enable,
 	.link_disable		= intel_ntb_link_disable,
 	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_get_align		= intel_ntb_mw_get_align,
 	.mw_set_trans		= intel_ntb_mw_set_trans,
+	.peer_mw_count		= intel_ntb_peer_mw_count,
+	.peer_mw_get_addr	= intel_ntb_peer_mw_get_addr,
 	.db_is_unsafe		= intel_ntb_db_is_unsafe,
 	.db_valid_mask		= intel_ntb_db_valid_mask,
 	.db_vector_count	= intel_ntb_db_vector_count,
-- 
2.6.6

