Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com. [2607:f8b0:4864:20::544])
        by gmr-mx.google.com with ESMTPS id x127si3097vkc.0.2020.02.05.07.55.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:16 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j4so1171696pgi.1
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:15 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 09/15] NTB: handle link up, D0 and D3 events correctly
Date: Wed,  5 Feb 2020 21:24:26 +0530
Message-Id: <4c07c3e337fe2343d9fa0ff234c2d85543198274.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Just like for Link-Down event, Link-Up and D3 events
are also mutually exclusive to Link-Down and D0 events
respectively. So we clear the bitmasks in peer_sta
depending on event type.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d933a1dffdc6..a1c4a21c58c3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -568,6 +568,11 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	case AMD_PEER_PMETO_EVENT:
 	case AMD_LINK_UP_EVENT:
 		ndev->peer_sta |= status;
+		if (status == AMD_LINK_UP_EVENT)
+			ndev->peer_sta &= ~AMD_LINK_DOWN_EVENT;
+		else if (status == AMD_PEER_D3_EVENT)
+			ndev->peer_sta &= ~AMD_PEER_D0_EVENT;
+
 		amd_ack_smu(ndev, status);
 
 		/* link down */
@@ -582,6 +587,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 			dev_info(dev, "Wakeup is done.\n");
 
 		ndev->peer_sta |= AMD_PEER_D0_EVENT;
+		ndev->peer_sta &= ~AMD_PEER_D3_EVENT;
 		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
 
 		/* start a timer to poll link status */
-- 
2.17.1

