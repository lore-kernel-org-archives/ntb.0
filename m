Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com. [2a00:1450:4864:20::135])
        by gmr-mx.google.com with ESMTPS id j45si47266wre.0.2019.01.30.03.21.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:21:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n18so17092388lfh.6
        for <linux-ntb@googlegroups.com>; Wed, 30 Jan 2019 03:21:01 -0800 (PST)
Return-Path: <fomichev.ru@gmail.com>
Date: Wed, 30 Jan 2019 14:20:59 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: [RFC PATCH] ntb core: copy device archdata on create
Message-ID: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On non-x86 platforms, e.g. PowerPC, struct device's archdata field is used to
store DMA-related sensitive information. Meanwhile NTB subsystem doesn't copy
that field when creates a child device. Therefore dma_alloc_coherent() fails on
PowerPC. As a result ntb_tool doesn't work.
This is the possible solution.

---
 drivers/ntb/ntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2581ab7..e690987 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -114,6 +114,7 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->dev.bus = &ntb_bus;
 	ntb->dev.parent = &ntb->pdev->dev;
 	ntb->dev.release = ntb_dev_release;
+	ntb->dev.archdata = ntb->pdev->dev.archdata;
 	dev_set_name(&ntb->dev, "%s", pci_name(ntb->pdev));
 
 	ntb->ctx = NULL;
-- 
2.7.4
