Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id dw9si957770qcb.2.2015.05.20.13.42.13
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 13:42:13 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 14/16] ntb: performance improvement by write combining
Date: Wed, 20 May 2015 11:41:15 -0400
Message-Id: <0bd1cf12d3f5d92cc612b4b772de9f52d3249390.1432135632.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Changing the memory window BAR mappings to write combining significantly
boosts the performance.  We will also use memcpy that utilizies
non-temporal store which showed performance improement when doing
non-cached memcpys.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 91809fa..cc0b7ff 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -58,6 +58,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -989,7 +990,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		if (rc)
 			goto err1;
 
-		mw->vbase = ioremap(mw->phys_addr, mw->phys_size);
+		mw->vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
 		if (!mw->vbase) {
 			rc = -ENOMEM;
 			goto err1;
@@ -1360,7 +1361,11 @@ static void ntb_tx_copy_callback(void *data)
 
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
-	memcpy_toio(offset, entry->buf, entry->len);
+	/*
+	 * Using non-temporal mov to improve performance on non-cached
+	 * writes. Even though we aren't actually copying from user space.
+	 */
+	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
 
 	/* Ensure that the data is fully copied out before setting the flags */
 	wmb();
-- 
2.4.0.rc0.43.gcf8a8c6

