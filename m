Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id k67si609975vki.0.2017.12.08.16.02.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 16:02:25 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Dec 2017 17:02:16 -0700
Message-Id: <20171209000217.18366-1-logang@deltatee.com>
Subject: [PATCH 1/2] ntb_transport: Fix bug with max_mw_size parameter
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 045e3dd4750e..9878c48826e3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1003,6 +1003,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	mw_base = nt->mw_vec[mw_num].phys_addr;
 	mw_size = nt->mw_vec[mw_num].phys_size;
 
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
 
-- 
2.11.0

