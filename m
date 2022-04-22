Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4A28E6
	for <ntb@lists.linux.dev>; Fri, 22 Apr 2022 11:39:30 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id q14so9258256ljc.12
        for <ntb@lists.linux.dev>; Fri, 22 Apr 2022 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcUqPUJi/udjv1G8nRVEEJSZRW93sNuO8u5+qwETuBw=;
        b=RopDoxRjJpK54TMjm5Eu/qpj8G0HfV8B1In5XnVHTXc9mH+VYoz1nqKwiNbcArHtPs
         SWgyFCNk9iWIYjarNs7Qyic7k8Pb3VVT6WuRFtZN23YO6ctUntlkf7LVpskPrGsJCFaC
         wZS0mjC6gUnEBtc/8oHlvKpgdjiTcZDt0qQSyYEwwfc7hihaMcHVcUYMgoQr7TGd2u2q
         uVTWfNIy+00fdodxHOuJ55GDLZ45i8iCiWiSDlMAU4WKNgBLZmfzaZ1k3ddq9lLqJbgQ
         qzBYwNn8pcRPiLKTPBspZ30tkCR/g3lQp1wRqNSXMho9obcSSDpMuz0nTp4dbS/wArDQ
         CR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcUqPUJi/udjv1G8nRVEEJSZRW93sNuO8u5+qwETuBw=;
        b=NANcGAEzWqbYKcxbDSuJtZ7ek2salN68VENRmVARpMV7pi/LnacVvx1Dxhmg9Jas+y
         4OSboo6zl2LCzOohMRawUiwWTsSEocozE0Ml7r38JFJeaUGZ6eI+XV2ipM0WsCBFa4UB
         QbTigmjOULeilz5uS4psxaIitoaY6TioSNCmpDG0qVWihpXlejCdyxYb82j9xyVJmc1R
         tdlAmLMf3eH9GEDreyThOUVMQaZNHt3LBUaYAzise4mmLBqAOlCHL8aFdr35wzPszBVn
         5GUPDvafHlDyzH+UDCazW4fVCFgCMFJ4NH05Aj+ESlCD2Bv4ETXBY3oEGG80PyouDPg6
         BIsw==
X-Gm-Message-State: AOAM533KucWu2JptqA2QVwZN2qzm87446nqMP96woZ5wfP6tIZ4fRSim
	izqt7I9dhThysB3wFr/3YHKqqkOMsoaM15ihIqc=
X-Google-Smtp-Source: ABdhPJw5OgPnfMBqZmDkSfdUvxMPCe17ANeKEaMicpfgivGA6bYyXOgUgdLOoM/o0MX4cMk5/RIE8A==
X-Received: by 2002:a05:651c:b06:b0:24d:bd4e:8e8 with SMTP id b6-20020a05651c0b0600b0024dbd4e08e8mr2425316ljr.217.1650627567562;
        Fri, 22 Apr 2022 04:39:27 -0700 (PDT)
Received: from localhost.localdomain ([178.176.79.58])
        by smtp.googlemail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm190487lji.116.2022.04.22.04.39.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:39:27 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v2 3/3] ntb_perf: extend with doorbell latency measurement
Date: Fri, 22 Apr 2022 14:37:03 +0300
Message-Id: <20220422113703.48820-3-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422113703.48820-1-fomichev.ru@gmail.com>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Fomichev <a.fomichev@yadro.com>

The proposed change extends ntb_perf with 3d of 3 new metrics. The resulting
test is fully backward compatible.

3. Doorbell latency. It's a delay between start to ring an NTB doorbell
and receiving the confirmation. The remote system needs to be run in server
mode beforehand. Then the server waits for a doorbell event and immediately
rings self doorbell to confirm.

Thanks-to: Guo Zhengkui <guozhengkui@vivo.com>
Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/ntb/test/ntb_perf.c | 541 ++++++++++++++++++++++++++++--------
 1 file changed, 420 insertions(+), 121 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index d4664410e543..26f0e801ea93 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -6,6 +6,7 @@
  *
  *   Copyright(c) 2015 Intel Corporation. All rights reserved.
  *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
+ *   Copyright(c) 2022 YADRO. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -15,6 +16,7 @@
  *
  *   Copyright(c) 2015 Intel Corporation. All rights reserved.
  *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
+ *   Copyright(c) 2022 YADRO. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -65,6 +67,22 @@
  *
  * root@self# echo 0 > $DBG_DIR/run
  * root@self# cat $DBG_DIR/run
