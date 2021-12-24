Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id q2si170721ljc.0.2021.12.23.17.25.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:08 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 1/6] ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
Date: Thu, 23 Dec 2021 17:23:29 -0800
Message-ID: <20211224012334.89173-2-kelvin.cao@microchip.com>
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

From: Jeremy Pallotta <jmpallotta@gmail.com>

Array mmio_part_cfg_all holds the partition configuration of all
partitions, with partition number as index. Fix this by reading into
mmio_part_cfg_all for pff.

Fixes: 0ee28f26f378 ("NTB: switchtec_ntb: Add link management")
Signed-off-by: Jeremy Pallotta <jmpallotta@gmail.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 4c6eb61a6ac6..6603c77c0a84 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -419,8 +419,8 @@ static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
 					  enum ntb_width *width)
 {
 	struct switchtec_dev *stdev = sndev->stdev;
-
-	u32 pff = ioread32(&stdev->mmio_part_cfg[partition].vep_pff_inst_id);
+	u32 pff =
+		ioread32(&stdev->mmio_part_cfg_all[partition].vep_pff_inst_id);
 	u32 linksta = ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
 
 	if (speed)
-- 
2.25.1

