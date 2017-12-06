Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x22f.google.com (mail-lf0-x22f.google.com. [2a00:1450:4010:c07::22f])
        by gmr-mx.google.com with ESMTPS id q77si306736lfi.1.2017.12.06.06.32.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:21 -0800 (PST)
Received: by mail-lf0-x22f.google.com with SMTP id x20so4487979lff.1
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:21 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 05/15] NTB: ntb_tool: Add full multi-port NTB API support
Date: Wed,  6 Dec 2017 17:31:56 +0300
Message-Id: <20171206143206.14665-6-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Former NTB Debugging tool driver supported only the limited
functionality of the recently updated NTB API, which is now available
to work with the truly NTB multi-port devices and devices, which
got NTB Message registers instead of Scratchpads. This patch
fully rewrites the driver so one would fully expose all the new
NTB API interfaces. Particularly it concerns the Message registers,
peer ports API, NTB link settings. Additional cleanups are also added
here.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
Changelog v1:
- Alter interface in compliance with multi-port API
- Move Message/MW/Port/Link settings to a specific directory

Changelog v2:
- Remove driver Author/Description/License macros
- Return error if ntb_mw_get_align called while link is down
- Add db_valid_mask DebugFS file
- Add msg_inbits/msg_outbits DebugFS files

Changelog v3:
- Remove contacts info from the driver header
- Add descriptive comments for the MW-related structures
- Replace on-stack bufs sizes with macro

 drivers/ntb/test/ntb_tool.c | 1820 +++++++++++++++++++++++++++++--------------
 1 file changed, 1240 insertions(+), 580 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index e490bbc8726c..920fc9b161b0 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2017 T-Platforms All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -18,6 +19,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2017 T-Platforms All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -46,9 +48,6 @@
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  * PCIe NTB Debugging Tool Linux driver
- *
- * Contact Information:
- * Allen Hubbe <Allen.Hubbe@emc.com>
  */
 
 /*
@@ -56,42 +55,125 @@
  *
  * Assuming $DBG_DIR is something like:
  * '/sys/kernel/debug/ntb_tool/0000:00:03.0'
+ * Suppose aside from local device there is at least one remote device
+ * connected to NTB with index 0.
+ *-----------------------------------------------------------------------------
+ * Eg: check local/peer device information.
+ *
+ * # Get local device port number
+ * root@self# cat $DBG_DIR/port
+ *
+ * # Check local device functionality
+ * root@self# ls $DBG_DIR
+ * db            msg1          msg_sts     peer4/        port
+ * db_event      msg2          peer0/      peer5/        spad0
+ * db_mask       msg3          peer1/      peer_db       spad1
+ * link          msg_event     peer2/      peer_db_mask  spad2
+ * msg0          msg_mask      peer3/      peer_spad     spad3
+ * # As one can see it supports:
+ * # 1) four inbound message registers
+ * # 2) four inbound scratchpads
+ * # 3) up to six peer devices
+ *
+ * # Check peer device port number
+ * root@self# cat $DBG_DIR/peer0/port
  *
- * Eg: check if clearing the doorbell mask generates an interrupt.
+ * # Check peer device(s) functionality to be used
+ * root@self# ls $DBG_DIR/peer0
+ * link             mw_trans0       mw_trans6        port
+ * link_event       mw_trans1       mw_trans7        spad0
+ * msg0             mw_trans2       peer_mw_trans0   spad1
+ * msg1             mw_trans3       peer_mw_trans1   spad2
+ * msg2             mw_trans4       peer_mw_trans2   spad3
+ * msg3             mw_trans5       peer_mw_trans3
+ * # As one can see we got:
+ * # 1) four outbound message registers
+ * # 2) four outbound scratchpads
+ * # 3) eight inbound memory windows
+ * # 4) four outbound memory windows
+ *-----------------------------------------------------------------------------
+ * Eg: NTB link tests
  *
- * # Check the link status
- * root@self# cat $DBG_DIR/link
+ * # Set local link up/down
+ * root@self# echo Y > $DBG_DIR/link
+ * root@self# echo N > $DBG_DIR/link
  *
- * # Block until the link is up
- * root@self# echo Y > $DBG_DIR/link_event
+ * # Check if link with peer device is up/down:
+ * root@self# cat $DBG_DIR/peer0/link
  *
- * # Set the doorbell mask
- * root@self# echo 's 1' > $DBG_DIR/mask
+ * # Block until the link is up/down
+ * root@self# echo Y > $DBG_DIR/peer0/link_event
+ * root@self# echo N > $DBG_DIR/peer0/link_event
+ *-----------------------------------------------------------------------------
+ * Eg: Doorbell registers tests (some functionality might be absent)
  *
- * # Ring the doorbell from the peer
+ * # Set/clear/get local doorbell
+ * root@self# echo 's 1' > $DBG_DIR/db
+ * root@self# echo 'c 1' > $DBG_DIR/db
+ * root@self# cat  $DBG_DIR/db
+ *
+ * # Set/clear/get local doorbell mask
+ * root@self# echo 's 1' > $DBG_DIR/db_mask
+ * root@self# echo 'c 1' > $DBG_DIR/db_mask
+ * root@self# cat $DBG_DIR/db_mask
+ *
+ * # Ring/clear/get peer doorbell
  * root@peer# echo 's 1' > $DBG_DIR/peer_db
+ * root@peer# echo 'c 1' > $DBG_DIR/peer_db
+ * root@peer# cat $DBG_DIR/peer_db
+ *
+ * # Set/clear/get peer doorbell mask
+ * root@self# echo 's 1' > $DBG_DIR/peer_db_mask
+ * root@self# echo 'c 1' > $DBG_DIR/peer_db_mask
+ * root@self# cat $DBG_DIR/peer_db_mask
+ *
+ * # Block until local doorbell is set with specified value
+ * root@self# echo 1 > $DBG_DIR/db_event
+ *-----------------------------------------------------------------------------
+ * Eg: Message registers tests (functionality might be absent)
  *
- * # Clear the doorbell mask
- * root@self# echo 'c 1' > $DBG_DIR/mask
+ * # Set/clear/get in/out message registers status
+ * root@self# echo 's 1' > $DBG_DIR/msg_sts
+ * root@self# echo 'c 1' > $DBG_DIR/msg_sts
+ * root@self# cat $DBG_DIR/msg_sts
  *
- * Observe debugging output in dmesg or your console.  You should see a
- * doorbell event triggered by clearing the mask.  If not, this may indicate an
- * issue with the hardware that needs to be worked around in the driver.
+ * # Set/clear in/out message registers mask
+ * root@self# echo 's 1' > $DBG_DIR/msg_mask
+ * root@self# echo 'c 1' > $DBG_DIR/msg_mask
  *
- * Eg: read and write scratchpad registers
+ * # Get inbound message register #0 value and source of port index
+ * root@self# cat  $DBG_DIR/msg0
  *
- * root@peer# echo '0 0x01010101 1 0x7f7f7f7f' > $DBG_DIR/peer_spad
+ * # Send some data to peer over outbound message register #0
+ * root@self# echo 0x01020304 > $DBG_DIR/peer0/msg0
+ *-----------------------------------------------------------------------------
+ * Eg: Scratchpad registers tests (functionality might be absent)
  *
- * root@self# cat $DBG_DIR/spad
+ * # Write/read to/from local scratchpad register #0
+ * root@peer# echo 0x01020304 > $DBG_DIR/spad0
+ * root@peer# cat $DBG_DIR/spad0
  *
- * Observe that spad 0 and 1 have the values set by the peer.
+ * # Write/read to/from peer scratchpad register #0
+ * root@peer# echo 0x01020304 > $DBG_DIR/peer0/spad0
+ * root@peer# cat $DBG_DIR/peer0/spad0
+ *-----------------------------------------------------------------------------
+ * Eg: Memory windows tests
  *
- * # Check the memory window translation info
- * cat $DBG_DIR/peer_trans0
+ * # Create inbound memory window buffer of specified size/get its base address
+ * root@peer# echo 16384 > $DBG_DIR/peer0/mw_trans0
+ * root@peer# cat $DBG_DIR/peer0/mw_trans0
  *
- * # Setup a 16k memory window buffer
- * echo 16384 > $DBG_DIR/peer_trans0
+ * # Write/read data to/from inbound memory window
+ * root@peer# echo Hello > $DBG_DIR/peer0/mw0
+ * root@peer# head -c 7 $DBG_DIR/peer0/mw0
  *
+ * # Map outbound memory window/check it settings (on peer device)
+ * root@peer# echo 0xADD0BA5E:16384 > $DBG_DIR/peer0/peer_mw_trans0
+ * root@peer# cat $DBG_DIR/peer0/peer_mw_trans0
+ *
+ * # Write/read data to/from outbound memory window (on peer device)
+ * root@peer# echo olleH > $DBG_DIR/peer0/peer_mw0
+ * root@peer# head -c 7 $DBG_DIR/peer0/peer_mw0
  */
 
 #include <linux/init.h>
