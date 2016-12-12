Return-Path: <fancer.lancer@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id l206si2519247wmf.2.2016.12.12.13.09.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 13:09:18 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id u144so13871477wmu.0
        for <linux-ntb@googlegroups.com>; Mon, 12 Dec 2016 13:09:18 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 8/9] NTB: Add PCIe Gen4 link speed
Date: Tue, 13 Dec 2016 00:08:21 +0300
Message-Id: <1481576902-21091-9-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
 <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 90746df..fe0437c 100644
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

