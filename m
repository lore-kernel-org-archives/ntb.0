Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com. [2607:f8b0:400e:c03::231])
        by gmr-mx.google.com with ESMTPS id pe1si2092532pac.2.2015.10.03.01.09.52
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 01:09:52 -0700 (PDT)
Received: by mail-pa0-x231.google.com with SMTP id ex6so127523393pac.0
        for <linux-ntb@googlegroups.com>; Sat, 03 Oct 2015 01:09:52 -0700 (PDT)
Return-Path: <sudipm.mukherjee@gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/2] NTB: fix access of free-ed pointer
Date: Sat,  3 Oct 2015 13:39:41 +0530
Message-Id: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

We were accessing nt->mw_vec after freeing it. Fix the error path so
that we free nt->mw_vec after we have finished using it.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/ntb/ntb_transport.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6e3ee90..69953ee 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1080,7 +1080,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 				  GFP_KERNEL, node);
 	if (!nt->qp_vec) {
 		rc = -ENOMEM;
-		goto err2;
+		goto err1;
 	}
 
 	if (nt_debugfs_dir) {
@@ -1092,7 +1092,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	for (i = 0; i < qp_count; i++) {
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
-			goto err3;
+			goto err2;
 	}
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
@@ -1100,12 +1100,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
 	if (rc)
-		goto err3;
+		goto err2;
 
 	INIT_LIST_HEAD(&nt->client_devs);
 	rc = ntb_bus_init(nt);
 	if (rc)
-		goto err4;
+		goto err3;
 
 	nt->link_is_up = false;
 	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
@@ -1113,17 +1113,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	return 0;
 
-err4:
-	ntb_clear_ctx(ndev);
 err3:
-	kfree(nt->qp_vec);
+	ntb_clear_ctx(ndev);
 err2:
-	kfree(nt->mw_vec);
+	kfree(nt->qp_vec);
 err1:
 	while (i--) {
 		mw = &nt->mw_vec[i];
 		iounmap(mw->vbase);
 	}
+	kfree(nt->mw_vec);
 err:
 	kfree(nt);
 	return rc;
-- 
1.9.1

