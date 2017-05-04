Return-Path: <Gary.Hook@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on0061.outbound.protection.outlook.com. [104.47.36.61])
        by gmr-mx.google.com with ESMTPS id f188si24747pfc.1.2017.05.04.09.36.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 09:36:59 -0700 (PDT)
Subject: [PATCH] ntb: Correct modinfo usage statement for ntb_perf
From: Gary R Hook <gary.hook@amd.com>
Date: Thu, 4 May 2017 11:36:52 -0500
Message-ID: <20170504163652.6904.47683.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The order parameters are powers of 2; adjust the usage information
to use correct mathematical representations.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/ntb/test/ntb_perf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 9c4a21f1a9d9..42756a98a728 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -91,11 +91,11 @@
 
 static unsigned int seg_order = 19; /* 512K */
 module_param(seg_order, uint, 0644);
-MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for testing");
+MODULE_PARM_DESC(seg_order, "size order [2^n] of buffer segment for testing");
 
 static unsigned int run_order = 32; /* 4G */
 module_param(run_order, uint, 0644);
-MODULE_PARM_DESC(run_order, "size order [n^2] of total data to transfer");
+MODULE_PARM_DESC(run_order, "size order [2^n] of total data to transfer");
 
 static bool use_dma; /* default to 0 */
 module_param(use_dma, bool, 0644);

