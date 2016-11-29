Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id s81si354789wmf.3.2016.11.29.09.16.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:13 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id 98so13273405lfs.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:13 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 17/22] NTB AMD: Alter Scratchpads interface to fit new NTB API
Date: Tue, 29 Nov 2016 20:16:12 +0300
Message-Id: <1480439777-1080-18-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 9b3f78c..3479c2b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -458,30 +458,30 @@ static int amd_ntb_spad_write(struct ntb_dev *ntb,
 	return 0;
 }
 
-static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
 	u32 offset;
 
-	if (idx < 0 || idx >= ndev->spad_count)
+	if (sidx < 0 || sidx >= ndev->spad_count)
 		return -EINVAL;
 
-	offset = ndev->peer_spad + (idx << 2);
+	offset = ndev->peer_spad + (sidx << 2);
 	return readl(mmio + AMD_SPAD_OFFSET + offset);
 }
 
-static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
-				   int idx, u32 val)
+static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
+				   int sidx, u32 val)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
 	u32 offset;
 
-	if (idx < 0 || idx >= ndev->spad_count)
+	if (sidx < 0 || sidx >= ndev->spad_count)
 		return -EINVAL;
 
-	offset = ndev->peer_spad + (idx << 2);
+	offset = ndev->peer_spad + (sidx << 2);
 	writel(val, mmio + AMD_SPAD_OFFSET + offset);
 
 	return 0;
-- 
2.6.6

