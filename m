Return-Path: <likaige@loongson.cn>
Received: from loongson.cn (mail.loongson.cn. [114.242.206.163])
        by gmr-mx.google.com with ESMTP id i6si206265pgj.5.2020.07.24.01.42.38
        for <linux-ntb@googlegroups.com>;
        Fri, 24 Jul 2020 01:42:40 -0700 (PDT)
From: Kaige Li <likaige@loongson.cn>
Subject: [PATCH] NTB: hw: amd: Add missed pci_release_region
Date: Fri, 24 Jul 2020 16:42:04 +0800
Message-Id: <1595580124-407-1-git-send-email-likaige@loongson.cn>
To: Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>
List-ID: <linux-ntb.googlegroups.com>

The driver forgets to call pci_release_region() in init_pci failure.
Add the missed call to fix it.

Signed-off-by: Kaige Li <likaige@loongson.cn>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 88e1db6..71428d8 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1203,6 +1203,7 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 
 err_dma_mask:
 	pci_clear_master(pdev);
+	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
 err_pci_enable:
-- 
2.1.0

