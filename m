Return-Path: <kelvin.cao@microchip.com>
Received: from esa6.microchip.iphmx.com (esa6.microchip.iphmx.com. [216.71.154.253])
        by gmr-mx.google.com with ESMTPS id o125si20148oig.5.2019.06.06.00.09.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:09:57 -0700 (PDT)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 2/3] ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case
Date: Thu, 6 Jun 2019 15:09:43 +0800
Message-ID: <1559804984-24698-3-git-send-email-kelvin.cao@microchip.com>
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
Return-Path: kelvin.cao@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: kelvin.cao@microchip.com, kelvincao@outlook.com
List-ID: <linux-ntb.googlegroups.com>

From: Wesley Sheng <wesley.sheng@microchip.com>

In case of NTB crosslink topology, the setting of shared memory window in
the virtual partition doesn't reset on peer's reboot. So skip the
unnecessary re-setup of shared memory window for that case.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 947ed0b..6cf15c18 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1459,6 +1459,9 @@ static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 {
 	int rc;
 
+	if (crosslink_is_enabled(sndev))
+		return 0;
+
 	dev_info(&sndev->stdev->dev, "reinitialize shared memory window\n");
 	rc = config_rsvd_lut_win(sndev, sndev->mmio_peer_ctrl, 0,
 				 sndev->self_partition,
-- 
2.7.4

