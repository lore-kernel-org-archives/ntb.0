Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id i138si194523ywe.2.2016.01.13.09.54.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 09:54:15 -0800 (PST)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Add more than just the first NTB to debugfs
Date: Wed, 13 Jan 2016 07:55:30 -0500
Message-Id: <2d02b2a1ea097008718489de404dfd939b560979.1452689594.git.Allen.Hubbe@emc.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Due to perf_debugfs_setup called only if the top level perf_debugfs_dir
was not created, only the first NTB would be added to debugfs.

Instead, call perf_debugfs_setup for every NTB.  Check that
perf_debugfs_dir exists in perf_debugfs_setup, and if necessary, create
it there.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---

Dave, if you like, you can just fix up your patch with this.

 drivers/ntb/test/ntb_perf.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dcf903584c43..5d60d59bd2d6 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -636,9 +636,16 @@ static int perf_debugfs_setup(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
 
-	if (!perf_debugfs_dir)
+	if (!debugfs_initialized())
 		return -ENODEV;
 
+	if (!perf_debugfs_dir) {
+		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+		if (!perf_debugfs_dir)
+			return -ENODEV;
+	}
+
 	perf->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
 						    perf_debugfs_dir);
 	if (!perf->debugfs_node_dir)
@@ -691,15 +698,9 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 	ntb_link_event(ntb);
 
-	if (debugfs_initialized() && !perf_debugfs_dir) {
-		perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
-		if (!perf_debugfs_dir)
-			goto err_ctx;
-
-		rc = perf_debugfs_setup(perf);
-		if (rc)
-			goto err_ctx;
-	}
+	rc = perf_debugfs_setup(perf);
+	if (rc)
+		goto err_ctx;
 
 	return 0;
 
-- 
2.5.3

