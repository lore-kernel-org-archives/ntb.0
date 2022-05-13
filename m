Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5E7A
	for <ntb@lists.linux.dev>; Fri, 13 May 2022 19:38:14 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id 16so11395739lju.13
        for <ntb@lists.linux.dev>; Fri, 13 May 2022 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljObTqx/PdCyP+gPDOj5B116uUi0/GPi/NssLjDst1U=;
        b=FL9XQdbCUMSJhcwYJXfa4KT6Bh2UBxNob7dKJVaZlyLUdl2Gtvfaez137lbGplq08A
         QDUyoSj6HhRZOdF2oFqf7TE5f5LjOyk8GtNti7EeFSfNhYXoNzP071bw2zvAcylMcjnJ
         BX+RwVY9IkJ7R85MJRLJfAWB93MFfVoDXJLU1tf6Bb2d4ApzKmIXZvJ/QIiZL0tm+0Qt
         thT16H9BX4U0BvOMpAM0dOdly4Zq0nhdvyIDS5NFY9Kuc2dwrRVp9cy2EdvaR4jOK72Z
         DL+xJB+h9dwRd7zkoensHj4bkdn7D9+9ymI7foZ95t3zC/SZRxuJSATDSHBHQSjxSuH4
         9MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljObTqx/PdCyP+gPDOj5B116uUi0/GPi/NssLjDst1U=;
        b=742xVskopqt7N9tVleBN0GFkZxCDthsWj2j9h4YeArS8qtQZF8jwByH6AqPcsmNATG
         AcLa7JWNJLLH57M2m/8dDNLtwjIOa5URbuiSjESDkdL3xzMDhnIx4G3pUaPY0Q1Qx7d2
         10PTiOL3EZrWRf67V47fMGKnyknO11JeZ1Nk8tgCw7BleiNaEGd9tl0NaQyd8Xj0ck0x
         krO1jkup8uiKkSvKXQMrNqTnRd1XuJn12urQGEwAHKQc9HzOemPQXIAd+3jwRnrpFZUy
         /W0cEGU4HJUNkEDJKYI/bXiqZ7osyqc5zFX4mMLudjIC/Vwy4fyqE5Yx1uwnIJI9Bu58
         iBcg==
X-Gm-Message-State: AOAM530l3AE6zved5C09tjtDBbxjDgOgle0MA6/lJxbgMw2lQoc3HfsS
	TFt2O7MI4KHl/unUkPlZ/7OBdD2NA39fbedk1Wo=
X-Google-Smtp-Source: ABdhPJxpep6p5fRt2xKENgiKUKIROqJIq5gdHG0uWVHTxKGstu+h94kOljlT8xamreYUPZIIq2OoRA==
X-Received: by 2002:a2e:9188:0:b0:24f:1a0d:6bbd with SMTP id f8-20020a2e9188000000b0024f1a0d6bbdmr3875936ljg.226.1652470692540;
        Fri, 13 May 2022 12:38:12 -0700 (PDT)
Received: from localhost.localdomain ([62.217.189.101])
        by smtp.googlemail.com with ESMTPSA id q12-20020ac2528c000000b0047255d211bbsm472962lfm.234.2022.05.13.12.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 12:38:12 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v3 1/3] ntb_perf: extend with burst latency measurement
Date: Fri, 13 May 2022 22:37:02 +0300
Message-Id: <20220513193704.36868-2-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513193704.36868-1-fomichev.ru@gmail.com>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Fomichev <a.fomichev@yadro.com>

Burst latency is a delay between start to send 1 byte to the
remote system and hardware readiness to send another byte. The
measurement performed within bandwidth test procedure. The DMA Engine is
off. Data integrity is not checked. This mode can be disabled by
'perf_latency=N' module parameter.

Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/ntb/test/ntb_perf.c | 140 ++++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 65e1e5cf1b29..23bde12eaf3d 100644
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
@@ -85,7 +87,7 @@
 #include <linux/ntb.h>
 
 #define DRIVER_NAME		"ntb_perf"
-#define DRIVER_VERSION		"2.0"
+#define DRIVER_VERSION		"2.1"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
@@ -106,6 +108,9 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 
 #define PERF_BUF_LEN 1024
 
+#define LAT_MIN_TRIES	20
+#define RESCHEDULE_RATIO	10000
+
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
@@ -122,6 +127,14 @@ static bool use_dma; /* default to 0 */
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
 
