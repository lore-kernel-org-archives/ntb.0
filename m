Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id t6si424779wiz.0.2015.07.13.10.07.34
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:34 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 7/7] NTB: Fix dereference before check
Date: Mon, 13 Jul 2015 08:07:14 -0400
Message-Id: <593b4f16b84b5c7d0e769bdc7d218819844ba6bb.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
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
index 04e6c345419c..3363a8968f9d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1692,7 +1692,6 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
  */
 void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev;
 	struct ntb_queue_entry *entry;
 	u64 qp_bit;
@@ -1745,7 +1744,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 
-	nt->qp_bitmap_free |= qp_bit;
+	qp->transport->qp_bitmap_free |= qp_bit;
 
 	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
 }
-- 
2.5.0.rc1

