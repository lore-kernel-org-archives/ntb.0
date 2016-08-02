Return-Path: <baolex.ni@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id yt6si384341pac.2.2016.08.02.05.26.42
        for <linux-ntb@googlegroups.com>;
        Tue, 02 Aug 2016 05:26:42 -0700 (PDT)
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0809/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:48:38 +0800
Message-Id: <20160802114838.3900-1-baolex.ni@intel.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, rjui@broadcom.com, sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, john.kading@gd-ms.com, arnd@arndb.de, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-ntb.googlegroups.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ntb/test/ntb_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 8dfce9c..7c67b88 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -84,15 +84,15 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 static struct dentry *perf_debugfs_dir;
 
 static unsigned int seg_order = 19; /* 512K */
-module_param(seg_order, uint, 0644);
+module_param(seg_order, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for testing");
 
 static unsigned int run_order = 32; /* 4G */
-module_param(run_order, uint, 0644);
+module_param(run_order, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(run_order, "size order [n^2] of total data to transfer");
 
 static bool use_dma; /* default to 0 */
-module_param(use_dma, bool, 0644);
+module_param(use_dma, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_dma, "Using DMA engine to measure performance");
 
 struct perf_mw {
-- 
2.9.2

