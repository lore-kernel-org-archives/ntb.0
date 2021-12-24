Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id o7si285731lfk.11.2021.12.23.17.25.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:10 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 6/6] ntb_hw_switchtec: Fix a minor issue in config_req_id_table()
Date: Thu, 23 Dec 2021 17:23:34 -0800
Message-ID: <20211224012334.89173-7-kelvin.cao@microchip.com>
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

The req_id_table_size field is 16-bit wide, use ioread16() to read the
value.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 0e33eef64ec6..189faad0d0d5 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -955,7 +955,7 @@ static int config_req_id_table(struct switchtec_ntb *sndev,
 	u32 error;
 	u32 proxy_id;
 
-	if (ioread32(&mmio_ctrl->req_id_table_size) < count) {
+	if (ioread16(&mmio_ctrl->req_id_table_size) < count) {
 		dev_err(&sndev->stdev->dev,
 			"Not enough requester IDs available.\n");
 		return -EFAULT;
-- 
2.25.1

