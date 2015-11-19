Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id pe1si1035626pac.2.2015.11.19.13.00.55
        for <linux-ntb@googlegroups.com>;
        Thu, 19 Nov 2015 13:00:55 -0800 (PST)
Subject: [PATCH v2] NTB: Clear property bits in BAR value
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 19 Nov 2015 14:00:54 -0700
Message-ID: <20151119210054.127573.61827.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com, cem@freebsd.org
List-ID: <linux-ntb.googlegroups.com>

The lower bits read from a BAR register will contain property bits
that we do not care about. Clear those so that we can use the BAR
values for limit and xlat registers.

Reported-by: Conrad Meyer <cem@freebsd.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |    4 ++--
 drivers/ntb/hw/intel/ntb_hw_intel.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index a198f82..40d04ef 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -875,7 +875,7 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	limit_reg = bar2_off(ndev->xlat_reg->bar2_limit, bar);
 
 	if (bar < 4 || !ndev->bar4_split) {
-		base = ioread64(mmio + base_reg);
+		base = ioread64(mmio + base_reg) & NTB_BAR_MASK_64;
 
 		/* Set the limit if supported, if size is not mw_size */
 		if (limit_reg && size != mw_size)
@@ -906,7 +906,7 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 		if ((addr + size) & (~0ull << 32))
 			return -EINVAL;
 
-		base = ioread32(mmio + base_reg);
+		base = ioread32(mmio + base_reg) & NTB_BAR_MASK_32;
 
 		/* Set the limit if supported, if size is not mw_size */
 		if (limit_reg && size != mw_size)
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 2eb4add..4d60433 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -245,6 +245,9 @@
 #define NTB_UNSAFE_DB			BIT_ULL(0)
 #define NTB_UNSAFE_SPAD			BIT_ULL(1)
 
+#define NTB_BAR_MASK_64			~(0xfull)
+#define NTB_BAR_MASK_32			~(0xfu)
+
 struct intel_ntb_dev;
 
 struct intel_ntb_reg {

