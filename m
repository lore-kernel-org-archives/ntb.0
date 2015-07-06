Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id l198si1993579ywe.2.2015.07.06.08.31.19
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:19 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 12/12] NTB: Fix zero size or integer overflow in ntb_set_mw
Date: Mon,  6 Jul 2015 11:30:35 -0400
Message-Id: <4f9192accfbc8d2d850b8b8da67a193857c25d80.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

A plain 32 bit integer will overflow for values over 4GiB.

Change the plain integer size to the appropriate size type in
ntb_set_mw.  Change the type of the size parameter and two local
variables used for size.

Even if there is no overflow, a size of zero is invalid here.

Reported-by: Juyoung Jung <jjung@micron.com>
Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index fbddeab13b4c..42ae5a122412 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -648,13 +648,16 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 }
 
 static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
-		      unsigned int size)
+		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct pci_dev *pdev = nt->ndev->pdev;
-	unsigned int xlat_size, buff_size;
+	size_t xlat_size, buff_size;
 	int rc;
 
+	if (!size)
+		return -EINVAL;
+
 	xlat_size = round_up(size, mw->xlat_align_size);
 	buff_size = round_up(size, mw->xlat_align);
 
@@ -674,7 +677,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	if (!mw->virt_addr) {
 		mw->xlat_size = 0;
 		mw->buff_size = 0;
-		dev_err(&pdev->dev, "Unable to alloc MW buff of size %d\n",
+		dev_err(&pdev->dev, "Unable to alloc MW buff of size %lu\n",
 			buff_size);
 		return -ENOMEM;
 	}
-- 
2.4.0.rc0.43.gcf8a8c6

