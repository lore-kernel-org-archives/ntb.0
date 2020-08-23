Return-Path: <dinghao.liu@zju.edu.cn>
Received: from zju.edu.cn (spam.zju.edu.cn. [61.164.42.155])
        by gmr-mx.google.com with ESMTP id t7si327455ilh.2.2020.08.22.23.55.21
        for <linux-ntb@googlegroups.com>;
        Sat, 22 Aug 2020 23:55:23 -0700 (PDT)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Subject: [PATCH] ntb: intel: Fix memleak in intel_ntb_pci_probe
Date: Sun, 23 Aug 2020 14:55:12 +0800
Message-Id: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

The default error branch of a series of pdev_is_gen calls
should free ndev just like what we've done in these calls.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 3185efeab487..093dd20057b9 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1893,7 +1893,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 			goto err_init_dev;
 	} else {
 		rc = -EINVAL;
-		goto err_ndev;
+		goto err_init_pci;
 	}
 
 	ndev_reset_unsafe_flags(ndev);
-- 
2.17.1

