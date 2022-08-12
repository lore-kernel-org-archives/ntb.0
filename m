Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE72115
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 16:56:48 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id w5so2108427lfq.5
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1xMFzCnfGLqmET7EMzacXq8bxPd0LvBc4Z1HAbjZYB8=;
        b=Ji0/eBM0BcqOCSYXKN4ikE0+oiHodZwVVVFx5Jl2r6WenYXn498pvZE+GkDTVPUyYS
         75ELBUzTluzznNiNHSPAzL4W0tEzb/wE2+VOTgflEYXvfwEXkhpt9wP/fBzcp3BHZHgJ
         5Tfi/3opdTqyE06G9E19krkUdmUxibjR+HQB7uJxyyz0XlTVH/QEGzWg+HHC52qbB8Gl
         mBVEM2ZwzKOKOBwkmwyf8U0IHz57Wbntj1JvLAgu3bQ3AoqxbcBysHTdZsMc0weA2J/O
         lAW0aNExwrr610a5odB01oNb7RKExI5b7kVpUN4TaPQ7BvjrxfJArMD2P04ZWmvgVPxB
         lNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1xMFzCnfGLqmET7EMzacXq8bxPd0LvBc4Z1HAbjZYB8=;
        b=RQefVZ0F1bflfrFGOIcDiuqJHo2GMGRDm5I8Z7xmhySPmn8hr9wavUSlyht/wvja3W
         w5zbRohzKi9ZG9DSsT9JotpdvwRschYHBnbOvfWOOXMttqdUsbIubTyOGYSDUo6cgiBp
         POLB32ntD+xQEMEkYJF7ZMjkJlF9SZGFxo3wUTpKtVH62x5ng9Zmg/7AjXS36kPZ2fXG
         qQ9Hvei6shTZMhMUR3WVn9vd9ZzQ1dDKZioF2S/I2ccYkgtFY35hUauzVogPOzBOkml8
         qN8LzZOt+KrpbkKzjf6idD/2VCfVwr5bgtgGi6RRWjgf4WemZbpzwT73nv+rGNyysWiI
         ZEvA==
X-Gm-Message-State: ACgBeo1fcTN/5sXj9C8Rf/vZGwNea6Hf05K3m19vOEgstjjSviPISfmt
	9D/ZSVjyrlHNOuss2euJyZdcAujNQsgooA==
X-Google-Smtp-Source: AA6agR5ZqvE9nq0y4zZaFAanN15vjVtrCiCsqEgD99tWE7iKooKEK0C7Y+7zQDz/Y+/kOi3D5DQ9WA==
X-Received: by 2002:ac2:5190:0:b0:48b:29b2:4755 with SMTP id u16-20020ac25190000000b0048b29b24755mr1449826lfi.23.1660323406449;
        Fri, 12 Aug 2022 09:56:46 -0700 (PDT)
Received: from localhost.localdomain ([62.217.189.101])
        by smtp.googlemail.com with ESMTPSA id m13-20020a056512358d00b0048a7fa5bff1sm266146lfr.248.2022.08.12.09.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:56:45 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v4 2/3] ntb_perf: extend with poll latency measurement
Date: Fri, 12 Aug 2022 19:55:43 +0300
Message-Id: <20220812165544.26307-3-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812165544.26307-1-fomichev.ru@gmail.com>
References: <20220812165544.26307-1-fomichev.ru@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Fomichev <a.fomichev@yadro.com>

Poll latency is a delay between start to send 1 byte to the
remote system and receiving the confirmation. The remote system needs to
be run in server mode beforehand. Then the server polls the input buffer
and on receiving data immediately sends the confirmation back.

Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/ntb/test/ntb_perf.c | 375 +++++++++++++++++++++++++++++++++++-
 1 file changed, 374 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 7bcd5a07c9b3..f7ecf4524c67 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -67,6 +67,14 @@
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
  */
 
 #include <linux/init.h>
@@ -87,7 +95,7 @@
 #include <linux/ntb.h>
 
 #define DRIVER_NAME		"ntb_perf"
