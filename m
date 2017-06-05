Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u187si680913ita.0.2017.06.05.13.01.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 13:01:00 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  5 Jun 2017 14:00:52 -0600
Message-Id: <20170605200053.6912-2-logang@deltatee.com>
In-Reply-To: <20170605200053.6912-1-logang@deltatee.com>
References: <20170605200053.6912-1-logang@deltatee.com>
Subject: [PATCH] ntb_transport: fix qp count bug
To: linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

In cases where there are more mw's than spads/2-2, the mw count gets
reduced to match the limitation. ntb_transport also tries to ensure that
there are fewer qps than mws but uses the full mw count instead of
the reduced one. When this happens, the math in
'ntb_transport_setup_qp_mw' will get confused and result in a kernel
paging request bug.

This patch fixes the bug by reducing qp_count to the reduced mw count
instead of the full mw count.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 02ca45fdd892..0a778d2cab94 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1128,8 +1128,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (max_num_clients && max_num_clients < qp_count)
 		qp_count = max_num_clients;
-	else if (mw_count < qp_count)
-		qp_count = mw_count;
+	else if (nt->mw_count < qp_count)
+		qp_count = nt->mw_count;
 
 	qp_bitmap &= BIT_ULL(qp_count) - 1;
 
-- 
2.11.0