+ *-----------------------------------------------------------------------------
+ * Eg: start latency test with peer (index 0) poll-waiting and get the metrics
+ *
+ * Server side:
+ * root@self# echo 0 > $DBG_DIR/poll_latency/run_server
+ * Client side:
+ * root@self# echo 0 > $DBG_DIR/poll_latency/run_client
+ * root@self# cat $DBG_DIR/poll_latency/run_client
+ *-----------------------------------------------------------------------------
+ * Eg: start doorbell latency test with peer (index 0) and get the metrics
+ *
+ * Server side:
+ * root@self# echo 0 > $DBG_DIR/db_latency/run_server
+ * Client side:
+ * root@self# echo 0 > $DBG_DIR/db_latency/run_client
+ * root@self# cat $DBG_DIR/db_latency/run_client
  */
 
 #include <linux/init.h>
@@ -76,6 +94,7 @@
 #include <linux/dmaengine.h>
 #include <linux/pci.h>
 #include <linux/ktime.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
@@ -85,7 +104,7 @@
 #include <linux/ntb.h>
 
 #define DRIVER_NAME		"ntb_perf"
-#define DRIVER_VERSION		"2.1"
+#define DRIVER_VERSION		"2.2"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
@@ -137,6 +156,10 @@ static unsigned long lat_timeout_us = 500;
 module_param(lat_timeout_us, ulong, 0644);
 MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");
 
+static unsigned long peer_timeout_s = 60;
+module_param(peer_timeout_s, ulong, 0644);
+MODULE_PARM_DESC(peer_timeout_s, "Timeout (in s) to wait for peer link");
+
 /*==============================================================================
  *                         Perf driver data definition
  *==============================================================================
@@ -156,9 +179,18 @@ enum perf_cmd {
 enum run_mode {
 	RUN_PL_CLIENT,
 	RUN_PL_SERVER,
+	RUN_DBL_CLIENT,
+	RUN_DBL_SERVER,
 };
 
 struct perf_ctx;
+struct perf_ext_lat_data;
+
+struct perf_ext_lat_ops {
+	int (*init)(struct perf_ext_lat_data *data);
+	int (*run)(struct perf_ext_lat_data *data);
+	void (*clear)(struct perf_ext_lat_data *data);
+};
 
 struct perf_peer {
 	struct perf_ctx	*perf;
@@ -206,20 +238,21 @@ struct perf_thread {
 #define to_thread_work(__work) \
 	container_of(__work, struct perf_thread, work)
 
-struct perf_poll_lat_data {
+struct perf_ext_lat_data {
 	struct perf_ctx *perf;
-	void *src;
 	ktime_t latency;
 	u64 tries;
 	int status;
-	atomic_t running;
-	struct work_struct clt_work;
-	struct work_struct srv_work;
+	struct perf_ext_lat_ops ops;
+	struct work_struct work;
+
+	union {
+		void *src;
+		int db;
+	};
 };
-#define to_pldata_clt_work(__work) \
-	container_of(__work, struct perf_poll_lat_data, clt_work)
-#define to_pldata_srv_work(__work) \
-	container_of(__work, struct perf_poll_lat_data, srv_work)
+#define to_ext_lat_data(__work) \
+	container_of(__work, struct perf_ext_lat_data, work)
 
 struct perf_ctx {
 	struct ntb_dev *ntb;
@@ -228,7 +261,12 @@ struct perf_ctx {
 	int gidx;
 	int pcnt;
 	struct perf_peer *peers;
-	struct perf_poll_lat_data pldata;
+
+	/* Ext latency tests interface */
+	enum run_mode mode;
+	struct perf_ext_lat_data pldata;
+	struct perf_ext_lat_data dbldata;
+	atomic_t running;
 
 	/* Performance measuring work-threads interface */
 	unsigned long busy_flag;
@@ -541,6 +579,15 @@ static void perf_link_event(void *ctx)
 	}
 }
 
+static inline void perf_dbl_pong(struct perf_ctx *perf)
+{
+	struct perf_ext_lat_data *data = &perf->dbldata;
+
+	ntb_db_clear(perf->ntb, BIT_ULL(data->db));
+	data->tries++;
+	ntb_peer_db_set(perf->ntb, BIT_ULL(data->db));
+}
+
 static void perf_db_event(void *ctx, int vec)
 {
 	struct perf_ctx *perf = ctx;
@@ -549,7 +596,11 @@ static void perf_db_event(void *ctx, int vec)
 		ntb_db_vector_mask(perf->ntb, vec), ntb_db_read(perf->ntb));
 
 	/* Just receive all available commands */
