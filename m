Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id b8si191577wrf.5.2017.11.30.13.41.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 13:41:10 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id a12so9535181lfe.4
        for <linux-ntb@googlegroups.com>; Thu, 30 Nov 2017 13:41:10 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH] NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
Date: Fri,  1 Dec 2017 00:41:07 +0300
Message-Id: <20171130214107.21194-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Since Switchtec patch there has been a new topology added to
the NTB API. It's called NTB_TOPO_SWITCH and dedicated for
PCIe switch chips. Even though topo field isn't used within the
IDT driver much, lets set it for the sake of unification.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index d87dbd4bc82c..27fdd14e0dca 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2070,7 +2070,7 @@ static int idt_register_device(struct idt_ntb_dev *ndev)
 
 	/* Initialize the rest of NTB device structure and register it */
 	ndev->ntb.ops = &idt_ntb_ops;
-	ndev->ntb.topo = NTB_TOPO_PRI;
+	ndev->ntb.topo = NTB_TOPO_SWITCH;
 
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret != 0) {
-- 
2.12.0

