Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id z131si3617026ywz.4.2016.12.27.14.57.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 14:57:26 -0800 (PST)
From: Allen Hubbe <Allen.Hubbe@dell.com>
Subject: [PATCH] NTB: ntb_transport: fix debugfs_remove_recursive
Date: Tue, 27 Dec 2016 17:57:04 -0500
Message-Id: <6f7341ada9073025b0172a2ab0decc084b4d2ef4.1482879327.git.Allen.Hubbe@dell.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>
List-ID: <linux-ntb.googlegroups.com>

The call to debugfs_remove_recursive(qp->debugfs_dir) of the sub-level
directory must not be later than
debugfs_remove_recursive(nt_debugfs_dir) of the top-level directory.
Otherwise, the sub-level directory will not exist, and it would be
invalid (panic) to attempt to remove it.  This removes the top-level
directory last, after sub-level directories have been cleaned up.

Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f81aa4b18d9f..0e18adb51e4e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2273,9 +2273,8 @@ module_init(ntb_transport_init);
 
 static void __exit ntb_transport_exit(void)
 {
-	debugfs_remove_recursive(nt_debugfs_dir);
-
 	ntb_unregister_client(&ntb_transport_client);
 	bus_unregister(&ntb_transport_bus);
+	debugfs_remove_recursive(nt_debugfs_dir);
 }
 module_exit(ntb_transport_exit);
-- 
2.9.1

