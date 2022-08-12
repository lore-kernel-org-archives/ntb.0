Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03C2115
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 16:56:44 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id x25so1499818ljm.5
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y8Qh+y8heBSAj1hCqJLSMUDoLX1HLEFPw5t/+shPTtw=;
        b=mNIyTyLqR62OebkQRH+1ZpnxAB3YBDWpSsVpaiaNj4k/yAmMnNeZzhMOMxWqDXzY88
         9LIMRDDw3EN3Ry0n7HSHe8g4ReJflnMP7UePDSllHSA9ILC4Xza4MNl7qHlzzaFWAGbS
         vVPNuUDyDLsJLaqjH8T3pWh7kRotBsd+wwiwO3IljgIpYwWtl4fvi4DdT33/Sqk/JKKF
         Xn0eCMvNnlqelvcQJZIkEBQ3WplCCc9f2gF3TYMTCN5HNEhVtqb9qtcRhUIj/BZEkBpv
         /+df4JKdDsN/aBdEhAzKBTyNBck/7qJUJ6RuImPx46EozpmDbZqJxFWhIY7GxsDd0H7l
         GOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y8Qh+y8heBSAj1hCqJLSMUDoLX1HLEFPw5t/+shPTtw=;
        b=Bli6h8seYwyYYEG8/9o+sgXVGUDidUjd8HA3Rdh+5PgW+2b1E7IPvovf1EDjSMhG9T
         hAZnJ4TK0wRg1LFKIQ8fdOf78c8k2yodo3LKFMkTK+N9T8ql6i//WRIJXPQpJhqA2A+A
         WzTi7uKmioVreCjJ3DHL9cVeZmeqKb4OgXShmYHI7/TEzgijNYY/4QNBzLCmRCH36N0C
         jQEWH2KG7k3fdPQiZnyr20HbpwgAG3tEhUXlJtJYZk2FAOaR55AVcV+EONhp4L8Zf5sW
         o91kqzVEK/35kTeiyD+Uri8tOo7029e/aZjQlF9uKQRfpaQGSdllz8S/uXuo+zX2CJ5f
         Wwmw==
X-Gm-Message-State: ACgBeo0GeO2RrGfpse2mjATkfwhwPWIHDPp8Vms8ZvZ0Fr41UgvxR3sk
	8J0SBclnXAoyECPKGxFR94z8b29oT1Am+w==
X-Google-Smtp-Source: AA6agR4aurCJmagRLlKV0I+206YPAgGGdRcTsgw3KLb2TRzslHw+zIc4wmyZAdlwXBCg3ikLSySTTw==
X-Received: by 2002:a05:651c:160a:b0:25a:62a4:9085 with SMTP id f10-20020a05651c160a00b0025a62a49085mr1485221ljq.214.1660323401563;
        Fri, 12 Aug 2022 09:56:41 -0700 (PDT)
Received: from localhost.localdomain ([62.217.189.101])
        by smtp.googlemail.com with ESMTPSA id m13-20020a056512358d00b0048a7fa5bff1sm266146lfr.248.2022.08.12.09.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:56:41 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v4 1/3] ntb_perf: extend with burst latency measurement
Date: Fri, 12 Aug 2022 19:55:42 +0300
Message-Id: <20220812165544.26307-2-fomichev.ru@gmail.com>
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

Burst latency is a delay between start to send 1 byte to the
remote system and hardware readiness to send another byte. The
measurement performed within bandwidth test procedure. The DMA Engine is
off. Data integrity is not checked. This mode can be disabled by
'perf_latency=N' module parameter.

Thanks-to: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/ntb/test/ntb_perf.c | 141 +++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 65e1e5cf1b29..7bcd5a07c9b3 100644
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
+#define RESCHEDULE_RATIO	8192 /* MUST be power of 2 for 32-bit archs */
+
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
@@ -122,6 +127,14 @@ static bool use_dma; /* default to 0 */
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
 
+static bool perf_latency = false;
+module_param(perf_latency, bool, 0644);
+MODULE_PARM_DESC(perf_latency, "Measure burst latency (together with bandwidth)");
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
@@ -1018,6 +1033,68 @@ static void perf_clear_test(struct perf_thread *pthr)
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
+		dev_warn(&ntb->dev,
+			"%d: Too few steps (%llu) to measure Latency, results may be inaccurate\n",
+			pthr->tidx, pthr->tries);
+		dev_warn(&ntb->dev,
+			"%d: To perform > %d steps, increase value of 'lat_time_ms' parameter\n",
+			pthr->tidx, LAT_MIN_TRIES);
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
@@ -1043,6 +1120,11 @@ static void perf_thread_work(struct work_struct *work)
 	}
 
 	pthr->status = perf_sync_test(pthr);
+	if (pthr->status)
+		goto err_clear_test;
+
+	if (perf_latency)
+		pthr->status = perf_run_latency(pthr);
 
 err_clear_test:
 	perf_clear_test(pthr);
@@ -1142,6 +1224,18 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
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
@@ -1344,12 +1438,48 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
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
@@ -1375,6 +1505,9 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
 
 	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
+
+	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_lattrs);
 }
 
 static void perf_clear_dbgfs(struct perf_ctx *perf)
-- 
2.37.1

