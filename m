Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id h23si897631wmi.1.2016.12.13.15.49.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:30 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id p100so220325lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:30 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 3/9] NTB: Alter link-state API to support multi-port devices
Date: Wed, 14 Dec 2016 02:49:15 +0300
Message-Id: <1481672961-10753-4-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
 <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Multi-port devices permit the NTB connections between multiple domains,
so a local device can have NTB link being up with one peer and being
down with another. NTB link-state API is appropriately altered to return
a bitfield of the link-states between the local device and possible peers.

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c |  2 +-
 include/linux/ntb.h                 | 31 ++++++++++++++++---------------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 6ccba0d..4d8d0bd 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -213,7 +213,7 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
 	return 0;
 }
 
-static int amd_ntb_link_is_up(struct ntb_dev *ntb,
+static u64 amd_ntb_link_is_up(struct ntb_dev *ntb,
 			      enum ntb_speed *speed,
 			      enum ntb_width *width)
 {
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index d2ce280..725ffa4 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1171,7 +1171,7 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
-static int intel_ntb_link_is_up(struct ntb_dev *ntb,
+static u64 intel_ntb_link_is_up(struct ntb_dev *ntb,
 				enum ntb_speed *speed,
 				enum ntb_width *width)
 {
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index fe175c7..6eef109 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -235,7 +235,7 @@ struct ntb_dev_ops {
 	int (*peer_port_number)(struct ntb_dev *ntb, int pidx);
 	int (*peer_port_idx)(struct ntb_dev *ntb, int port);
 
-	int (*link_is_up)(struct ntb_dev *ntb,
+	u64 (*link_is_up)(struct ntb_dev *ntb,
 			  enum ntb_speed *speed, enum ntb_width *width);
 	int (*link_enable)(struct ntb_dev *ntb,
 			   enum ntb_speed max_speed, enum ntb_width max_width);
@@ -607,25 +607,26 @@ static inline int ntb_peer_port_idx(struct ntb_dev *ntb, int port)
  * state once after every link event.  It is safe to query the link state in
  * the context of the link event callback.
  *
- * Return: One if the link is up, zero if the link is down, otherwise a
- *		negative value indicating the error number.
+ * Return: bitfield of indexed ports link state: bit is set/cleared if the
+ *         link is up/down respectively.
  */
-static inline int ntb_link_is_up(struct ntb_dev *ntb,
+static inline u64 ntb_link_is_up(struct ntb_dev *ntb,
 				 enum ntb_speed *speed, enum ntb_width *width)
 {
 	return ntb->ops->link_is_up(ntb, speed, width);
 }
 
 /**
- * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * ntb_link_enable() - enable the local port ntb connection
  * @ntb:	NTB device context.
  * @max_speed:	The maximum link speed expressed as PCIe generation number.
  * @max_width:	The maximum link width expressed as the number of PCIe lanes.
  *
- * Enable the link on the secondary side of the ntb.  This can only be done
- * from the primary side of the ntb in primary or b2b topology.  The ntb device
- * should train the link to its maximum speed and width, or the requested speed
- * and width, whichever is smaller, if supported.
+ * Enable the NTB/PCIe link on the local or remote (for bridge-to-bridge
+ * topology) side of the bridge. If it's supported the ntb device should train
+ * the link to its maximum speed and width, or the requested speed and width,
+ * whichever is smaller. Some hardware doesn't support PCIe link training, so
+ * the last two arguments will be ignored then.
  *
  * Return: Zero on success, otherwise an error number.
  */
@@ -637,14 +638,14 @@ static inline int ntb_link_enable(struct ntb_dev *ntb,
 }
 
 /**
- * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * ntb_link_disable() - disable the local port ntb connection
  * @ntb:	NTB device context.
  *
- * Disable the link on the secondary side of the ntb.  This can only be
- * done from the primary side of the ntb in primary or b2b topology.  The ntb
- * device should disable the link.  Returning from this call must indicate that
- * a barrier has passed, though with no more writes may pass in either
- * direction across the link, except if this call returns an error number.
+ * Disable the link on the local or remote (for b2b topology) of the ntb.
+ * The ntb device should disable the link.  Returning from this call must
+ * indicate that a barrier has passed, though with no more writes may pass in
+ * either direction across the link, except if this call returns an error
+ * number.
  *
  * Return: Zero on success, otherwise an error number.
  */
-- 
2.6.6

