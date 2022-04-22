Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F828E6
	for <ntb@lists.linux.dev>; Fri, 22 Apr 2022 11:37:58 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id p12so8244864lfs.5
        for <ntb@lists.linux.dev>; Fri, 22 Apr 2022 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWCTt/WIrz6/IXs1WBPRSMlnglSjsSbDXTUjobW7DQE=;
        b=mj2qtWrfIyuUdLwBVkCZHEZsL0fdRxiH2GWvRWSyhKrJUtMYHYoXvFlnRhh4GrBjJZ
         sifLqjq1LqJWXsEJoPo66hpJOy8/RD90kx0PUOt2fPyFNjlpH2cGY2Wu5jWC954Gwb3r
         zTJx/E/aHwpiNZEMO01QE+PFUL5sF0heubMCj6trnxIJcWjdiHOWfOOX50alFEwscdfL
         2Dc7/JutgVux320SxWa1fgG0ofbYodpXUs7hLN3Tw0At2rgG7TybSWEWD+0uwXBVb0Nw
         OlqDGma1uj3JDHW6wRT2+WCpW507UwhkOsdgLyarkSQeTkUT+yiufNLZOS/duyMWkLrb
         QiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWCTt/WIrz6/IXs1WBPRSMlnglSjsSbDXTUjobW7DQE=;
        b=3gXyP8G5/7ATQ8C1AYgT004T6vesIvd6YialdJPkrscfvZ+4lT0VGgnF1O4TzWkhpX
         g5zgp4o9ui2PjJVJzO+Ks5O1hH181fEsZ970OvwhgnlzZ6oWIJm9GuH130oZQHSO+p7Y
         5G3k5H1P8LL6CjdGGHjxnj5RizeeT55jdLAoytAZtPU2XUooX2y/IQa+NdxscF4LL/QG
         z13NNL8DLAMWVRBV1hYhFezm6WmyfwFToqtMvSZDl6zDA3saBgmSBL3Ozd7gpRF+iQ0L
         DDXVieQ2m7q4CYT2UJNOvqUrq9NdGoARMTFdDIISwo4FBqMWt3Bx91dkyxyLpW8SFkuj
         b3vQ==
X-Gm-Message-State: AOAM533JB+KMmFS0qxYHygJizSOBXgnKvDfcbL7vgglF85OKFB3ar6zi
	BW754gQ7kPS+Pq7i4GUQUhCNjyGzFw5HuDhpu7s=
X-Google-Smtp-Source: ABdhPJyvzgWeAbBy62pjOktvIAtixQuT8yQx2ChmhylYWOeSAsJrvyM+tABgrdqdhdieUeUfVgRHXQ==
X-Received: by 2002:a05:6512:3230:b0:46d:ca6:d355 with SMTP id f16-20020a056512323000b0046d0ca6d355mr2797088lfe.268.1650627475885;
        Fri, 22 Apr 2022 04:37:55 -0700 (PDT)
Received: from localhost.localdomain ([178.176.79.58])
        by smtp.googlemail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm190487lji.116.2022.04.22.04.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:37:55 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v2 1/3] ntb_perf: extend with burst latency measurement
Date: Fri, 22 Apr 2022 14:37:01 +0300
Message-Id: <20220422113703.48820-1-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Fomichev <a.fomichev@yadro.com>

The ntb_perf test provides a tool for NTB hardware performance
evaluation. For software impact elimination the test uses a simple method
(let's call it 'burst' mode), when the local system sends to the remote
system a data set and counts time interval until hardware completion
report, without the remote side confirming, nor data integrity check.
The measured metric is a 'burst' throughput bandwidth of NTB connection.

The proposed change extends ntb_perf with 1 of 3 new metrics. The resulting
test is fully backward compatible.

1. Burst latency. It's a delay between start to send 1 byte to the
remote system and hardware readiness to send another byte. The
measurement performed within bandwidth test procedure. The DMA Engine is
off. Data integrity is not checked. This mode can be disabled by
'perf_latency=N' module parameter.

Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
---
 drivers/ntb/test/ntb_perf.c | 135 +++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 65e1e5cf1b29..79faa4a7fe94 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -106,6 +106,9 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 
 #define PERF_BUF_LEN 1024
 
+#define LAT_MIN_TRIES	20
+#define RESCHEDULE_RATIO	10000
+
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
@@ -122,6 +125,14 @@ static bool use_dma; /* default to 0 */
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
 
+static bool perf_latency = true;
+module_param(perf_latency, bool, 0644);
+MODULE_PARM_DESC(perf_latency, "Also measure latency");
+
+static unsigned long lat_time_ms = 1000; /* default 1s */
+module_param(lat_time_ms, ulong, 0644);
+MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
+
 /*==============================================================================
  *                         Perf driver data definition
  *==============================================================================
@@ -178,6 +189,8 @@ struct perf_thread {
 	void *src;
 	u64 copied;
 	ktime_t duration;
+	ktime_t latency;
+	u64 tries;
 	int status;
 	struct work_struct work;
 };
@@ -783,7 +796,7 @@ static void perf_dma_copy_callback(void *data)
 }
 
 static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+			   void __iomem *dst, void *src, size_t len, bool use_dma_)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
@@ -794,7 +807,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	void __iomem *dst_vaddr;
 	dma_addr_t dst_dma_addr;
 
-	if (!use_dma) {
+	if (!use_dma_) {
 		memcpy_toio(dst, src, len);
 		goto ret_check_tsync;
 	}
@@ -940,7 +953,7 @@ static int perf_run_test(struct perf_thread *pthr)
 
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size, use_dma);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -1018,6 +1031,66 @@ static void perf_clear_test(struct perf_thread *pthr)
 	kfree(pthr->src);
 }
 
+static int perf_run_latency(struct perf_thread *pthr)
+{
+	struct perf_peer *peer = pthr->perf->test_peer;
+	struct ntb_dev *ntb = pthr->perf->ntb;
+	void *flt_src;
+	void __iomem *flt_dst, *bnd_dst;
+	int ret;
+	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
+
+	pthr->tries = 0;
+	pthr->latency = ktime_get();
+	flt_src = pthr->src;
+	flt_dst = peer->outbuf;
+	bnd_dst = peer->outbuf + peer->outbuf_size;
+
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
+		dev_err(&ntb->dev, "%d: Too few steps (%d) to measure Latency, "
+			"recommended > %d. Increase value of 'lat_time_ms' "
+			"parameter\n", pthr->tidx, pthr->tries, LAT_MIN_TRIES);
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
@@ -1043,6 +1116,11 @@ static void perf_thread_work(struct work_struct *work)
 	}
 
 	pthr->status = perf_sync_test(pthr);
+	if (pthr->status)
+		goto err_clear_test;
+
+	if (perf_latency)
+		pthr->status = perf_run_latency(pthr);
 
 err_clear_test:
 	perf_clear_test(pthr);
@@ -1142,6 +1220,18 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
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
@@ -1344,12 +1434,48 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
 	return size;
 }
 
+static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_ctx *perf = filep->private_data;
+	char *buf;
+	ssize_t pos, ret;
+	size_t buf_size = min_t(size_t, size, PERF_BUF_LEN);
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
@@ -1375,6 +1501,9 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
 
 	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
+
+	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
+			    &perf_dbgfs_lattrs);
 }
 
 static void perf_clear_dbgfs(struct perf_ctx *perf)
-- 
2.30.2

