Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si3246033pfx.1.2016.06.14.10.02.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 10:02:38 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jun 2016 11:02:27 -0600
Message-Id: <1442774814a0ca9e68c08ae5061d47d8fd45753c.1465919683.git.logang@deltatee.com>
In-Reply-To: <cover.1465919682.git.logang@deltatee.com>
References: <cover.1465919682.git.logang@deltatee.com>
In-Reply-To: <cover.1465919682.git.logang@deltatee.com>
References: <cover.1465919682.git.logang@deltatee.com>
Subject: [PATCH v2 7/8] ntb_pingpong: Add a debugfs file to get the ping count
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

This commit adds a debugfs 'count' file to ntb_pingpong. This is so
testing with ntb_pingpong can be automated beyond just checking the
logs for pong messages.

The count file returns a number which increments every pong. The
counter can be cleared by writing a zero.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_pingpong.c | 62 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index fe16005..7d31179 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -61,6 +61,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/debugfs.h>
 
 #include <linux/ntb.h>
 
@@ -96,8 +97,13 @@ struct pp_ctx {
 	spinlock_t			db_lock;
 	struct timer_list		db_timer;
 	unsigned long			db_delay;
+	struct dentry			*debugfs_node_dir;
+	struct dentry			*debugfs_count;
+	atomic_t			count;
 };
 
+static struct dentry *pp_debugfs_dir;
+
 static void pp_ping(unsigned long ctx)
 {
 	struct pp_ctx *pp = (void *)ctx;
@@ -171,10 +177,32 @@ static void pp_db_event(void *ctx, int vec)
 		dev_dbg(&pp->ntb->dev,
 			"Pong vec %d bits %#llx\n",
 			vec, db_bits);
+		atomic_inc(&pp->count);
 	}
 	spin_unlock_irqrestore(&pp->db_lock, irqflags);
 }
 
+static int pp_debugfs_setup(struct pp_ctx *pp)
+{
+	struct pci_dev *pdev = pp->ntb->pdev;
+
+	if (!pp_debugfs_dir)
+		return -ENODEV;
+
+	pp->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
+						  pp_debugfs_dir);
+	if (!pp->debugfs_node_dir)
+		return -ENODEV;
+
+	pp->debugfs_count = debugfs_create_atomic_t("count", S_IRUSR | S_IWUSR,
+						    pp->debugfs_node_dir,
+						    &pp->count);
+	if (!pp->debugfs_count)
+		return -ENODEV;
+
+	return 0;
+}
+
 static const struct ntb_ctx_ops pp_ops = {
 	.link_event = pp_link_event,
 	.db_event = pp_db_event,
@@ -210,6 +238,7 @@ static int pp_probe(struct ntb_client *client,
 
 	pp->ntb = ntb;
 	pp->db_bits = 0;
+	atomic_set(&pp->count, 0);
 	spin_lock_init(&pp->db_lock);
 	setup_timer(&pp->db_timer, pp_ping, (unsigned long)pp);
 	pp->db_delay = msecs_to_jiffies(delay_ms);
@@ -218,6 +247,10 @@ static int pp_probe(struct ntb_client *client,
 	if (rc)
 		goto err_ctx;
 
+	rc = pp_debugfs_setup(pp);
+	if (rc)
+		goto err_ctx;
+
 	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 	ntb_link_event(ntb);
 
@@ -234,6 +267,8 @@ static void pp_remove(struct ntb_client *client,
 {
 	struct pp_ctx *pp = ntb->ctx;
 
+	debugfs_remove_recursive(pp->debugfs_node_dir);
+
 	ntb_clear_ctx(ntb);
 	del_timer_sync(&pp->db_timer);
 	ntb_link_disable(ntb);
@@ -247,4 +282,29 @@ static struct ntb_client pp_client = {
 		.remove = pp_remove,
 	},
 };
-module_ntb_client(pp_client);
+
+static int __init pp_init(void)
+{
+	int rc;
+
+	if (debugfs_initialized())
+		pp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	rc = ntb_register_client(&pp_client);
+	if (rc)
+		goto err_client;
+
+	return 0;
+
+err_client:
+	debugfs_remove_recursive(pp_debugfs_dir);
+	return rc;
+}
+module_init(pp_init);
+
+static void __exit pp_exit(void)
+{
+	ntb_unregister_client(&pp_client);
+	debugfs_remove_recursive(pp_debugfs_dir);
+}
+module_exit(pp_exit);
-- 
2.1.4

