Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id l19si533442wmg.0.2016.11.29.09.16.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:17 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id o141so13358506lff.1
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:17 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 21/22] NTB Perf: Alter driver to work with two-ports NTB API
Date: Tue, 29 Nov 2016 20:16:16 +0300
Message-Id: <1480439777-1080-22-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The same as for PingPong driver, this driver can't be used with hardware
whithout Scratchpads. Additionally it supports two-ports and inbound MW
based devices only at the moment.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/test/ntb_perf.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e75d4fd..99f1522 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -76,6 +76,7 @@
 #define DMA_RETRIES		20
 #define SZ_4G			(1ULL << 32)
 #define MAX_SEG_ORDER		20 /* no larger than 1M for kmalloc buffer */
+#define PIDX			0
 
 MODULE_LICENSE(DRIVER_LICENSE);
 MODULE_VERSION(DRIVER_VERSION);
@@ -452,7 +453,7 @@ static void perf_free_mw(struct perf_ctx *perf)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(perf->ntb, 0);
+	ntb_mw_clear_trans(perf->ntb, PIDX, 0);
 	dma_free_coherent(&pdev->dev, mw->buf_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -488,7 +489,7 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
 		mw->buf_size = 0;
 	}
 
-	rc = ntb_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
+	rc = ntb_mw_set_trans(perf->ntb, PIDX, 0, mw->dma_addr, mw->xlat_size);
 	if (rc) {
 		dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
 		perf_free_mw(perf);
@@ -515,9 +516,9 @@ static void perf_link_work(struct work_struct *work)
 	if (max_mw_size && size > max_mw_size)
 		size = max_mw_size;
 
-	ntb_peer_spad_write(ndev, MW_SZ_HIGH, upper_32_bits(size));
-	ntb_peer_spad_write(ndev, MW_SZ_LOW, lower_32_bits(size));
-	ntb_peer_spad_write(ndev, VERSION, PERF_VERSION);
+	ntb_peer_spad_write(ndev, PIDX, MW_SZ_HIGH, upper_32_bits(size));
+	ntb_peer_spad_write(ndev, PIDX, MW_SZ_LOW, lower_32_bits(size));
+	ntb_peer_spad_write(ndev, PIDX, VERSION, PERF_VERSION);
 
 	/* now read what peer wrote */
 	val = ntb_spad_read(ndev, VERSION);
@@ -559,8 +560,12 @@ static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
 
 	mw = &perf->mw;
 
-	rc = ntb_mw_get_range(ntb, 0, &mw->phys_addr, &mw->phys_size,
-			      &mw->xlat_align, &mw->xlat_align_size);
+	rc = ntb_mw_get_align(ntb, PIDX, 0, &mw->xlat_align,
+			      &mw->xlat_align_size, NULL);
+	if (rc)
+		return rc;
+
+	rc = ntb_peer_mw_get_addr(ntb, 0, &mw->phys_addr, &mw->phys_size);
 	if (rc)
 		return rc;
 
@@ -764,6 +769,14 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 		return -EIO;
 	}
 
+	if (!ntb->ops->mw_set_trans) {
+		dev_err(&ntb->dev, "Need inbound MW based NTB API\n");
+		return -EINVAL;
+	}
+
+	if (ntb_peer_port_count(ntb) != 1)
+		dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
+
 	node = dev_to_node(&pdev->dev);
 
 	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
-- 
2.6.6

