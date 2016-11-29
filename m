Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id l19si533440wmg.0.2016.11.29.09.16.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:16:16 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id p100so13315547lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:16:16 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 20/22] NTB Tool: Alter driver to work with two-ports NTB API
Date: Tue, 29 Nov 2016 20:16:15 +0300
Message-Id: <1480439777-1080-21-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The same as for PingPong driver, this driver can't be used with hardware
whithout Scratchpads. Additionally it supports two-ports and inbound MW
based devices only at the moment.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/test/ntb_tool.c | 87 +++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 61bf2ef..f9329c0 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -119,7 +119,10 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
-#define MAX_MWS 16
+/* It is rare to have hadrware with greater than six MWs */
+#define MAX_MWS 6
+/* Only two-ports devices are supported */
+#define PIDX 0
 
 static struct dentry *tool_dbgfs;
 
@@ -261,14 +264,17 @@ static ssize_t tool_dbfn_write(struct tool_ctx *tc,
 
 static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 				size_t size, loff_t *offp,
-				u32 (*spad_read_fn)(struct ntb_dev *, int))
+				u32 (*spad_read_fn)(struct ntb_dev *, int),
+				u32 (*spad_peer_read_fn)(struct ntb_dev *, int,
+							 int))
 {
 	size_t buf_size;
 	char *buf;
 	ssize_t pos, rc;
 	int i, spad_count;
+	u32 data;
 
-	if (!spad_read_fn)
+	if (!spad_read_fn && !spad_peer_read_fn)
 		return -EINVAL;
 
 	spad_count = ntb_spad_count(tc->ntb);
@@ -287,8 +293,12 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
 	pos = 0;
 
 	for (i = 0; i < spad_count; ++i) {
+		if (spad_read_fn)
+			data = spad_read_fn(tc->ntb, i);
+		else
+			data = spad_peer_read_fn(tc->ntb, PIDX, i);
 		pos += scnprintf(buf + pos, buf_size - pos, "%d\t%#x\n",
-				 i, spad_read_fn(tc->ntb, i));
+				 i, data);
 	}
 
 	rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
