Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id q2si170721ljc.0.2021.12.23.17.25.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:09 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 3/6] ntb_hw_switchtec: AND with the part_map for a valid tpart_vec
Date: Thu, 23 Dec 2021 17:23:31 -0800
Message-ID: <20211224012334.89173-4-kelvin.cao@microchip.com>
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

Some firmware versions return 1 in the target partition vector for
undefined partitions. AND with the part_map to give a valid tpart_vec.

Signed-off-by: Jeremy Pallotta <jmpallotta@gmail.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index ec9cb6c81eda..25302a384a7d 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -858,6 +858,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	tpart_vec |= ioread32(&sndev->mmio_ntb->ntp_info[self].target_part_low);
 
 	part_map = ioread64(&sndev->mmio_ntb->ep_map);
+	tpart_vec &= part_map;
 	part_map &= ~(1 << sndev->self_partition);
 
 	if (!tpart_vec) {
-- 
2.25.1

