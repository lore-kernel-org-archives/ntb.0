Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com. [2a00:1450:4010:c07::236])
        by gmr-mx.google.com with ESMTPS id i88si340198lfh.4.2017.12.06.06.32.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:19 -0800 (PST)
Received: by mail-lf0-x236.google.com with SMTP id f18so4452354lfg.8
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:19 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 04/15] NTB: ntb_pp: Add full multi-port NTB API support
Date: Wed,  6 Dec 2017 17:31:55 +0300
Message-Id: <20171206143206.14665-5-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Current Ping Pong driver can't truly work with multi-port devices.
Additionally it requires the Scratchpad registers being available
on NTB device. This patches rewrites the driver so one would
perform the cyclic Ping-Pong algorithm around all the available
NTB peers and makes it working with NTB hardware, which doesn't
support Scratchpads, but such alternative as NTB Message register.
Additional cleanups are also added here.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
Changelog v1:
- Add Multi-port API support
- Use NTB Message registers if available
- Ping-pong now works like cyclic ping around all the peers

Changelog v2:
- Remove driver Author/Description/Version macros

Changelog v3:
- Remove contacts from the driver header
- Discard spin_lock/unlocks around debug prints
- Print error if neither Msg and Spads available

 drivers/ntb/test/ntb_pingpong.c | 447 +++++++++++++++++++++++++---------------
 1 file changed, 282 insertions(+), 165 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index e700873e03fb..65865e460ab8 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -1,10 +1,11 @@
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
+ *   This file is provided under a dual BSD/GPLv2 license.  When using or
  *   redistributing this file, you may do so under either license.
  *
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2017 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -18,6 +19,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2017 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -46,36 +48,45 @@
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  * PCIe NTB Pingpong Linux driver
- *
- * Contact Information:
- * Allen Hubbe <Allen.Hubbe@emc.com>
  */
 
-/* Note: load this module with option 'dyndbg=+p' */
+/*
+ * How to use this tool, by example.
+ *
+ * Assuming $DBG_DIR is something like:
+ * '/sys/kernel/debug/ntb_perf/0000:00:03.0'
+ * Suppose aside from local device there is at least one remote device
+ * connected to NTB with index 0.
+ *-----------------------------------------------------------------------------
+ * Eg: install driver with specified delay between doorbell event and response
+ *
+ * root@self# insmod ntb_pingpong.ko delay_ms=1000
+ *-----------------------------------------------------------------------------
+ * Eg: get number of ping-pong cycles performed
+ *
+ * root@self# cat $DBG_DIR/count
+ */
 
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
 
-#include <linux/dma-mapping.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
+#include <linux/hrtimer.h>
 #include <linux/debugfs.h>
 
 #include <linux/ntb.h>
 
-#define DRIVER_NAME			"ntb_pingpong"
-#define DRIVER_DESCRIPTION		"PCIe NTB Simple Pingpong Client"
-
-#define DRIVER_VERSION			"1.0"
-#define DRIVER_RELDATE			"24 March 2015"
-#define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
+#define DRIVER_NAME		"ntb_pingpong"
+#define DRIVER_VERSION		"2.0"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_AUTHOR("Allen Hubbe <Allen.Hubbe@emc.com>");
+MODULE_DESCRIPTION("PCIe NTB Simple Pingpong Client");
 
 static unsigned int unsafe;
 module_param(unsafe, uint, 0644);
@@ -85,237 +96,343 @@ static unsigned int delay_ms = 1000;
 module_param(delay_ms, uint, 0644);
 MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to peer");
 
-static unsigned long db_init = 0x7;
-module_param(db_init, ulong, 0644);
-MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
-
-/* Only two-ports NTB devices are supported */
-#define PIDX		NTB_DEF_PEER_IDX
-
 struct pp_ctx {
-	struct ntb_dev			*ntb;
-	u64				db_bits;
-	/* synchronize access to db_bits by ping and pong */
-	spinlock_t			db_lock;
-	struct timer_list		db_timer;
-	unsigned long			db_delay;
-	struct dentry			*debugfs_node_dir;
-	struct dentry			*debugfs_count;
-	atomic_t			count;
+	struct ntb_dev *ntb;
+	struct hrtimer timer;
+	u64 in_db;
+	u64 out_db;
+	int out_pidx;
+	u64 nmask;
+	u64 pmask;
+	atomic_t count;
+	spinlock_t lock;
+	struct dentry *dbgfs_dir;
 };
