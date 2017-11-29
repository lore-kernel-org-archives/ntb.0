Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v4si124459oth.4.2017.11.29.09.55.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:56 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:25 -0700
Message-Id: <20171129175530.31032-3-logang@deltatee.com>
In-Reply-To: <20171129175530.31032-1-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 2/7] ntb_hw_switchtec: Keep track of the number of LUT windows used by the driver
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This is a prep patch in order to support the crosslink feature which will
require the driver to use another reserved LUT window. To simplify this,
we add some code to track the number of reserved LUT windows in use
instead of assuming this is always 1.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 088ae220ecb4..51fec6497164 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -109,6 +109,7 @@ struct switchtec_ntb {
 
 	int nr_direct_mw;
 	int nr_lut_mw;
+	int nr_rsvd_luts;
 	int direct_mw_to_bar[MAX_DIRECT_MW];
 
 	int peer_nr_direct_mw;
@@ -197,7 +198,7 @@ static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 	int nr_direct_mw = sndev->peer_nr_direct_mw;
-	int nr_lut_mw = sndev->peer_nr_lut_mw - 1;
+	int nr_lut_mw = sndev->peer_nr_lut_mw - sndev->nr_rsvd_luts;
 
 	if (pidx != NTB_DEF_PEER_IDX)
 		return -EINVAL;
@@ -210,12 +211,12 @@ static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 
 static int lut_index(struct switchtec_ntb *sndev, int mw_idx)
 {
-	return mw_idx - sndev->nr_direct_mw + 1;
+	return mw_idx - sndev->nr_direct_mw + sndev->nr_rsvd_luts;
 }
 
 static int peer_lut_index(struct switchtec_ntb *sndev, int mw_idx)
 {
-	return mw_idx - sndev->peer_nr_direct_mw + 1;
+	return mw_idx - sndev->peer_nr_direct_mw + sndev->nr_rsvd_luts;
 }
 
 static int switchtec_ntb_mw_get_align(struct ntb_dev *ntb, int pidx,
@@ -355,8 +356,9 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 static int switchtec_ntb_peer_mw_count(struct ntb_dev *ntb)
 {
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	int nr_lut_mw = sndev->nr_lut_mw - sndev->nr_rsvd_luts;
 
-	return sndev->nr_direct_mw + (use_lut_mws ? sndev->nr_lut_mw - 1 : 0);
+	return sndev->nr_direct_mw + (use_lut_mws ? nr_lut_mw : 0);
 }
 
 static int switchtec_ntb_direct_get_addr(struct switchtec_ntb *sndev,
@@ -1008,6 +1010,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 	u32 ctl_val;
 	int rc;
 
+	sndev->nr_rsvd_luts++;
 	sndev->self_shared = dma_zalloc_coherent(&sndev->stdev->pdev->dev,
 						 LUT_SIZE,
 						 &sndev->self_shared_dma,
@@ -1074,6 +1077,7 @@ static void switchtec_ntb_deinit_shared_mw(struct switchtec_ntb *sndev)
 		dma_free_coherent(&sndev->stdev->pdev->dev, LUT_SIZE,
 				  sndev->self_shared,
 				  sndev->self_shared_dma);
+	sndev->nr_rsvd_luts--;
 }
 
 static irqreturn_t switchtec_ntb_doorbell_isr(int irq, void *dev)
-- 
2.11.0

