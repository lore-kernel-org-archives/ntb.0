Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id fg5si447007vdb.1.2015.06.10.07.09.10
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 07:09:11 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 19/19] NTB: Increase transport MTU to 64k from 16k
Date: Wed, 10 Jun 2015 05:08:24 -0400
Message-Id: <b1facc7cc0e9f2a2a3e2c33ca694b75a5343c798.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433925092.git.Allen.Hubbe@emc.com>
References: <cover.1433925092.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Benchmarking showed a significant performance increase with the MTU size
to 64k instead of 16k.  Change the driver default to 64k.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index e07b056af3be..1551493197b4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -76,7 +76,7 @@ static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
 
-static unsigned int transport_mtu = 0x401E;
+static unsigned int transport_mtu = 0x10000;
 module_param(transport_mtu, uint, 0644);
 MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
 
-- 
2.4.0.rc0.43.gcf8a8c6

