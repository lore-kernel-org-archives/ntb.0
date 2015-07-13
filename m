Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id t14si556553ywe.3.2015.07.13.10.07.43
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:43 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 11/14] NTB: Make the transport list in order of discovery
Date: Mon, 13 Jul 2015 08:07:19 -0400
Message-Id: <36c7044e849407b57fbf15e7074107cd2937533c.1436788771.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788771.git.Allen.Hubbe@emc.com>
References: <cover.1436788771.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

The list should be added from the bottom and not the top in order to
ensure the transport is provided in the same order to clients as ntb
devices are discovered.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8c9d50d50e92..55c26c59f4fe 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -297,7 +297,7 @@ static LIST_HEAD(ntb_transport_list);
 
 static int ntb_bus_init(struct ntb_transport_ctx *nt)
 {
-	list_add(&nt->entry, &ntb_transport_list);
+	list_add_tail(&nt->entry, &ntb_transport_list);
 	return 0;
 }
 
-- 
2.5.0.rc1

