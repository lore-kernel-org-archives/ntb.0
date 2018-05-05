Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id o81-v6si359729ita.0.2018.05.04.19.52.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:52:04 -0700 (PDT)
Subject: [PATCH 3/4] NTB : Modification to ntb_perf module
References: <20180410004822.GA6040@codeaurora.org>
 <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
 <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
 <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <63737765-0d7d-a268-21cc-66d50b2e0ca5@codeaurora.org>
Date: Fri, 4 May 2018 19:52:00 -0700
MIME-Version: 1.0
In-Reply-To: <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com; fancer.lancer@gmail.com;jdmason"@kudzu.us, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>

Hi all,

This is third patch of four series patches.
Refactor ntb_perf module to get library code out 
of it, to make use for other client. 

Regards,
Atul Raut

From a73a380c50fa09650de01f745deeb70550d8277f Mon Sep 17 00:00:00 2001
From: Atul Raut <araut@codeaurora.org>
Date: Fri, 4 May 2018 19:30:07 -0700
Subject: [PATCH 3/4] NTB : Modification to ntb_perf module

Refactor ntb_perf module to get library code
so that other client can make use of it.

Signed-off-by: Atul Raut <araut@codeaurora.org>
---
 drivers/ntb/test/ntb_perf.c | 347 +++++---------------------------------------
 1 file changed, 40 insertions(+), 307 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0..c65f81e 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -100,10 +100,6 @@
 #define DMA_TRIES		100
 #define DMA_MDELAY		10
 
-#define MSG_TRIES		500
-#define MSG_UDELAY_LOW		1000
-#define MSG_UDELAY_HIGH		2000
-
 #define PERF_BUF_LEN 1024
 
 static unsigned long max_mw_size;
@@ -127,17 +123,6 @@
  *==============================================================================
  */
 
