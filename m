Return-Path: <wesley.sheng@microchip.com>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com. [68.232.149.84])
        by gmr-mx.google.com with ESMTPS id z204si1846086ywa.2.2019.04.07.23.46.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:46:40 -0700 (PDT)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH 3/3] ntb_hw_switchtec: Fix setup MW with failure bug
Date: Mon, 8 Apr 2019 22:45:22 +0800
Message-ID: <1554734722-7833-4-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
References: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com, kelvin.cao@microchip.com
List-ID: <linux-ntb.googlegroups.com>

From: Joey Zhang <joey.zhang@microchip.com>

Switchtec does not support setting multiple MWs simultaneously. The 
driver takes a hardware lock to ensure that two peers are not doing this
simultaneously and it fails if someone else takes the lock. In most
cases, this is fine as clients only setup the MWs once on one side of
the link.

However, there's a race condition when a re-initialization is caused by
a link event. The driver will re-setup the shared memory window
asynchronously and this races with the client setting up it's memory
windows on the link up event.

To fix this we ensure do the entire initialization in a work queue and
signal the client once it's done.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 66 ++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 6cf15c18..fffff9a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -95,7 +95,8 @@ struct switchtec_ntb {
 	bool link_is_up;
 	enum ntb_speed link_speed;
 	enum ntb_width link_width;
-	struct work_struct link_reinit_work;
+	struct work_struct check_link_status_work;
+	bool link_force_down;
 };
 
 static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
@@ -494,33 +495,11 @@ enum switchtec_msg {
 
 static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev);
 
-static void link_reinit_work(struct work_struct *work)
-{
-	struct switchtec_ntb *sndev;
-
-	sndev = container_of(work, struct switchtec_ntb, link_reinit_work);
-
-	switchtec_ntb_reinit_peer(sndev);
-}
-
-static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
-				     enum switchtec_msg msg)
+static void switchtec_ntb_link_status_update(struct switchtec_ntb *sndev)
 {
 	int link_sta;
 	int old = sndev->link_is_up;
 
-	if (msg == MSG_LINK_FORCE_DOWN) {
-		schedule_work(&sndev->link_reinit_work);
-
-		if (sndev->link_is_up) {
-			sndev->link_is_up = 0;
-			ntb_link_event(&sndev->ntb);
-			dev_info(&sndev->stdev->dev, "ntb link forced down\n");
-		}
-
-		return;
-	}
-
 	link_sta = sndev->self_shared->link_sta;
 	if (link_sta) {
 		u64 peer = ioread64(&sndev->peer_shared->magic);
@@ -545,6 +524,38 @@ static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
 	}
 }
 
+static void check_link_status_work(struct work_struct *work)
+{
+	struct switchtec_ntb *sndev;
+
+	sndev = container_of(work, struct switchtec_ntb,
+			     check_link_status_work);
+
+	if (sndev->link_force_down) {
+		sndev->link_force_down = false;
+		switchtec_ntb_reinit_peer(sndev);
+
+		if (sndev->link_is_up) {
+			sndev->link_is_up = 0;
+			ntb_link_event(&sndev->ntb);
+			dev_info(&sndev->stdev->dev, "ntb link forced down\n");
+		}
+
+		return;
+	}
+
+	switchtec_ntb_link_status_update(sndev);
+}
+
+static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
+				      enum switchtec_msg msg)
+{
+	if (msg == MSG_LINK_FORCE_DOWN)
+		sndev->link_force_down = true;
+
+	schedule_work(&sndev->check_link_status_work);
+}
+
 static void switchtec_ntb_link_notification(struct switchtec_dev *stdev)
 {
 	struct switchtec_ntb *sndev = stdev->sndev;
@@ -577,7 +588,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
 	sndev->self_shared->link_sta = 1;
 	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
 
-	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
+	switchtec_ntb_link_status_update(sndev);
 
 	return 0;
 }
@@ -591,7 +602,7 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
 	sndev->self_shared->link_sta = 0;
 	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);
 
-	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
+	switchtec_ntb_link_status_update(sndev);
 
 	return 0;
 }
@@ -844,7 +855,8 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 	sndev->ntb.topo = NTB_TOPO_SWITCH;
 	sndev->ntb.ops = &switchtec_ntb_ops;
 
-	INIT_WORK(&sndev->link_reinit_work, link_reinit_work);
+	INIT_WORK(&sndev->check_link_status_work, check_link_status_work);
+	sndev->link_force_down = false;
 
 	sndev->self_partition = sndev->stdev->partition;
 
-- 
2.7.4

