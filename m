Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id el2si1972119pbb.0.2015.09.24.13.03.12
        for <linux-ntb@googlegroups.com>;
        Thu, 24 Sep 2015 13:03:12 -0700 (PDT)
Subject: [PATCH] NTB: unify translation addresses
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 24 Sep 2015 13:03:05 -0700
Message-ID: <20150924200304.3052.96889.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

There is no need for the upstream and downstream addresses to be different
for the NTB configs. Go to using a single set of address. It is still
possible to configure them differently using module parameter override
however.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |   16 ++++++++--------
 drivers/ntb/hw/intel/ntb_hw_intel.h |   15 +++++----------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 6e4f7be..c45850a 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -2481,17 +2481,17 @@ static const struct intel_ntb_xlat_reg xeon_sec_xlat = {
 };
 
 static struct intel_b2b_addr xeon_b2b_usd_addr = {
-	.bar2_addr64		= XEON_B2B_BAR2_USD_ADDR64,
-	.bar4_addr64		= XEON_B2B_BAR4_USD_ADDR64,
-	.bar4_addr32		= XEON_B2B_BAR4_USD_ADDR32,
-	.bar5_addr32		= XEON_B2B_BAR5_USD_ADDR32,
+	.bar2_addr64		= XEON_B2B_BAR2_ADDR64,
+	.bar4_addr64		= XEON_B2B_BAR4_ADDR64,
+	.bar4_addr32		= XEON_B2B_BAR4_ADDR32,
+	.bar5_addr32		= XEON_B2B_BAR5_ADDR32,
 };
 
 static struct intel_b2b_addr xeon_b2b_dsd_addr = {
-	.bar2_addr64		= XEON_B2B_BAR2_DSD_ADDR64,
-	.bar4_addr64		= XEON_B2B_BAR4_DSD_ADDR64,
-	.bar4_addr32		= XEON_B2B_BAR4_DSD_ADDR32,
-	.bar5_addr32		= XEON_B2B_BAR5_DSD_ADDR32,
+	.bar2_addr64		= XEON_B2B_BAR2_ADDR64,
+	.bar4_addr64		= XEON_B2B_BAR4_ADDR64,
+	.bar4_addr32		= XEON_B2B_BAR4_ADDR32,
+	.bar5_addr32		= XEON_B2B_BAR5_ADDR32,
 };
 
 /* operations for primary side of local ntb */
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index e261a8b..0e9acd9 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -228,16 +228,11 @@
 
 /* Use the following addresses for translation between b2b ntb devices in case
  * the hardware default values are not reliable. */
-#define XEON_B2B_BAR0_USD_ADDR		0x1000000000000000ull
-#define XEON_B2B_BAR2_USD_ADDR64	0x2000000000000000ull
-#define XEON_B2B_BAR4_USD_ADDR64	0x4000000000000000ull
-#define XEON_B2B_BAR4_USD_ADDR32	0x20000000u
-#define XEON_B2B_BAR5_USD_ADDR32	0x40000000u
-#define XEON_B2B_BAR0_DSD_ADDR		0x9000000000000000ull
-#define XEON_B2B_BAR2_DSD_ADDR64	0xa000000000000000ull
-#define XEON_B2B_BAR4_DSD_ADDR64	0xc000000000000000ull
-#define XEON_B2B_BAR4_DSD_ADDR32	0xa0000000u
-#define XEON_B2B_BAR5_DSD_ADDR32	0xc0000000u
+#define XEON_B2B_BAR0_ADDR	0x1000000000000000ull
+#define XEON_B2B_BAR2_ADDR64	0x2000000000000000ull
+#define XEON_B2B_BAR4_ADDR64	0x4000000000000000ull
+#define XEON_B2B_BAR4_ADDR32	0x20000000u
+#define XEON_B2B_BAR5_ADDR32	0x40000000u
 
 /* The peer ntb secondary config space is 32KB fixed size */
 #define XEON_B2B_MIN_SIZE		0x8000

