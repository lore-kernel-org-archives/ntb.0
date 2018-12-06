Return-Path: <wesley.sheng@microchip.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-eopbgr780053.outbound.protection.outlook.com. [40.107.78.53])
        by gmr-mx.google.com with ESMTPS id 204si682334itw.2.2018.12.05.23.48.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 23:48:27 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH v2 2/3] ntb_hw_switchtec: NT req id mapping table register entry number should be 512
Date: Thu, 6 Dec 2018 21:30:51 +0800
Message-ID: <1544103052-28191-3-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com
List-ID: <linux-ntb.googlegroups.com>

The number of available NT req id mapping table entries per NTB control
register is 512. The driver mistakenly limits the number to 256.

Fix the array size of NT req id mapping table.

Fixes: c082b04c9d40 ("NTB: switchtec: Add NTB hardware register definitions")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/switchtec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ab400af..623719c9 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -244,8 +244,8 @@ struct ntb_ctrl_regs {
 		u64 xlate_addr;
 	} bar_entry[6];
 	u32 reserved2[216];
-	u32 req_id_table[256];
-	u32 reserved3[512];
+	u32 req_id_table[512];
+	u32 reserved3[256];
 	u64 lut_entry[512];
 } __packed;
 
-- 
2.7.4