-enum perf_cmd {
-	PERF_CMD_INVAL = -1,/* invalid spad command */
-	PERF_CMD_SSIZE = 0, /* send out buffer size */
-	PERF_CMD_RSIZE = 1, /* recv in  buffer size */
-	PERF_CMD_SXLAT = 2, /* send in  buffer xlat */
-	PERF_CMD_RXLAT = 3, /* recv out buffer xlat */
-	PERF_CMD_CLEAR = 4, /* clear allocated memory */
-	PERF_STS_DONE  = 5, /* init is done */
-	PERF_STS_LNKUP = 6, /* link up state flag */
-};
-
 struct perf_ctx;
 
 struct perf_peer {
@@ -197,36 +182,11 @@ struct perf_ctx {
 	struct perf_peer *test_peer;
 	struct perf_thread threads[MAX_THREADS_CNT];
 
-	/* Scratchpad/Message IO operations */
-	int (*cmd_send)(struct perf_peer *peer, enum perf_cmd cmd, u64 data);
-	int (*cmd_recv)(struct perf_ctx *perf, int *pidx, enum perf_cmd *cmd,
-			u64 *data);
+	struct msg_type handle;
 
 	struct dentry *dbgfs_dir;
 };
 
-/*
- * Scratchpads-base commands interface
- */
-#define PERF_SPAD_CNT(_pcnt) \
-	(3*((_pcnt) + 1))
-#define PERF_SPAD_CMD(_gidx) \
-	(3*(_gidx))
-#define PERF_SPAD_LDATA(_gidx) \
-	(3*(_gidx) + 1)
-#define PERF_SPAD_HDATA(_gidx) \
-	(3*(_gidx) + 2)
-#define PERF_SPAD_NOTIFY(_gidx) \
-	(BIT_ULL(_gidx))
-
-/*
- * Messages-base commands interface
- */
-#define PERF_MSG_CNT		3
-#define PERF_MSG_CMD		0
-#define PERF_MSG_LDATA		1
-#define PERF_MSG_HDATA		2
-
 /*==============================================================================
  *                           Static data declarations
  *==============================================================================
@@ -251,192 +211,27 @@ static inline bool perf_link_is_up(struct perf_peer *peer)
 	return !!(link & BIT_ULL_MASK(peer->pidx));
 }
 
-static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
-			      u64 data)
-{
-	struct perf_ctx *perf = peer->perf;
-	int try;
-	u32 sts;
-
-	dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
-
-	/*
-	 * Perform predefined number of attempts before give up.
-	 * We are sending the data to the port specific scratchpad, so
-	 * to prevent a multi-port access race-condition. Additionally
-	 * there is no need in local locking since only thread-safe
-	 * service work is using this method.
-	 */
-	for (try = 0; try < MSG_TRIES; try++) {
-		if (!perf_link_is_up(peer))
-			return -ENOLINK;
-
-		sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
-					 PERF_SPAD_CMD(perf->gidx));
-		if (sts != PERF_CMD_INVAL) {
-			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
-			continue;
-		}
-
-		ntb_peer_spad_write(perf->ntb, peer->pidx,
-				    PERF_SPAD_LDATA(perf->gidx),
-				    lower_32_bits(data));
-		ntb_peer_spad_write(perf->ntb, peer->pidx,
-				    PERF_SPAD_HDATA(perf->gidx),
-				    upper_32_bits(data));
-		mmiowb();
-		ntb_peer_spad_write(perf->ntb, peer->pidx,
-				    PERF_SPAD_CMD(perf->gidx),
-				    cmd);
-		mmiowb();
-		ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
-
-		dev_dbg(&perf->ntb->dev, "DB ring peer %#llx\n",
-			PERF_SPAD_NOTIFY(peer->gidx));
-
-		break;
-	}
-
-	return try < MSG_TRIES ? 0 : -EAGAIN;
-}
-
-static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
-			      enum perf_cmd *cmd, u64 *data)
-{
-	struct perf_peer *peer;
-	u32 val;
-
-	ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
-
-	/*
-	 * We start scanning all over, since cleared DB may have been set
-	 * by any peer. Yes, it makes peer with smaller index being
-	 * serviced with greater priority, but it's convenient for spad
-	 * and message code unification and simplicity.
-	 */
-	for (*pidx = 0; *pidx < perf->pcnt; (*pidx)++) {
-		peer = &perf->peers[*pidx];
-
-		if (!perf_link_is_up(peer))
-			continue;
-
-		val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
-		if (val == PERF_CMD_INVAL)
-			continue;
-
-		*cmd = val;
-
-		val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
-		*data = val;
-
-		val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
-		*data |= (u64)val << 32;
-
-		/* Next command can be retrieved from now */
-		ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
-			       PERF_CMD_INVAL);
-
-		dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
-
-		return 0;
-	}
-
-	return -ENODATA;
-}
-
-static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
-			     u64 data)
-{
-	struct perf_ctx *perf = peer->perf;
-	int try, ret;
-	u64 outbits;
-
-	dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
-
-	/*
-	 * Perform predefined number of attempts before give up. Message
-	 * registers are free of race-condition problem when accessed
-	 * from different ports, so we don't need splitting registers
-	 * by global device index. We also won't have local locking,
-	 * since the method is used from service work only.
-	 */
-	outbits = ntb_msg_outbits(perf->ntb);
-	for (try = 0; try < MSG_TRIES; try++) {
-		if (!perf_link_is_up(peer))
-			return -ENOLINK;
-
-		ret = ntb_msg_clear_sts(perf->ntb, outbits);
-		if (ret)
-			return ret;
-
-		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
-				   lower_32_bits(data));
-
-		if (ntb_msg_read_sts(perf->ntb) & outbits) {
-			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
-			continue;
-		}
-
-		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
-				   upper_32_bits(data));
-		mmiowb();
-
-		/* This call shall trigger peer message event */
-		ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD, cmd);
-
-		break;
-	}
-
-	return try < MSG_TRIES ? 0 : -EAGAIN;
-}
-
-static int perf_msg_cmd_recv(struct perf_ctx *perf, int *pidx,
-			     enum perf_cmd *cmd, u64 *data)
-{
-	u64 inbits;
-	u32 val;
-
-	inbits = ntb_msg_inbits(perf->ntb);
-
-	if (hweight64(ntb_msg_read_sts(perf->ntb) & inbits) < 3)
-		return -ENODATA;
-
-	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
-	*cmd = val;
-
-	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
-	*data = val;
-
-	val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
-	*data |= (u64)val << 32;
-
-	/* Next command can be retrieved from now */
-	ntb_msg_clear_sts(perf->ntb, inbits);
-
-	dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
-
-	return 0;
-}
-
-static int perf_cmd_send(struct perf_peer *peer, enum perf_cmd cmd, u64 data)
+static int perf_cmd_send(struct perf_peer *peer, enum nt_cmd cmd,
+		int cmd_wid, u64 data)
 {
 	struct perf_ctx *perf = peer->perf;
 
-	if (cmd == PERF_CMD_SSIZE || cmd == PERF_CMD_SXLAT)
-		return perf->cmd_send(peer, cmd, data);
+	if (cmd == NT_CMD_SSIZE || cmd == NT_CMD_SXLAT)
+		return perf->handle.cmd_send(perf->ntb, peer->pidx,
+			cmd, cmd_wid, data);
 
 	dev_err(&perf->ntb->dev, "Send invalid command\n");
 	return -EINVAL;
 }
 
