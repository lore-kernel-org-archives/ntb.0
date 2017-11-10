Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id u89si933723uau.1.2017.11.10.15.45.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 15:45:29 -0800 (PST)
Subject: [PATCH] ntb: intel: remove b2b memory window workaround for Skylake
 NTB
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 10 Nov 2017 16:45:27 -0700
Message-ID: <151035752755.53850.15930286252832571245.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The workaround code is never used because Skylake NTB does not need it.

Reported-by: Allen Hubbe <allen.hubbe@dell.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |   75 +----------------------------------
 1 file changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 94c0737..9f21fa3 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1499,89 +1499,18 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
 {
 	struct pci_dev *pdev;
 	void __iomem *mmio;
-	resource_size_t bar_size;
 	phys_addr_t bar_addr;
-	int b2b_bar;
-	u8 bar_sz;
 
 	pdev = ndev->ntb.pdev;
 	mmio = ndev->self_mmio;
 
-	if (ndev->b2b_idx == UINT_MAX) {
-		dev_dbg(&pdev->dev, "not using b2b mw\n");
-		b2b_bar = 0;
-		ndev->b2b_off = 0;
-	} else {
-		b2b_bar = ndev_mw_to_bar(ndev, ndev->b2b_idx);
-		if (b2b_bar < 0)
-			return -EIO;
-
-		dev_dbg(&pdev->dev, "using b2b mw bar %d\n", b2b_bar);
-
-		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
-
-		dev_dbg(&pdev->dev, "b2b bar size %#llx\n", bar_size);
-
-		if (b2b_mw_share && ((bar_size >> 1) >= XEON_B2B_MIN_SIZE)) {
-			dev_dbg(&pdev->dev, "b2b using first half of bar\n");
-			ndev->b2b_off = bar_size >> 1;
-		} else if (bar_size >= XEON_B2B_MIN_SIZE) {
-			dev_dbg(&pdev->dev, "b2b using whole bar\n");
-			ndev->b2b_off = 0;
-			--ndev->mw_count;
-		} else {
-			dev_dbg(&pdev->dev, "b2b bar size is too small\n");
-			return -EIO;
-		}
-	}
-
-	/*
-	 * Reset the secondary bar sizes to match the primary bar sizes,
-	 * except disable or halve the size of the b2b secondary bar.
-	 */
-	pci_read_config_byte(pdev, SKX_IMBAR1SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "IMBAR1SZ %#x\n", bar_sz);
-	if (b2b_bar == 1) {
-		if (ndev->b2b_off)
-			bar_sz -= 1;
-		else
-			bar_sz = 0;
-	}
-
-	pci_write_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, bar_sz);
-	pci_read_config_byte(pdev, SKX_EMBAR1SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "EMBAR1SZ %#x\n", bar_sz);
-
-	pci_read_config_byte(pdev, SKX_IMBAR2SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "IMBAR2SZ %#x\n", bar_sz);
-	if (b2b_bar == 2) {
-		if (ndev->b2b_off)
-			bar_sz -= 1;
-		else
-			bar_sz = 0;
-	}
-
-	pci_write_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, bar_sz);
-	pci_read_config_byte(pdev, SKX_EMBAR2SZ_OFFSET, &bar_sz);
-	dev_dbg(&pdev->dev, "EMBAR2SZ %#x\n", bar_sz);
-
-	/* SBAR01 hit by first part of the b2b bar */
-	if (b2b_bar == 0)
-		bar_addr = addr->bar0_addr;
-	else if (b2b_bar == 1)
-		bar_addr = addr->bar2_addr64;
-	else if (b2b_bar == 2)
-		bar_addr = addr->bar4_addr64;
-	else
-		return -EIO;
-
 	/* setup incoming bar limits == base addrs (zero length windows) */
-	bar_addr = addr->bar2_addr64 + (b2b_bar == 1 ? ndev->b2b_off : 0);
+	bar_addr = addr->bar2_addr64;
 	iowrite64(bar_addr, mmio + SKX_IMBAR1XLMT_OFFSET);
 	bar_addr = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
 	dev_dbg(&pdev->dev, "IMBAR1XLMT %#018llx\n", bar_addr);
 
-	bar_addr = addr->bar4_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
+	bar_addr = addr->bar4_addr64;
 	iowrite64(bar_addr, mmio + SKX_IMBAR2XLMT_OFFSET);
 	bar_addr = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
 	dev_dbg(&pdev->dev, "IMBAR2XLMT %#018llx\n", bar_addr);

