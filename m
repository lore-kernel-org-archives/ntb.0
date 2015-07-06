Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id da3si1041543wib.1.2015.07.06.09.50.52
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 09:50:52 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Fix dereference before check
Date: Mon,  6 Jul 2015 12:50:35 -0400
Message-Id: <bb4dd048e673ff6a7ccb49610873f8b0b41cfc1d.1436201347.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Remove early dereference of a pointer that is checked later in the code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 42ae5a122412..c64de9b99742 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1720,7 +1720,6 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
  */
 void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev;
 	struct ntb_queue_entry *entry;
 	u64 qp_bit;
@@ -1788,7 +1787,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 
-	nt->qp_bitmap_free |= qp_bit;
+	qp->transport->qp_bitmap_free |= qp_bit;
 
 	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
 }
-- 
2.4.0.rc0.43.gcf8a8c6

