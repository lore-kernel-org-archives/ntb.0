Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com. [2a00:1450:4864:20::231])
        by gmr-mx.google.com with ESMTPS id b1-v6si87152wme.0.2018.07.14.04.59.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 04:59:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r13-v6so26313470ljg.10
        for <linux-ntb@googlegroups.com>; Sat, 14 Jul 2018 04:59:06 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 4/4] ntb: idt: Alter the driver info comments
Date: Sat, 14 Jul 2018 14:58:34 +0300
Message-Id: <20180714115834.3350-5-fancer.lancer@gmail.com>
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
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
index b360e5613b9f..bacffd369494 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -23,9 +23,7 @@ config NTB_IDT
 	 BAR settings of peer NT-functions, the BAR setups can't be done over
 	 kernel PCI fixups. That's why the alternative pre-initialization
 	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized. Additionally if one needs to have temperature sensor
-	 information printed to system log, the corresponding registers must
-	 be initialized within BIOS/EEPROM as well.
+	 utilized.
 
 	 If unsure, say N.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 3d48267ae315..d7a4984ed423 100644
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
@@ -1825,10 +1825,11 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
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

