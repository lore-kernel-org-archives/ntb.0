Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id b10si212231wmc.0.2018.01.19.09.30.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 09:30:55 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id g72so2998236lfg.5
        for <linux-ntb@googlegroups.com>; Fri, 19 Jan 2018 09:30:55 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH] NTB: ntb_perf: fix cast to restricted __le32
Date: Fri, 19 Jan 2018 20:30:44 +0300
Message-Id: <20180119173044.8013-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@gmail.com
Cc: gary.hook@amd.com, arnd@arndb.de, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Sparse is whining about the u32 and __le32 mixed usage in the
driver.

drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
...

The NTB API can't be changed so ntb_spad_*() methods
would return either pure __le32 or __be32, since the scratchpad
data can have arbitrary endianness in general. In this case we
need to forcibly cast all the u32 to be __le32 and vise-versa
where it's supposed to be in accordance with the driver logic.

Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/test/ntb_perf.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index eaa252b71f82..5590aaf8e8a5 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -283,21 +283,21 @@ static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 
 		sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
 					 PERF_SPAD_CMD(perf->gidx));
-		if (le32_to_cpu(sts) != PERF_CMD_INVAL) {
+		if (le32_to_cpu((__force __le32)sts) != PERF_CMD_INVAL) {
 			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
 			continue;
 		}
 
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
-				    PERF_SPAD_LDATA(perf->gidx),
-				    cpu_to_le32(lower_32_bits(data)));
+				PERF_SPAD_LDATA(perf->gidx),
+				(__force u32)cpu_to_le32(lower_32_bits(data)));
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
-				    PERF_SPAD_HDATA(perf->gidx),
-				    cpu_to_le32(upper_32_bits(data)));
+				PERF_SPAD_HDATA(perf->gidx),
+				(__force u32)cpu_to_le32(upper_32_bits(data)));
 		mmiowb();
 		ntb_peer_spad_write(perf->ntb, peer->pidx,
 				    PERF_SPAD_CMD(perf->gidx),
-				    cpu_to_le32(cmd));
+				    (__force u32)cpu_to_le32(cmd));
 		mmiowb();
 		ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
 
@@ -331,21 +331,21 @@ static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
 			continue;
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
-		val = le32_to_cpu(val);
+		val = le32_to_cpu((__force __le32)val);
 		if (val == PERF_CMD_INVAL)
 			continue;
 
 		*cmd = val;
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
-		*data = le32_to_cpu(val);
+		*data = le32_to_cpu((__force __le32)val);
 
 		val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
-		*data |= (u64)le32_to_cpu(val) << 32;
+		*data |= (u64)le32_to_cpu((__force __le32)val) << 32;
 
 		/* Next command can be retrieved from now */
 		ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
-			       cpu_to_le32(PERF_CMD_INVAL));
+			       (__force u32)cpu_to_le32(PERF_CMD_INVAL));
 
 		dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
 
@@ -381,7 +381,7 @@ static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 			return ret;
 
 		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
-			      cpu_to_le32(lower_32_bits(data)));
+				(__force u32)cpu_to_le32(lower_32_bits(data)));
 
 		if (ntb_msg_read_sts(perf->ntb) & outbits) {
 			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
@@ -389,12 +389,12 @@ static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
 		}
 
 		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
-			      cpu_to_le32(upper_32_bits(data)));
+				(__force u32)cpu_to_le32(upper_32_bits(data)));
 		mmiowb();
 
 		/* This call shall trigger peer message event */
 		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD,
-			      cpu_to_le32(cmd));
+				   (__force u32)cpu_to_le32(cmd));
 
 		break;
 	}
@@ -414,13 +414,13 @@ static int perf_msg_cmd_recv(struct perf_ctx *perf, int *pidx,
 		return -ENODATA;
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
-	*cmd = le32_to_cpu(val);
+	*cmd = le32_to_cpu((__force __le32)val);
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
-	*data = le32_to_cpu(val);
+	*data = le32_to_cpu((__force __le32)val);
 
 	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
-	*data |= (u64)le32_to_cpu(val) << 32;
+	*data |= (u64)le32_to_cpu((__force __le32)val) << 32;
 
 	/* Next command can be retrieved from now */
 	ntb_msg_clear_sts(perf->ntb, inbits);
-- 
2.12.0

