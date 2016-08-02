Return-Path: <baolex.ni@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id ph9si412035pac.1.2016.08.02.05.26.04
        for <linux-ntb@googlegroups.com>;
        Tue, 02 Aug 2016 05:26:04 -0700 (PDT)
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0807/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:48:21 +0800
Message-Id: <20160802114821.3765-1-baolex.ni@intel.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linuxwifi@intel.com, kvalo@codeaurora.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-ntb.googlegroups.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 40d04ef..7aa1faa 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -92,56 +92,56 @@ static const struct file_operations intel_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
 
 static int b2b_mw_idx = -1;
-module_param(b2b_mw_idx, int, 0644);
+module_param(b2b_mw_idx, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(b2b_mw_idx, "Use this mw idx to access the peer ntb.  A "
 		 "value of zero or positive starts from first mw idx, and a "
 		 "negative value starts from last mw idx.  Both sides MUST "
 		 "set the same value here!");
 
 static unsigned int b2b_mw_share;
-module_param(b2b_mw_share, uint, 0644);
+module_param(b2b_mw_share, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(b2b_mw_share, "If the b2b mw is large enough, configure the "
 		 "ntb so that the peer ntb only occupies the first half of "
 		 "the mw, so the second half can still be used as a mw.  Both "
 		 "sides MUST set the same value here!");
 
 module_param_named(xeon_b2b_usd_bar2_addr64,
-		   xeon_b2b_usd_addr.bar2_addr64, ullong, 0644);
+		   xeon_b2b_usd_addr.bar2_addr64, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
 		 "XEON B2B USD BAR 2 64-bit address");
 
 module_param_named(xeon_b2b_usd_bar4_addr64,
-		   xeon_b2b_usd_addr.bar4_addr64, ullong, 0644);
+		   xeon_b2b_usd_addr.bar4_addr64, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
 		 "XEON B2B USD BAR 4 64-bit address");
 
 module_param_named(xeon_b2b_usd_bar4_addr32,
-		   xeon_b2b_usd_addr.bar4_addr32, ullong, 0644);
+		   xeon_b2b_usd_addr.bar4_addr32, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
 		 "XEON B2B USD split-BAR 4 32-bit address");
 
 module_param_named(xeon_b2b_usd_bar5_addr32,
-		   xeon_b2b_usd_addr.bar5_addr32, ullong, 0644);
+		   xeon_b2b_usd_addr.bar5_addr32, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
 		 "XEON B2B USD split-BAR 5 32-bit address");
 
 module_param_named(xeon_b2b_dsd_bar2_addr64,
-		   xeon_b2b_dsd_addr.bar2_addr64, ullong, 0644);
+		   xeon_b2b_dsd_addr.bar2_addr64, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
 		 "XEON B2B DSD BAR 2 64-bit address");
 
 module_param_named(xeon_b2b_dsd_bar4_addr64,
-		   xeon_b2b_dsd_addr.bar4_addr64, ullong, 0644);
+		   xeon_b2b_dsd_addr.bar4_addr64, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
 		 "XEON B2B DSD BAR 4 64-bit address");
 
 module_param_named(xeon_b2b_dsd_bar4_addr32,
-		   xeon_b2b_dsd_addr.bar4_addr32, ullong, 0644);
+		   xeon_b2b_dsd_addr.bar4_addr32, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
 		 "XEON B2B DSD split-BAR 4 32-bit address");
 
 module_param_named(xeon_b2b_dsd_bar5_addr32,
-		   xeon_b2b_dsd_addr.bar5_addr32, ullong, 0644);
+		   xeon_b2b_dsd_addr.bar5_addr32, ullong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
 		 "XEON B2B DSD split-BAR 5 32-bit address");
 
-- 
2.9.2