@@ -106,48 +188,87 @@
 
 #include <linux/ntb.h>
 
-#define DRIVER_NAME			"ntb_tool"
-#define DRIVER_DESCRIPTION		"PCIe NTB Debugging Tool"
-
-#define DRIVER_VERSION			"1.0"
-#define DRIVER_RELDATE			"22 April 2015"
-#define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
+#define DRIVER_NAME		"ntb_tool"
+#define DRIVER_VERSION		"2.0"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
-
-/* It is rare to have hadrware with greater than six MWs */
-#define MAX_MWS	6
-/* Only two-ports devices are supported */
-#define PIDX	NTB_DEF_PEER_IDX
-
-static struct dentry *tool_dbgfs;
+MODULE_AUTHOR("Allen Hubbe <Allen.Hubbe@emc.com>");
+MODULE_DESCRIPTION("PCIe NTB Debugging Tool");
 
+/*
+ * Inbound and outbound memory windows descriptor. Union members selection
+ * depends on the MW type the structure describes. mm_base/dma_base are the
+ * virtual and DMA address of an inbound MW. io_base/tr_base are the MMIO
+ * mapped virtual and xlat addresses of an outbound MW respectively.
+ */
 struct tool_mw {
-	int idx;
+	int widx;
+	int pidx;
 	struct tool_ctx *tc;
-	resource_size_t win_size;
+	union {
+		u8 *mm_base;
+		u8 __iomem *io_base;
+	};
+	union {
+		dma_addr_t dma_base;
+		u64 tr_base;
+	};
 	resource_size_t size;
-	u8 __iomem *local;
-	u8 *peer;
-	dma_addr_t peer_dma;
-	struct dentry *peer_dbg_file;
+	struct dentry *dbgfs_file;
+};
+
+/*
+ * Wrapper structure is used to distinguish the outbound MW peers reference
+ * within the corresponding DebugFS directory IO operation.
+ */
+struct tool_mw_wrap {
+	int pidx;
+	struct tool_mw *mw;
+};
+
+struct tool_msg {
+	int midx;
+	int pidx;
+	struct tool_ctx *tc;
+};
+
+struct tool_spad {
+	int sidx;
+	int pidx;
+	struct tool_ctx *tc;
+};
+
+struct tool_peer {
+	int pidx;
+	struct tool_ctx *tc;
+	int inmw_cnt;
+	struct tool_mw *inmws;
+	int outmw_cnt;
+	struct tool_mw_wrap *outmws;
+	int outmsg_cnt;
+	struct tool_msg *outmsgs;
+	int outspad_cnt;
+	struct tool_spad *outspads;
+	struct dentry *dbgfs_dir;
 };
 
 struct tool_ctx {
 	struct ntb_dev *ntb;
-	struct dentry *dbgfs;
 	wait_queue_head_t link_wq;
-	int mw_count;
-	struct tool_mw mws[MAX_MWS];
+	wait_queue_head_t db_wq;
+	wait_queue_head_t msg_wq;
+	int outmw_cnt;
+	struct tool_mw *outmws;
+	int peer_cnt;
+	struct tool_peer *peers;
+	int inmsg_cnt;
+	struct tool_msg *inmsgs;
+	int inspad_cnt;
+	struct tool_spad *inspads;
+	struct dentry *dbgfs_dir;
 };
 
