Return-Path: <dave.jiang@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id u12si398917pfd.3.2017.02.16.15.22.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 15:22:37 -0800 (PST)
Subject: [PATCH] ntb: ntb_hw_intel: link_poll isn't clearing the pending
 status properly
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 16 Feb 2017 16:22:36 -0700
Message-ID: <148728735682.1188.5989205862351479482.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

On Skylake hardware, the link_poll isn't clearing the pending interrupt
bit.  Adding a new function for SKX that handles clearing of status bit the
right way.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index eca9688..c002384 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1629,6 +1629,28 @@ static void atom_deinit_dev(struct intel_ntb_dev *ndev)
 
 /* Skylake Xeon NTB */
 
+static int skx_poll_link(struct intel_ntb_dev *ndev)
+{
+	u16 reg_val;
+	int rc;
+
+	ndev->reg->db_iowrite(ndev->db_link_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_clear);
+
+	rc = pci_read_config_word(ndev->ntb.pdev,
+				  SKX_LINK_STATUS_OFFSET, &reg_val);
+	if (rc)
+		return 0;
+
+	if (reg_val == ndev->lnk_sta)
+		return 0;
+
+	ndev->lnk_sta = reg_val;
+
+	return 1;
+}
+
 static u64 skx_db_ioread(void __iomem *mmio)
 {
 	return ioread64(mmio);
@@ -2852,7 +2874,7 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
 };
 
 static const struct intel_ntb_reg skx_reg = {
-	.poll_link		= xeon_poll_link,
+	.poll_link		= skx_poll_link,
 	.link_is_up		= xeon_link_is_up,
 	.db_ioread		= skx_db_ioread,
 	.db_iowrite		= skx_db_iowrite,

