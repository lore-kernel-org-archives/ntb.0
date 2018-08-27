Return-Path: <gustavo@embeddedor.com>
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com. [192.185.50.185])
        by gmr-mx.google.com with ESMTPS id z18-v6si19863qti.1.2018.08.27.15.13.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 15:13:49 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
	by gateway23.websitewelcome.com (Postfix) with ESMTP id 5B0E617230
	for <linux-ntb@googlegroups.com>; Mon, 27 Aug 2018 17:13:49 -0500 (CDT)
Date: Mon, 27 Aug 2018 17:13:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular NULL
 checks
Message-ID: <20180827221306.GA8936@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-ntb.googlegroups.com>

Both devm_kcalloc() and devm_kzalloc() return NULL on error. They
never return error pointers.

The use of IS_ERR_OR_NULL is currently applied to the wrong
context.

Fix this by replacing IS_ERR_OR_NULL with regular NULL checks.

Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dbe72f1..a67ef23 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1105,9 +1105,9 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	}
 
 	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt,
-				sizeof(*ret_mws), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(ret_mws))
+	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
+			       GFP_KERNEL);
+	if (!ret_mws)
 		return ERR_PTR(-ENOMEM);
 
 	/* Copy the info of detected memory windows */
@@ -2390,7 +2390,7 @@ static struct idt_ntb_dev *idt_create_dev(struct pci_dev *pdev,
 
 	/* Allocate memory for the IDT PCIe-device descriptor */
 	ndev = devm_kzalloc(&pdev->dev, sizeof(*ndev), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(ndev)) {
+	if (!ndev) {
 		dev_err(&pdev->dev, "Memory allocation failed for descriptor");
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.7.4

