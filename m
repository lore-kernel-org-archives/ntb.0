Return-Path: <sashal@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id i17si370690pjv.1.2020.06.17.18.25.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:25:38 -0700 (PDT)
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 156/172] NTB: Revert the change to use the NTB device dev for DMA allocations
Date: Wed, 17 Jun 2020 21:22:02 -0400
Message-Id: <20200618012218.607130-156-sashal@kernel.org>
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Alexander Fomichev <fomichev.ru@gmail.com>, Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 40da7d9a93c8941737ef4a1208d32c13ce017fe1 ]

Commit 417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
devices") started using the NTB device for DMA allocations which was
turns out was wrong. If the IOMMU is enabled, such alloctanions will
always fail with messages such as:

  DMAR: Allocating domain for 0000:02:00.1 failed

This is because the IOMMU has not setup the device for such use.

Change the tools back to using the PCI device for allocations seeing
it doesn't make sense to add an IOMMU group for the non-physical NTB
device. Also remove the code that sets the DMA mask as it no longer
makes sense to do this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/ntb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index c9a0912b175f..f8f75a504a58 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -311,4 +311,3 @@ static void __exit ntb_driver_exit(void)
 	bus_unregister(&ntb_bus);
 }
 module_exit(ntb_driver_exit);
-
-- 
2.25.1