-	(void)perf_cmd_recv(perf);
+	if (perf->dbldata.db >= 0 &&
+				BIT_ULL(perf->dbldata.db) & ntb_db_read(perf->ntb))
+		perf_dbl_pong(perf);
+	else
+		(void)perf_cmd_recv(perf);
 }
 
 static void perf_msg_event(void *ctx)
@@ -704,6 +755,8 @@ static int perf_init_service(struct perf_ctx *perf)
 		return -EINVAL;
 	}
 
+	perf->dbldata.db = -1;
+
 	if (ntb_msg_count(perf->ntb) >= PERF_MSG_CNT) {
 		perf->cmd_send = perf_msg_cmd_send;
 		perf->cmd_recv = perf_msg_cmd_recv;
@@ -1153,14 +1206,14 @@ static void perf_thread_work(struct work_struct *work)
 	perf_clear_test(pthr);
 }
 
-static int perf_init_pl(struct perf_poll_lat_data *pldata)
+static int perf_init_pl(struct perf_ext_lat_data *pldata)
 {
 	struct perf_ctx *perf = pldata->perf;
 	struct perf_peer *peer = perf->test_peer;
 	u8 *bp;
 
 	pldata->src = kmalloc_node(peer->outbuf_size, GFP_KERNEL,
-				 dev_to_node(&perf->ntb->dev));
+				dev_to_node(&perf->ntb->dev));
 	if (!pldata->src)
 		return -ENOMEM;
 
@@ -1195,10 +1248,11 @@ static int perf_poll_peer_reply(volatile u8 *cur)
 	return -EINTR;
 }
 
-static int perf_run_pl_client(struct perf_poll_lat_data *pldata)
+static int perf_run_pl_client(struct perf_ext_lat_data *pldata)
 {
-	struct perf_peer *peer = pldata->perf->test_peer;
-	struct ntb_dev *ntb = pldata->perf->ntb;
+	struct perf_ctx *perf = pldata->perf;
+	struct perf_peer *peer = perf->test_peer;
+	struct ntb_dev *ntb = perf->ntb;
 	void *src = pldata->src;
 	int ret;
 	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
@@ -1222,7 +1276,7 @@ static int perf_run_pl_client(struct perf_poll_lat_data *pldata)
 		} else if (ret == 1) {
 			dev_warn(&ntb->dev, "Server terminated on poll latency, stopping\n");
 			break;
-		} else if (!atomic_read(&pldata->running)) {
+		} else if (!atomic_read(&perf->running)) {
 			dev_err(&ntb->dev, "Poll latency client terminated\n");
 			return -EINTR;
 		}
@@ -1258,10 +1312,11 @@ static int perf_run_pl_client(struct perf_poll_lat_data *pldata)
 	return 0;
 }
 
