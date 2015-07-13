Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ec7si396683wib.3.2015.07.13.10.07.41
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:42 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 6/7] NTB: Fix zero size or integer overflow in ntb_set_mw
Date: Mon, 13 Jul 2015 08:07:13 -0400
Message-Id: <c032f37f585db5c4cb4c2076d7036c7736e0e5ea.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
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
index b82171e3e07d..04e6c345419c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -629,13 +629,16 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
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
 
@@ -655,7 +658,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	if (!mw->virt_addr) {
 		mw->xlat_size = 0;
 		mw->buff_size = 0;
-		dev_err(&pdev->dev, "Unable to alloc MW buff of size %d\n",
+		dev_err(&pdev->dev, "Unable to alloc MW buff of size %lu\n",
 			buff_size);
 		return -ENOMEM;
 	}
-- 
2.5.0.rc1