-#define SPAD_FNAME_SIZE 0x10
-#define INT_PTR(x) ((void *)(unsigned long)x)
-#define PTR_INT(x) ((int)(unsigned long)x)
-
 #define TOOL_FOPS_RDWR(__name, __read, __write) \
 	const struct file_operations __name = {	\
 		.owner = THIS_MODULE,		\
@@ -156,6 +277,15 @@ struct tool_ctx {
 		.write = __write,		\
 	}
 
+#define TOOL_BUF_LEN 32
+
+static struct dentry *tool_dbgfs_topdir;
+
+/*==============================================================================
+ *                               NTB events handlers
+ *==============================================================================
+ */
+
 static void tool_link_event(void *ctx)
 {
 	struct tool_ctx *tc = ctx;
@@ -181,580 +311,576 @@ static void tool_db_event(void *ctx, int vec)
 
 	dev_dbg(&tc->ntb->dev, "doorbell vec %d mask %#llx bits %#llx\n",
 		vec, db_mask, db_bits);
+
+	wake_up(&tc->db_wq);
+}
+
+static void tool_msg_event(void *ctx)
+{
+	struct tool_ctx *tc = ctx;
+	u64 msg_sts;
+
+	msg_sts = ntb_msg_read_sts(tc->ntb);
+
+	dev_dbg(&tc->ntb->dev, "message bits %#llx\n", msg_sts);
+
+	wake_up(&tc->msg_wq);
 }
 
 static const struct ntb_ctx_ops tool_ops = {
 	.link_event = tool_link_event,
 	.db_event = tool_db_event,
+	.msg_event = tool_msg_event
 };
 
-static ssize_t tool_dbfn_read(struct tool_ctx *tc, char __user *ubuf,
-			      size_t size, loff_t *offp,
-			      u64 (*db_read_fn)(struct ntb_dev *))
+/*==============================================================================
+ *                        Common read/write methods
+ *==============================================================================
+ */
+
+static ssize_t tool_fn_read(struct tool_ctx *tc, char __user *ubuf,
+			    size_t size, loff_t *offp,
+			    u64 (*fn_read)(struct ntb_dev *))
 {
 	size_t buf_size;
-	char *buf;
-	ssize_t pos, rc;
+	char buf[TOOL_BUF_LEN];
+	ssize_t pos;
 
-	if (!db_read_fn)
+	if (!fn_read)
 		return -EINVAL;
 
-	buf_size = min_t(size_t, size, 0x20);
-
-	buf = kmalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pos = scnprintf(buf, buf_size, "%#llx\n",
-			db_read_fn(tc->ntb));
+	buf_size = min(size, sizeof(buf));
 
-	rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	pos = scnprintf(buf, buf_size, "%#llx\n", fn_read(tc->ntb));
 
-	kfree(buf);
-
-	return rc;
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
 
-static ssize_t tool_dbfn_write(struct tool_ctx *tc,
-			       const char __user *ubuf,
-			       size_t size, loff_t *offp,
-			       int (*db_set_fn)(struct ntb_dev *, u64),
-			       int (*db_clear_fn)(struct ntb_dev *, u64))
+static ssize_t tool_fn_write(struct tool_ctx *tc,
+			     const char __user *ubuf,
+			     size_t size, loff_t *offp,
+			     int (*fn_set)(struct ntb_dev *, u64),
+			     int (*fn_clear)(struct ntb_dev *, u64))
 {
-	u64 db_bits;
 	char *buf, cmd;
-	ssize_t rc;
+	ssize_t ret;
+	u64 bits;
 	int n;
 
 	buf = kmalloc(size + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(buf, size, offp, ubuf, size);
-	if (rc < 0) {
+	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
+	if (ret < 0) {
 		kfree(buf);
-		return rc;
+		return ret;
 	}
 
 	buf[size] = 0;
 
-	n = sscanf(buf, "%c %lli", &cmd, &db_bits);
+	n = sscanf(buf, "%c %lli", &cmd, &bits);
 
 	kfree(buf);
 
 	if (n != 2) {
-		rc = -EINVAL;
+		ret = -EINVAL;
 	} else if (cmd == 's') {
-		if (!db_set_fn)
-			rc = -EINVAL;
+		if (!fn_set)
+			ret = -EINVAL;
 		else
-			rc = db_set_fn(tc->ntb, db_bits);
+			ret = fn_set(tc->ntb, bits);
 	} else if (cmd == 'c') {
-		if (!db_clear_fn)
-			rc = -EINVAL;
+		if (!fn_clear)
+			ret = -EINVAL;
 		else
-			rc = db_clear_fn(tc->ntb, db_bits);
+			ret = fn_clear(tc->ntb, bits);
 	} else {
-		rc = -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return rc ? : size;
+	return ret ? : size;
 }
 
-static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
-				size_t size, loff_t *offp,
-				u32 (*spad_read_fn)(struct ntb_dev *, int))
-{
-	size_t buf_size;
-	char *buf;
-	ssize_t pos, rc;
-	int i, spad_count;
-
-	if (!spad_read_fn)
-		return -EINVAL;
-
-	spad_count = ntb_spad_count(tc->ntb);
+/*==============================================================================
+ *                            Port read/write methods
+ *==============================================================================
+ */
 
-	/*
-	 * We multiply the number of spads by 15 to get the buffer size
-	 * this is from 3 for the %d, 10 for the largest hex value
-	 * (0x00000000) and 2 for the tab and line feed.
-	 */
-	buf_size = min_t(size_t, size, spad_count * 15);
+static ssize_t tool_port_read(struct file *filep, char __user *ubuf,
+			      size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+	char buf[TOOL_BUF_LEN];
+	int pos;
 
-	buf = kmalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	pos = scnprintf(buf, sizeof(buf), "%d\n", ntb_port_number(tc->ntb));
 
-	pos = 0;
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
 
-	for (i = 0; i < spad_count; ++i) {
-		pos += scnprintf(buf + pos, buf_size - pos, "%d\t%#x\n",
-				 i, spad_read_fn(tc->ntb, i));
-	}
+static TOOL_FOPS_RDWR(tool_port_fops,
+		      tool_port_read,
+		      NULL);
 
-	rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+static ssize_t tool_peer_port_read(struct file *filep, char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_peer *peer = filep->private_data;
+	struct tool_ctx *tc = peer->tc;
+	char buf[TOOL_BUF_LEN];
+	int pos;
 
-	kfree(buf);
+	pos = scnprintf(buf, sizeof(buf), "%d\n",
+		ntb_peer_port_number(tc->ntb, peer->pidx));
 
-	return rc;
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
 
-static ssize_t tool_spadfn_write(struct tool_ctx *tc,
-				 const char __user *ubuf,
-				 size_t size, loff_t *offp,
-				 int (*spad_write_fn)(struct ntb_dev *,
-						      int, u32))
+static TOOL_FOPS_RDWR(tool_peer_port_fops,
+		      tool_peer_port_read,
+		      NULL);
+
+static int tool_init_peers(struct tool_ctx *tc)
 {
-	int spad_idx;
-	u32 spad_val;
-	char *buf, *buf_ptr;
-	int pos, n;
-	ssize_t rc;
-
-	if (!spad_write_fn) {
-		dev_dbg(&tc->ntb->dev, "no spad write fn\n");
-		return -EINVAL;
-	}
+	int pidx;
 
-	buf = kmalloc(size + 1, GFP_KERNEL);
-	if (!buf)
+	tc->peer_cnt = ntb_peer_port_count(tc->ntb);
+	tc->peers = devm_kcalloc(&tc->ntb->dev, tc->peer_cnt,
+				 sizeof(*tc->peers), GFP_KERNEL);
+	if (tc->peers == NULL)
 		return -ENOMEM;
 
-	rc = simple_write_to_buffer(buf, size, offp, ubuf, size);
-	if (rc < 0) {
-		kfree(buf);
-		return rc;
-	}
-
-	buf[size] = 0;
-	buf_ptr = buf;
-	n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
-	while (n == 2) {
-		buf_ptr += pos;
-		rc = spad_write_fn(tc->ntb, spad_idx, spad_val);
-		if (rc)
-			break;
-
-		n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++) {
+		tc->peers[pidx].pidx = pidx;
+		tc->peers[pidx].tc = tc;
 	}
 
-	if (n < 0)
-		rc = n;
-
-	kfree(buf);
-
-	return rc ? : size;
+	return 0;
 }
 
-static ssize_t tool_db_read(struct file *filep, char __user *ubuf,
-			    size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
-
-	return tool_dbfn_read(tc, ubuf, size, offp,
-			      tc->ntb->ops->db_read);
-}
+/*==============================================================================
+ *                       Link state read/write methods
+ *==============================================================================
+ */
 
-static ssize_t tool_db_write(struct file *filep, const char __user *ubuf,
-			     size_t size, loff_t *offp)
+static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
+			       size_t size, loff_t *offp)
 {
 	struct tool_ctx *tc = filep->private_data;
+	bool val;
+	int ret;
 
-	return tool_dbfn_write(tc, ubuf, size, offp,
-			       tc->ntb->ops->db_set,
-			       tc->ntb->ops->db_clear);
-}
+	ret = kstrtobool_from_user(ubuf, size, &val);
+	if (ret)
+		return ret;
 
-static TOOL_FOPS_RDWR(tool_db_fops,
-		      tool_db_read,
-		      tool_db_write);
+	if (val)
+		ret = ntb_link_enable(tc->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	else
+		ret = ntb_link_disable(tc->ntb);
 
-static ssize_t tool_mask_read(struct file *filep, char __user *ubuf,
-			      size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
+	if (ret)
+		return ret;
 
-	return tool_dbfn_read(tc, ubuf, size, offp,
-			      tc->ntb->ops->db_read_mask);
+	return size;
 }
 
-static ssize_t tool_mask_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
+static TOOL_FOPS_RDWR(tool_link_fops,
+		      NULL,
+		      tool_link_write);
+
+static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
+				   size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_peer *peer = filep->private_data;
+	struct tool_ctx *tc = peer->tc;
+	char buf[3];
 
-	return tool_dbfn_write(tc, ubuf, size, offp,
-			       tc->ntb->ops->db_set_mask,
-			       tc->ntb->ops->db_clear_mask);
+	if (ntb_link_is_up(tc->ntb, NULL, NULL) & BIT(peer->pidx))
+		buf[0] = 'Y';
+	else
+		buf[0] = 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, 3);
 }
 
-static TOOL_FOPS_RDWR(tool_mask_fops,
-		      tool_mask_read,
-		      tool_mask_write);
+static TOOL_FOPS_RDWR(tool_peer_link_fops,
+		      tool_peer_link_read,
+		      NULL);
 
-static ssize_t tool_peer_db_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_peer_link_event_write(struct file *filep,
+					  const char __user *ubuf,
+					  size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_peer *peer = filep->private_data;
+	struct tool_ctx *tc = peer->tc;
+	u64 link_msk;
+	bool val;
+	int ret;
 
-	return tool_dbfn_read(tc, ubuf, size, offp,
-			      tc->ntb->ops->peer_db_read);
-}
+	ret = kstrtobool_from_user(ubuf, size, &val);
+	if (ret)
+		return ret;
 
-static ssize_t tool_peer_db_write(struct file *filep, const char __user *ubuf,
-				  size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
+	link_msk = BIT_ULL_MASK(peer->pidx);
+
+	if (wait_event_interruptible(tc->link_wq,
+		!!(ntb_link_is_up(tc->ntb, NULL, NULL) & link_msk) == val))
+		return -ERESTART;
 
-	return tool_dbfn_write(tc, ubuf, size, offp,
-			       tc->ntb->ops->peer_db_set,
-			       tc->ntb->ops->peer_db_clear);
+	return size;
 }
 
-static TOOL_FOPS_RDWR(tool_peer_db_fops,
-		      tool_peer_db_read,
-		      tool_peer_db_write);
+static TOOL_FOPS_RDWR(tool_peer_link_event_fops,
+		      NULL,
+		      tool_peer_link_event_write);
 
-static ssize_t tool_peer_mask_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+/*==============================================================================
+ *                  Memory windows read/write/setting methods
+ *==============================================================================
+ */
+
+static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
+			    size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_mw *inmw = filep->private_data;
+
+	if (inmw->mm_base == NULL)
+		return -ENXIO;
 
-	return tool_dbfn_read(tc, ubuf, size, offp,
-			      tc->ntb->ops->peer_db_read_mask);
+	return simple_read_from_buffer(ubuf, size, offp,
+				       inmw->mm_base, inmw->size);
 }
 
-static ssize_t tool_peer_mask_write(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t tool_mw_write(struct file *filep, const char __user *ubuf,
+			     size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_mw *inmw = filep->private_data;
+
+	if (inmw->mm_base == NULL)
+		return -ENXIO;
 
-	return tool_dbfn_write(tc, ubuf, size, offp,
-			       tc->ntb->ops->peer_db_set_mask,
-			       tc->ntb->ops->peer_db_clear_mask);
+	return simple_write_to_buffer(inmw->mm_base, inmw->size, offp,
+				      ubuf, size);
 }
 
-static TOOL_FOPS_RDWR(tool_peer_mask_fops,
-		      tool_peer_mask_read,
-		      tool_peer_mask_write);
+static TOOL_FOPS_RDWR(tool_mw_fops,
+		      tool_mw_read,
+		      tool_mw_write);
 
-static ssize_t tool_spad_read(struct file *filep, char __user *ubuf,
-			      size_t size, loff_t *offp)
+static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
+			 size_t req_size)
 {
-	struct tool_ctx *tc = filep->private_data;
+	resource_size_t size, addr_align, size_align;
+	struct tool_mw *inmw = &tc->peers[pidx].inmws[widx];
+	char buf[TOOL_BUF_LEN];
+	int ret;
 
-	return tool_spadfn_read(tc, ubuf, size, offp,
-				tc->ntb->ops->spad_read);
-}
+	if (inmw->mm_base != NULL)
+		return 0;
 
-static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
+	ret = ntb_mw_get_align(tc->ntb, pidx, widx, &addr_align,
+				&size_align, &size);
+	if (ret)
+		return ret;
+
+	inmw->size = min_t(resource_size_t, req_size, size);
+	inmw->size = round_up(inmw->size, addr_align);
+	inmw->size = round_up(inmw->size, size_align);
+	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+					   &inmw->dma_base, GFP_KERNEL);
+	if (!inmw->mm_base)
+		return -ENOMEM;
 
-	return tool_spadfn_write(tc, ubuf, size, offp,
-				 tc->ntb->ops->spad_write);
-}
+	if (!IS_ALIGNED(inmw->dma_base, addr_align)) {
+		ret = -ENOMEM;
+		goto err_free_dma;
+	}
 
-static TOOL_FOPS_RDWR(tool_spad_fops,
-		      tool_spad_read,
-		      tool_spad_write);
+	ret = ntb_mw_set_trans(tc->ntb, pidx, widx, inmw->dma_base, inmw->size);
+	if (ret)
+		goto err_free_dma;
 
-static u32 ntb_tool_peer_spad_read(struct ntb_dev *ntb, int sidx)
-{
-	return ntb_peer_spad_read(ntb, PIDX, sidx);
-}
+	snprintf(buf, sizeof(buf), "mw%d", widx);
+	inmw->dbgfs_file = debugfs_create_file(buf, 0600,
+					       tc->peers[pidx].dbgfs_dir, inmw,
+					       &tool_mw_fops);
 
-static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
+	return 0;
 
-	return tool_spadfn_read(tc, ubuf, size, offp, ntb_tool_peer_spad_read);
-}
+err_free_dma:
+	dma_free_coherent(&tc->ntb->dev, inmw->size, inmw->mm_base,
+			  inmw->dma_base);
+	inmw->mm_base = NULL;
+	inmw->dma_base = 0;
+	inmw->size = 0;
 
-static int ntb_tool_peer_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
-{
-	return ntb_peer_spad_write(ntb, PIDX, sidx, val);
+	return ret;
 }
 
-static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static void tool_free_mw(struct tool_ctx *tc, int pidx, int widx)
 {
-	struct tool_ctx *tc = filep->private_data;
-
-	return tool_spadfn_write(tc, ubuf, size, offp,
-				 ntb_tool_peer_spad_write);
-}
-
-static TOOL_FOPS_RDWR(tool_peer_spad_fops,
-		      tool_peer_spad_read,
-		      tool_peer_spad_write);
+	struct tool_mw *inmw = &tc->peers[pidx].inmws[widx];
 
-static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
-			      size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
-	char buf[3];
+	debugfs_remove(inmw->dbgfs_file);
 
-	buf[0] = ntb_link_is_up(tc->ntb, NULL, NULL) ? 'Y' : 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
+	if (inmw->mm_base != NULL) {
+		ntb_mw_clear_trans(tc->ntb, pidx, widx);
+		dma_free_coherent(&tc->ntb->dev, inmw->size,
+				  inmw->mm_base, inmw->dma_base);
+	}
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
+	inmw->mm_base = NULL;
+	inmw->dma_base = 0;
+	inmw->size = 0;
+	inmw->dbgfs_file = NULL;
 }
 
