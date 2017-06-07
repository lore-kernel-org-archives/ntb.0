Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id k19si317926pfb.13.2017.06.07.14.27.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 14:27:20 -0700 (PDT)
Subject: [PATCH] ntb: ntb_hw_intel: Skylake doorbells should be 32bits,
 not 64bits
From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 07 Jun 2017 14:27:19 -0700
Message-ID: <149687083920.6910.11754451825100195660.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com, ujjal.singh@intel.com
List-ID: <linux-ntb.googlegroups.com>

Fixing doorbell register length to 32bits per spec. On Skylake NTB, the
doorbell registers are 32bit write only registers. The source for the
doorbell is a 64bit register that shows the interrupt bits.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index c002384..859ba7ef 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1658,7 +1658,7 @@ static u64 skx_db_ioread(void __iomem *mmio)
 
 static void skx_db_iowrite(u64 bits, void __iomem *mmio)
 {
-	iowrite64(bits, mmio);
+	iowrite32((u32)bits, mmio);
 }
 
 static int skx_init_isr(struct intel_ntb_dev *ndev)
@@ -2878,7 +2878,7 @@ static const struct intel_ntb_reg skx_reg = {
 	.link_is_up		= xeon_link_is_up,
 	.db_ioread		= skx_db_ioread,
 	.db_iowrite		= skx_db_iowrite,
-	.db_size		= sizeof(u64),
+	.db_size		= sizeof(u32),
 	.ntb_ctl		= SKX_NTBCNTL_OFFSET,
 	.mw_bar			= {2, 4},
 };

