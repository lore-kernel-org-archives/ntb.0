Return-Path: <anath.amd@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com. [2607:f8b0:4864:20::442])
        by gmr-mx.google.com with ESMTPS id z20si8223ill.5.2020.02.05.07.55.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:12 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id s1so1404141pfh.10
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:12 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 08/15] NTB: handle link down event correctly
Date: Wed,  5 Feb 2020 21:24:25 +0530
Message-Id: <bff304461627e0d4b748973066b7f2d3c62b0b65.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Link-Up and Link-Down are mutually exclusive events.
So when we receive a Link-Down event, we should also
clear the bitmask for Link-Up event in peer_sta.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index e964442ae2c3..d933a1dffdc6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -551,8 +551,12 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		dev_info(dev, "Flush is done.\n");
 		break;
 	case AMD_PEER_RESET_EVENT:
-		ndev->peer_sta |= AMD_PEER_RESET_EVENT;
-		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
+	case AMD_LINK_DOWN_EVENT:
+		ndev->peer_sta |= status;
+		if (status == AMD_LINK_DOWN_EVENT)
+			ndev->peer_sta &= ~AMD_LINK_UP_EVENT;
+
+		amd_ack_smu(ndev, status);
 
 		/* link down first */
 		ntb_link_event(&ndev->ntb);
@@ -563,7 +567,6 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	case AMD_PEER_D3_EVENT:
 	case AMD_PEER_PMETO_EVENT:
 	case AMD_LINK_UP_EVENT:
-	case AMD_LINK_DOWN_EVENT:
 		ndev->peer_sta |= status;
 		amd_ack_smu(ndev, status);
 
-- 
2.17.1

