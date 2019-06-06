Return-Path: <kelvin.cao@microchip.com>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com. [68.232.149.84])
        by gmr-mx.google.com with ESMTPS id o123si101194itc.3.2019.06.06.00.09.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:09:53 -0700 (PDT)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 1/3] ntb_hw_switchtec: Remove redundant steps of switchtec_ntb_reinit_peer() function
Date: Thu, 6 Jun 2019 15:09:42 +0800
Message-ID: <1559804984-24698-2-git-send-email-kelvin.cao@microchip.com>
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
Return-Path: kelvin.cao@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: kelvin.cao@microchip.com, kelvincao@outlook.com
List-ID: <linux-ntb.googlegroups.com>

From: Joey Zhang <joey.zhang@microchip.com>

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory window. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. We only need to reconfigure the hardware
registers. Remove the redundant steps from
switchtec_ntb_reinit_peer() function.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d905d36..947ed0b 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1457,10 +1457,13 @@ static void switchtec_ntb_deinit_db_msg_irq(struct switchtec_ntb *sndev)
 
 static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
-	dev_info(&sndev->stdev->dev, "peer reinitialized\n");
-	switchtec_ntb_deinit_shared_mw(sndev);
-	switchtec_ntb_init_mw(sndev);
-	return switchtec_ntb_init_shared_mw(sndev);
+	int rc;
+
+	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
+	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
+				 sndev->self_partition,
+				 sndev->self_shared_dma);
+	return rc;
 }
 
 static int switchtec_ntb_add(struct device *dev,
-- 
2.7.4

