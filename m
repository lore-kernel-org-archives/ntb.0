Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id i184si358641wmf.1.2016.11.29.09.16.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:12 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id o20so13313191lfg.3
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:12 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 16/22] NTB AMD: Alter MW interface to fit new NTB API
Date: Tue, 29 Nov 2016 20:16:11 +0300
Message-Id: <1480439777-1080-17-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 66 ++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index b7c9f67..9b3f78c 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -197,40 +197,42 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
 	return 1 << idx;
 }
 
-static int amd_ntb_mw_count(struct ntb_dev *ntb)
+static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				phys_addr_t *base,
-				resource_size_t *size,
-				resource_size_t *align,
-				resource_size_t *align_size)
+static int amd_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
+				resource_size_t *addr_align,
+				resource_size_t *size_align,
+				resource_size_t *size_max)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	bar = ndev_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
-	if (base)
-		*base = pci_resource_start(ndev->ntb.pdev, bar);
-
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar);
+	if (addr_align)
+		*addr_align = SZ_4K;
 
-	if (align)
-		*align = SZ_4K;
+	if (size_align)
+		*size_align = 1;
 
-	if (align_size)
-		*align_size = 1;
+	if (size_max)
+		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
 
 	return 0;
 }
 
-static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				dma_addr_t addr, resource_size_t size)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
@@ -240,6 +242,9 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	u64 base_addr, limit, reg_val;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	bar = ndev_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
@@ -312,6 +317,31 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
+static int amd_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	/* The same as for inbound MWs */
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int amd_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
+				    phys_addr_t *base, resource_size_t *size)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	if (base)
+		*base = pci_resource_start(ndev->ntb.pdev, bar);
+
+	if (size)
+		*size = pci_resource_len(ndev->ntb.pdev, bar);
+
+	return 0;
+}
+
 static u64 amd_ntb_db_valid_mask(struct ntb_dev *ntb)
 {
 	return ntb_ndev(ntb)->db_valid_mask;
@@ -466,8 +496,10 @@ static const struct ntb_dev_ops amd_ntb_ops = {
 	.link_enable		= amd_ntb_link_enable,
 	.link_disable		= amd_ntb_link_disable,
 	.mw_count		= amd_ntb_mw_count,
-	.mw_get_range		= amd_ntb_mw_get_range,
+	.mw_get_align		= amd_ntb_mw_get_align,
 	.mw_set_trans		= amd_ntb_mw_set_trans,
+	.peer_mw_count		= amd_ntb_peer_mw_count,
+	.peer_mw_get_addr	= amd_ntb_peer_mw_get_addr,
 	.db_valid_mask		= amd_ntb_db_valid_mask,
 	.db_vector_count	= amd_ntb_db_vector_count,
 	.db_vector_mask		= amd_ntb_db_vector_mask,
-- 
2.6.6