-static int perf_run_pl_server(struct perf_poll_lat_data *pldata)
+static int perf_run_pl_server(struct perf_ext_lat_data *pldata)
 {
-	struct perf_peer *peer = pldata->perf->test_peer;
-	struct ntb_dev *ntb = pldata->perf->ntb;
+	struct perf_ctx *perf = pldata->perf;
+	struct perf_peer *peer = perf->test_peer;
+	struct ntb_dev *ntb = perf->ntb;
 	void *src = pldata->src;
 	int ret = 0;
 
@@ -1269,7 +1324,7 @@ static int perf_run_pl_server(struct perf_poll_lat_data *pldata)
 
 	pldata->tries = 0;
 
-	while (ret != 1 && atomic_read(&pldata->running)) {
+	while (ret != 1 && atomic_read(&perf->running)) {
 		ret = perf_poll_peer_reply(peer->inbuf);
 		if (!ret) {
 			/* Pong to client */
@@ -1291,44 +1346,130 @@ static int perf_run_pl_server(struct perf_poll_lat_data *pldata)
 	dev_dbg(&ntb->dev, "poll_lat: server stopped, had responded %llu times\n",
 		pldata->tries);
 
-	return atomic_read(&pldata->running) ? -ENODATA : -EINTR;
+	return atomic_read(&perf->running) ? -ENODATA : -EINTR;
 }
 
-static void perf_clear_pl(struct perf_poll_lat_data *pldata)
+static void perf_clear_pl(struct perf_ext_lat_data *pldata)
 {
 	struct perf_ctx *perf = pldata->perf;
 	struct perf_peer *peer = perf->test_peer;
 
 	memset(peer->inbuf, stop_word, 1);
-	atomic_set(&pldata->running, 0);
+	atomic_set(&perf->running, 0);
 	wake_up(&perf->twait);
 	kfree(pldata->src);
 }
 
-static void perf_poll_lat_client_work(struct work_struct *work)
+static struct perf_ext_lat_ops perf_pl_client_ops = {
+	.init = perf_init_pl,
+	.run = perf_run_pl_client,
+	.clear = perf_clear_pl
+};
+
+static struct perf_ext_lat_ops perf_pl_server_ops = {
+	.init = perf_init_pl,
+	.run = perf_run_pl_server,
+	.clear = perf_clear_pl
+};
+
+static int perf_init_dbl(struct perf_ext_lat_data *data)
 {
-	struct perf_poll_lat_data *pldata = to_pldata_clt_work(work);
+	struct perf_ctx *perf = data->perf;
 
-	pldata->status = perf_init_pl(pldata);
-	if (pldata->status)
-		return;
+	data->db = get_bitmask_order(ntb_db_valid_mask(perf->ntb)) - 1;
+	dev_dbg(&perf->ntb->dev, "DB bit for latency test: %d\n", data->db);
+
+	if (data->db <= perf->gidx) {
+		dev_err(&perf->ntb->dev, "No spare DoorBell found\n");
+		data->db = -1;
+		return -ENOSPC;
+	}
+
+	return ntb_db_clear_mask(perf->ntb, BIT_ULL(data->db));
+}
+
+static int perf_run_dbl_client(struct perf_ext_lat_data *data)
+{
+	struct perf_ctx *perf = data->perf;
+	struct ntb_dev *ntb = perf->ntb;
+	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
+
+	dev_dbg(&ntb->dev, "db_lat: client started.\n");
+
+	data->tries = 0;
+	data->latency = ktime_get();
+
+	if (ntb_peer_db_set(perf->ntb, BIT_ULL(data->db)))
+		return -EIO;
+
+	while (ktime_get_real_fast_ns() < stop_at) {
+		/* Avoid processor soft lock-ups */
+		schedule();
+
+		if (!atomic_read(&perf->running)) {
+			dev_err(&ntb->dev, "DoorBell latency client terminated\n");
+			return -EINTR;
+		}
+	}
 
-	pldata->status = perf_run_pl_client(pldata);
+	/* Stop timer */
+	data->latency = ktime_sub(ktime_get(), data->latency);
+
+	if (data->tries < LAT_MIN_TRIES) {
+		dev_err(&ntb->dev, "Too few steps (%d) to measure Latency, "
+			"recommended > %d. Increase value of 'lat_time_ms' "
+			"parameter\n", data->tries, LAT_MIN_TRIES);
+		data->latency = ktime_set(0, 0);
+		return -EINVAL;
+	}
+
+	dev_dbg(&ntb->dev, "db_lat: made %llu tries, lasted %llu usecs\n",
+		data->tries, ktime_to_us(data->latency));
+
+	data->latency = ns_to_ktime(ktime_divns(data->latency, data->tries));
+
+	dev_dbg(&ntb->dev, "db_lat: latency %llu us (%llu ns)\n",
+		ktime_to_us(data->latency), ktime_to_ns(data->latency));
+
+	return 0;
+}
+
+static void perf_clear_dbl(struct perf_ext_lat_data *data)
+{
+	struct perf_ctx *perf = data->perf;
 
-	perf_clear_pl(pldata);
+	data->db = -1;
+	ntb_db_set_mask(perf->ntb, BIT_ULL(data->db));
+	atomic_set(&perf->running, 0);
+	wake_up(&perf->twait);
 }
 
-static void perf_poll_lat_server_work(struct work_struct *work)
+static struct perf_ext_lat_ops perf_dbl_client_ops = {
+	.init = perf_init_dbl,
+	.run = perf_run_dbl_client,
+	.clear = perf_clear_dbl
+};
+
+static void perf_ext_lat_work(struct work_struct *work)
 {
-	struct perf_poll_lat_data *pldata = to_pldata_srv_work(work);
+	struct perf_ext_lat_data *data = to_ext_lat_data(work);
 
-	pldata->status = perf_init_pl(pldata);
-	if (pldata->status)
+	if (!data->ops.init || !data->ops.run || !data->ops.clear) {
+		struct perf_ctx *perf = data->perf;
+
+		data->status = -EFAULT;
+		atomic_set(&perf->running, 0);
+		wake_up(&perf->twait);
 		return;
+	}
 
-	pldata->status = perf_run_pl_server(pldata);
+	data->status = data->ops.init(data);
+	if (data->status)
+		return;
 
-	perf_clear_pl(pldata);
+	data->status = data->ops.run(data);
+
+	data->ops.clear(data);
 }
 
 static int perf_set_tcnt(struct perf_ctx *perf, u8 tcnt)
@@ -1351,10 +1492,10 @@ static void perf_terminate_test(struct perf_ctx *perf)
 	int tidx;
 
 	atomic_set(&perf->tsync, -1);
-	atomic_set(&perf->pldata.running, 0);
+	atomic_set(&perf->running, 0);
 	wake_up(&perf->twait);
-	cancel_work_sync(&perf->pldata.srv_work);
-	cancel_work_sync(&perf->pldata.clt_work);
+	cancel_work_sync(&perf->pldata.work);
+	cancel_work_sync(&perf->dbldata.work);
 
 	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
 		wake_up(&perf->threads[tidx].dma_wait);
@@ -1368,9 +1509,10 @@ static int perf_submit_test(struct perf_peer *peer)
 	struct perf_thread *pthr;
 	int tidx, ret;
 
-	ret = wait_for_completion_interruptible(&peer->init_comp);
-	if (ret < 0)
-		return ret;
+	ret = wait_for_completion_interruptible_timeout(&peer->init_comp,
+			msecs_to_jiffies(peer_timeout_s * 1000));
+	if (ret <= 0)
+		return ret ? ret : -ETIMEDOUT;
 
 	if (test_and_set_bit_lock(0, &perf->busy_flag))
 		return -EBUSY;
@@ -1400,41 +1542,58 @@ static int perf_submit_test(struct perf_peer *peer)
 	return ret;
 }
 
-static int perf_submit_poll_lat(struct perf_peer *peer, enum run_mode mode)
+static int perf_submit_ext_lat(struct perf_peer *peer)
 {
 	struct perf_ctx *perf = peer->perf;
 	int ret;
 
-	ret = wait_for_completion_interruptible(&peer->init_comp);
-	if (ret < 0)
-		return ret;
+	ret = wait_for_completion_interruptible_timeout(&peer->init_comp,
+			msecs_to_jiffies(peer_timeout_s * 1000));
+	if (ret <= 0)
+		return ret ? ret : -ETIMEDOUT;
 
 	if (test_and_set_bit_lock(0, &perf->busy_flag))
 		return -EBUSY;
 
 	perf->test_peer = peer;
-	atomic_set(&perf->pldata.running, 1);
+	atomic_set(&perf->running, 1);
 	perf->pldata.status = -ENODATA;
 	perf->pldata.tries = 0;
 	perf->pldata.latency = ktime_set(0, 0);
+	perf->dbldata.status = -ENODATA;
+	perf->dbldata.tries = 0;
+	perf->dbldata.latency = ktime_set(0, 0);
 
-	switch (mode) {
+	switch (perf->mode) {
 	case RUN_PL_SERVER:
-		(void)queue_work(perf_wq, &perf->pldata.srv_work);
+		perf->pldata.ops = perf_pl_server_ops;
+		(void)queue_work(perf_wq, &perf->pldata.work);
 		break;
 	case RUN_PL_CLIENT:
-	default:
-		(void)queue_work(perf_wq, &perf->pldata.clt_work);
+		perf->pldata.ops = perf_pl_client_ops;
+		(void)queue_work(perf_wq, &perf->pldata.work);
+		break;
+	case RUN_DBL_SERVER:
+		ret = perf_init_dbl(&perf->dbldata);
+		dev_dbg(&perf->ntb->dev, "db_lat: server started.\n");
+		goto submit_exit;
+	case RUN_DBL_CLIENT:
+		perf->dbldata.ops = perf_dbl_client_ops;
+		(void)queue_work(perf_wq, &perf->dbldata.work);
 		break;
+	default:
+		ret = -EINVAL;
+		goto submit_exit;
 	}
 
 	ret = wait_event_interruptible(perf->twait,
-				       !atomic_read(&perf->pldata.running));
+				       !atomic_read(&perf->running));
 	if (ret == -ERESTARTSYS) {
 		perf_terminate_test(perf);
 		ret = -EINTR;
 	}
 
+submit_exit:
 	clear_bit_unlock(0, &perf->busy_flag);
 
 	return ret;
@@ -1482,30 +1641,12 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
 		}
 	}
 
-	if (perf->pldata.status != -ENODATA) {
-		(*pos) += scnprintf(buf + *pos, size - *pos, "\n");
-		if (perf->pldata.status) {
-			(*pos) += scnprintf(buf + *pos, size - *pos,
-				"poll latency: error status %d\n", perf->pldata.status);
-		} else {
-			if (ktime_to_us(perf->pldata.latency) < 10) {
-				(*pos) += scnprintf(buf + *pos, size - *pos,
-						"poll latency %llu ns\n",
-						ktime_to_ns(perf->pldata.latency));
-			} else {
-				(*pos) += scnprintf(buf + *pos, size - *pos,
-						"poll latency %llu us\n",
-						ktime_to_us(perf->pldata.latency));
-			}
-		}
-	}
-
 	clear_bit_unlock(0, &perf->busy_flag);
 
 	return 0;
 }
 
