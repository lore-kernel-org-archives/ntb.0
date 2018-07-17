Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com. [2a00:1450:4864:20::22a])
        by gmr-mx.google.com with ESMTPS id s14-v6si25127ljh.0.2018.07.17.02.25.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:25:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j19-v6so377712ljc.7
        for <linux-ntb@googlegroups.com>; Tue, 17 Jul 2018 02:25:01 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 4/4] ntb: idt: Alter the driver info comments
Date: Tue, 17 Jul 2018 12:24:37 +0300
Message-Id: <20180717092437.18918-5-fancer.lancer@gmail.com>
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Since IDT PCIe-switch temperature sensor is now always available
irregardless of the EEPROM/BIOS settings, Kconfig and in-code
description should be properly altered. In addition lets update
the driver copyright lines.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/Kconfig      |  4 +---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 11 ++++++-----
 drivers/ntb/hw/idt/ntb_hw_idt.h |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index 2ed147368fa8..f8948cf515ce 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -24,9 +24,7 @@ config NTB_IDT
 	 BAR settings of peer NT-functions, the BAR setups can't be done over
 	 kernel PCI fixups. That's why the alternative pre-initialization
 	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized. Additionally if one needs to have temperature sensor
-	 information printed to system log, the corresponding registers must
-	 be initialized within BIOS/EEPROM as well.
+	 utilized.
 
 	 If unsure, say N.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 55321086d59a..8706b8e0864a 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -4,7 +4,7 @@
  *
  *   GPL LICENSE SUMMARY
  *
- *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *   Copyright (C) 2016-2018 T-Platforms JSC All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify it
  *   under the terms and conditions of the GNU General Public License,
@@ -1824,10 +1824,11 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
  *                      7. Temperature sensor operations
  *
  *    IDT PCIe-switch has an embedded temperature sensor, which can be used to
- * warn a user-space of possible chip overheating. Since workload temperature
- * can be different on different platforms, temperature thresholds as well as
- * general sensor settings must be setup in the framework of BIOS/EEPROM
- * initializations. It includes the actual sensor enabling as well.
+ * check current chip core temperature. Since a workload environment can be
+ * different on different platforms, an offset and ADC/filter settings can be
+ * specified. Although the offset configuration is only exposed to the sysfs
+ * hwmon interface at the moment. The rest of the settings can be adjusted
+ * for instance by the BIOS/EEPROM firmware.
  *=============================================================================
  */
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 3517cd2e2baa..2f1aa121b0cf 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -4,7 +4,7 @@
  *
  *   GPL LICENSE SUMMARY
  *
- *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *   Copyright (C) 2016-2018 T-Platforms JSC All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify it
  *   under the terms and conditions of the GNU General Public License,
-- 
2.12.0

