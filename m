Return-Path: <dan.carpenter@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com. [156.151.31.86])
        by gmr-mx.google.com with ESMTPS id k4si607655iti.1.2018.01.23.00.34.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 00:34:28 -0800 (PST)
Date: Tue, 23 Jan 2018 11:33:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ntb_perf: Fix an error code in perf_copy_chunk()
Message-ID: <20180123083356.GC10091@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Gary R Hook <gary.hook@amd.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

We accidentally return success if dmaengine_submit() fails.  The fix is
to preserve the error code from dma_submit_error().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 8de72f3fba4d..387e685063fc 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -828,7 +828,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	tx->callback_param = pthr;
 	dma_set_unmap(tx, unmap);
 
-	if (dma_submit_error(dmaengine_submit(tx))) {
+	ret = dma_submit_error(dmaengine_submit(tx));
+	if (ret) {
 		dmaengine_unmap_put(unmap);
 		goto err_free_resource;
 	}