+static bool perf_latency = true;
+module_param(perf_latency, bool, 0644);
+MODULE_PARM_DESC(perf_latency, "Measure burst latency");
+
+static unsigned long lat_time_ms = 1000; /* default 1s */
+module_param(lat_time_ms, ulong, 0644);
+MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
+
 /*==============================================================================
  *                         Perf driver data definition
  *==============================================================================
@@ -178,6 +191,8 @@ struct perf_thread {
 	void *src;
 	u64 copied;
 	ktime_t duration;
+	ktime_t latency;
+	u64 tries;
 	int status;
 	struct work_struct work;
 };
@@ -783,7 +798,7 @@ static void perf_dma_copy_callback(void *data)
 }
 
 static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+			   void __iomem *dst, void *src, size_t len, bool _use_dma)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
@@ -794,7 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	void __iomem *dst_vaddr;
 	dma_addr_t dst_dma_addr;
 
-	if (!use_dma) {
+	if (!_use_dma) {
 		memcpy_toio(dst, src, len);
 		goto ret_check_tsync;
 	}
@@ -940,7 +955,7 @@ static int perf_run_test(struct perf_thread *pthr)
 
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size, use_dma);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -1018,6 +1033,67 @@ static void perf_clear_test(struct perf_thread *pthr)
 	kfree(pthr->src);
 }
 
+static int perf_run_latency(struct perf_thread *pthr)
+{
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct ntb_dev *ntb = pthr->perf->ntb;
+	void __iomem *flt_dst, *bnd_dst;
+	void *flt_src;
+	u64 stop_at;
+	int ret;
+
+	pthr->tries = 0;
+	pthr->latency = ktime_get();
+	flt_src = pthr->src;
+	flt_dst = peer->outbuf;
+	bnd_dst = peer->outbuf + peer->outbuf_size;
+
+	stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
+	while (ktime_get_real_fast_ns() < stop_at) {
+		ret = perf_copy_chunk(pthr, flt_dst, flt_src, 1, false);
+		if (ret) {
+			dev_err(&ntb->dev, "%d: Latency testing error %d\n",
+				pthr->tidx, ret);
+			pthr->latency = ktime_set(0, 0);
+			return ret;
+		}
+
+		pthr->tries++;
+		flt_dst++;
+		flt_src++;
+
+		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
+			flt_dst = peer->outbuf;
+			flt_src = pthr->src;
+		}
+
+		/* Avoid processor soft lock-ups */
+		if (!(pthr->tries % RESCHEDULE_RATIO))
+			schedule();
+	}
+
+	/* Stop timer */
+	pthr->latency = ktime_sub(ktime_get(), pthr->latency);
+
+	if (pthr->tries < LAT_MIN_TRIES) {
+		dev_err(&ntb->dev,
+			"%d: Too few steps (%llu) to measure Latency, recommended > %d. Increase value of 'lat_time_ms' parameter\n",
+			pthr->tidx, pthr->tries, LAT_MIN_TRIES);
+		pthr->latency = ktime_set(0, 0);
+		return -EINVAL;
+	}
+
+	dev_dbg(&ntb->dev, "%d: made %llu tries, lasted %llu usecs\n",
+		pthr->tidx, pthr->tries, ktime_to_us(pthr->latency));
+
+	pthr->latency = ns_to_ktime(ktime_divns(pthr->latency, pthr->tries));
+
+	dev_dbg(&ntb->dev, "%d: latency %llu us (%llu ns)\n", pthr->tidx,
+		ktime_to_us(pthr->latency), ktime_to_ns(pthr->latency));
+
+	return 0;
+}
+
 static void perf_thread_work(struct work_struct *work)
 {
 	struct perf_thread *pthr = to_thread_work(work);
@@ -1043,6 +1119,11 @@ static void perf_thread_work(struct work_struct *work)
 	}
 
 	pthr->status = perf_sync_test(pthr);
+	if (pthr->status)
+		goto err_clear_test;
+
+	if (perf_latency)
+		pthr->status = perf_run_latency(pthr);
 
 err_clear_test:
 	perf_clear_test(pthr);
@@ -1142,6 +1223,18 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
 			"%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
 			tidx, pthr->copied, ktime_to_us(pthr->duration),
 			div64_u64(pthr->copied, ktime_to_us(pthr->duration)));
+
+		if (perf_latency && ktime_compare(pthr->latency, ktime_set(0, 0))) {
+			if (ktime_to_us(pthr->latency) < 10) {
+				(*pos) += scnprintf(buf + *pos, size - *pos,
+						"%d: latency %llu ns\n",
+						tidx, ktime_to_ns(pthr->latency));
+			} else {
+				(*pos) += scnprintf(buf + *pos, size - *pos,
+						"%d: latency %llu us\n",
+						tidx, ktime_to_us(pthr->latency));
+			}
+		}
 	}
 
 	clear_bit_unlock(0, &perf->busy_flag);
@@ -1344,12 +1437,48 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
 	return size;
 }
 
+static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	size_t buf_size = min_t(size_t, size, PERF_BUF_LEN);
+	struct perf_ctx *perf = filep->private_data;
+	ssize_t pos, ret;
+	char *buf;
+	int tidx;
+
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos = scnprintf(buf, buf_size, "    Peer %d latency try count:\n",
+			perf->test_peer->pidx);
+
+	for (tidx = 0; tidx < perf->tcnt; tidx++) {
+		struct perf_thread *pthr = &perf->threads[tidx];
+
+		pos += scnprintf(buf + pos, buf_size - pos,
+			"%d: made %llu tries\n",
+			tidx, pthr->tries);
+	}
+
+	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+
+	kfree(buf);
+
+	return ret;
+}
+
 static const struct file_operations perf_dbgfs_tcnt = {
 	.open = simple_open,
 	.read = perf_dbgfs_read_tcnt,
 	.write = perf_dbgfs_write_tcnt
 };
 
+static const struct file_operations perf_dbgfs_lattrs = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_lattrs
+};
+
 static void perf_setup_dbgfs(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
@@ -1375,6 +1504,9 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
 
 	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
+
+	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_lattrs);
 }
 
 static void perf_clear_dbgfs(struct perf_ctx *perf)
-- 
2.36.1

