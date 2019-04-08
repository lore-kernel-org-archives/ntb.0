Return-Path: <wesley.sheng@microchip.com>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com. [68.232.149.84])
        by gmr-mx.google.com with ESMTPS id z204si1846086ywa.2.2019.04.07.23.46.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:46:37 -0700 (PDT)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH 2/3] ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case
Date: Mon, 8 Apr 2019 22:45:21 +0800
Message-ID: <1554734722-7833-3-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
References: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com, kelvin.cao@microchip.com
List-ID: <linux-ntb.googlegroups.com>

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

