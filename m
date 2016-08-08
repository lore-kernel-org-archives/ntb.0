Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id z4si4714084pam.0.2016.08.08.02.48.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 02:48:50 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id y134so24738706pfg.3
        for <linux-ntb@googlegroups.com>; Mon, 08 Aug 2016 02:48:50 -0700 (PDT)
Return-Path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] NTB: ntb_hw_intel: Fix typo in module parameter descriptions
Date: Mon,  8 Aug 2016 09:48:42 +0000
Message-Id: <1470649722-29709-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Fix typo in module parameter descriptions.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 0d5c29a..1ee61d9 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -112,17 +112,17 @@ MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
 
 module_param_named(xeon_b2b_usd_bar4_addr64,
 		   xeon_b2b_usd_addr.bar4_addr64, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr64,
 		 "XEON B2B USD BAR 4 64-bit address");
 
 module_param_named(xeon_b2b_usd_bar4_addr32,
 		   xeon_b2b_usd_addr.bar4_addr32, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr32,
 		 "XEON B2B USD split-BAR 4 32-bit address");
 
 module_param_named(xeon_b2b_usd_bar5_addr32,
 		   xeon_b2b_usd_addr.bar5_addr32, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_usd_bar5_addr32,
 		 "XEON B2B USD split-BAR 5 32-bit address");
 
 module_param_named(xeon_b2b_dsd_bar2_addr64,
@@ -132,17 +132,17 @@ MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
 
 module_param_named(xeon_b2b_dsd_bar4_addr64,
 		   xeon_b2b_dsd_addr.bar4_addr64, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr64,
 		 "XEON B2B DSD BAR 4 64-bit address");
 
 module_param_named(xeon_b2b_dsd_bar4_addr32,
 		   xeon_b2b_dsd_addr.bar4_addr32, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr32,
 		 "XEON B2B DSD split-BAR 4 32-bit address");
 
 module_param_named(xeon_b2b_dsd_bar5_addr32,
 		   xeon_b2b_dsd_addr.bar5_addr32, ullong, 0644);
-MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
 		 "XEON B2B DSD split-BAR 5 32-bit address");
 
 #ifndef ioread64

