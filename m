Return-Path: <wangqing@vivo.com>
Received: from m176115.mail.qiye.163.com (m176115.mail.qiye.163.com. [59.111.176.115])
        by gmr-mx.google.com with ESMTPS id x21si34297qtx.1.2020.11.06.01.43.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 01:43:41 -0800 (PST)
From: Wang Qing <wangqing@vivo.com>
Subject: [PATCH] ntb: idt: fix error check in ntb_hw_idt.c
Date: Fri,  6 Nov 2020 17:43:31 +0800
Message-Id: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Wang Qing <wangqing@vivo.com>
List-ID: <linux-ntb.googlegroups.com>

idt_create_dev never return NULL and fix smatch warning.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index d54261f..e7a4c2a
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2511,7 +2511,7 @@ static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
 	/* If the top directory is not created then do nothing */
 	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
 		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-		return PTR_ERR(dbgfs_topdir);
+		return PTR_ERR_OR_ZERO(dbgfs_topdir);
 	}
 
 	/* Create the info file node */
@@ -2756,7 +2756,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
 
 	/* Allocate the memory for IDT NTB device data */
 	ndev = idt_create_dev(pdev, id);
-	if (IS_ERR_OR_NULL(ndev))
+	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
 	/* Initialize the basic PCI subsystem of the device */
-- 
2.7.4

