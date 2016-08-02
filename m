Return-Path: <baolex.ni@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id i136si447990pfe.1.2016.08.02.05.26.26
        for <linux-ntb@googlegroups.com>;
        Tue, 02 Aug 2016 05:26:26 -0700 (PDT)
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0810/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:48:45 +0800
Message-Id: <20160802114845.3968-1-baolex.ni@intel.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, rjui@broadcom.com, sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, arnd@arndb.de
List-ID: <linux-ntb.googlegroups.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ntb/test/ntb_pingpong.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index fe16005..a7f6f41 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -78,15 +78,15 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
 static unsigned int unsafe;
-module_param(unsafe, uint, 0644);
+module_param(unsafe, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(unsafe, "Run even though ntb operations may be unsafe");
 
 static unsigned int delay_ms = 1000;
-module_param(delay_ms, uint, 0644);
+module_param(delay_ms, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to peer");
 
 static unsigned long db_init = 0x7;
-module_param(db_init, ulong, 0644);
+module_param(db_init, ulong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(delay_ms, "Initial doorbell bits to ring on the peer");
 
 struct pp_ctx {
-- 
2.9.2

