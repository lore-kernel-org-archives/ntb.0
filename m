Return-Path: <anath.amd@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com. [2607:f8b0:4864:20::442])
        by gmr-mx.google.com with ESMTPS id w4si12312vse.2.2020.02.05.07.55.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id p14so1421018pfn.4
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:04 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 05/15] NTB: return the side info status from amd_poll_link
Date: Wed,  5 Feb 2020 21:24:22 +0530
Message-Id: <a6bacf6fc59017acf02ba5c69c85da2192365a59.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Bit 1 of SIDE_INFO register is an indication that
the driver on the other side of link is ready. We
set this bit during driver initialization sequence.
So rather than having separate macros to return the
status, we can simply return the status of this bit
from amd_poll_link(). So a return of 1 or 0 from
this function will indicate to the caller whether
the driver on the other side of link is ready or not,
respectively.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 +++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index f50537e0917b..84723420d70b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -246,7 +246,7 @@ static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
 	if (!ndev->peer_sta)
-		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
+		return ndev->cntl_sta;
 
 	if (ndev->peer_sta & AMD_LINK_UP_EVENT) {
 		ndev->peer_sta = 0;
@@ -896,16 +896,15 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 	u32 reg;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
-	reg &= NTB_LIN_STA_ACTIVE_BIT;
+	reg &= AMD_SIDE_READY;
 
 	dev_dbg(&ndev->ntb.pdev->dev, "%s: reg_val = 0x%x.\n", __func__, reg);
 
-	if (reg == ndev->cntl_sta)
-		return 0;
-
 	ndev->cntl_sta = reg;
 
-	return amd_ntb_get_link_status(ndev);
+	amd_ntb_get_link_status(ndev);
+
+	return ndev->cntl_sta;
 }
 
 static void amd_link_hb(struct work_struct *work)
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 39e5d18e12ff..156a4a92b803 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,10 +53,8 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
-#define NTB_LIN_STA_ACTIVE_BIT	0x00000002
 #define NTB_LNK_STA_SPEED_MASK	0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK	0x03F00000
-#define NTB_LNK_STA_ACTIVE(x)	(!!((x) & NTB_LIN_STA_ACTIVE_BIT))
 #define NTB_LNK_STA_SPEED(x)	(((x) & NTB_LNK_STA_SPEED_MASK) >> 16)
 #define NTB_LNK_STA_WIDTH(x)	(((x) & NTB_LNK_STA_WIDTH_MASK) >> 20)
 
-- 
2.17.1

