Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si1013749pfx.1.2016.06.10.15.55.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 15:55:28 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 10 Jun 2016 16:54:09 -0600
Message-Id: <e447cedb6197b62f141e7688ed2329c259f33eb9.1465598632.git.logang@deltatee.com>
In-Reply-To: <cover.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com>
In-Reply-To: <cover.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com>
Subject: [PATCH 6/8] ntb_tool: Add link status file to debugfs
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

In order to more successfully script with ntb_tool it's useful to
have a link file to check the link status so that the script
doesn't use the other files until the link is up.

This commit adds a 'link' file to the debugfs directory which reads
0 or 1 depending on the link status. For scripting convenience, writing
will block until the link is up (discarding anything that was written).

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_tool.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 954e1d5..116352e 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -59,6 +59,12 @@
  *
  * Eg: check if clearing the doorbell mask generates an interrupt.
  *
+ * # Check the link status
+ * root@self# cat $DBG_DIR/link
+ *
+ * # Block until the link is up
+ * root@self# echo > $DBG_DIR/link
+ *
  * # Set the doorbell mask
  * root@self# echo 's 1' > $DBG_DIR/mask
  *
@@ -127,6 +133,7 @@ struct tool_ctx {
 	struct work_struct link_cleanup;
 	bool link_is_up;
 	struct delayed_work link_work;
+	wait_queue_head_t link_wq;
 	int mw_count;
 	struct tool_mw mws[MAX_MWS];
 };
@@ -237,6 +244,7 @@ static void tool_link_work(struct work_struct *work)
 			"Error setting up memory windows: %d\n", rc);
 
 	tc->link_is_up = true;
+	wake_up(&tc->link_wq);
 }
 
 static void tool_link_cleanup(struct work_struct *work)
@@ -573,6 +581,39 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
 		      tool_peer_spad_read,
 		      tool_peer_spad_write);
 
+static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
+			      size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+	char *buf;
+	ssize_t pos, rc;
+
+	buf = kmalloc(64, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos = scnprintf(buf, 64, "%d\n", tc->link_is_up);
+	rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+
+	kfree(buf);
+
+	return rc;
+}
+
+static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
+			       size_t size, loff_t *offp)
+{
+	struct tool_ctx *tc = filep->private_data;
+
+	if (wait_event_interruptible(tc->link_wq, tc->link_is_up))
+		return -ERESTART;
+
+	return size;
+}
+
+static TOOL_FOPS_RDWR(tool_link_fops,
+		      tool_link_read,
+		      tool_link_write);
 
 static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
 			    size_t size, loff_t *offp)
@@ -708,6 +749,9 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
 	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
 			    tc, &tool_peer_spad_fops);
 
+	debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
+			    tc, &tool_link_fops);
+
 	mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
 	for (i = 0; i < mw_count; i++) {
 		char buf[30];
@@ -741,6 +785,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	}
 
 	tc->ntb = ntb;
+	init_waitqueue_head(&tc->link_wq);
 	INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
 	INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
 
-- 
2.1.4

