Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id d199si364106wmd.1.2016.12.13.15.49.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:34 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id 96so224886lfs.1
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:34 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 8/9] NTB: Add PCIe Gen4 link speed
Date: Wed, 14 Dec 2016 02:49:20 +0300
Message-Id: <1481672961-10753-9-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
 <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/ntb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 76c56d5..6d46179 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -108,6 +108,7 @@ static inline char *ntb_topo_string(enum ntb_topo topo)
  * @NTB_SPEED_GEN1:	Link is trained to gen1 speed.
  * @NTB_SPEED_GEN2:	Link is trained to gen2 speed.
  * @NTB_SPEED_GEN3:	Link is trained to gen3 speed.
+ * @NTB_SPEED_GEN4:	Link is trained to gen4 speed.
  */
 enum ntb_speed {
 	NTB_SPEED_AUTO = -1,
@@ -115,6 +116,7 @@ enum ntb_speed {
 	NTB_SPEED_GEN1 = 1,
 	NTB_SPEED_GEN2 = 2,
 	NTB_SPEED_GEN3 = 3,
+	NTB_SPEED_GEN4 = 4
 };
 
 /**
-- 
2.6.6

