Return-Path: <gustavoars@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [2604:1380:4641:c500::1])
        by gmr-mx.google.com with ESMTPS id s10si147500wrt.2.2022.01.20.14.56.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 14:56:14 -0800 (PST)
Date: Thu, 20 Jan 2022 17:02:47 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
Message-ID: <20220120230247.GA40182@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ntb/msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index dd683cb58d09..6295e55ef85e 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -33,7 +33,6 @@ int ntb_msi_init(struct ntb_dev *ntb,
 {
 	phys_addr_t mw_phys_addr;
 	resource_size_t mw_size;
-	size_t struct_size;
 	int peer_widx;
 	int peers;
 	int ret;
@@ -43,9 +42,8 @@ int ntb_msi_init(struct ntb_dev *ntb,
 	if (peers <= 0)
 		return -EINVAL;
 
-	struct_size = sizeof(*ntb->msi) + sizeof(*ntb->msi->peer_mws) * peers;
-
-	ntb->msi = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
+	ntb->msi = devm_kzalloc(&ntb->dev, struct_size(ntb->msi, peer_mws, peers),
+				GFP_KERNEL);
 	if (!ntb->msi)
 		return -ENOMEM;
 
-- 
2.27.0

