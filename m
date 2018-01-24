Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id f6si231235wre.4.2018.01.23.23.49.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 23:49:06 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id o89so3921207lfg.10
        for <linux-ntb@googlegroups.com>; Tue, 23 Jan 2018 23:49:06 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2] NTB: ntb_perf: fix cast to restricted __le32
Date: Wed, 24 Jan 2018 10:48:45 +0300
Message-Id: <20180124074845.32125-1-fancer.lancer@gmail.com>
In-Reply-To: <20180119173044.8013-1-fancer.lancer@gmail.com>
References: <20180119173044.8013-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arnd@arndb.de
Cc: gary.hook@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Sparse is whining about the u32 and __le32 mixed usage in the driver

drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
...

NTB hardware drivers shall accept CPU-endian data and translate it to
the portable formate by internal means, so the explicit conversions
are not necessary before Scratchpad/Messages API usage anymore.

Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/test/ntb_perf.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 1829a17dd461..3fded6aeda08 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -273,21 +273,21 @@ static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 
 		sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
 					 PERF_SPAD_CMD(perf->gidx));
-		if (le32_to_cpu(sts) != PERF_CMD_INVAL) {
+		if (sts != PERF_CMD_INVAL) {
 			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
 			continue;
 		}
 
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
 				    PERF_SPAD_LDATA(perf->gidx),
-				    cpu_to_le32(lower_32_bits(data)));
+				    lower_32_bits(data));
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
 				    PERF_SPAD_HDATA(perf->gidx),
-				    cpu_to_le32(upper_32_bits(data)));
+				    upper_32_bits(data));
 		mmiowb();
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
 				    PERF_SPAD_CMD(perf->gidx),
-				    cpu_to_le32(cmd));
+				    cmd);
 		mmiowb();
 		ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
 
@@ -321,21 +321,20 @@ static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
 			continue;
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
-		val = le32_to_cpu(val);
 		if (val == PERF_CMD_INVAL)
 			continue;
 
 		*cmd = val;
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
-		*data = le32_to_cpu(val);
+		*data = val;
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
-		*data |= (u64)le32_to_cpu(val) << 32;
+		*data |= (u64)val << 32;
 
 		/* Next command can be retrieved from now */
 		ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
-			       cpu_to_le32(PERF_CMD_INVAL));
+			       PERF_CMD_INVAL);
 
 		dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
 
@@ -371,7 +370,7 @@ static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 			return ret;
 
 		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
-			      cpu_to_le32(lower_32_bits(data)));
+				   lower_32_bits(data));
 
 		if (ntb_msg_read_sts(perf->ntb) & outbits) {
 			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
@@ -379,12 +378,11 @@ static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 		}
 
 		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
-			      cpu_to_le32(upper_32_bits(data)));
+				   upper_32_bits(data));
 		mmiowb();
 
 		/* This call shall trigger peer message event */
-		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD,
-			      cpu_to_le32(cmd));
+		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD, cmd);
 
 		break;
 	}
@@ -404,13 +402,13 @@ static int perf_msg_cmd_recv(struct perf_ctx *perf, int *pidx,
 		return -ENODATA;
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
-	*cmd = le32_to_cpu(val);
+	*cmd = val;
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
-	*data = le32_to_cpu(val);
+	*data = val;
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
-	*data |= (u64)le32_to_cpu(val) << 32;
+	*data |= (u64)val << 32;
 
 	/* Next command can be retrieved from now */
 	ntb_msg_clear_sts(perf->ntb, inbits);
-- 
2.12.0

