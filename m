Return-Path: <anath.amd@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com. [2607:f8b0:4864:20::443])
        by gmr-mx.google.com with ESMTPS id t18si9969otq.5.2020.02.05.07.54.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:54:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 84so1413936pfy.6
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:54:55 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 02/15] NTB: clear interrupt status register
Date: Wed,  5 Feb 2020 21:24:19 +0530
Message-Id: <92dbbe6f9b6a54a2169207dbff10e1dfa6f9d3b5.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

The interrupt status register should be cleared
by driver once the particular event is handled.
The patch fixes this.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 9a60f34a37c2..150e4db11485 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -550,6 +550,9 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		dev_info(dev, "event status = 0x%x.\n", status);
 		break;
 	}
+
+	/* Clear the interrupt status */
+	writel(status, mmio + AMD_INTSTAT_OFFSET);
 }
 
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
-- 
2.17.1