+#define to_pp_timer(__timer) \
+	container_of(__timer, struct pp_ctx, timer)
 
-static struct dentry *pp_debugfs_dir;
+static struct dentry *pp_dbgfs_topdir;
 
-static void pp_ping(struct timer_list *t)
+static int pp_find_next_peer(struct pp_ctx *pp)
 {
-	struct pp_ctx *pp = from_timer(pp, t, db_timer);
-	unsigned long irqflags;
-	u64 db_bits, db_mask;
-	u32 spad_rd, spad_wr;
+	u64 link, out_db;
+	int pidx;
+
+	link = ntb_link_is_up(pp->ntb, NULL, NULL);
+
+	/* Find next available peer */
+	if (link & pp->nmask) {
+		pidx = __ffs64(link & pp->nmask);
+		out_db = BIT_ULL(pidx + 1);
+	} else if (link & pp->pmask) {
+		pidx = __ffs64(link & pp->pmask);
+		out_db = BIT_ULL(pidx);
+	} else {
+		return -ENODEV;
+	}
 
-	spin_lock_irqsave(&pp->db_lock, irqflags);
-	{
-		db_mask = ntb_db_valid_mask(pp->ntb);
-		db_bits = ntb_db_read(pp->ntb);
+	spin_lock(&pp->lock);
+	pp->out_pidx = pidx;
+	pp->out_db = out_db;
+	spin_unlock(&pp->lock);
 
-		if (db_bits) {
-			dev_dbg(&pp->ntb->dev,
-				"Masked pongs %#llx\n",
-				db_bits);
-			ntb_db_clear(pp->ntb, db_bits);
-		}
+	return 0;
+}
 
-		db_bits = ((pp->db_bits | db_bits) << 1) & db_mask;
+static void pp_setup(struct pp_ctx *pp)
+{
+	int ret;
 
-		if (!db_bits)
-			db_bits = db_init;
+	ntb_db_set_mask(pp->ntb, pp->in_db);
 
-		spad_rd = ntb_spad_read(pp->ntb, 0);
-		spad_wr = spad_rd + 1;
+	hrtimer_cancel(&pp->timer);
 
-		dev_dbg(&pp->ntb->dev,
-			"Ping bits %#llx read %#x write %#x\n",
-			db_bits, spad_rd, spad_wr);
+	ret = pp_find_next_peer(pp);
+	if (ret == -ENODEV) {
+		dev_dbg(&pp->ntb->dev, "Got no peers, so cancel\n");
+		return;
+	}
 
-		ntb_peer_spad_write(pp->ntb, PIDX, 0, spad_wr);
-		ntb_peer_db_set(pp->ntb, db_bits);
-		ntb_db_clear_mask(pp->ntb, db_mask);
+	dev_dbg(&pp->ntb->dev, "Ping-pong started with port %d, db %#llx\n",
+		ntb_peer_port_number(pp->ntb, pp->out_pidx), pp->out_db);
 
-		pp->db_bits = 0;
-	}
-	spin_unlock_irqrestore(&pp->db_lock, irqflags);
+	hrtimer_start(&pp->timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
 }
 
-static void pp_link_event(void *ctx)
+static void pp_clear(struct pp_ctx *pp)
 {
-	struct pp_ctx *pp = ctx;
+	hrtimer_cancel(&pp->timer);
 
-	if (ntb_link_is_up(pp->ntb, NULL, NULL) == 1) {
-		dev_dbg(&pp->ntb->dev, "link is up\n");
-		pp_ping(&pp->db_timer);
-	} else {
-		dev_dbg(&pp->ntb->dev, "link is down\n");
-		del_timer(&pp->db_timer);
-	}
+	ntb_db_set_mask(pp->ntb, pp->in_db);
+
+	dev_dbg(&pp->ntb->dev, "Ping-pong cancelled\n");
 }
 
-static void pp_db_event(void *ctx, int vec)
+static void pp_ping(struct pp_ctx *pp)
 {
-	struct pp_ctx *pp = ctx;
-	u64 db_bits, db_mask;
-	unsigned long irqflags;
+	u32 count;
 
-	spin_lock_irqsave(&pp->db_lock, irqflags);
-	{
-		db_mask = ntb_db_vector_mask(pp->ntb, vec);
-		db_bits = db_mask & ntb_db_read(pp->ntb);
-		ntb_db_set_mask(pp->ntb, db_mask);
-		ntb_db_clear(pp->ntb, db_bits);
+	count = atomic_read(&pp->count);
 
-		pp->db_bits |= db_bits;
+	spin_lock(&pp->lock);
+	ntb_peer_spad_write(pp->ntb, pp->out_pidx, 0, count);
+	ntb_peer_msg_write(pp->ntb, pp->out_pidx, 0, count);
 
-		mod_timer(&pp->db_timer, jiffies + pp->db_delay);
+	dev_dbg(&pp->ntb->dev, "Ping port %d spad %#x, msg %#x\n",
+		ntb_peer_port_number(pp->ntb, pp->out_pidx), count, count);
 
-		dev_dbg(&pp->ntb->dev,
-			"Pong vec %d bits %#llx\n",
-			vec, db_bits);
-		atomic_inc(&pp->count);
-	}
-	spin_unlock_irqrestore(&pp->db_lock, irqflags);
+	ntb_peer_db_set(pp->ntb, pp->out_db);
+	ntb_db_clear_mask(pp->ntb, pp->in_db);
+	spin_unlock(&pp->lock);
 }
 
-static int pp_debugfs_setup(struct pp_ctx *pp)
+static void pp_pong(struct pp_ctx *pp)
 {
-	struct pci_dev *pdev = pp->ntb->pdev;
+	u32 msg_data = -1, spad_data = -1;
+	int pidx = 0;
 
-	if (!pp_debugfs_dir)
-		return -ENODEV;
+	/* Read pong data */
+	spad_data = ntb_spad_read(pp->ntb, 0);
+	msg_data = ntb_msg_read(pp->ntb, &pidx, 0);
+	ntb_msg_clear_sts(pp->ntb, -1);
 
-	pp->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
-						  pp_debugfs_dir);
-	if (!pp->debugfs_node_dir)
-		return -ENODEV;
+	/*
+	 * Scratchpad and message data may differ, since message register can't
+	 * be rewritten unless status is cleared. Additionally either of them
+	 * might be unsupported
+	 */
+	dev_dbg(&pp->ntb->dev, "Pong spad %#x, msg %#x (port %d)\n",
+		spad_data, msg_data, ntb_peer_port_number(pp->ntb, pidx));
 
-	pp->debugfs_count = debugfs_create_atomic_t("count", S_IRUSR | S_IWUSR,
-						    pp->debugfs_node_dir,
-						    &pp->count);
-	if (!pp->debugfs_count)
-		return -ENODEV;
+	atomic_inc(&pp->count);
 
-	return 0;
+	ntb_db_set_mask(pp->ntb, pp->in_db);
+	ntb_db_clear(pp->ntb, pp->in_db);
+
+	hrtimer_start(&pp->timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
+}
+
+static enum hrtimer_restart pp_timer_func(struct hrtimer *t)
+{
+	struct pp_ctx *pp = to_pp_timer(t);
+
+	pp_ping(pp);
+
+	return HRTIMER_NORESTART;
+}
+
+static void pp_link_event(void *ctx)
+{
+	struct pp_ctx *pp = ctx;
+
+	pp_setup(pp);
+}
+
+static void pp_db_event(void *ctx, int vec)
+{
+	struct pp_ctx *pp = ctx;
+
+	pp_pong(pp);
 }
 
 static const struct ntb_ctx_ops pp_ops = {
 	.link_event = pp_link_event,
-	.db_event = pp_db_event,
+	.db_event = pp_db_event
 };
 
-static int pp_probe(struct ntb_client *client,
-		    struct ntb_dev *ntb)
+static int pp_check_ntb(struct ntb_dev *ntb)
 {
-	struct pp_ctx *pp;
-	int rc;
+	u64 pmask;
 
 	if (ntb_db_is_unsafe(ntb)) {
-		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
-		if (!unsafe) {
-			rc = -EINVAL;
-			goto err_pp;
-		}
-	}
-
-	if (ntb_spad_count(ntb) < 1) {
-		dev_dbg(&ntb->dev, "no enough scratchpads\n");
-		rc = -EINVAL;
-		goto err_pp;
+		dev_dbg(&ntb->dev, "Doorbell is unsafe\n");
+		if (!unsafe)
+			return -EINVAL;
 	}
 
 	if (ntb_spad_is_unsafe(ntb)) {
-		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
-		if (!unsafe) {
-			rc = -EINVAL;
-			goto err_pp;
-		}
+		dev_dbg(&ntb->dev, "Scratchpad is unsafe\n");
+		if (!unsafe)
+			return -EINVAL;
 	}
 
-	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
-		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
+	pmask = GENMASK_ULL(ntb_peer_port_count(ntb), 0);
+	if ((ntb_db_valid_mask(ntb) & pmask) != pmask) {
+		dev_err(&ntb->dev, "Unsupported DB configuration\n");
+		return -EINVAL;
+	}
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_pp;
+	if (ntb_spad_count(ntb) < 1 && ntb_msg_count(ntb) < 1) {
+		dev_err(&ntb->dev, "Scratchpads and messages unsupported\n");
+		return -EINVAL;
+	} else if (ntb_spad_count(ntb) < 1) {
+		dev_dbg(&ntb->dev, "Scratchpads unsupported\n");
+	} else if (ntb_msg_count(ntb) < 1) {
+		dev_dbg(&ntb->dev, "Messages unsupported\n");
 	}
 
+	return 0;
+}
+
+static struct pp_ctx *pp_create_data(struct ntb_dev *ntb)
+{
+	struct pp_ctx *pp;
+
+	pp = devm_kzalloc(&ntb->dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return ERR_PTR(-ENOMEM);
+
 	pp->ntb = ntb;
-	pp->db_bits = 0;
 	atomic_set(&pp->count, 0);
-	spin_lock_init(&pp->db_lock);
-	timer_setup(&pp->db_timer, pp_ping, 0);
-	pp->db_delay = msecs_to_jiffies(delay_ms);
+	spin_lock_init(&pp->lock);
+	hrtimer_init(&pp->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	pp->timer.function = pp_timer_func;
+
+	return pp;
+}
+
+static void pp_init_flds(struct pp_ctx *pp)
+{
+	int pidx, lport, pcnt;
+
+	/* Find global port index */
+	lport = ntb_port_number(pp->ntb);
+	pcnt = ntb_peer_port_count(pp->ntb);
+	for (pidx = 0; pidx < pcnt; pidx++) {
+		if (lport < ntb_peer_port_number(pp->ntb, pidx))
+			break;
+	}
 
-	rc = ntb_set_ctx(ntb, pp, &pp_ops);
-	if (rc)
-		goto err_ctx;
+	pp->in_db = BIT_ULL(pidx);
+	pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
+	pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
 
-	rc = pp_debugfs_setup(pp);
-	if (rc)
-		goto err_ctx;
+	dev_dbg(&pp->ntb->dev, "Inbound db %#llx, prev %#llx, next %#llx\n",
+		pp->in_db, pp->pmask, pp->nmask);
+}
+
+static int pp_mask_events(struct pp_ctx *pp)
+{
+	u64 db_mask, msg_mask;
+	int ret;
+
+	db_mask = ntb_db_valid_mask(pp->ntb);
+	ret = ntb_db_set_mask(pp->ntb, db_mask);
+	if (ret)
+		return ret;
 
-	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
-	ntb_link_event(ntb);
+	/* Skip message events masking if unsupported */
+	if (ntb_msg_count(pp->ntb) < 1)
+		return 0;
+
+	msg_mask = ntb_msg_outbits(pp->ntb) | ntb_msg_inbits(pp->ntb);
+	return ntb_msg_set_mask(pp->ntb, msg_mask);
+}
+
+static int pp_setup_ctx(struct pp_ctx *pp)
+{
+	int ret;
+
+	ret = ntb_set_ctx(pp->ntb, pp, &pp_ops);
+	if (ret)
+		return ret;
+
+	ntb_link_enable(pp->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	/* Might be not necessary */
+	ntb_link_event(pp->ntb);
 
 	return 0;
+}
+
+static void pp_clear_ctx(struct pp_ctx *pp)
+{
+	ntb_link_disable(pp->ntb);
 
-err_ctx:
-	kfree(pp);
-err_pp:
-	return rc;
+	ntb_clear_ctx(pp->ntb);
 }
 
-static void pp_remove(struct ntb_client *client,
-		      struct ntb_dev *ntb)
+static void pp_setup_dbgfs(struct pp_ctx *pp)
+{
+	struct pci_dev *pdev = pp->ntb->pdev;
+	void *ret;
+
+	pp->dbgfs_dir = debugfs_create_dir(pci_name(pdev), pp_dbgfs_topdir);
+
+	ret = debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &pp->count);
+	if (!ret)
+		dev_warn(&pp->ntb->dev, "DebugFS unsupported\n");
+}
+
+static void pp_clear_dbgfs(struct pp_ctx *pp)
+{
+	debugfs_remove_recursive(pp->dbgfs_dir);
+}
+
+static int pp_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct pp_ctx *pp;
+	int ret;
+
+	ret = pp_check_ntb(ntb);
+	if (ret)
+		return ret;
+
+	pp = pp_create_data(ntb);
+	if (IS_ERR(pp))
+		return PTR_ERR(pp);
+
+	pp_init_flds(pp);
+
+	ret = pp_mask_events(pp);
+	if (ret)
+		return ret;
+
+	ret = pp_setup_ctx(pp);
+	if (ret)
+		return ret;
+
+	pp_setup_dbgfs(pp);
+
+	return 0;
+}
+
+static void pp_remove(struct ntb_client *client, struct ntb_dev *ntb)
 {
 	struct pp_ctx *pp = ntb->ctx;
 
-	debugfs_remove_recursive(pp->debugfs_node_dir);
+	pp_clear_dbgfs(pp);
 
-	ntb_clear_ctx(ntb);
-	del_timer_sync(&pp->db_timer);
-	ntb_link_disable(ntb);
+	pp_clear_ctx(pp);
 
-	kfree(pp);
+	pp_clear(pp);
 }
 
 static struct ntb_client pp_client = {
 	.ops = {
 		.probe = pp_probe,
-		.remove = pp_remove,
-	},
+		.remove = pp_remove
+	}
 };
 
 static int __init pp_init(void)
 {
-	int rc;
+	int ret;
 
 	if (debugfs_initialized())
-		pp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+		pp_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	rc = ntb_register_client(&pp_client);
-	if (rc)
-		goto err_client;
+	ret = ntb_register_client(&pp_client);
+	if (ret)
+		debugfs_remove_recursive(pp_dbgfs_topdir);
 
-	return 0;
-
-err_client:
-	debugfs_remove_recursive(pp_debugfs_dir);
-	return rc;
+	return ret;
 }
 module_init(pp_init);
 
 static void __exit pp_exit(void)
 {
 	ntb_unregister_client(&pp_client);
-	debugfs_remove_recursive(pp_debugfs_dir);
+	debugfs_remove_recursive(pp_dbgfs_topdir);
 }
 module_exit(pp_exit);
+
-- 
2.12.0

