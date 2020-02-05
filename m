Return-Path: <anath.amd@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com. [2607:f8b0:4864:20::443])
        by gmr-mx.google.com with ESMTPS id t18si9969otq.5.2020.02.05.07.55.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:09 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 84so1413936pfy.6
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:09 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 07/15] NTB: remove handling of peer_sta from amd_link_is_up
Date: Wed,  5 Feb 2020 21:24:24 +0530
Message-Id: <7239c2cfca73382562ba8c6579e262b308143304.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

amd_link_is_up() is a callback to inquire whether
the NTB link is up or not. So it should not indulge
itself into clearing the bitmasks of peer_sta.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index b85af150f2c6..e964442ae2c3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -253,17 +253,6 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
 		return 1;
 	}
 
-	/* If peer_sta is reset or D0 event, the ISR has
-	 * started a timer to check link status of hardware.
-	 * So here just clear status bit. And if peer_sta is
-	 * D3 or PME_TO, D0/reset event will be happened when
-	 * system wakeup/poweron, so do nothing here.
-	 */
-	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
-		ndev->peer_sta &= ~AMD_PEER_RESET_EVENT;
-	else if (ndev->peer_sta & (AMD_PEER_D0_EVENT | AMD_LINK_DOWN_EVENT))
-		ndev->peer_sta = 0;
-
 	return 0;
 }
 
-- 
2.17.1

