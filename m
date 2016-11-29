Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id s81si354788wmf.3.2016.11.29.09.16.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:07 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id p100so13315546lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:07 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 12/22] NTB Intel: Alter Scratchpads interface to fit new NTB API
Date: Tue, 29 Nov 2016 20:16:07 +0300
Message-Id: <1480439777-1080-13-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index c41da32..e308fbe 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1235,30 +1235,30 @@ static int intel_ntb_spad_write(struct ntb_dev *ntb,
 			       ndev->self_reg->spad);
 }
 
-static int intel_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
+static int intel_ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
 				    phys_addr_t *spad_addr)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return ndev_spad_addr(ndev, idx, spad_addr, ndev->peer_addr,
+	return ndev_spad_addr(ndev, sidx, spad_addr, ndev->peer_addr,
 			      ndev->peer_reg->spad);
 }
 
-static u32 intel_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+static u32 intel_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return ndev_spad_read(ndev, idx,
+	return ndev_spad_read(ndev, sidx,
 			      ndev->peer_mmio +
 			      ndev->peer_reg->spad);
 }
 
-static int intel_ntb_peer_spad_write(struct ntb_dev *ntb,
-				     int idx, u32 val)
+static int intel_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
+				     int sidx, u32 val)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return ndev_spad_write(ndev, idx, val,
+	return ndev_spad_write(ndev, sidx, val,
 			       ndev->peer_mmio +
 			       ndev->peer_reg->spad);
 }
-- 
2.6.6