-static void perf_init_threads(struct perf_ctx *perf)
+static void perf_init_workers(struct perf_ctx *perf)
 {
 	struct perf_thread *pthr;
 	int tidx;
@@ -1513,11 +1654,15 @@ static void perf_init_threads(struct perf_ctx *perf)
 	perf->tcnt = DEF_THREADS_CNT;
 	perf->test_peer = &perf->peers[0];
 	init_waitqueue_head(&perf->twait);
+
 	perf->pldata.perf = perf;
-	INIT_WORK(&perf->pldata.srv_work, perf_poll_lat_server_work);
-	INIT_WORK(&perf->pldata.clt_work, perf_poll_lat_client_work);
+	INIT_WORK(&perf->pldata.work, perf_ext_lat_work);
 	perf->pldata.status = -ENODATA;
 
+	perf->dbldata.perf = perf;
+	INIT_WORK(&perf->dbldata.work, perf_ext_lat_work);
+	perf->dbldata.status = -ENODATA;
+
 	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
 		pthr = &perf->threads[tidx];
 
@@ -1529,7 +1674,7 @@ static void perf_init_threads(struct perf_ctx *perf)
 	}
 }
 
-static void perf_clear_threads(struct perf_ctx *perf)
+static void perf_clear_workers(struct perf_ctx *perf)
 {
 	perf_terminate_test(perf);
 }