-static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
+static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
+				  size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc = filep->private_data;
-	char buf[32];
+	struct tool_mw *inmw = filep->private_data;
+	resource_size_t addr_align;
+	resource_size_t size_align;
+	resource_size_t size_max;
+	ssize_t ret, off = 0;
 	size_t buf_size;
-	bool val;
-	int rc;
+	char *buf;
 
-	buf_size = min(size, (sizeof(buf) - 1));
-	if (copy_from_user(buf, ubuf, buf_size))
-		return -EFAULT;
+	buf_size = min_t(size_t, size, 512);
 
-	buf[buf_size] = '\0';
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	rc = strtobool(buf, &val);
-	if (rc)
-		return rc;
+	ret = ntb_mw_get_align(inmw->tc->ntb, inmw->pidx, inmw->widx,
+			       &addr_align, &size_align, &size_max);
+	if (ret)
+		return ret;
 
-	if (val)
-		rc = ntb_link_enable(tc->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
-	else
-		rc = ntb_link_disable(tc->ntb);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Inbound MW     \t%d\n",
+			 inmw->widx);
 
-	if (rc)
-		return rc;
+	off += scnprintf(buf + off, buf_size - off,
+			 "Port           \t%d (%d)\n",
+			 ntb_peer_port_number(inmw->tc->ntb, inmw->pidx),
+			 inmw->pidx);
 
-	return size;
-}
+	off += scnprintf(buf + off, buf_size - off,
+			 "Window Address \t0x%pK\n", inmw->mm_base);
 
-static TOOL_FOPS_RDWR(tool_link_fops,
-		      tool_link_read,
-		      tool_link_write);
+	off += scnprintf(buf + off, buf_size - off,
+			 "DMA Address    \t%pad\n",
+			 &inmw->dma_base);
 
-static ssize_t tool_link_event_write(struct file *filep,
-				     const char __user *ubuf,
-				     size_t size, loff_t *offp)
-{
-	struct tool_ctx *tc = filep->private_data;
-	char buf[32];
-	size_t buf_size;
-	bool val;
-	int rc;
+	off += scnprintf(buf + off, buf_size - off,
+			 "Window Size    \t%pa[p]\n",
+			 &inmw->size);
 
-	buf_size = min(size, (sizeof(buf) - 1));
-	if (copy_from_user(buf, ubuf, buf_size))
-		return -EFAULT;
+	off += scnprintf(buf + off, buf_size - off,
+			 "Alignment      \t%pa[p]\n",
+			 &addr_align);
 
-	buf[buf_size] = '\0';
+	off += scnprintf(buf + off, buf_size - off,
+			 "Size Alignment \t%pa[p]\n",
+			 &size_align);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "Size Max       \t%pa[p]\n",
+			 &size_max);
 
-	rc = strtobool(buf, &val);
-	if (rc)
-		return rc;
+	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
+	kfree(buf);
 
-	if (wait_event_interruptible(tc->link_wq,
-		ntb_link_is_up(tc->ntb, NULL, NULL) == val))
-		return -ERESTART;
+	return ret;
+}
+
+static ssize_t tool_mw_trans_write(struct file *filep, const char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_mw *inmw = filep->private_data;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
+
+	tool_free_mw(inmw->tc, inmw->pidx, inmw->widx);
+	if (val) {
+		ret = tool_setup_mw(inmw->tc, inmw->pidx, inmw->widx, val);
+		if (ret)
+			return ret;
+	}
 
 	return size;
 }
 
-static TOOL_FOPS_RDWR(tool_link_event_fops,
-		      NULL,
-		      tool_link_event_write);
+static TOOL_FOPS_RDWR(tool_mw_trans_fops,
+		      tool_mw_trans_read,
+		      tool_mw_trans_write);
 
