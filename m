Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com. [2607:f8b0:4864:20::541])
        by gmr-mx.google.com with ESMTPS id h4si10648ilf.3.2020.02.05.07.54.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:54:58 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id u131so1149508pgc.10
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:54:58 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 03/15] NTB: Enable link up and down event notification
Date: Wed,  5 Feb 2020 21:24:20 +0530
Message-Id: <1fb68eb0ee7ee636ab92bb0b3b7340c56f4a20c3.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Link-Up and Link-Down events can occur irrespective
of whether a data transfer is in progress or not.
So we need to enable the interrupt delivery for
these events early during driver load.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 150e4db11485..111f33ff2bd7 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -994,6 +994,7 @@ static enum ntb_topo amd_get_topo(struct amd_ntb_dev *ndev)
 
 static int amd_init_dev(struct amd_ntb_dev *ndev)
 {
+	void __iomem *mmio = ndev->self_mmio;
 	struct pci_dev *pdev;
 	int rc = 0;
 
@@ -1015,6 +1016,10 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
+	/* Enable Link-Up and Link-Down event interrupts */
+	ndev->int_mask &= ~(AMD_LINK_UP_EVENT | AMD_LINK_DOWN_EVENT);
+	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
+
 	return 0;
 }
 
-- 
2.17.1

