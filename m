Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id t186si229052qkf.3.2019.10.11.06.19.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 06:19:25 -0700 (PDT)
Date: Fri, 11 Oct 2019 15:19:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ntb: ntb_pingpong: no need to check the return value of
 debugfs calls
Message-ID: <20191011131919.GA1174815@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

There is no need to check the return value of debugfs_create_atomic_t as
nothing happens with the error.  Also, the code will never return NULL,
so this check has never caught anything :)

Fix this by removing the check entirely.

Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/test/ntb_pingpong.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 65865e460ab8..04dd46647db3 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -354,13 +354,10 @@ static void pp_clear_ctx(struct pp_ctx *pp)
 static void pp_setup_dbgfs(struct pp_ctx *pp)
 {
 	struct pci_dev *pdev = pp->ntb->pdev;
-	void *ret;
 
 	pp->dbgfs_dir = debugfs_create_dir(pci_name(pdev), pp_dbgfs_topdir);
 
-	ret = debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &pp->count);
-	if (!ret)
-		dev_warn(&pp->ntb->dev, "DebugFS unsupported\n");
+	debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &pp->count);
 }
 
 static void pp_clear_dbgfs(struct pp_ctx *pp)
-- 
2.23.0