-static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
-			    size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
+				 size_t size, loff_t *offp)
 {
-	struct tool_mw *mw = filep->private_data;
-	ssize_t rc;
+	struct tool_mw *outmw = filep->private_data;
 	loff_t pos = *offp;
+	ssize_t ret;
 	void *buf;
 
-	if (mw->local == NULL)
+	if (outmw->io_base == NULL)
 		return -EIO;
-	if (pos < 0)
-		return -EINVAL;
-	if (pos >= mw->win_size || !size)
+
+	if (pos >= outmw->size || !size)
 		return 0;
-	if (size > mw->win_size - pos)
-		size = mw->win_size - pos;
+
+	if (size > outmw->size - pos)
+		size = outmw->size - pos;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	memcpy_fromio(buf, mw->local + pos, size);
-	rc = copy_to_user(ubuf, buf, size);
-	if (rc == size) {
-		rc = -EFAULT;
+	memcpy_fromio(buf, outmw->io_base + pos, size);
+	ret = copy_to_user(ubuf, buf, size);
+	if (ret == size) {
+		ret = -EFAULT;
 		goto err_free;
 	}
 
-	size -= rc;
+	size -= ret;
 	*offp = pos + size;
-	rc = size;
+	ret = size;
 
 err_free:
 	kfree(buf);
 
-	return rc;
+	return ret;
 }
 
-static ssize_t tool_mw_write(struct file *filep, const char __user *ubuf,
-			     size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
+				  size_t size, loff_t *offp)
 {
-	struct tool_mw *mw = filep->private_data;
-	ssize_t rc;
+	struct tool_mw *outmw = filep->private_data;
+	ssize_t ret;
 	loff_t pos = *offp;
 	void *buf;
 
-	if (pos < 0)
-		return -EINVAL;
-	if (pos >= mw->win_size || !size)
+	if (outmw->io_base == NULL)
+		return -EIO;
+
+	if (pos >= outmw->size || !size)
 		return 0;
-	if (size > mw->win_size - pos)
-		size = mw->win_size - pos;
+	if (size > outmw->size - pos)
+		size = outmw->size - pos;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	rc = copy_from_user(buf, ubuf, size);
-	if (rc == size) {
-		rc = -EFAULT;
+	ret = copy_from_user(buf, ubuf, size);
+	if (ret == size) {
+		ret = -EFAULT;
 		goto err_free;
 	}
 
-	size -= rc;
+	size -= ret;
 	*offp = pos + size;
-	rc = size;
+	ret = size;
 
-	memcpy_toio(mw->local + pos, buf, size);
+	memcpy_toio(outmw->io_base + pos, buf, size);
 
 err_free:
 	kfree(buf);
 
-	return rc;
-}
-
-static TOOL_FOPS_RDWR(tool_mw_fops,
-		      tool_mw_read,
-		      tool_mw_write);
-
-static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
-{
-	struct tool_mw *mw = filep->private_data;
-
-	if (!mw->peer)
-		return -ENXIO;
-
-	return simple_read_from_buffer(ubuf, size, offp, mw->peer, mw->size);
-}
-
-static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
-				  size_t size, loff_t *offp)
-{
-	struct tool_mw *mw = filep->private_data;
-
-	if (!mw->peer)
-		return -ENXIO;
-
-	return simple_write_to_buffer(mw->peer, mw->size, offp, ubuf, size);
+	return ret;
 }
 
 static TOOL_FOPS_RDWR(tool_peer_mw_fops,
 		      tool_peer_mw_read,
 		      tool_peer_mw_write);
 
-static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
+static int tool_setup_peer_mw(struct tool_ctx *tc, int pidx, int widx,
+			      u64 req_addr, size_t req_size)
 {
-	int rc;
-	struct tool_mw *mw = &tc->mws[idx];
-	resource_size_t size, align_addr, align_size;
-	char buf[16];
+	struct tool_mw *outmw = &tc->outmws[widx];
+	resource_size_t map_size;
+	phys_addr_t map_base;
+	char buf[TOOL_BUF_LEN];
+	int ret;
 
-	if (mw->peer)
+	if (outmw->io_base != NULL)
 		return 0;
 
-	rc = ntb_mw_get_align(tc->ntb, PIDX, idx, &align_addr,
-				&align_size, &size);
-	if (rc)
-		return rc;
+	ret = ntb_peer_mw_get_addr(tc->ntb, widx, &map_base, &map_size);
+	if (ret)
+		return ret;
 
-	mw->size = min_t(resource_size_t, req_size, size);
-	mw->size = round_up(mw->size, align_addr);
-	mw->size = round_up(mw->size, align_size);
-	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
-				      &mw->peer_dma, GFP_KERNEL);
+	ret = ntb_peer_mw_set_trans(tc->ntb, pidx, widx, req_addr, req_size);
+	if (ret)
+		return ret;
 
-	if (!mw->peer || !IS_ALIGNED(mw->peer_dma, align_addr))
-		return -ENOMEM;
+	outmw->io_base = ioremap_wc(map_base, map_size);
+	if (outmw->io_base == NULL) {
+		ret = -EFAULT;
+		goto err_clear_trans;
+	}
 
-	rc = ntb_mw_set_trans(tc->ntb, PIDX, idx, mw->peer_dma, mw->size);
-	if (rc)
-		goto err_free_dma;
+	outmw->tr_base = req_addr;
+	outmw->size = req_size;
+	outmw->pidx = pidx;
 
-	snprintf(buf, sizeof(buf), "peer_mw%d", idx);
-	mw->peer_dbg_file = debugfs_create_file(buf, S_IRUSR | S_IWUSR,
-						mw->tc->dbgfs, mw,
-						&tool_peer_mw_fops);
+	snprintf(buf, sizeof(buf), "peer_mw%d", widx);
+	outmw->dbgfs_file = debugfs_create_file(buf, 0600,
+					       tc->peers[pidx].dbgfs_dir, outmw,
+					       &tool_peer_mw_fops);
 
 	return 0;
 
-err_free_dma:
-	dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
-			  mw->peer,
-			  mw->peer_dma);
-	mw->peer = NULL;
-	mw->peer_dma = 0;
-	mw->size = 0;
-
-	return rc;
+err_clear_trans:
+	ntb_peer_mw_clear_trans(tc->ntb, pidx, widx);
+
+	return ret;
 }
 
-static void tool_free_mw(struct tool_ctx *tc, int idx)
+static void tool_free_peer_mw(struct tool_ctx *tc, int widx)
 {
-	struct tool_mw *mw = &tc->mws[idx];
+	struct tool_mw *outmw = &tc->outmws[widx];
 
-	if (mw->peer) {
-		ntb_mw_clear_trans(tc->ntb, PIDX, idx);
-		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
-				  mw->peer,
-				  mw->peer_dma);
-	}
+	debugfs_remove(outmw->dbgfs_file);
 
-	mw->peer = NULL;
-	mw->peer_dma = 0;
-
-	debugfs_remove(mw->peer_dbg_file);
+	if (outmw->io_base != NULL) {
+		iounmap(tc->outmws[widx].io_base);
+		ntb_peer_mw_clear_trans(tc->ntb, outmw->pidx, widx);
+	}
 
-	mw->peer_dbg_file = NULL;
+	outmw->io_base = NULL;
+	outmw->tr_base = 0;
+	outmw->size = 0;
+	outmw->pidx = -1;
+	outmw->dbgfs_file = NULL;
 }
 
-static ssize_t tool_peer_mw_trans_read(struct file *filep,
-				       char __user *ubuf,
-				       size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
+					size_t size, loff_t *offp)
 {
-	struct tool_mw *mw = filep->private_data;
-
-	char *buf;
+	struct tool_mw_wrap *outmw_wrap = filep->private_data;
+	struct tool_mw *outmw = outmw_wrap->mw;
+	resource_size_t map_size;
+	phys_addr_t map_base;
+	ssize_t off = 0;
 	size_t buf_size;
-	ssize_t ret, off = 0;
+	char *buf;
+	int ret;
 
-	phys_addr_t base;
-	resource_size_t mw_size;
-	resource_size_t align_addr = 0;
-	resource_size_t align_size = 0;
-	resource_size_t max_size = 0;
+	ret = ntb_peer_mw_get_addr(outmw->tc->ntb, outmw->widx,
+				  &map_base, &map_size);
+	if (ret)
+		return ret;
 
 	buf_size = min_t(size_t, size, 512);
 
@@ -762,43 +888,37 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 	if (!buf)
 		return -ENOMEM;
 
-	ntb_mw_get_align(mw->tc->ntb, PIDX, mw->idx,
-			 &align_addr, &align_size, &max_size);
-	ntb_peer_mw_get_addr(mw->tc->ntb, mw->idx, &base, &mw_size);
-
 	off += scnprintf(buf + off, buf_size - off,
-			 "Peer MW %d Information:\n", mw->idx);
+			 "Outbound MW:        \t%d\n", outmw->widx);
 
-	off += scnprintf(buf + off, buf_size - off,
-			 "Physical Address      \t%pa[p]\n",
-			 &base);
-
-	off += scnprintf(buf + off, buf_size - off,
-			 "Window Size           \t%lld\n",
-			 (unsigned long long)mw_size);
+	if (outmw->io_base != NULL) {
+		off += scnprintf(buf + off, buf_size - off,
+			"Port attached       \t%d (%d)\n",
+			ntb_peer_port_number(outmw->tc->ntb, outmw->pidx),
+			outmw->pidx);
+	} else {
+		off += scnprintf(buf + off, buf_size - off,
+				 "Port attached       \t-1 (-1)\n");
+	}
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Alignment             \t%lld\n",
-			 (unsigned long long)align_addr);
+			 "Virtual address     \t0x%pK\n", outmw->io_base);
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Size Alignment        \t%lld\n",
-			 (unsigned long long)align_size);
+			 "Phys Address        \t%pa[p]\n", &map_base);
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Size Max              \t%lld\n",
-			 (unsigned long long)max_size);
+			 "Mapping Size        \t%pa[p]\n", &map_size);
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Ready                 \t%c\n",
-			 (mw->peer) ? 'Y' : 'N');
+			 "Translation Address \t0x%016llx\n", outmw->tr_base);
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Allocated Size       \t%zd\n",
-			 (mw->peer) ? (size_t)mw->size : 0);
+			 "Window Size         \t%pa[p]\n", &outmw->size);
 
 	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
 	kfree(buf);
+
 	return ret;
 }
 
