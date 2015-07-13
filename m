Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id ec7si396659wib.3.2015.07.13.10.07.32
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:33 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 2/7] NTB: Fix transport stats for multiple devices
Date: Mon, 13 Jul 2015 08:07:09 -0400
Message-Id: <dfa0bd2961f380fe6991ec259129edba1f7f999f.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Currently the debugfs does not have files for all NTB transport queue
pairs.  When there are multiple NTBs present in a system, the QP names
of the last transport clobber the names of previously added transport
QPs.  Only the last added QPs can be observed via debugfs.

Create a directory per NTB transport to associate the QPs with that
transport.  Name the directory the same as the PCI device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 98e58c765f2e..25e973ff64cf 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -212,6 +212,8 @@ struct ntb_transport_ctx {
 	bool link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_node_dir;
 };
 
 enum {
@@ -945,12 +947,12 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
-	if (nt_debugfs_dir) {
+	if (nt->debugfs_node_dir) {
 		char debugfs_name[4];
 
 		snprintf(debugfs_name, 4, "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
-						     nt_debugfs_dir);
+						     nt->debugfs_node_dir);
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
@@ -1053,6 +1055,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		goto err2;
 	}
 
+	if (nt_debugfs_dir) {
+		nt->debugfs_node_dir =
+			debugfs_create_dir(pci_name(ndev->pdev),
+					   nt_debugfs_dir);
+	}
+
 	for (i = 0; i < qp_count; i++) {
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
-- 
2.5.0.rc1

