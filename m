Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2607:7c80:54:e::133])
        by gmr-mx.google.com with ESMTPS id o3si943186yba.5.2019.09.18.13.58.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 13:58:37 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] NTB: fix IDT Kconfig typos/spellos
Message-ID: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
Date: Wed, 18 Sep 2019 13:58:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos in drivers/ntb/hw/idt/Kconfig.
Use consistent spelling and capitalization.

Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb@googlegroups.com
---
 drivers/ntb/hw/idt/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-53.orig/drivers/ntb/hw/idt/Kconfig
+++ lnx-53/drivers/ntb/hw/idt/Kconfig
@@ -4,11 +4,11 @@ config NTB_IDT
 	depends on PCI
 	select HWMON
 	help
-	 This driver supports NTB of cappable IDT PCIe-switches.
+	 This driver supports NTB of capable IDT PCIe-switches.
 
 	 Some of the pre-initializations must be made before IDT PCIe-switch
-	 exposes it NT-functions correctly. It should be done by either proper
-	 initialisation of EEPROM connected to master smbus of the switch or
+	 exposes its NT-functions correctly. It should be done by either proper
+	 initialization of EEPROM connected to master SMbus of the switch or
 	 by BIOS using slave-SMBus interface changing corresponding registers
 	 value. Evidently it must be done before PCI bus enumeration is
 	 finished in Linux kernel.