@@ -1673,8 +1818,55 @@ static const struct file_operations perf_dbgfs_run = {
 	.write = perf_dbgfs_write_run
 };
 
-static ssize_t perf_dbgfs_write_run_pl(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp, enum run_mode mode)
+static ssize_t perf_dbgfs_read_run_pl(struct file *filep, char __user *ubuf,
+				   size_t fsize, loff_t *offp)
+{
+	struct perf_ctx *perf = filep->private_data;
+	ssize_t ret;
+	ssize_t pos = 0;
+	ssize_t size = PERF_BUF_LEN;
+	char *buf;
+
+	if (test_and_set_bit_lock(0, &perf->busy_flag))
+		return -EBUSY;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos += scnprintf(buf + pos, size - pos,
+		"    Peer %d test statistics:\n", perf->test_peer->pidx);
+
+	if (perf->pldata.status != -ENODATA) {
+		if (perf->pldata.status) {
+			pos += scnprintf(buf + pos, size - pos,
+				"poll latency: error status %d\n", perf->pldata.status);
+		} else {
+			if (ktime_to_us(perf->pldata.latency) < 10) {
+				pos += scnprintf(buf + pos, size - pos,
+						"poll latency %llu ns\n",
+						ktime_to_ns(perf->pldata.latency));
+			} else {
+				pos += scnprintf(buf + pos, size - pos,
+						"poll latency %llu us\n",
+						ktime_to_us(perf->pldata.latency));
+			}
+		}
+	} else {
+		pos += scnprintf(buf + pos, size - pos, "Test did not run\n");
+	}
+
+	ret = simple_read_from_buffer(ubuf, fsize, offp, buf, pos);
+
+	kfree(buf);
+
+	clear_bit_unlock(0, &perf->busy_flag);
+
+	return ret;
+}
+
+static ssize_t perf_dbgfs_write_run_ext(struct file *filep, const char __user *ubuf,
+					size_t size, loff_t *offp, enum run_mode mode)
 {
 	struct perf_ctx *perf = filep->private_data;
 	struct ntb_dev *ntb = perf->ntb;
@@ -1685,50 +1877,132 @@ static ssize_t perf_dbgfs_write_run_pl(struct file *filep, const char __user *ub
 	if (ret)
 		return ret;
 
-	if (pidx < 0 && mode == RUN_PL_SERVER) {
-		dev_dbg(&ntb->dev, "poll_lat: kill server\n");
-		if (test_bit(0, &perf->busy_flag)) {
-			peer = perf->test_peer;
-			/* Send stop to client */
-			memcpy_toio(peer->outbuf, &stop_word, 1);
+	if (pidx < 0) {
+		switch (mode) {
+		case RUN_PL_SERVER:
+			dev_dbg(&ntb->dev, "poll_lat: kill server\n");
+			if (test_bit(0, &perf->busy_flag)) {
+				peer = perf->test_peer;
+				/* Send stop to client */
+				memcpy_toio(peer->outbuf, &stop_word, 1);
+			}
+			perf_terminate_test(perf);
+			clear_bit_unlock(0, &perf->busy_flag);
+			return size;
+		case RUN_DBL_SERVER:
+			dev_dbg(&ntb->dev, "db_lat: kill server\n");
+			perf_clear_dbl(&perf->dbldata);
+			clear_bit_unlock(0, &perf->busy_flag);
+			return size;
+		default:
+			return -EINVAL;
 		}
-		perf_terminate_test(perf);
-		clear_bit_unlock(0, &perf->busy_flag);
-		return size;
 	}
 
-	if (pidx < 0 || pidx >= perf->pcnt)
+	if (pidx >= perf->pcnt)
 		return -EINVAL;
 
 	peer = &perf->peers[pidx];
+	perf->mode = mode;
 
-	ret = perf_submit_poll_lat(peer, mode);
+	ret = perf_submit_ext_lat(peer);
 
 	return ret ? ret : size;
 }
 
-static ssize_t perf_dbgfs_write_run_client(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_write_run_pl_client(struct file *filep,
+					const char __user *ubuf, size_t size, loff_t *offp)
 {
-	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_CLIENT);
+	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_PL_CLIENT);
 }
 
-static const struct file_operations perf_dbgfs_run_client = {
+static const struct file_operations perf_dbgfs_run_pl_client = {
 	.open = simple_open,
-	.read = perf_dbgfs_read_run,
-	.write = perf_dbgfs_write_run_client
+	.read = perf_dbgfs_read_run_pl,
+	.write = perf_dbgfs_write_run_pl_client
 };
 
-static ssize_t perf_dbgfs_write_run_server(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_write_run_pl_server(struct file *filep,
+					const char __user *ubuf, size_t size, loff_t *offp)
 {
-	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_SERVER);
+	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_PL_SERVER);
 }
 
-static const struct file_operations perf_dbgfs_run_server = {
+static const struct file_operations perf_dbgfs_run_pl_server = {
 	.open = simple_open,
-	.read = perf_dbgfs_read_run,
-	.write = perf_dbgfs_write_run_server
+	.read = perf_dbgfs_read_run_pl,
+	.write = perf_dbgfs_write_run_pl_server
+};
+
+static ssize_t perf_dbgfs_read_run_dbl(struct file *filep, char __user *ubuf,
+				   size_t fsize, loff_t *offp)
+{
+	struct perf_ctx *perf = filep->private_data;
+	ssize_t ret;
+	ssize_t pos = 0;
+	ssize_t size = PERF_BUF_LEN;
+	char *buf;
+
+	if (test_and_set_bit_lock(0, &perf->busy_flag))
+		return -EBUSY;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos += scnprintf(buf + pos, size - pos,
+		"    Peer %d test statistics:\n", perf->test_peer->pidx);
+
+	if (perf->dbldata.status != -ENODATA) {
+		if (perf->dbldata.status) {
+			pos += scnprintf(buf + pos, size - pos,
+				"doorbell latency: error status %d\n", perf->dbldata.status);
+		} else {
+			if (ktime_to_us(perf->dbldata.latency) < 10) {
+				pos += scnprintf(buf + pos, size - pos,
+						"doorbell latency %llu ns\n",
+						ktime_to_ns(perf->dbldata.latency));
+			} else {
+				pos += scnprintf(buf + pos, size - pos,
+						"doorbell latency %llu us\n",
+						ktime_to_us(perf->dbldata.latency));
+			}
+		}
+	} else {
+		pos += scnprintf(buf + pos, size - pos, "Test did not run\n");
+	}
+
+	ret = simple_read_from_buffer(ubuf, fsize, offp, buf, pos);
+
+	kfree(buf);
+
+	clear_bit_unlock(0, &perf->busy_flag);
+
+	return ret;
+}
+
+static ssize_t perf_dbgfs_write_run_dbl_client(struct file *filep,
+					const char __user *ubuf, size_t size, loff_t *offp)
+{
+	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_DBL_CLIENT);
+}
+
+static const struct file_operations perf_dbgfs_run_dbl_client = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_run_dbl,
+	.write = perf_dbgfs_write_run_dbl_client
+};
+
+static ssize_t perf_dbgfs_write_run_dbl_server(struct file *filep,
+					const char __user *ubuf, size_t size, loff_t *offp)
+{
+	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_DBL_SERVER);
+}
+
+static const struct file_operations perf_dbgfs_run_dbl_server = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_run_dbl,
+	.write = perf_dbgfs_write_run_dbl_server
 };
 
 static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
