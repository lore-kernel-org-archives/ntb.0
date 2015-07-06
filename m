Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id eo3si1661056wib.0.2015.07.06.08.31.21
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:22 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 03/12] NTB: Fix transport stats for multiple devices
Date: Mon,  6 Jul 2015 11:30:26 -0400
Message-Id: <67bb7814d372c1e4097c0aaa0113c15f681eb1f8.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
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
index 76a03d4070a9..7e2de6764b9f 100644
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
@@ -952,12 +954,12 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
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
@@ -1060,6 +1062,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
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
2.4.0.rc0.43.gcf8a8c6