@@ -806,12 +926,12 @@ static ssize_t tool_peer_mw_trans_write(struct file *filep,
 					const char __user *ubuf,
 					size_t size, loff_t *offp)
 {
-	struct tool_mw *mw = filep->private_data;
-
-	char buf[32];
-	size_t buf_size;
-	unsigned long long val;
-	int rc;
+	struct tool_mw_wrap *outmw_wrap = filep->private_data;
+	struct tool_mw *outmw = outmw_wrap->mw;
+	size_t buf_size, wsize;
+	char buf[TOOL_BUF_LEN];
+	int ret, n;
+	u64 addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
 	if (copy_from_user(buf, ubuf, buf_size))
@@ -819,16 +939,17 @@ static ssize_t tool_peer_mw_trans_write(struct file *filep,
 
 	buf[buf_size] = '\0';
 
-	rc = kstrtoull(buf, 0, &val);
-	if (rc)
-		return rc;
-
-	tool_free_mw(mw->tc, mw->idx);
-	if (val)
-		rc = tool_setup_mw(mw->tc, mw->idx, val);
+	n = sscanf(buf, "%lli:%zi", &addr, &wsize);
+	if (n != 2)
+		return -EINVAL;
 
-	if (rc)
-		return rc;
+	tool_free_peer_mw(outmw->tc, outmw->widx);
+	if (wsize) {
+		ret = tool_setup_peer_mw(outmw->tc, outmw_wrap->pidx,
+					 outmw->widx, addr, wsize);
+		if (ret)
+			return ret;
+	}
 
 	return size;
 }
@@ -837,195 +958,734 @@ static TOOL_FOPS_RDWR(tool_peer_mw_trans_fops,
 		      tool_peer_mw_trans_read,
 		      tool_peer_mw_trans_write);
 
-static int tool_init_mw(struct tool_ctx *tc, int idx)
+static int tool_init_mws(struct tool_ctx *tc)
 {
-	struct tool_mw *mw = &tc->mws[idx];
-	phys_addr_t base;
-	int rc;
-
-	rc = ntb_peer_mw_get_addr(tc->ntb, idx, &base, &mw->win_size);
-	if (rc)
-		return rc;
-
-	mw->tc = tc;
-	mw->idx = idx;
-	mw->local = ioremap_wc(base, mw->win_size);
-	if (!mw->local)
-		return -EFAULT;
+	int widx, pidx;
+
+	/* Initialize outbound memory windows */
+	tc->outmw_cnt = ntb_peer_mw_count(tc->ntb);
+	tc->outmws = devm_kcalloc(&tc->ntb->dev, tc->outmw_cnt,
+				  sizeof(*tc->outmws), GFP_KERNEL);
+	if (tc->outmws == NULL)
+		return -ENOMEM;
+
+	for (widx = 0; widx < tc->outmw_cnt; widx++) {
+		tc->outmws[widx].widx = widx;
+		tc->outmws[widx].pidx = -1;
+		tc->outmws[widx].tc = tc;
+	}
+
+	/* Initialize inbound memory windows and outbound MWs wrapper */
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++) {
+		tc->peers[pidx].inmw_cnt = ntb_mw_count(tc->ntb, pidx);
+		tc->peers[pidx].inmws =
+			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].inmw_cnt,
+				    sizeof(*tc->peers[pidx].inmws), GFP_KERNEL);
+		if (tc->peers[pidx].inmws == NULL)
+			return -ENOMEM;
+
+		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++) {
+			tc->peers[pidx].inmws[widx].widx = widx;
+			tc->peers[pidx].inmws[widx].pidx = pidx;
+			tc->peers[pidx].inmws[widx].tc = tc;
+		}
+
+		tc->peers[pidx].outmw_cnt = ntb_peer_mw_count(tc->ntb);
+		tc->peers[pidx].outmws =
+			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
+				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+
+		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
+			tc->peers[pidx].outmws[widx].pidx = pidx;
+			tc->peers[pidx].outmws[widx].mw = &tc->outmws[widx];
+		}
+	}
 
 	return 0;
 }
 
-static void tool_free_mws(struct tool_ctx *tc)
+static void tool_clear_mws(struct tool_ctx *tc)
 {
-	int i;
+	int widx, pidx;
 
-	for (i = 0; i < tc->mw_count; i++) {
-		tool_free_mw(tc, i);
+	/* Free outbound memory windows */
+	for (widx = 0; widx < tc->outmw_cnt; widx++)
+		tool_free_peer_mw(tc, widx);
 
-		if (tc->mws[i].local)
-			iounmap(tc->mws[i].local);
+	/* Free outbound memory windows */
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++)
+		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++)
+			tool_free_mw(tc, pidx, widx);
+}
 
-		tc->mws[i].local = NULL;
-	}
+/*==============================================================================
+ *                       Doorbell read/write methods
+ *==============================================================================
+ */
+
+static ssize_t tool_db_read(struct file *filep, char __user *ubuf,
+			    size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_read);
 }
 
-static void tool_setup_dbgfs(struct tool_ctx *tc)
+static ssize_t tool_db_write(struct file *filep, const char __user *ubuf,
+			     size_t size, loff_t *offp)
 {
-	int i;
+	struct tool_ctx *tc = filep->private_data;
 
-	/* This modules is useless without dbgfs... */
-	if (!tool_dbgfs) {
-		tc->dbgfs = NULL;
-		return;
+	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->db_set,
+			     tc->ntb->ops->db_clear);
+}
+
+static TOOL_FOPS_RDWR(tool_db_fops,
+		      tool_db_read,
+		      tool_db_write);
+
+static ssize_t tool_db_valid_mask_read(struct file *filep, char __user *ubuf,
+				       size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_valid_mask);
+}
+
+static TOOL_FOPS_RDWR(tool_db_valid_mask_fops,
+		      tool_db_valid_mask_read,
+		      NULL);
+
+static ssize_t tool_db_mask_read(struct file *filep, char __user *ubuf,
+				 size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_read_mask);
+}
+
+static ssize_t tool_db_mask_write(struct file *filep, const char __user *ubuf,
+			       size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->db_set_mask,
+			     tc->ntb->ops->db_clear_mask);
+}
+
+static TOOL_FOPS_RDWR(tool_db_mask_fops,
+		      tool_db_mask_read,
+		      tool_db_mask_write);
+
+static ssize_t tool_peer_db_read(struct file *filep, char __user *ubuf,
+				 size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->peer_db_read);
+}
+
+static ssize_t tool_peer_db_write(struct file *filep, const char __user *ubuf,
+				  size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->peer_db_set,
+			     tc->ntb->ops->peer_db_clear);
+}
+
+static TOOL_FOPS_RDWR(tool_peer_db_fops,
+		      tool_peer_db_read,
+		      tool_peer_db_write);
+
+static ssize_t tool_peer_db_mask_read(struct file *filep, char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp,
+			    tc->ntb->ops->peer_db_read_mask);
+}
+
+static ssize_t tool_peer_db_mask_write(struct file *filep,
+				       const char __user *ubuf,
+				       size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_write(tc, ubuf, size, offp,
+			     tc->ntb->ops->peer_db_set_mask,
+			     tc->ntb->ops->peer_db_clear_mask);
+}
+
+static TOOL_FOPS_RDWR(tool_peer_db_mask_fops,
+		      tool_peer_db_mask_read,
+		      tool_peer_db_mask_write);
+
+static ssize_t tool_db_event_write(struct file *filep,
+				   const char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
+
+	if (wait_event_interruptible(tc->db_wq, ntb_db_read(tc->ntb) == val))
+		return -ERESTART;
+
+	return size;
+}
+
+static TOOL_FOPS_RDWR(tool_db_event_fops,
+		      NULL,
+		      tool_db_event_write);
+
+/*==============================================================================
+ *                       Scratchpads read/write methods
+ *==============================================================================
+ */
+
+static ssize_t tool_spad_read(struct file *filep, char __user *ubuf,
+			      size_t size, loff_t *offp)
+{
+	struct tool_spad *spad = filep->private_data;
+	char buf[TOOL_BUF_LEN];
+	ssize_t pos;
+
+	if (!spad->tc->ntb->ops->spad_read)
+		return -EINVAL;
+
+	pos = scnprintf(buf, sizeof(buf), "%#x\n",
+		ntb_spad_read(spad->tc->ntb, spad->sidx));
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
+			       size_t size, loff_t *offp)
+{
+	struct tool_spad *spad = filep->private_data;
+	u32 val;
+	int ret;
+
+	if (!spad->tc->ntb->ops->spad_write) {
+		dev_dbg(&spad->tc->ntb->dev, "no spad write fn\n");
+		return -EINVAL;
 	}
 
-	tc->dbgfs = debugfs_create_dir(dev_name(&tc->ntb->dev),
-				       tool_dbgfs);
-	if (!tc->dbgfs)
-		return;
+	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
 
-	debugfs_create_file("db", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_db_fops);
+	ret = ntb_spad_write(spad->tc->ntb, spad->sidx, val);
 
-	debugfs_create_file("mask", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_mask_fops);
+	return ret ?: size;
+}
 
-	debugfs_create_file("peer_db", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_peer_db_fops);
+static TOOL_FOPS_RDWR(tool_spad_fops,
+		      tool_spad_read,
+		      tool_spad_write);
+
+static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_spad *spad = filep->private_data;
+	char buf[TOOL_BUF_LEN];
+	ssize_t pos;
 
-	debugfs_create_file("peer_mask", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_peer_mask_fops);
+	if (!spad->tc->ntb->ops->peer_spad_read)
+		return -EINVAL;
 
