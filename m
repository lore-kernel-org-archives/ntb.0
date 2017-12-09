Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g129si245408itd.1.2017.12.08.16.02.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 16:02:23 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Dec 2017 17:02:17 -0700
Message-Id: <20171209000217.18366-2-logang@deltatee.com>
In-Reply-To: <20171209000217.18366-1-logang@deltatee.com>
References: <20171209000217.18366-1-logang@deltatee.com>
Subject: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

With Switchtec hardware, the buffer used for a memory window must be
aligned to its size (the hardware only replaces the lower bits). In
certain circumstances dma_alloc_coherent() will not provide a buffer
that adheres to this requirement like when using the CMA and
CONFIG_CMA_ALIGNMENT is set lower than the buffer size.

When we get an unaligned buffer mw_set_trans() should return an error.
We also log an error so we know the cause of the problem.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 709f37fbe232..984b83bc7dd3 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -315,6 +315,19 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (xlate_pos < 12)
 		return -EINVAL;
 
+	if (addr & ((1 << xlate_pos) - 1)) {
+		/*
+		 * In certain circumstances we can get a buffer that is
+		 * not aligned to its size. (Most of the time
+		 * dma_alloc_coherent ensures this). This can happen when
+		 * using large buffers allocated by the CMA
+		 * (see CMA_CONFIG_ALIGNMENT)
+		 */
+		dev_err(&sndev->stdev->dev,
+			"ERROR: Memory window address is not aligned to it's size!\n");
+		return -EINVAL;
+	}
+
 	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
 				   NTB_CTRL_PART_STATUS_LOCKED);
 	if (rc)
-- 
2.11.0