@@ -1782,8 +2056,7 @@ static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
 		struct perf_thread *pthr = &perf->threads[tidx];
 
 		pos += scnprintf(buf + pos, buf_size - pos,
-			"%d: made %llu tries\n",
-			tidx, pthr->tries);
+				"%d: made %llu tries\n", tidx, pthr->tries);
 	}
 
 	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
@@ -1794,7 +2067,7 @@ static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
 }
 
 static ssize_t perf_dbgfs_read_inbuf(struct file *filep, char __user *ubuf,
-				    size_t size, loff_t *offp)
+					size_t size, loff_t *offp)
 {
 	struct perf_ctx *perf = filep->private_data;
 	char buf[32];
@@ -1830,6 +2103,9 @@ static const struct file_operations perf_dbgfs_inbuf = {
 static void perf_setup_dbgfs(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
+	struct dentry *burst_lat_dir;
+	struct dentry *poll_lat_dir;
+	struct dentry *db_lat_dir;
 
 	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
 	if (!perf->dbgfs_dir) {
@@ -1840,17 +2116,10 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_file("info", 0600, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_info);
 
-	debugfs_create_file("run", 0600, perf->dbgfs_dir, perf,
-			    &perf_dbgfs_run);
+	debugfs_create_symlink("run", perf->dbgfs_dir, "burst_latency/run");
 
-	debugfs_create_file("run_client", 0600, perf->dbgfs_dir, perf,
-			    &perf_dbgfs_run_client);
-
-	debugfs_create_file("run_server", 0600, perf->dbgfs_dir, perf,
-			    &perf_dbgfs_run_server);
-
-	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
-			    &perf_dbgfs_tcnt);
+	debugfs_create_symlink("threads_count", perf->dbgfs_dir,
+				"burst_latency/threads_count");
 
 	/* They are made read-only for test exec safety and integrity */
 	debugfs_create_u8("chunk_order", 0500, perf->dbgfs_dir, &chunk_order);
@@ -1859,14 +2128,44 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 
 	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
 
-	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
+	debugfs_create_file("inbuf", 0400, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_inbuf);
+
+	/* burst_latency subdir */
+
+	burst_lat_dir = debugfs_create_dir("burst_latency", perf->dbgfs_dir);
+
+	debugfs_create_file("run", 0600, burst_lat_dir, perf, &perf_dbgfs_run);
+
+	debugfs_create_file("threads_count", 0600, burst_lat_dir, perf,
+			    &perf_dbgfs_tcnt);
+
+	debugfs_create_file("tries", 0400, burst_lat_dir, perf,
 			    &perf_dbgfs_lattrs);
 
-	debugfs_create_u64("poll_latency_tries", 0400, perf->dbgfs_dir,
-				&perf->pldata.tries);
+	/* poll_latency subdir */
 
-	debugfs_create_file("inbuf", 0400, perf->dbgfs_dir, perf,
-			    &perf_dbgfs_inbuf);
+	poll_lat_dir = debugfs_create_dir("poll_latency", perf->dbgfs_dir);
+
+	debugfs_create_file("run_client", 0600, poll_lat_dir, perf,
+			    &perf_dbgfs_run_pl_client);
+
+	debugfs_create_file("run_server", 0600, poll_lat_dir, perf,
+			    &perf_dbgfs_run_pl_server);
+
+	debugfs_create_u64("tries", 0400, poll_lat_dir, &perf->pldata.tries);
+
+	/* db_latency subdir */
+
+	db_lat_dir = debugfs_create_dir("db_latency", perf->dbgfs_dir);
+
+	debugfs_create_file("run_client", 0600, db_lat_dir, perf,
+			    &perf_dbgfs_run_dbl_client);
+
+	debugfs_create_file("run_server", 0600, db_lat_dir, perf,
+			    &perf_dbgfs_run_dbl_server);
+
+	debugfs_create_u64("tries", 0400, db_lat_dir, &perf->dbldata.tries);
 }
 
 static void perf_clear_dbgfs(struct perf_ctx *perf)
@@ -1986,7 +2285,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (ret)
 		return ret;
 
-	perf_init_threads(perf);
+	perf_init_workers(perf);
 
 	ret = perf_init_service(perf);
 	if (ret)
@@ -2009,7 +2308,7 @@ static void perf_remove(struct ntb_client *client, struct ntb_dev *ntb)
 
 	perf_disable_service(perf);
 
-	perf_clear_threads(perf);
+	perf_clear_workers(perf);
 }
 
 static struct ntb_client perf_client = {
-- 
2.30.2

