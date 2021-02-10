Return-Path: <weiyongjun1@huawei.com>
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com. [45.249.212.190])
        by gmr-mx.google.com with ESMTPS id f24si321770pju.1.2021.02.09.23.45.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 23:45:54 -0800 (PST)
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] NTB: Drop kfree for memory allocated with devm_kzalloc
Date: Wed, 10 Feb 2021 07:53:45 +0000
Message-ID: <20210210075345.1096001-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
To: Hulk Robot <hulkci@huawei.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Fixes: 363baf7d6051 ("NTB: Add support for EPF PCI-Express Non-Transparent Bridge")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 2cccb7dff5dd..b019755e4e21 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -723,7 +723,6 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	ntb_unregister_device(&ndev->ntb);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
-	kfree(ndev);
 }
 
 static const struct ntb_epf_data j721e_data = {