-	debugfs_create_file("spad", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_spad_fops);
+	pos = scnprintf(buf, sizeof(buf), "%#x\n",
+		ntb_peer_spad_read(spad->tc->ntb, spad->pidx, spad->sidx));
 
-	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_peer_spad_fops);
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
 
-	debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
-			    tc, &tool_link_fops);
+static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct tool_spad *spad = filep->private_data;
+	u32 val;
+	int ret;
+
+	if (!spad->tc->ntb->ops->peer_spad_write) {
+		dev_dbg(&spad->tc->ntb->dev, "no spad write fn\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
 
-	debugfs_create_file("link_event", S_IWUSR, tc->dbgfs,
-			    tc, &tool_link_event_fops);
+	ret = ntb_peer_spad_write(spad->tc->ntb, spad->pidx, spad->sidx, val);
 
-	for (i = 0; i < tc->mw_count; i++) {
-		char buf[30];
+	return ret ?: size;
+}
+
+static TOOL_FOPS_RDWR(tool_peer_spad_fops,
+		      tool_peer_spad_read,
+		      tool_peer_spad_write);
 
-		snprintf(buf, sizeof(buf), "mw%d", i);
-		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
-				    &tc->mws[i], &tool_mw_fops);
+static int tool_init_spads(struct tool_ctx *tc)
+{
+	int sidx, pidx;
 
-		snprintf(buf, sizeof(buf), "peer_trans%d", i);
-		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
-				    &tc->mws[i], &tool_peer_mw_trans_fops);
+	/* Initialize inbound scratchpad structures */
+	tc->inspad_cnt = ntb_spad_count(tc->ntb);
+	tc->inspads = devm_kcalloc(&tc->ntb->dev, tc->inspad_cnt,
+				   sizeof(*tc->inspads), GFP_KERNEL);
+	if (tc->inspads == NULL)
+		return -ENOMEM;
+
+	for (sidx = 0; sidx < tc->inspad_cnt; sidx++) {
+		tc->inspads[sidx].sidx = sidx;
+		tc->inspads[sidx].pidx = -1;
+		tc->inspads[sidx].tc = tc;
 	}
+
+	/* Initialize outbound scratchpad structures */
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++) {
+		tc->peers[pidx].outspad_cnt = ntb_spad_count(tc->ntb);
+		tc->peers[pidx].outspads =
+			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outspad_cnt,
+				sizeof(*tc->peers[pidx].outspads), GFP_KERNEL);
+		if (tc->peers[pidx].outspads == NULL)
+			return -ENOMEM;
+
+		for (sidx = 0; sidx < tc->peers[pidx].outspad_cnt; sidx++) {
+			tc->peers[pidx].outspads[sidx].sidx = sidx;
+			tc->peers[pidx].outspads[sidx].pidx = pidx;
+			tc->peers[pidx].outspads[sidx].tc = tc;
+		}
+	}
+
+	return 0;
 }
 
