Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t123si11539vkb.1.2017.11.28.14.01.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 14:01:54 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 28 Nov 2017 15:01:44 -0700
Message-Id: <20171128220144.13294-1-logang@deltatee.com>
Subject: [PATCH] ntb_hw_switchtec: Force down the peer's link before initializing
To: linux-ntb@googlegroups.com, ThanhTuThai <cruisethai@gmail.com>
Cc: jdmason@kudzu.us, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

If one host crashes and soft reboots, the other host may not see a
link down event. Then when the crashed host comes back up, the
surviving host may not know the link was reset and the ntb clients
may not work without being reset.

To solve this, we send a LINK_FORCE_DOWN message to each peer every
time we come up, before we register the ntb device. If a surving
host still thinks the link is up it will take it down immediately.
In this way, once the crashed host comes up fully, it will send a
regular link up event as per usual and the link will be properly
restarted.

While we are in the area, this also fixes the MSG_LINK_UP message that
was in the link down function that was reported by Doug Meyers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reported-by: ThanhTuThai <cruisethai@gmail.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d71744904b19..5cfcd4deadaf 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -463,18 +463,30 @@ static void switchtec_ntb_set_link_speed(struct switchtec_ntb *sndev)
 	sndev->link_width = min(self_width, peer_width);
 }

-enum {
+enum switchtec_msg {
 	LINK_MESSAGE = 0,
 	MSG_LINK_UP = 1,
 	MSG_LINK_DOWN = 2,
 	MSG_CHECK_LINK = 3,
+	MSG_LINK_FORCE_DOWN = 4,
 };

-static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
+static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
+				     enum switchtec_msg msg)
 {
 	int link_sta;
 	int old = sndev->link_is_up;

+	if (msg == MSG_LINK_FORCE_DOWN) {
+		if (sndev->link_is_up) {
+			sndev->link_is_up = 0;
+			ntb_link_event(&sndev->ntb);
+			dev_info(&sndev->stdev->dev, "ntb link forced down\n");
+		}
+
+		return;
+	}
+
 	link_sta = sndev->self_shared->link_sta;
 	if (link_sta) {
 		u64 peer = ioread64(&sndev->peer_shared->magic);
@@ -500,7 +512,7 @@ static void switchtec_ntb_link_notification(struct switchtec_dev *stdev)
 {
 	struct switchtec_ntb *sndev = stdev->sndev;

-	switchtec_ntb_check_link(sndev);
+	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
 }

 static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
@@ -528,7 +540,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
 	sndev->self_shared->link_sta = 1;
 	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);

-	switchtec_ntb_check_link(sndev);
+	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);

 	return 0;
 }
@@ -540,9 +552,9 @@ static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
 	dev_dbg(&sndev->stdev->dev, "disabling link\n");

 	sndev->self_shared->link_sta = 0;
-	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
+	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);

-	switchtec_ntb_check_link(sndev);
+	switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);

 	return 0;
 }
@@ -1061,7 +1073,7 @@ static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
 			iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);

 			if (i == LINK_MESSAGE)
-				switchtec_ntb_check_link(sndev);
+				switchtec_ntb_check_link(sndev, msg);
 		}
 	}

@@ -1159,6 +1171,13 @@ static int switchtec_ntb_add(struct device *dev,
 	if (rc)
 		goto deinit_shared_and_exit;

+	/*
+	 * If this host crashed, the other host may think the link is
+	 * still up. Tell them to force it down (it will go back up
+	 * once we register the ntb device).
+	 */
+	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_FORCE_DOWN);
+
 	rc = ntb_register_device(&sndev->ntb);
 	if (rc)
 		goto deinit_and_exit;
--
2.11.0