@@ -302,7 +312,9 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
 				 const char __user *ubuf,
 				 size_t size, loff_t *offp,
 				 int (*spad_write_fn)(struct ntb_dev *,
-						      int, u32))
+						      int, u32),
+				 int (*spad_peer_write_fn)(struct ntb_dev *,
+							   int, int, u32))
 {
 	int spad_idx;
 	u32 spad_val;
@@ -310,7 +322,7 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
 	int pos, n;
 	ssize_t rc;
 
-	if (!spad_write_fn) {
+	if (!spad_write_fn || !spad_peer_write_fn) {
 		dev_dbg(&tc->ntb->dev, "no spad write fn\n");
 		return -EINVAL;
 	}
@@ -330,7 +342,11 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
 	n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
 	while (n == 2) {
 		buf_ptr += pos;
-		rc = spad_write_fn(tc->ntb, spad_idx, spad_val);
+		if (spad_write_fn)
+			rc = spad_write_fn(tc->ntb, spad_idx, spad_val);
+		else
+			rc = spad_peer_write_fn(tc->ntb, PIDX, spad_idx,
+						spad_val);
 		if (rc)
 			break;
 
@@ -443,7 +459,7 @@ static ssize_t tool_spad_read(struct file *filep, char __user *ubuf,
 	struct tool_ctx *tc = filep->private_data;
 
 	return tool_spadfn_read(tc, ubuf, size, offp,
-				tc->ntb->ops->spad_read);
+				tc->ntb->ops->spad_read, NULL);
 }
 
 static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
@@ -452,7 +468,7 @@ static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
 	struct tool_ctx *tc = filep->private_data;
 
 	return tool_spadfn_write(tc, ubuf, size, offp,
-				 tc->ntb->ops->spad_write);
+				 tc->ntb->ops->spad_write, NULL);
 }
 
 static TOOL_FOPS_RDWR(tool_spad_fops,
@@ -464,7 +480,7 @@ static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
 {
 	struct tool_ctx *tc = filep->private_data;
 
-	return tool_spadfn_read(tc, ubuf, size, offp,
+	return tool_spadfn_read(tc, ubuf, size, offp, NULL,
 				tc->ntb->ops->peer_spad_read);
 }
 
@@ -473,7 +489,7 @@ static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
 {
 	struct tool_ctx *tc = filep->private_data;
 
-	return tool_spadfn_write(tc, ubuf, size, offp,
+	return tool_spadfn_write(tc, ubuf, size, offp, NULL,
 				 tc->ntb->ops->peer_spad_write);
 }
 
@@ -668,28 +684,27 @@ static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
 {
 	int rc;
 	struct tool_mw *mw = &tc->mws[idx];
-	phys_addr_t base;
-	resource_size_t size, align, align_size;
+	resource_size_t size, align_addr, align_size;
 	char buf[16];
 
 	if (mw->peer)
 		return 0;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
-			      &align_size);
+	rc = ntb_mw_get_align(tc->ntb, PIDX, idx, &align_addr,
+			      &align_size, &size);
 	if (rc)
 		return rc;
 
 	mw->size = min_t(resource_size_t, req_size, size);
-	mw->size = round_up(mw->size, align);
+	mw->size = round_up(mw->size, align_addr);
 	mw->size = round_up(mw->size, align_size);
 	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
 				      &mw->peer_dma, GFP_KERNEL);
 
-	if (!mw->peer)
+	if (!mw->peer || !IS_ALIGNED(mw->peer_dma, align_addr))
 		return -ENOMEM;
 
-	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
+	rc = ntb_mw_set_trans(tc->ntb, PIDX, idx, mw->peer_dma, mw->size);
 	if (rc)
 		goto err_free_dma;
 
@@ -716,7 +731,7 @@ static void tool_free_mw(struct tool_ctx *tc, int idx)
 	struct tool_mw *mw = &tc->mws[idx];
 
 	if (mw->peer) {
-		ntb_mw_clear_trans(tc->ntb, idx);
+		ntb_mw_clear_trans(tc->ntb, PIDX, idx);
 		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
 				  mw->peer,
 				  mw->peer_dma);
@@ -742,8 +757,9 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 
 	phys_addr_t base;
 	resource_size_t mw_size;
-	resource_size_t align;
+	resource_size_t align_addr;
 	resource_size_t align_size;
+	resource_size_t max_size;
 
 	buf_size = min_t(size_t, size, 512);
 
@@ -751,8 +767,9 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 	if (!buf)
 		return -ENOMEM;
 
-	ntb_mw_get_range(mw->tc->ntb, mw->idx,
-			 &base, &mw_size, &align, &align_size);
+	ntb_mw_get_align(mw->tc->ntb, PIDX, mw->idx,
+			 &align_addr, &align_size, &max_size);
+	ntb_peer_mw_get_addr(mw->tc->ntb, mw->idx, &base, &mw_size);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Peer MW %d Information:\n", mw->idx);
@@ -767,13 +784,17 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Alignment             \t%lld\n",
-			 (unsigned long long)align);
+			 (unsigned long long)align_addr);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Size Alignment        \t%lld\n",
 			 (unsigned long long)align_size);
 
 	off += scnprintf(buf + off, buf_size - off,
+			 "Size Max              \t%lld\n",
+			 (unsigned long long)max_size);
+
+	off += scnprintf(buf + off, buf_size - off,
 			 "Ready                 \t%c\n",
 			 (mw->peer) ? 'Y' : 'N');
 
@@ -827,8 +848,7 @@ static int tool_init_mw(struct tool_ctx *tc, int idx)
 	phys_addr_t base;
 	int rc;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &mw->win_size,
-			      NULL, NULL);
+	rc = ntb_peer_mw_get_addr(tc->ntb, idx, &base, &mw->win_size);
 	if (rc)
 		return rc;
 
@@ -919,6 +939,21 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	if (ntb_spad_is_unsafe(ntb))
 		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
 
+	if (ntb_spad_count(ntb) < 1) {
+		dev_dbg(&ntb->dev, "no enough scratchpads\n");
+		rc = -EINVAL;
+		goto err_tc;
+	}
+
+	if (!ntb->ops->mw_set_trans) {
+		dev_dbg(&ntb->dev, "need inbound MW based NTB API\n");
+		rc = -EINVAL;
+		goto err_tc;
+	}
+
+	if (ntb_peer_port_count(ntb) != 1)
+		dev_warn(&ntb->dev, "multi-port NTB devices unsupported\n");
+
 	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
 	if (!tc) {
 		rc = -ENOMEM;
@@ -928,7 +963,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	tc->ntb = ntb;
 	init_waitqueue_head(&tc->link_wq);
 
-	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
+	tc->mw_count = min(ntb_mw_count(tc->ntb, PIDX), MAX_MWS);
 	for (i = 0; i < tc->mw_count; i++) {
 		rc = tool_init_mw(tc, i);
 		if (rc)
-- 
2.6.6

