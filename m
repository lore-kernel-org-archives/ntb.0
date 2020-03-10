Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com. [40.107.237.57])
        by gmr-mx.google.com with ESMTPS id d193si366285qke.1.2020.03.10.13.55.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:55:28 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
Date: Tue, 10 Mar 2020 15:54:51 -0500
Message-Id: <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
In-Reply-To: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Arindam Nath <arindam.nath@amd.com>

perf_spad_cmd_send() and perf_msg_cmd_send() return
-EAGAIN after trying to send commands for a maximum
of MSG_TRIES re-tries. But currently there is no
handling for this error. These functions are invoked
from perf_service_work() through function pointers,
so rather than simply call these functions is not
enough. We need to make sure to invoke them again in
case of -EAGAIN. Since peer status bits were cleared
before calling these functions, we set the same status
bits before queueing the work again for later invocation.
This way we simply won't go ahead and initialize the
XLAT registers wrongfully in case sending the very first
command itself fails.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 6d16628..9068e42 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -625,14 +625,24 @@ static void perf_service_work(struct work_struct *work)
 {
 	struct perf_peer *peer = to_peer_service(work);
 
-	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
+	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SSIZE, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
 		perf_setup_inbuf(peer);
 
-	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
+	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SXLAT, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
 		perf_setup_outbuf(peer);
-- 
2.7.4

