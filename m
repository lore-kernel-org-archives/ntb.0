Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0057.outbound.protection.outlook.com. [104.47.37.57])
        by gmr-mx.google.com with ESMTPS id c68si3753427ith.1.2016.11.14.01.00.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 01:00:52 -0800 (PST)
From: Shyam Sundar S K <ssundark@amd.com>
Subject: [PATCH] NTB: Register and offset values fix for memory window
Message-ID: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
Date: Mon, 14 Nov 2016 14:30:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah,
 Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal,
 Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "Subramaniyan, Ramkumar" <ramkumar.ks@amd.com>, Richard1.Su@amd.com
List-ID: <linux-ntb.googlegroups.com>

Due to incorrect limit and translation register values, NTB link was
going down when the memory window translation was setup. Made appropriate
changes as per spec.

Also, fixed the limit register values for BAR1, which was overlapping
with the BAR23 address.

Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 6ccba0d..9bbe3e0 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -138,11 +138,11 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	base_addr = pci_resource_start(ndev->ntb.pdev, bar);

 	if (bar != 1) {
-		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 3);
-		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 3);
+		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 2);
+		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 2);

 		/* Set the limit if supported */
-		limit = base_addr + size;
+		limit = size;

 		/* set and verify setting the translation address */
 		write64(addr, peer_mmio + xlat_reg);
@@ -164,14 +164,9 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 		xlat_reg = AMD_BAR1XLAT_OFFSET;
 		limit_reg = AMD_BAR1LMT_OFFSET;

-		/* split bar addr range must all be 32 bit */
-		if (addr & (~0ull << 32))
-			return -EINVAL;
-		if ((addr + size) & (~0ull << 32))
-			return -EINVAL;

 		/* Set the limit if supported */
-		limit = base_addr + size;
+		limit = size;

 		/* set and verify setting the translation address */
 		write64(addr, peer_mmio + xlat_reg);
@@ -376,13 +371,11 @@ static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 offset;

-	if (idx < 0 || idx >= ndev->spad_count)
+	if (idx < 0 || idx >= (ndev->spad_count + 4))
 		return 0;

-	offset = ndev->self_spad + (idx << 2);
-	return readl(mmio + AMD_SPAD_OFFSET + offset);
+	return readl(mmio + AMD_SPAD_OFFSET + (idx << 2));
 }

 static int amd_ntb_spad_write(struct ntb_dev *ntb,
@@ -392,11 +385,10 @@ static int amd_ntb_spad_write(struct ntb_dev *ntb,
 	void __iomem *mmio = ndev->self_mmio;
 	u32 offset;

-	if (idx < 0 || idx >= ndev->spad_count)
+	if (idx < 0 || idx >= (ndev->spad_count + 4))
 		return -EINVAL;

-	offset = ndev->self_spad + (idx << 2);
-	writel(val, mmio + AMD_SPAD_OFFSET + offset);
+	writel(val, mmio + AMD_SPAD_OFFSET + (idx << 2));

 	return 0;
 }
@@ -405,13 +397,11 @@ static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 offset;

-	if (idx < 0 || idx >= ndev->spad_count)
+	if (idx < 0 || idx >= (ndev->spad_count + 4))
 		return -EINVAL;

-	offset = ndev->peer_spad + (idx << 2);
-	return readl(mmio + AMD_SPAD_OFFSET + offset);
+	return readl(mmio + AMD_SPAD_OFFSET + (idx << 2));
 }

 static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
@@ -421,11 +411,10 @@ static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
 	void __iomem *mmio = ndev->self_mmio;
 	u32 offset;

-	if (idx < 0 || idx >= ndev->spad_count)
+	if (idx < 0 || idx >= (ndev->spad_count + 4))
 		return -EINVAL;

-	offset = ndev->peer_spad + (idx << 2);
-	writel(val, mmio + AMD_SPAD_OFFSET + offset);
+	writel(val, mmio + AMD_SPAD_OFFSET + (idx << 2));

 	return 0;
 }
-- 
2.7.4
