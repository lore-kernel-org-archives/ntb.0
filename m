Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com. [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id w5si2167882pbt.1.2015.10.03.01.09.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 01:09:55 -0700 (PDT)
Received: by mail-pa0-x22d.google.com with SMTP id hy16so127361640pad.1
        for <linux-ntb@googlegroups.com>; Sat, 03 Oct 2015 01:09:55 -0700 (PDT)
Return-Path: <sudipm.mukherjee@gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/2] NTB: remove unused variable
Date: Sat,  3 Oct 2015 13:39:42 +0530
Message-Id: <1443859782-16773-2-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

These variables were not used anywhere. So remove them.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/ntb/ntb_transport.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 69953ee..28f9a03 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -928,7 +928,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
-	struct ntb_transport_mw *mw;
 	phys_addr_t mw_base;
 	resource_size_t mw_size;
 	unsigned int num_qps_mw, tx_size;
@@ -939,7 +938,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp_count = nt->qp_count;
 
 	mw_num = QP_TO_MW(nt, qp_num);
-	mw = &nt->mw_vec[mw_num];
 
 	qp = &nt->qp_vec[qp_num];
 	qp->qp_num = qp_num;
@@ -1930,13 +1928,11 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
  */
 void ntb_transport_link_down(struct ntb_transport_qp *qp)
 {
-	struct pci_dev *pdev;
 	int val;
 
 	if (!qp)
 		return;
 
-	pdev = qp->ndev->pdev;
 	qp->client_ready = false;
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
-- 
1.9.1

