Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com. [2a00:1450:4010:c07::236])
        by gmr-mx.google.com with ESMTPS id i88si340198lfh.4.2017.12.06.06.32.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:33 -0800 (PST)
Received: by mail-lf0-x236.google.com with SMTP id f18so4452354lfg.8
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:33 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 15/15] NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
Date: Wed,  6 Dec 2017 17:32:06 +0300
Message-Id: <20171206143206.14665-16-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Since Switchtec patch there has been a new topology added to
the NTB API. It's called NTB_TOPO_SWITCH and dedicated for
PCIe switch chips. Even though topo field isn't used within the
IDT driver much, lets set it for the sake of unification.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 93d4c9d2a9ad..8d98872d0983 100644
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

