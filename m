Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id q2si170723ljc.0.2021.12.23.17.25.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:09 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 4/6] ntb_hw_switchtec: Update the way of getting VEP instance ID
Date: Thu, 23 Dec 2021 17:23:32 -0800
Message-ID: <20211224012334.89173-5-kelvin.cao@microchip.com>
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: kelvin.cao@microchip.com
Content-Type: text/plain
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com, Jeremy
 Pallotta <jmpallotta@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Gen4 firmware adds DMA VEP and NVMe VEP support in VEP (virtual EP)
instance ID register in addtion to management EP. Update the way of
getting management VEP instance ID.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 25302a384a7d..03839346233d 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -419,8 +419,10 @@ static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
 					  enum ntb_width *width)
 {
 	struct switchtec_dev *stdev = sndev->stdev;
-	u32 pff =
-		ioread32(&stdev->mmio_part_cfg_all[partition].vep_pff_inst_id);
+	struct part_cfg_regs __iomem *part_cfg =
+		&stdev->mmio_part_cfg_all[partition];
+
+	u32 pff = ioread32(&part_cfg->vep_pff_inst_id) & 0xFF;
 	u32 linksta = ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
 
 	if (speed)
@@ -1089,7 +1091,7 @@ static int crosslink_enum_partition(struct switchtec_ntb *sndev,
 {
 	struct part_cfg_regs __iomem *part_cfg =
 		&sndev->stdev->mmio_part_cfg_all[sndev->peer_partition];
-	u32 pff = ioread32(&part_cfg->vep_pff_inst_id);
+	u32 pff = ioread32(&part_cfg->vep_pff_inst_id) & 0xFF;
 	struct pff_csr_regs __iomem *mmio_pff =
 		&sndev->stdev->mmio_pff_csr[pff];
 	const u64 bar_space = 0x1000000000LL;
-- 
2.25.1