-#define DRIVER_VERSION		"2.1"
+#define DRIVER_VERSION		"2.2"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
@@ -135,6 +143,10 @@ static unsigned long lat_time_ms = 1000; /* default 1s */
 module_param(lat_time_ms, ulong, 0644);
 MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
 
+static unsigned long lat_timeout_us = 500;
+module_param(lat_timeout_us, ulong, 0644);
+MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");
+
 /*==============================================================================
  *                         Perf driver data definition
  *==============================================================================
@@ -151,6 +163,11 @@ enum perf_cmd {
 	PERF_STS_LNKUP = 6, /* link up state flag */
 };
 
+enum run_mode {
+	RUN_PL_CLIENT,
+	RUN_PL_SERVER,
+};
+
 struct perf_ctx;
 
 struct perf_peer {
@@ -199,6 +216,21 @@ struct perf_thread {
 #define to_thread_work(__work) \
 	container_of(__work, struct perf_thread, work)
 
+struct perf_poll_lat_data {
+	struct perf_ctx *perf;
+	void *src;
+	ktime_t latency;
+	u64 tries;
+	int status;
+	atomic_t running;
+	struct work_struct clt_work;
+	struct work_struct srv_work;
+};
+#define to_pldata_clt_work(__work) \
+	container_of(__work, struct perf_poll_lat_data, clt_work)
+#define to_pldata_srv_work(__work) \
+	container_of(__work, struct perf_poll_lat_data, srv_work)
+
 struct perf_ctx {
 	struct ntb_dev *ntb;
 
@@ -206,6 +238,7 @@ struct perf_ctx {
 	int gidx;
 	int pcnt;
 	struct perf_peer *peers;
+	struct perf_poll_lat_data pldata;
 
 	/* Performance measuring work-threads interface */
 	unsigned long busy_flag;
@@ -254,6 +287,8 @@ static struct dentry *perf_dbgfs_topdir;
 
 static struct workqueue_struct *perf_wq __read_mostly;
 
+static const u8 stop_word = 0xFF;
+
 /*==============================================================================
  *                  NTB cross-link commands execution service
  *==============================================================================
@@ -1130,6 +1165,186 @@ static void perf_thread_work(struct work_struct *work)
 	perf_clear_test(pthr);
 }
 
+static int perf_init_pl(struct perf_poll_lat_data *pldata)
+{
+	struct perf_ctx *perf = pldata->perf;
+	struct perf_peer *peer = perf->test_peer;
+	u8 *bp;
+
+	pldata->src = kmalloc_node(peer->outbuf_size, GFP_KERNEL,
+				 dev_to_node(&perf->ntb->dev));
+	if (!pldata->src)
+		return -ENOMEM;
+
+	/*
+	 * Prepare random data to send, guaranteed exclusion of 0x00 (unreceived)
+	 * and 0xFF (stop_word)
+	 */
+	get_random_bytes(pldata->src, peer->outbuf_size);
+	for (bp = pldata->src; bp < (u8 *) pldata->src + peer->outbuf_size; bp++)
+		while (*bp == 0 || *bp == stop_word)
+			*bp = (u8)get_random_int();
+
+	memset(peer->inbuf, 0, peer->inbuf_size);
+
+	return 0;
+}
+
+static int perf_poll_peer_reply(volatile u8 *cur)
+{
+	u64 wait_till = ktime_get_real_fast_ns() + lat_timeout_us * NSEC_PER_USEC;
+
+	while (ktime_get_real_fast_ns() < wait_till) {
+		if (*cur == stop_word) {
+			*cur = 0;
+			return 1;
+		}
+		if (*cur != 0) {
+			*cur = 0;
+			return 0;
+		}
+	}
+	return -EINTR;
+}
+
+static int perf_run_pl_client(struct perf_poll_lat_data *pldata)
+{
+	struct perf_peer *peer = pldata->perf->test_peer;
+	struct ntb_dev *ntb = pldata->perf->ntb;
+	void *src = pldata->src;
+	u64 stop_at;
+	int ret;
+
+	dev_dbg(&ntb->dev, "poll_lat: client started.\n");
+
+	pldata->tries = 0;
+	pldata->latency = ktime_get();
+
+	stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
+	while (ktime_get_real_fast_ns() < stop_at) {
+		memcpy_toio(peer->outbuf, src, 1);
+
+		/* Avoid processor soft lock-ups */
+		schedule();
+
+		ret = perf_poll_peer_reply(peer->inbuf);
+		if (ret < 0) {
+			dev_err(&ntb->dev, "Timeout waiting for peer reply on poll latency\n");
+			pldata->latency = ktime_set(0, 0);
+			return -EINTR;
+		} else if (ret == 1) {
+			dev_warn(&ntb->dev, "Server terminated on poll latency, stopping\n");
+			break;
+		} else if (!atomic_read(&pldata->running)) {
+			dev_err(&ntb->dev, "Poll latency client terminated\n");
+			return -EINTR;
+		}
+
+		pldata->tries++;
+		src++;
+
+		if (src >= pldata->src + peer->outbuf_size)
+			src = pldata->src;
+	}
+
+	/* Stop timer */
+	pldata->latency = ktime_sub(ktime_get(), pldata->latency);
+	/* Send stop to peer */
+	memcpy_toio(peer->outbuf, &stop_word, 1);
+
+	if (pldata->tries < LAT_MIN_TRIES) {
+		dev_warn(&ntb->dev,
+			"Too few steps (%llu) to measure Latency, results may be inaccurate\n",
+			pldata->tries);
+		dev_warn(&ntb->dev,
+			"To perform > %d steps, increase value of 'lat_time_ms' parameter\n",
+			LAT_MIN_TRIES);
+	}
+
+	dev_dbg(&ntb->dev, "poll_lat: made %llu tries, lasted %llu usecs\n",
+		pldata->tries, ktime_to_us(pldata->latency));
+
+	pldata->latency = ns_to_ktime(ktime_divns(pldata->latency, pldata->tries));
+
+	dev_dbg(&ntb->dev, "poll_lat: latency %llu us (%llu ns)\n",
+		ktime_to_us(pldata->latency), ktime_to_ns(pldata->latency));
+
+	return 0;
+}
+
+static int perf_run_pl_server(struct perf_poll_lat_data *pldata)
+{
+	struct perf_peer *peer = pldata->perf->test_peer;
+	struct ntb_dev *ntb = pldata->perf->ntb;
+	void *src = pldata->src;
+	int ret = 0;
+
+	dev_dbg(&ntb->dev, "poll_lat: server started.\n");
+
+	pldata->tries = 0;
+
+	while (ret != 1 && atomic_read(&pldata->running)) {
+		ret = perf_poll_peer_reply(peer->inbuf);
+		if (!ret) {
+			/* Pong to client */
+			memcpy_toio(peer->outbuf, src++, 1);
+			if (src >= pldata->src + peer->outbuf_size)
+				src = pldata->src;
+
+			pldata->tries++;
+		}
+
+		/* Avoid processor soft lock-ups */
+		schedule();
+	}
+
+	if (pldata->tries < LAT_MIN_TRIES)
+		dev_warn(&ntb->dev,
+			"Poll latency test terminated too early. Increase client's test time\n");
+
+	dev_dbg(&ntb->dev, "poll_lat: server stopped, had responded %llu times\n",
+		pldata->tries);
+
+	return atomic_read(&pldata->running) ? -ENODATA : -EINTR;
+}
+
+static void perf_clear_pl(struct perf_poll_lat_data *pldata)
+{
+	struct perf_ctx *perf = pldata->perf;
+	struct perf_peer *peer = perf->test_peer;
+
+	memset(peer->inbuf, stop_word, 1);
+	atomic_set(&pldata->running, 0);
+	wake_up(&perf->twait);
+	kfree(pldata->src);
+}
+
+static void perf_poll_lat_client_work(struct work_struct *work)
+{
+	struct perf_poll_lat_data *pldata = to_pldata_clt_work(work);
+
+	pldata->status = perf_init_pl(pldata);
+	if (pldata->status)
+		return;
+
+	pldata->status = perf_run_pl_client(pldata);
+
+	perf_clear_pl(pldata);
+}
+
+static void perf_poll_lat_server_work(struct work_struct *work)
+{
+	struct perf_poll_lat_data *pldata = to_pldata_srv_work(work);
+
+	pldata->status = perf_init_pl(pldata);
+	if (pldata->status)
+		return;
+
+	pldata->status = perf_run_pl_server(pldata);
+
+	perf_clear_pl(pldata);
+}
+
 static int perf_set_tcnt(struct perf_ctx *perf, u8 tcnt)
 {
 	if (tcnt == 0 || tcnt > MAX_THREADS_CNT)
@@ -1150,7 +1365,10 @@ static void perf_terminate_test(struct perf_ctx *perf)
 	int tidx;
 
 	atomic_set(&perf->tsync, -1);
+	atomic_set(&perf->pldata.running, 0);
 	wake_up(&perf->twait);
+	cancel_work_sync(&perf->pldata.srv_work);
+	cancel_work_sync(&perf->pldata.clt_work);
 
 	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
 		wake_up(&perf->threads[tidx].dma_wait);
@@ -1196,6 +1414,46 @@ static int perf_submit_test(struct perf_peer *peer)
 	return ret;
 }
 
+static int perf_submit_poll_lat(struct perf_peer *peer, enum run_mode mode)
+{
+	struct perf_ctx *perf = peer->perf;
+	int ret;
+
+	ret = wait_for_completion_interruptible(&peer->init_comp);
+	if (ret < 0)
+		return ret;
+
+	if (test_and_set_bit_lock(0, &perf->busy_flag))
+		return -EBUSY;
+
+	perf->test_peer = peer;
+	atomic_set(&perf->pldata.running, 1);
+	perf->pldata.status = -ENODATA;
+	perf->pldata.tries = 0;
+	perf->pldata.latency = ktime_set(0, 0);
+
+	switch (mode) {
+	case RUN_PL_SERVER:
+		(void)queue_work(perf_wq, &perf->pldata.srv_work);
+		break;
+	case RUN_PL_CLIENT:
+	default:
+		(void)queue_work(perf_wq, &perf->pldata.clt_work);
+		break;
+	}
+
+	ret = wait_event_interruptible(perf->twait,
+				       !atomic_read(&perf->pldata.running));
+	if (ret == -ERESTARTSYS) {
+		perf_terminate_test(perf);
+		ret = -EINTR;
+	}
+
+	clear_bit_unlock(0, &perf->busy_flag);
+
+	return ret;
+}
+
 static int perf_read_stats(struct perf_ctx *perf, char *buf,
 			   size_t size, ssize_t *pos)
 {
@@ -1238,6 +1496,24 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
 		}
 	}
 
+	if (perf->pldata.status != -ENODATA) {
+		(*pos) += scnprintf(buf + *pos, size - *pos, "\n");
+		if (perf->pldata.status) {
+			(*pos) += scnprintf(buf + *pos, size - *pos,
+				"poll latency: error status %d\n", perf->pldata.status);
+		} else {
+			if (ktime_to_us(perf->pldata.latency) < 10) {
+				(*pos) += scnprintf(buf + *pos, size - *pos,
+						"poll latency %llu ns\n",
+						ktime_to_ns(perf->pldata.latency));
+			} else {
+				(*pos) += scnprintf(buf + *pos, size - *pos,
+						"poll latency %llu us\n",
+						ktime_to_us(perf->pldata.latency));
+			}
+		}
+	}
+
 	clear_bit_unlock(0, &perf->busy_flag);
 
 	return 0;
@@ -1251,6 +1527,10 @@ static void perf_init_threads(struct perf_ctx *perf)
 	perf->tcnt = DEF_THREADS_CNT;
 	perf->test_peer = &perf->peers[0];
 	init_waitqueue_head(&perf->twait);
+	perf->pldata.perf = perf;
+	INIT_WORK(&perf->pldata.srv_work, perf_poll_lat_server_work);
+	INIT_WORK(&perf->pldata.clt_work, perf_poll_lat_client_work);
+	perf->pldata.status = -ENODATA;
 
 	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
 		pthr = &perf->threads[tidx];
@@ -1407,6 +1687,64 @@ static const struct file_operations perf_dbgfs_run = {
 	.write = perf_dbgfs_write_run
 };
 
+static ssize_t perf_dbgfs_write_run_pl(struct file *filep, const char __user *ubuf,
+				    size_t size, loff_t *offp, enum run_mode mode)
+{
+	struct perf_ctx *perf = filep->private_data;
+	struct ntb_dev *ntb = perf->ntb;
+	struct perf_peer *peer;
+	int pidx, ret;
+
+	ret = kstrtoint_from_user(ubuf, size, 0, &pidx);
+	if (ret)
+		return ret;
+
+	if (pidx < 0 && mode == RUN_PL_SERVER) {
+		dev_dbg(&ntb->dev, "poll_lat: kill server\n");
+		if (test_bit(0, &perf->busy_flag)) {
+			peer = perf->test_peer;
+			/* Send stop to client */
+			memcpy_toio(peer->outbuf, &stop_word, 1);
+		}
+		perf_terminate_test(perf);
+		clear_bit_unlock(0, &perf->busy_flag);
+		return size;
+	}
+
+	if (pidx < 0 || pidx >= perf->pcnt)
+		return -EINVAL;
+
+	peer = &perf->peers[pidx];
+
+	ret = perf_submit_poll_lat(peer, mode);
+
+	return ret ? ret : size;
+}
+
+static ssize_t perf_dbgfs_write_run_client(struct file *filep, const char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_CLIENT);
+}
+
+static const struct file_operations perf_dbgfs_run_client = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_run,
+	.write = perf_dbgfs_write_run_client
+};
+
+static ssize_t perf_dbgfs_write_run_server(struct file *filep, const char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_SERVER);
+}
+
+static const struct file_operations perf_dbgfs_run_server = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_run,
+	.write = perf_dbgfs_write_run_server
+};
+
 static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
 				    size_t size, loff_t *offp)
 {
@@ -1469,6 +1807,24 @@ static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
 	return ret;
 }
 
