Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x41-v6si791900qth.2.2018.10.02.15.41.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 15:41:16 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  2 Oct 2018 16:41:07 -0600
Message-Id: <20181002224108.3321-6-logang@deltatee.com>
In-Reply-To: <20181002224108.3321-1-logang@deltatee.com>
References: <20181002224108.3321-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v22 5/6] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Now that ioread64 and iowrite64 are available in io-64-nonatomic,
we can remove the hack at the top of ntb_hw_intel.c and replace it
with an include.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Acked-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/intel/ntb_hw_intel.h | 30 +----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index c49ff8970ce3..e071e28bca3f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -53,6 +53,7 @@
 
 #include <linux/ntb.h>
 #include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /* PCI device IDs */
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF	0x3725
@@ -218,33 +219,4 @@ static inline int pdev_is_gen3(struct pci_dev *pdev)
 	return 0;
 }
 
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
 #endif
-- 
2.19.0

