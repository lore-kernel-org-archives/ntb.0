Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com. [2607:f8b0:4002:c07::231])
        by gmr-mx.google.com with ESMTPS id i144si1747429ywe.2.2015.12.19.14.55.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 14:55:16 -0800 (PST)
Received: by mail-yk0-x231.google.com with SMTP id p130so97152375yka.1
        for <linux-ntb@googlegroups.com>; Sat, 19 Dec 2015 14:55:16 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Received: from arkham.kudzu.us ([98.122.145.248])
        by smtp.gmail.com with ESMTPSA id h64sm23554422ywd.46.2015.12.19.14.55.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 14:55:15 -0800 (PST)
From: Jon Mason <jdmason@kudzu.us>
Subject: [PATCH] NTB: ntb_process_tx error path bug
Date: Sat, 19 Dec 2015 17:55:07 -0500
Message-Id: <1450565707-3904-1-git-send-email-jdmason@kudzu.us>
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The transmit overrun avoidance error path in ntb_process_tx accidentally
swapped the first two values being passed to the tx_handler client.
This could result in crashes in the ntb_netdev (or other out-of-tree NTB
clients).

Reported-by: Alex Depoutovitch <alex@pernixdata.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 60654d5..bd1bcb3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1532,7 +1532,7 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
 		if (qp->tx_handler)
-			qp->tx_handler(qp->cb_data, qp, NULL, -EIO);
+			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
 
 		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
 			     &qp->tx_free_q);
-- 
2.1.4

