Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id u75si1989773ywe.4.2015.07.06.08.31.27
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:27 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 08/12] NTB: Make the transport list in order of discovery
Date: Mon,  6 Jul 2015 11:30:31 -0400
Message-Id: <066a600663dc520a3336ae751d50a6f1fbd9cea7.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
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
index 4bba3c4a4a3a..f92239141674 100644
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
2.4.0.rc0.43.gcf8a8c6

