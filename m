Return-Path: <anath.amd@gmail.com>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com. [2607:f8b0:4864:20::642])
        by gmr-mx.google.com with ESMTPS id b16si10234ion.0.2020.02.05.07.55.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:27 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p11so1033897plq.10
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:27 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 13/15] NTB: remove redundant setting of DB valid mask
Date: Wed,  5 Feb 2020 21:24:30 +0530
Message-Id: <77ab9d5b86cbf404cd254d50d26e276472014293.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

db_valid_mask is set at two places, once within
amd_init_ntb(), and again within amd_init_dev().
Since amd_init_ntb() is actually called from
amd_init_dev(), setting db_valid_mask from
former does not really make sense. So remove it.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 8a9852343de6..04be1482037b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1056,8 +1056,6 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 		return -EINVAL;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
-
 	/* Mask event interrupts */
 	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
 
-- 
2.17.1

