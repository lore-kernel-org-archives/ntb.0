Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ei5si308702pbb.0.2015.08.31.11.30.58
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:30:59 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 2/2] NTB: Fix range check on memory window index
Date: Mon, 31 Aug 2015 09:31:00 -0400
Message-Id: <bbeb424c9cb05a8f948604b53670d22c3a26912c.1441027457.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1441027457.git.Allen.Hubbe@emc.com>
References: <cover.1441027457.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1441027457.git.Allen.Hubbe@emc.com>
References: <cover.1441027457.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

The range check must exclude the upper bound.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index fc6af2da8df0..865a3e3cc581 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -240,7 +240,7 @@ static inline int ndev_ignore_unsafe(struct intel_ntb_dev *ndev,
 
 static int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
 {
-	if (idx < 0 || idx > ndev->mw_count)
+	if (idx < 0 || idx >= ndev->mw_count)
 		return -EINVAL;
 	return ndev->reg->mw_bar[idx];
 }
-- 
2.5.0.rc1

