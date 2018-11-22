Return-Path: <wesley.sheng@microchip.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (mail-eopbgr720051.outbound.protection.outlook.com. [40.107.72.51])
        by gmr-mx.google.com with ESMTPS id h3si1709537qtk.5.2018.11.21.19.19.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 19:19:37 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH 3/3] ntb_hw_switchtec: NT req id mapping table register entry number should be 512
Date: Thu, 22 Nov 2018 17:02:02 +0800
Message-ID: <1542877322-24548-4-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com
List-ID: <linux-ntb.googlegroups.com>

The number of available NT req id mapping table entries per NTB control
register is 512. The driver mistakenly limits the number to 256.

Fix the array size of NT req id mapping table.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 include/linux/switchtec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 1e6e333..52a079b 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -253,8 +253,8 @@ struct ntb_ctrl_regs {
 		u32 reserved[3];
 	} bar_ext_entry[6];
 	u32 reserved2[192];
-	u32 req_id_table[256];
-	u32 reserved3[512];
+	u32 req_id_table[512];
+	u32 reserved3[256];
 	u64 lut_entry[512];
 } __packed;
 
-- 
2.7.4