+static ssize_t perf_dbgfs_read_inbuf(struct file *filep, char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_ctx *perf = filep->private_data;
+	char buf[32];
+	ssize_t pos;
+	u64 *value;
+
+	if (!perf->test_peer || !perf->test_peer->inbuf) {
+		pos = scnprintf(buf, sizeof(buf), "NULL\n");
+	} else {
+		value = perf->test_peer->inbuf;
+		pos = scnprintf(buf, sizeof(buf), "0x%llx\n", *value);
+	}
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
 static const struct file_operations perf_dbgfs_tcnt = {
 	.open = simple_open,
 	.read = perf_dbgfs_read_tcnt,
@@ -1480,6 +1836,11 @@ static const struct file_operations perf_dbgfs_lattrs = {
 	.read = perf_dbgfs_read_lattrs
 };
 
+static const struct file_operations perf_dbgfs_inbuf = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_inbuf,
+};
+
 static void perf_setup_dbgfs(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
@@ -1496,6 +1857,12 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_file("run", 0600, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_run);
 
+	debugfs_create_file("run_client", 0600, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_run_client);
+
+	debugfs_create_file("run_server", 0600, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_run_server);
+
 	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_tcnt);
 
@@ -1508,6 +1875,12 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 
 	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_lattrs);
+
+	debugfs_create_u64("poll_latency_tries", 0400, perf->dbgfs_dir,
+				&perf->pldata.tries);
+
+	debugfs_create_file("inbuf", 0400, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_inbuf);
 }
 
 static void perf_clear_dbgfs(struct perf_ctx *perf)
-- 
2.37.1

