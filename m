Return-Path: <likaige@loongson.cn>
Received: from loongson.cn (mail.loongson.cn. [114.242.206.163])
        by gmr-mx.google.com with ESMTP id v18si143032oor.0.2020.08.10.19.00.30
        for <linux-ntb@googlegroups.com>;
        Mon, 10 Aug 2020 19:00:31 -0700 (PDT)
From: Kaige Li <likaige@loongson.cn>
Subject: [RESEND] NTB: hw: amd: fix an issue about leak system resources
Date: Tue, 11 Aug 2020 09:59:57 +0800
Message-Id: <1597111197-28563-1-git-send-email-likaige@loongson.cn>
To: Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

The related system resources were not released when pci_set_dma_mask(),
pci_set_consistent_dma_mask(), or pci_iomap() return error in the
amd_ntb_init_pci() function. Add pci_release_regions() to fix it.

Signed-off-by: Kaige Li <likaige@loongson.cn>
---

changed commit massage.

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

