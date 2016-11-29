Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id f71si335691wmf.2.2016.11.29.09.16.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:18 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id o141so13358500lff.1
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:18 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 22/22] NTB Transport: Alter driver to work with two-ports NTB API
Date: Tue, 29 Nov 2016 20:16:17 +0300
Message-Id: <1480439777-1080-23-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The same as for PingPong driver, this driver can't be used with hardware
whithout Scratchpads. Additionally it supports two-ports and inbound MW
based devices only at the moment.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/ntb_transport.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4eb8adb..2390c65 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -94,6 +94,9 @@ MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
 static struct dentry *nt_debugfs_dir;
 
+/* Only two-ports NTB devices are supported */
+#define PIDX		0
+
 struct ntb_queue_entry {
 	/* ntb_queue list reference */
 	struct list_head entry;
@@ -682,7 +685,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(nt->ndev, num_mw);
+	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_coherent(&pdev->dev, mw->buff_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -739,7 +742,8 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	}
 
 	/* Notify HW the memory location of the receive buffer */
-	rc = ntb_mw_set_trans(nt->ndev, num_mw, mw->dma_addr, mw->xlat_size);
+	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
+			      mw->xlat_size);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
@@ -871,17 +875,17 @@ static void ntb_transport_link_work(struct work_struct *work)
 			size = max_mw_size;
 
 		spad = MW0_SZ_HIGH + (i * 2);
-		ntb_peer_spad_write(ndev, spad, upper_32_bits(size));
+		ntb_peer_spad_write(ndev, PIDX, spad, upper_32_bits(size));
 
 		spad = MW0_SZ_LOW + (i * 2);
-		ntb_peer_spad_write(ndev, spad, lower_32_bits(size));
+		ntb_peer_spad_write(ndev, PIDX, spad, lower_32_bits(size));
 	}
 
-	ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);
+	ntb_peer_spad_write(ndev, PIDX, NUM_MWS, nt->mw_count);
 
-	ntb_peer_spad_write(ndev, NUM_QPS, nt->qp_count);
+	ntb_peer_spad_write(ndev, PIDX, NUM_QPS, nt->qp_count);
 
-	ntb_peer_spad_write(ndev, VERSION, NTB_TRANSPORT_VERSION);
+	ntb_peer_spad_write(ndev, PIDX, VERSION, NTB_TRANSPORT_VERSION);
 
 	/* Query the remote side for its info */
 	val = ntb_spad_read(ndev, VERSION);
@@ -957,10 +961,10 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-	ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));
+	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
 
 	/* query remote spad for qp ready bits */
-	ntb_peer_spad_read(nt->ndev, QP_LINKS);
+	ntb_peer_spad_read(nt->ndev, PIDX, QP_LINKS);
 	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
 
 	/* See if the remote side is up */
@@ -1069,13 +1073,21 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	int node;
 	int rc, i;
 
-	mw_count = ntb_mw_count(ndev);
+	mw_count = ntb_mw_count(ndev, PIDX);
 	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
 		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
 			NTB_TRANSPORT_NAME);
 		return -EIO;
 	}
 
+	if (!ndev->ops->mw_set_trans) {
+		dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
+		return -EINVAL;
+	}
+
+	if (ntb_peer_port_count(ndev) != 1)
+		dev_warn(&ndev->dev, "Multi-port NTB devices unsupported\n");
+
 	if (ntb_db_is_unsafe(ndev))
 		dev_dbg(&ndev->dev,
 			"doorbell is unsafe, proceed anyway...\n");
@@ -1103,8 +1115,13 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	for (i = 0; i < mw_count; i++) {
 		mw = &nt->mw_vec[i];
 
-		rc = ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
-				      &mw->xlat_align, &mw->xlat_align_size);
+		rc = ntb_mw_get_align(ndev, PIDX, i, &mw->xlat_align,
+				      &mw->xlat_align_size, NULL);
+		if (rc)
+			goto err1;
+
+		rc = ntb_peer_mw_get_addr(ndev, i, &mw->phys_addr,
+					  &mw->phys_size);
 		if (rc)
 			goto err1;
 
@@ -2124,7 +2141,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
-	ntb_peer_spad_write(qp->ndev, QP_LINKS,
+	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS,
 			    val & ~BIT(qp->qp_num));
 
 	if (qp->link_is_up)
-- 
2.6.6

