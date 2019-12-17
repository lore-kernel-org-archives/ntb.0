Return-Path: <linjiasen@hygon.cn>
Received: from spam1.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id x13si1146548pgt.3.2019.12.16.18.44.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 18:44:10 -0800 (PST)
From: Jiasen Lin <linjiasen@hygon.cn>
Subject: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
Date: Mon, 16 Dec 2019 18:42:16 -0800
Message-ID: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, logang@deltatee.com
Cc: allenbh@gmail.com, dave.jiang@intel.com, linjiasen@hygon.cn, sanju.mehta@amd.com
List-ID: <linux-ntb.googlegroups.com>

Currently, read input and output buffer is not supported yet in
debugfs of ntb_perf. We can not confirm whether the output data is
transmitted to the input buffer at peer memory through NTB.

This patch add new entries in debugfs which implement interface to read
a part of input and out buffer. User can dump output and input data at
local and peer system by hexdump command, and then compare them manually.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..338c3ec 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -106,6 +106,8 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 
 #define PERF_BUF_LEN 1024
 
+#define MAX_STR_LENGTH		16
+
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
@@ -1227,6 +1229,46 @@ static const struct file_operations perf_dbgfs_info = {
 	.read = perf_dbgfs_read_info
 };
 
+static ssize_t perf_dbgfs_read_inbuf(struct file *filep,
+				    char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_peer *peer = filep->private_data;
+	size_t buf_size;
+
+	if (!peer->inbuf)
+		return -ENXIO;
+
+	buf_size = min_t(size_t, size, peer->inbuf_size);
+	return simple_read_from_buffer(ubuf, size, offp,
+					peer->inbuf, buf_size);
+}
+
+static const struct file_operations perf_dbgfs_inbuf = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_inbuf,
+};
+
+static ssize_t perf_dbgfs_read_outbuf(struct file *filep,
+				    char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_peer *peer = filep->private_data;
+	size_t buf_size;
+
+	if (!peer->outbuf)
+		return -ENXIO;
+
+	buf_size = min_t(size_t, size, peer->outbuf_size);
+	return simple_read_from_buffer(ubuf, size, offp,
+					peer->outbuf, buf_size);
+}
+
+static const struct file_operations perf_dbgfs_outbuf = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_outbuf,
+};
+
 static ssize_t perf_dbgfs_read_run(struct file *filep, char __user *ubuf,
 				   size_t size, loff_t *offp)
 {
@@ -1318,6 +1360,9 @@ static const struct file_operations perf_dbgfs_tcnt = {
 static void perf_setup_dbgfs(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
+	struct perf_peer *peer;
+	int pidx;
+	char name[MAX_STR_LENGTH];
 
 	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
 	if (!perf->dbgfs_dir) {
@@ -1334,6 +1379,20 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_tcnt);
 
+	for (pidx = 0; pidx < perf->pcnt; pidx++) {
+		peer = &perf->peers[pidx];
+		if (!peer)
+			continue;
+		memset(name, 0, sizeof(name));
+		snprintf(name, sizeof(name), "%s_%u", "inbuf_info", pidx);
+		debugfs_create_file(name, 0600, perf->dbgfs_dir, peer,
+					&perf_dbgfs_inbuf);
+
+		memset(name, 0, sizeof(name));
+		snprintf(name, sizeof(name), "%s_%u", "outbuf_info", pidx);
+		debugfs_create_file(name, 0600, perf->dbgfs_dir, peer,
+					&perf_dbgfs_outbuf);
+	}
 	/* They are made read-only for test exec safety and integrity */
 	debugfs_create_u8("chunk_order", 0500, perf->dbgfs_dir, &chunk_order);
 
-- 
2.7.4

