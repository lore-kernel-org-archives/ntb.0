Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com. [156.151.31.85])
        by gmr-mx.google.com with ESMTPS id y53si1132910qtj.1.2019.06.18.22.32.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 22:32:22 -0700 (PDT)
Date: Wed, 19 Jun 2019 08:32:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] NTB: test: remove a duplicate check
Message-ID: <20190619053205.GA10452@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

We already verified that the "nm->isr_ctx" allocation succeeded so there
is no need to check again here.

Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Hey Logan, can pick a patch prefix when you're introducing a new module?
"[PATCH] NTB/test: Introduce NTB MSI Test Client" or whatever.

 drivers/ntb/test/ntb_msi_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 99d826ed9c34..9ba3c3162cd0 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -372,9 +372,6 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (ret)
 		goto remove_dbgfs;
 
-	if (!nm->isr_ctx)
-		goto remove_dbgfs;
-
 	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 
 	return 0;
-- 
2.20.1

