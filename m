Return-Path: <wesley.sheng@microchip.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (mail-sn1nam04on0603.outbound.protection.outlook.com. [2a01:111:f400:fe4c::603])
        by gmr-mx.google.com with ESMTPS id 69si346143wrb.1.2018.11.21.19.19.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 19:19:27 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH 1/3] ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
Date: Thu, 22 Nov 2018 17:02:00 +0800
Message-ID: <1542877322-24548-2-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com
List-ID: <linux-ntb.googlegroups.com>

From: Paul Selles <paul.selles@microchip.com>

Switchtec NTB crosslink BARs are 64bit addressed but they are printed as
32bit addressed BARs. Fix debug log to increment the BAR numbers by 2 to
reflect the 64bit address alignment.

Signed-off-by: Paul Selles <paul.selles@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40..9916bc5 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1120,7 +1120,7 @@ static int crosslink_enum_partition(struct switchtec_ntb *sndev,
 
 		dev_dbg(&sndev->stdev->dev,
 			"Crosslink BAR%d addr: %llx\n",
-			i, bar_addr);
+			i*2, bar_addr);
 
 		if (bar_addr != bar_space * i)
 			continue;
-- 
2.7.4

