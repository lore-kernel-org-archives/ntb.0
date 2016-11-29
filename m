Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id s81si354714wmf.3.2016.11.29.09.16.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:01 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id 98so13272887lfs.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:01 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 06/22] NTB: Slightly alter link state NTB API
Date: Tue, 29 Nov 2016 20:16:01 +0300
Message-Id: <1480439777-1080-7-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Some minor changes of link state NTB API. Particularly link_is_up()
method from now shall return a bitfield of link states for all accessible
port indexes.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index fc9d034..a59a155 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -221,7 +221,7 @@ struct ntb_dev_ops {
 	int (*peer_port_number)(struct ntb_dev *ntb, int pidx);
 	int (*peer_port_idx)(struct ntb_dev *ntb, int port);
 
-	int (*link_is_up)(struct ntb_dev *ntb,
+	u64 (*link_is_up)(struct ntb_dev *ntb,
 			  enum ntb_speed *speed, enum ntb_width *width);
 	int (*link_enable)(struct ntb_dev *ntb,
 			   enum ntb_speed max_speed, enum ntb_width max_width);
@@ -567,25 +567,26 @@ static inline int ntb_peer_port_idx(struct ntb_dev *ntb, int port)
  * state once after every link event.  It is safe to query the link state in
  * the context of the link event callback.
  *
- * Return: One if the link is up, zero if the link is down, otherwise a
- *		negative value indicating the error number.
+ * Return: bitfield of indexed ports link state: bit is set/cleared if the
+ *         link is up/down respectively, otherwise a negative value indicating
+ *         an error number.
  */
-static inline int ntb_link_is_up(struct ntb_dev *ntb,
+static inline u64 ntb_link_is_up(struct ntb_dev *ntb,
 				 enum ntb_speed *speed, enum ntb_width *width)
 {
 	return ntb->ops->link_is_up(ntb, speed, width);
 }
 
 /**
- * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * ntb_link_enable() - enable the link of the ntb
  * @ntb:	NTB device context.
  * @max_speed:	The maximum link speed expressed as PCIe generation number.
  * @max_width:	The maximum link width expressed as the number of PCIe lanes.
  *
- * Enable the link on the secondary side of the ntb.  This can only be done
- * from the primary side of the ntb in primary or b2b topology.  The ntb device
- * should train the link to its maximum speed and width, or the requested speed
- * and width, whichever is smaller, if supported.
+ * Enable the NTB/PCIe link on the local or remote (for bridge-to-bridge
+ * topology) side of the bridge. The ntb device should train the link to its
+ * maximum speed and width, or the requested speed and width, whichever is
+ * smaller, if supported.
  *
  * Return: Zero on success, otherwise an error number.
  */
@@ -597,14 +598,14 @@ static inline int ntb_link_enable(struct ntb_dev *ntb,
 }
 
 /**
- * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * ntb_link_disable() - disable the link of the ntb
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

