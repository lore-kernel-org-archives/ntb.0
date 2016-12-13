Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id z62si10236268pfz.1.2016.12.13.08.03.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 08:03:14 -0800 (PST)
Subject: [PATCH] ntb: fix SKX NTB config space size register offsets
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 13 Dec 2016 09:03:13 -0700
Message-ID: <148164499341.194663.8632238363765425811.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Allen.Hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, Sandeep Mann <sandeep@purestorage.com>, Zachary Ross <zacharyx.ross@intel.com>
List-ID: <linux-ntb.googlegroups.com>

The offsets for the SZ registers are wrong. Updated.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reported-by: Sandeep Mann <sandeep@purestorage.com>
Tested-by: Zachary Ross <zacharyx.ross@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 6e8c182..f2cf8a7 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -152,10 +152,10 @@
 #define XEON_SPAD_COUNT			16
 
 /* Intel Skylake Xeon hardware */
-#define SKX_IMBAR1SZ_OFFSET		0x00d1
-#define SKX_IMBAR2SZ_OFFSET		0x00d5
-#define SKX_EMBAR1SZ_OFFSET		0x00d3
-#define SKX_EMBAR2SZ_OFFSET		0x00d6
+#define SKX_IMBAR1SZ_OFFSET		0x00d0
+#define SKX_IMBAR2SZ_OFFSET		0x00d1
+#define SKX_EMBAR1SZ_OFFSET		0x00d2
+#define SKX_EMBAR2SZ_OFFSET		0x00d3
 #define SKX_DEVCTRL_OFFSET		0x0098
 #define SKX_DEVSTS_OFFSET		0x009a
 #define SKX_UNCERRSTS_OFFSET		0x014c