-static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
+/*==============================================================================
+ *                       Messages read/write methods
+ *==============================================================================
+ */
+
+static ssize_t tool_inmsg_read(struct file *filep, char __user *ubuf,
+			       size_t size, loff_t *offp)
 {
-	struct tool_ctx *tc;
-	int rc;
-	int i;
+	struct tool_msg *msg = filep->private_data;
+	char buf[TOOL_BUF_LEN];
+	ssize_t pos;
+	u32 data;
+	int pidx;
+
+	data = ntb_msg_read(msg->tc->ntb, &pidx, msg->midx);
+
+	pos = scnprintf(buf, sizeof(buf), "0x%08x<-%d\n", data, pidx);
+
+	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+}
+
+static TOOL_FOPS_RDWR(tool_inmsg_fops,
+		      tool_inmsg_read,
+		      NULL);
+
+static ssize_t tool_outmsg_write(struct file *filep,
+				 const char __user *ubuf,
+				 size_t size, loff_t *offp)
+{
+	struct tool_msg *msg = filep->private_data;
+	u32 val;
+	int ret;
+
+	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = ntb_peer_msg_write(msg->tc->ntb, msg->pidx, msg->midx, val);
+
+	return ret ? : size;
+}
+
+static TOOL_FOPS_RDWR(tool_outmsg_fops,
+		      NULL,
+		      tool_outmsg_write);
+
+static ssize_t tool_msg_sts_read(struct file *filep, char __user *ubuf,
+				 size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_read_sts);
+}
+
+static ssize_t tool_msg_sts_write(struct file *filep, const char __user *ubuf,
+				  size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_write(tc, ubuf, size, offp, NULL,
+			     tc->ntb->ops->msg_clear_sts);
+}
+
+static TOOL_FOPS_RDWR(tool_msg_sts_fops,
+		      tool_msg_sts_read,
+		      tool_msg_sts_write);
+
+static ssize_t tool_msg_inbits_read(struct file *filep, char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_inbits);
+}
+
+static TOOL_FOPS_RDWR(tool_msg_inbits_fops,
+		      tool_msg_inbits_read,
+		      NULL);
+
+static ssize_t tool_msg_outbits_read(struct file *filep, char __user *ubuf,
+				     size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_outbits);
+}
+
+static TOOL_FOPS_RDWR(tool_msg_outbits_fops,
+		      tool_msg_outbits_read,
+		      NULL);
+
+static ssize_t tool_msg_mask_write(struct file *filep, const char __user *ubuf,
+				   size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	return tool_fn_write(tc, ubuf, size, offp,
+			     tc->ntb->ops->msg_set_mask,
+			     tc->ntb->ops->msg_clear_mask);
+}
+
+static TOOL_FOPS_RDWR(tool_msg_mask_fops,
+		      NULL,
+		      tool_msg_mask_write);
+
+static ssize_t tool_msg_event_write(struct file *filep,
+				    const char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
+
+	if (wait_event_interruptible(tc->msg_wq,
+		ntb_msg_read_sts(tc->ntb) == val))
+		return -ERESTART;
 
-	if (!ntb->ops->mw_set_trans) {
-		dev_dbg(&ntb->dev, "need inbound MW based NTB API\n");
-		rc = -EINVAL;
-		goto err_tc;
+	return size;
+}
+
+static TOOL_FOPS_RDWR(tool_msg_event_fops,
+		      NULL,
+		      tool_msg_event_write);
+
+static int tool_init_msgs(struct tool_ctx *tc)
+{
+	int midx, pidx;
+
+	/* Initialize inbound message structures */
+	tc->inmsg_cnt = ntb_msg_count(tc->ntb);
+	tc->inmsgs = devm_kcalloc(&tc->ntb->dev, tc->inmsg_cnt,
+				   sizeof(*tc->inmsgs), GFP_KERNEL);
+	if (tc->inmsgs == NULL)
+		return -ENOMEM;
+
+	for (midx = 0; midx < tc->inmsg_cnt; midx++) {
+		tc->inmsgs[midx].midx = midx;
+		tc->inmsgs[midx].pidx = -1;
+		tc->inmsgs[midx].tc = tc;
 	}
 
-	if (ntb_spad_count(ntb) < 1) {
-		dev_dbg(&ntb->dev, "no enough scratchpads\n");
-		rc = -EINVAL;
-		goto err_tc;
+	/* Initialize outbound message structures */
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++) {
+		tc->peers[pidx].outmsg_cnt = ntb_msg_count(tc->ntb);
+		tc->peers[pidx].outmsgs =
+			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmsg_cnt,
+				sizeof(*tc->peers[pidx].outmsgs), GFP_KERNEL);
+		if (tc->peers[pidx].outmsgs == NULL)
+			return -ENOMEM;
+
+		for (midx = 0; midx < tc->peers[pidx].outmsg_cnt; midx++) {
+			tc->peers[pidx].outmsgs[midx].midx = midx;
+			tc->peers[pidx].outmsgs[midx].pidx = pidx;
+			tc->peers[pidx].outmsgs[midx].tc = tc;
+		}
 	}
 
+	return 0;
+}
+
+/*==============================================================================
+ *                          Initialization methods
+ *==============================================================================
+ */
+
+static struct tool_ctx *tool_create_data(struct ntb_dev *ntb)
+{
+	struct tool_ctx *tc;
+
+	tc = devm_kzalloc(&ntb->dev, sizeof(*tc), GFP_KERNEL);
+	if (tc == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	tc->ntb = ntb;
+	init_waitqueue_head(&tc->link_wq);
+	init_waitqueue_head(&tc->db_wq);
+	init_waitqueue_head(&tc->msg_wq);
+
 	if (ntb_db_is_unsafe(ntb))
 		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
 
 	if (ntb_spad_is_unsafe(ntb))
 		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
 
-	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
-		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
+	return tc;
+}
+
+static void tool_clear_data(struct tool_ctx *tc)
+{
+	wake_up(&tc->link_wq);
+	wake_up(&tc->db_wq);
+	wake_up(&tc->msg_wq);
+}
+
+static int tool_init_ntb(struct tool_ctx *tc)
+{
+	return ntb_set_ctx(tc->ntb, tc, &tool_ops);
+}
+
+static void tool_clear_ntb(struct tool_ctx *tc)
+{
+	ntb_clear_ctx(tc->ntb);
+	ntb_link_disable(tc->ntb);
+}
 
-	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
-	if (!tc) {
-		rc = -ENOMEM;
-		goto err_tc;
+static void tool_setup_dbgfs(struct tool_ctx *tc)
+{
+	int pidx, widx, sidx, midx;
+	char buf[TOOL_BUF_LEN];
+
+	/* This modules is useless without dbgfs... */
+	if (!tool_dbgfs_topdir) {
+		tc->dbgfs_dir = NULL;
+		return;
 	}
 
-	tc->ntb = ntb;
-	init_waitqueue_head(&tc->link_wq);
+	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
+					   tool_dbgfs_topdir);
+	if (!tc->dbgfs_dir)
+		return;
+
+	debugfs_create_file("port", 0600, tc->dbgfs_dir,
+			    tc, &tool_port_fops);
+
+	debugfs_create_file("link", 0600, tc->dbgfs_dir,
+			    tc, &tool_link_fops);
+
+	debugfs_create_file("db", 0600, tc->dbgfs_dir,
+			    tc, &tool_db_fops);
+
+	debugfs_create_file("db_valid_mask", 0600, tc->dbgfs_dir,
+			    tc, &tool_db_valid_mask_fops);
+
+	debugfs_create_file("db_mask", 0600, tc->dbgfs_dir,
+			    tc, &tool_db_mask_fops);
+
+	debugfs_create_file("db_event", 0600, tc->dbgfs_dir,
+			    tc, &tool_db_event_fops);
 
-	tc->mw_count = min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
-	for (i = 0; i < tc->mw_count; i++) {
-		rc = tool_init_mw(tc, i);
-		if (rc)
-			goto err_ctx;
+	debugfs_create_file("peer_db", 0600, tc->dbgfs_dir,
+			    tc, &tool_peer_db_fops);
+
+	debugfs_create_file("peer_db_mask", 0600, tc->dbgfs_dir,
+			    tc, &tool_peer_db_mask_fops);
+
+	if (tc->inspad_cnt != 0) {
+		for (sidx = 0; sidx < tc->inspad_cnt; sidx++) {
+			snprintf(buf, sizeof(buf), "spad%d", sidx);
+
+			debugfs_create_file(buf, 0600, tc->dbgfs_dir,
+					   &tc->inspads[sidx], &tool_spad_fops);
+		}
 	}
 
-	tool_setup_dbgfs(tc);
+	if (tc->inmsg_cnt != 0) {
+		for (midx = 0; midx < tc->inmsg_cnt; midx++) {
+			snprintf(buf, sizeof(buf), "msg%d", midx);
+			debugfs_create_file(buf, 0600, tc->dbgfs_dir,
+					   &tc->inmsgs[midx], &tool_inmsg_fops);
+		}
+
+		debugfs_create_file("msg_sts", 0600, tc->dbgfs_dir,
+				    tc, &tool_msg_sts_fops);
+
+		debugfs_create_file("msg_inbits", 0600, tc->dbgfs_dir,
+				    tc, &tool_msg_inbits_fops);
+
+		debugfs_create_file("msg_outbits", 0600, tc->dbgfs_dir,
+				    tc, &tool_msg_outbits_fops);
+
+		debugfs_create_file("msg_mask", 0600, tc->dbgfs_dir,
+				    tc, &tool_msg_mask_fops);
+
+		debugfs_create_file("msg_event", 0600, tc->dbgfs_dir,
+				    tc, &tool_msg_event_fops);
+	}
+
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++) {
+		snprintf(buf, sizeof(buf), "peer%d", pidx);
+		tc->peers[pidx].dbgfs_dir =
+			debugfs_create_dir(buf, tc->dbgfs_dir);
+
+		debugfs_create_file("port", 0600,
+				    tc->peers[pidx].dbgfs_dir,
+				    &tc->peers[pidx], &tool_peer_port_fops);
+
+		debugfs_create_file("link", 0200,
+				    tc->peers[pidx].dbgfs_dir,
+				    &tc->peers[pidx], &tool_peer_link_fops);
+
+		debugfs_create_file("link_event", 0200,
+				  tc->peers[pidx].dbgfs_dir,
+				  &tc->peers[pidx], &tool_peer_link_event_fops);
+
+		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++) {
+			snprintf(buf, sizeof(buf), "mw_trans%d", widx);
+			debugfs_create_file(buf, 0600,
+					    tc->peers[pidx].dbgfs_dir,
+					    &tc->peers[pidx].inmws[widx],
+					    &tool_mw_trans_fops);
+		}
+
+		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
+			snprintf(buf, sizeof(buf), "peer_mw_trans%d", widx);
+			debugfs_create_file(buf, 0600,
+					    tc->peers[pidx].dbgfs_dir,
+					    &tc->peers[pidx].outmws[widx],
+					    &tool_peer_mw_trans_fops);
+		}
+
+		for (sidx = 0; sidx < tc->peers[pidx].outspad_cnt; sidx++) {
+			snprintf(buf, sizeof(buf), "spad%d", sidx);
+
+			debugfs_create_file(buf, 0600,
+					    tc->peers[pidx].dbgfs_dir,
+					    &tc->peers[pidx].outspads[sidx],
+					    &tool_peer_spad_fops);
+		}
+
+		for (midx = 0; midx < tc->peers[pidx].outmsg_cnt; midx++) {
+			snprintf(buf, sizeof(buf), "msg%d", midx);
+			debugfs_create_file(buf, 0600,
+					    tc->peers[pidx].dbgfs_dir,
+					    &tc->peers[pidx].outmsgs[midx],
+					    &tool_outmsg_fops);
+		}
+	}
+}
+
+static void tool_clear_dbgfs(struct tool_ctx *tc)
+{
+	debugfs_remove_recursive(tc->dbgfs_dir);
+}
+
+static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
+{
+	struct tool_ctx *tc;
+	int ret;
 
-	rc = ntb_set_ctx(ntb, tc, &tool_ops);
-	if (rc)
-		goto err_ctx;
+	tc = tool_create_data(ntb);
+	if (IS_ERR(tc))
+		return PTR_ERR(tc);
 
-	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
-	ntb_link_event(ntb);
+	ret = tool_init_peers(tc);
+	if (ret != 0)
+		goto err_clear_data;
+
+	ret = tool_init_mws(tc);
+	if (ret != 0)
+		goto err_clear_data;
+
+	ret = tool_init_spads(tc);
+	if (ret != 0)
+		goto err_clear_mws;
+
+	ret = tool_init_msgs(tc);
+	if (ret != 0)
+		goto err_clear_mws;
+
+	ret = tool_init_ntb(tc);
+	if (ret != 0)
+		goto err_clear_mws;
+
+	tool_setup_dbgfs(tc);
 
 	return 0;
 
-err_ctx:
-	tool_free_mws(tc);
-	debugfs_remove_recursive(tc->dbgfs);
-	kfree(tc);
-err_tc:
-	return rc;
+err_clear_mws:
+	tool_clear_mws(tc);
+
+err_clear_data:
+	tool_clear_data(tc);
+
+	return ret;
 }
 
 static void tool_remove(struct ntb_client *self, struct ntb_dev *ntb)
 {
 	struct tool_ctx *tc = ntb->ctx;
 
-	tool_free_mws(tc);
+	tool_clear_dbgfs(tc);
+
+	tool_clear_ntb(tc);
 
-	ntb_clear_ctx(ntb);
-	ntb_link_disable(ntb);
+	tool_clear_mws(tc);
 
-	debugfs_remove_recursive(tc->dbgfs);
-	kfree(tc);
+	tool_clear_data(tc);
 }
 
 static struct ntb_client tool_client = {
 	.ops = {
 		.probe = tool_probe,
 		.remove = tool_remove,
-	},
+	}
 };
 
 static int __init tool_init(void)
 {
-	int rc;
+	int ret;
 
 	if (debugfs_initialized())
-		tool_dbgfs = debugfs_create_dir(KBUILD_MODNAME, NULL);
-
-	rc = ntb_register_client(&tool_client);
-	if (rc)
-		goto err_client;
+		tool_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return 0;
+	ret = ntb_register_client(&tool_client);
+	if (ret)
+		debugfs_remove_recursive(tool_dbgfs_topdir);
 
-err_client:
-	debugfs_remove_recursive(tool_dbgfs);
-	return rc;
+	return ret;
 }
 module_init(tool_init);
 
 static void __exit tool_exit(void)
 {
 	ntb_unregister_client(&tool_client);
-	debugfs_remove_recursive(tool_dbgfs);
+	debugfs_remove_recursive(tool_dbgfs_topdir);
 }
 module_exit(tool_exit);
+
-- 
2.12.0