-static int perf_cmd_exec(struct perf_peer *peer, enum perf_cmd cmd)
+static int perf_cmd_exec(struct perf_peer *peer, enum nt_cmd cmd)
 {
 	switch (cmd) {
-	case PERF_CMD_SSIZE:
-	case PERF_CMD_RSIZE:
-	case PERF_CMD_SXLAT:
-	case PERF_CMD_RXLAT:
-	case PERF_CMD_CLEAR:
+	case NT_CMD_SSIZE:
+	case NT_CMD_RSIZE:
+	case NT_CMD_SXLAT:
+	case NT_CMD_RXLAT:
+	case NT_CMD_CLEAR:
 		break;
 	default:
 		dev_err(&peer->perf->ntb->dev, "Exec invalid command\n");
@@ -456,19 +251,20 @@ static int perf_cmd_exec(struct perf_peer *peer, enum perf_cmd cmd)
 static int perf_cmd_recv(struct perf_ctx *perf)
 {
 	struct perf_peer *peer;
-	int ret, pidx, cmd;
+	int ret, pidx, cmd, cmd_wid;
 	u64 data;
 
-	while (!(ret = perf->cmd_recv(perf, &pidx, &cmd, &data))) {
+	while (!(ret = perf->handle.cmd_recv(perf->ntb, &pidx, &cmd,
+			&cmd_wid, &data))) {
 		peer = &perf->peers[pidx];
 
 		switch (cmd) {
-		case PERF_CMD_SSIZE:
+		case NT_CMD_SSIZE:
 			peer->inbuf_size = data;
-			return perf_cmd_exec(peer, PERF_CMD_RSIZE);
-		case PERF_CMD_SXLAT:
+			return perf_cmd_exec(peer, NT_CMD_RSIZE);
+		case NT_CMD_SXLAT:
 			peer->outbuf_xlat = data;
-			return perf_cmd_exec(peer, PERF_CMD_RXLAT);
+			return perf_cmd_exec(peer, NT_CMD_RXLAT);
 		default:
 			dev_err(&perf->ntb->dev, "Recv invalid command\n");
 			return -EINVAL;
@@ -492,11 +288,11 @@ static void perf_link_event(void *ctx)
 		lnk_up = perf_link_is_up(peer);
 
 		if (lnk_up &&
-		    !test_and_set_bit(PERF_STS_LNKUP, &peer->sts)) {
-			perf_cmd_exec(peer, PERF_CMD_SSIZE);
+		    !test_and_set_bit(NT_STS_LNKUP, &peer->sts)) {
+			perf_cmd_exec(peer, NT_CMD_SSIZE);
 		} else if (!lnk_up &&
-			   test_and_clear_bit(PERF_STS_LNKUP, &peer->sts)) {
-			perf_cmd_exec(peer, PERF_CMD_CLEAR);
+			   test_and_clear_bit(NT_STS_LNKUP, &peer->sts)) {
+			perf_cmd_exec(peer, NT_CMD_CLEAR);
 		}
 	}
 }
@@ -548,7 +344,7 @@ static int perf_setup_outbuf(struct perf_peer *peer)
 	}
 
 	/* Initialization is finally done */
-	set_bit(PERF_STS_DONE, &peer->sts);
+	set_bit(NT_STS_DONE, &peer->sts);
 
 	return 0;
 }
@@ -612,7 +408,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 	 * the code architecture, even though this method is called from service
 	 * work itself so the command will be executed right after it returns.
 	 */
-	(void)perf_cmd_exec(peer, PERF_CMD_SXLAT);
+	(void)perf_cmd_exec(peer, NT_CMD_SXLAT);
 
 	return 0;
 
@@ -626,20 +422,21 @@ static void perf_service_work(struct work_struct *work)
 {
 	struct perf_peer *peer = to_peer_service(work);
 
-	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
+	if (test_and_clear_bit(NT_CMD_SSIZE, &peer->sts))
+		perf_cmd_send(peer, NT_CMD_SSIZE, peer->gidx,
+			peer->outbuf_size);
 
-	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
+	if (test_and_clear_bit(NT_CMD_RSIZE, &peer->sts))
 		perf_setup_inbuf(peer);
 
-	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
+	if (test_and_clear_bit(NT_CMD_SXLAT, &peer->sts))
+		perf_cmd_send(peer, NT_CMD_SXLAT, peer->gidx, peer->inbuf_xlat);
 
-	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
+	if (test_and_clear_bit(NT_CMD_RXLAT, &peer->sts))
 		perf_setup_outbuf(peer);
 
-	if (test_and_clear_bit(PERF_CMD_CLEAR, &peer->sts)) {
-		clear_bit(PERF_STS_DONE, &peer->sts);
+	if (test_and_clear_bit(NT_CMD_CLEAR, &peer->sts)) {
+		clear_bit(NT_STS_DONE, &peer->sts);
 		if (test_bit(0, &peer->perf->busy_flag) &&
 		    peer == peer->perf->test_peer) {
 			dev_warn(&peer->perf->ntb->dev,
@@ -651,44 +448,6 @@ static void perf_service_work(struct work_struct *work)
 	}
 }
 
-static int perf_init_service(struct perf_ctx *perf)
-{
-	u64 mask;
-
-	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
-		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
-		return -EINVAL;
-	}
-
-	if (ntb_msg_count(perf->ntb) >= PERF_MSG_CNT) {
-		perf->cmd_send = perf_msg_cmd_send;
-		perf->cmd_recv = perf_msg_cmd_recv;
-
-		dev_dbg(&perf->ntb->dev, "Message service initialized\n");
-
-		return 0;
-	}
-
-	dev_dbg(&perf->ntb->dev, "Message service unsupported\n");
-
-	mask = GENMASK_ULL(perf->pcnt, 0);
-	if (ntb_spad_count(perf->ntb) >= PERF_SPAD_CNT(perf->pcnt) &&
-	    (ntb_db_valid_mask(perf->ntb) & mask) == mask) {
-		perf->cmd_send = perf_spad_cmd_send;
-		perf->cmd_recv = perf_spad_cmd_recv;
-
-		dev_dbg(&perf->ntb->dev, "Scratchpad service initialized\n");
-
-		return 0;
-	}
-
-	dev_dbg(&perf->ntb->dev, "Scratchpad service unsupported\n");
-
-	dev_err(&perf->ntb->dev, "Command services unsupported\n");
-
-	return -EINVAL;
-}
-
 static int perf_enable_service(struct perf_ctx *perf)
 {
 	u64 mask, incmd_bit;
@@ -701,26 +460,7 @@ static int perf_enable_service(struct perf_ctx *perf)
 	if (ret)
 		return ret;
 
-	if (perf->cmd_send == perf_msg_cmd_send) {
-		u64 inbits, outbits;
-
-		inbits = ntb_msg_inbits(perf->ntb);
-		outbits = ntb_msg_outbits(perf->ntb);
-		(void)ntb_msg_set_mask(perf->ntb, inbits | outbits);
-
-		incmd_bit = BIT_ULL(__ffs64(inbits));
-		ret = ntb_msg_clear_mask(perf->ntb, incmd_bit);
-
-		dev_dbg(&perf->ntb->dev, "MSG sts unmasked %#llx\n", incmd_bit);
-	} else {
-		scnt = ntb_spad_count(perf->ntb);
-		for (sidx = 0; sidx < scnt; sidx++)
-			ntb_spad_write(perf->ntb, sidx, PERF_CMD_INVAL);
-		incmd_bit = PERF_SPAD_NOTIFY(perf->gidx);
-		ret = ntb_db_clear_mask(perf->ntb, incmd_bit);
-
-		dev_dbg(&perf->ntb->dev, "DB bits unmasked %#llx\n", incmd_bit);
-	}
+	ret = nt_enable_messaging(perf->ntb, perf->gidx);
 	if (ret) {
 		ntb_clear_ctx(perf->ntb);
 		return ret;
@@ -739,19 +479,12 @@ static void perf_disable_service(struct perf_ctx *perf)
 
 	ntb_link_disable(perf->ntb);
 
-	if (perf->cmd_send == perf_msg_cmd_send) {
-		u64 inbits;
-
-		inbits = ntb_msg_inbits(perf->ntb);
-		(void)ntb_msg_set_mask(perf->ntb, inbits);
-	} else {
-		(void)ntb_db_set_mask(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
-	}
+	nt_disable_messaging(perf->ntb, perf->gidx);
 
 	ntb_clear_ctx(perf->ntb);
 
 	for (pidx = 0; pidx < perf->pcnt; pidx++)
-		perf_cmd_exec(&perf->peers[pidx], PERF_CMD_CLEAR);
+		perf_cmd_exec(&perf->peers[pidx], NT_CMD_CLEAR);
 
 	for (pidx = 0; pidx < perf->pcnt; pidx++)
 		flush_work(&perf->peers[pidx].service);
@@ -1046,7 +779,7 @@ static int perf_submit_test(struct perf_peer *peer)
 	struct perf_thread *pthr;
 	int tidx, ret;
 
-	if (!test_bit(PERF_STS_DONE, &peer->sts))
+	if (!test_bit(NT_STS_DONE, &peer->sts))
 		return -ENOLINK;
 
 	if (test_and_set_bit_lock(0, &perf->busy_flag))
@@ -1184,7 +917,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tLink status: %s\n",
-			test_bit(PERF_STS_LNKUP, &peer->sts) ? "up" : "down");
+			test_bit(NT_STS_LNKUP, &peer->sts) ? "up" : "down");
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
@@ -1443,7 +1176,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 
 	perf_init_threads(perf);
 
-	ret = perf_init_service(perf);
+	ret = nt_init_messaging(ntb, &perf->handle);
 	if (ret)
 		return ret;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


