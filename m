Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q128si820496ywc.4.2018.03.05.11.08.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 11:08:47 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  5 Mar 2018 12:08:24 -0700
Message-Id: <20180305190824.847-8-logang@deltatee.com>
In-Reply-To: <20180305190824.847-1-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com>
Subject: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

Clean up the ifdefs which conditionally defined the io{read|write}64
functions in favour of the new common io-64-nonatomic-lo-hi header.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f624ae27eabe..d2a1e746b335 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/ntb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -35,35 +36,6 @@ module_param(use_lut_mws, bool, 0644);
 MODULE_PARM_DESC(use_lut_mws,
 		 "Enable the use of the LUT based memory windows");
 
-#ifndef ioread64
-#ifdef readq
-#define ioread64 readq
-#else
-#define ioread64 _ioread64
-static inline u64 _ioread64(void __iomem *mmio)
-{
-	u64 low, high;
-
-	low = ioread32(mmio);
-	high = ioread32(mmio + sizeof(u32));
-	return low | (high << 32);
-}
-#endif
-#endif
-
-#ifndef iowrite64
-#ifdef writeq
-#define iowrite64 writeq
-#else
-#define iowrite64 _iowrite64
-static inline void _iowrite64(u64 val, void __iomem *mmio)
-{
-	iowrite32(val, mmio);
-	iowrite32(val >> 32, mmio + sizeof(u32));
-}
-#endif
-#endif
-
 #define SWITCHTEC_NTB_MAGIC 0x45CC0001
 #define MAX_MWS     128
 
-- 
2.11.0

