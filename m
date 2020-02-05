Return-Path: <anath.amd@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com. [2607:f8b0:4864:20::442])
        by gmr-mx.google.com with ESMTPS id h2si365770pju.2.2020.02.05.07.55.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:24 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 185so1418845pfv.3
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:24 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 12/15] NTB: return link up status correctly for PRI and SEC
Date: Wed,  5 Feb 2020 21:24:29 +0530
Message-Id: <542aee58e6c78f240da80b3de84f8fa0b88ae6ad.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Since NTB connects two physically separate systems,
there can be scenarios where one system goes down
while the other one remains active. In case of NTB
primary, if the NTB secondary goes down, a Link-Down
event is received. For the NTB secondary, if the
NTB primary goes down, the PCIe hotplug mechanism
ensures that the driver on the secondary side is also
unloaded.

But there are other scenarios to consider as well,
when suppose the physical link remains active, but
the driver on primary or secondary side is loaded
or un-loaded.

When the driver is loaded, on either side, it sets
SIDE_READY bit(bit-1) of SIDE_INFO register. Similarly,
when the driver is un-loaded, it resets the same bit.

We consider the NTB link to be up and operational
only when the driver on both sides of link are loaded
and ready. But we also need to take account of
Link Up and Down events which signify the physical
link status. So amd_link_is_up() is modified to take
care of the above scenarios.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 64 ++++++++++++++++++++++++++++++---
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d4029d531466..8a9852343de6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -245,12 +245,66 @@ static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
-	if (!ndev->peer_sta)
-		return ndev->cntl_sta;
+	int ret;
+
+	/*
+	 * We consider the link to be up under two conditions:
+	 *
+	 *   - When a link-up event is received. This is indicated by
+	 *     AMD_LINK_UP_EVENT set in peer_sta.
+	 *   - When driver on both sides of the link have been loaded.
+	 *     This is indicated by bit 1 being set in the peer
+	 *     SIDEINFO register.
+	 *
+	 * This function should return 1 when the latter of the above
+	 * two conditions is true.
+	 *
+	 * Now consider the sequence of events - Link-Up event occurs,
+	 * then the peer side driver loads. In this case, we would have
+	 * received LINK_UP event and bit 1 of peer SIDEINFO is also
+	 * set. What happens now if the link goes down? Bit 1 of
+	 * peer SIDEINFO remains set, but LINK_DOWN bit is set in
+	 * peer_sta. So we should return 0 from this function. Not only
+	 * that, we clear bit 1 of peer SIDEINFO to 0, since the peer
+	 * side driver did not even get a chance to clear it before
+	 * the link went down. This can be the case of surprise link
+	 * removal.
+	 *
+	 * LINK_UP event will always occur before the peer side driver
+	 * gets loaded the very first time. So there can be a case when
+	 * the LINK_UP event has occurred, but the peer side driver hasn't
+	 * yet loaded. We return 0 in that case.
+	 *
+	 * There is also a special case when the primary side driver is
+	 * unloaded and then loaded again. Since there is no change in
+	 * the status of NTB secondary in this case, there is no Link-Up
+	 * or Link-Down notification received. We recognize this condition
+	 * with peer_sta being set to 0.
+	 *
+	 * If bit 1 of peer SIDEINFO register is not set, then we
+	 * simply return 0 irrespective of the link up or down status
+	 * set in peer_sta.
+	 */
+	ret = amd_poll_link(ndev);
+	if (ret) {
+		/*
+		 * We need to check the below only for NTB primary. For NTB
+		 * secondary, simply checking the result of PSIDE_INFO
+		 * register will suffice.
+		 */
+		if (ndev->ntb.topo == NTB_TOPO_PRI) {
+			if ((ndev->peer_sta & AMD_LINK_UP_EVENT) ||
+			    (ndev->peer_sta == 0))
+				return ret;
+			else if (ndev->peer_sta & AMD_LINK_DOWN_EVENT) {
+				/* Clear peer sideinfo register */
+				amd_clear_side_info_reg(ndev, true);
 
-	if (ndev->peer_sta & AMD_LINK_UP_EVENT) {
-		ndev->peer_sta = 0;
-		return 1;
+				return 0;
+			}
+		} else { /* NTB_TOPO_SEC */
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 62ffdf35b683..73959c0b9972 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -217,5 +217,6 @@ struct amd_ntb_dev {
 
 static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
 static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+static int amd_poll_link(struct amd_ntb_dev *ndev);
 
 #endif
-- 
2.17.1

