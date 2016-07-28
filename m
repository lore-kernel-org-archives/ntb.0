Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id r197si1812549wmf.2.2016.07.28.03.02.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 03:02:27 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id l89so3410835lfi.2
        for <linux-ntb@googlegroups.com>; Thu, 28 Jul 2016 03:02:27 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 3/3] ntb: Test client drivers for asynchronous NTB devices
Date: Thu, 28 Jul 2016 13:01:19 +0300
Message-Id: <1469700079-28377-4-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1469700079-28377-1-git-send-email-fancer.lancer@gmail.com>
References: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
 <1469700079-28377-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

There are three drivers to independently test all interfaces implemented by
the IDT 89HPES*NT* NTB driver.

Doorbells are tested by new NTB Doorbell Pingpong client driver. It implements
the so-named algorithm. Driver starts working from setting the peer doorbell of
the last locally set doorbell bit. If there has not been locally set doorbell,
it sets the very first bit. After that the driver unmasks the events of the
just set doorbell bit and waits until the peer sets the same doorbell. When
peer does it, the local driver iterates to the next doorbell bit and starts
delayed work thread, which will set the corresponding bit and perform doorbell
bit umasking on waking up.

Messaging subsystem can be tested by the client driver implementing a simple
transmition/reception algorithm. A message can be send to a peer by writing
data to /sys/kernel/debug/ntb_msg_test/ntbA{N}/data file. The peer can read
it from the same file then.

Memory Windows test driver implements a simple write/read algorithm. The driver
allocates the predefined number of local buffers (inbound memory window -
inwndw{N}). In order to get a translated base address driver sends a
corresponding command to a peer. Then driver initialize the outbound memory
windows (outwndw{N}). The read/write operations can be performed using the
following debug nodes:
/sys/kernel/debug/ntb_mw_test/ntbA{N}/inwndw{N}
/sys/kernel/debug/ntb_mw_test/ntbA{N}/outwndw{N}

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/test/Kconfig        |   32 +
 drivers/ntb/test/Makefile       |    9 +-
 drivers/ntb/test/ntb_db_test.c  |  677 +++++++++++++++++
 drivers/ntb/test/ntb_msg_test.c |  736 +++++++++++++++++++
 drivers/ntb/test/ntb_mw_test.c  | 1539 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 2991 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ntb/test/ntb_db_test.c
 create mode 100644 drivers/ntb/test/ntb_msg_test.c
 create mode 100644 drivers/ntb/test/ntb_mw_test.c

diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
index a5d0eda..80f5058 100644
--- a/drivers/ntb/test/Kconfig
+++ b/drivers/ntb/test/Kconfig
@@ -25,3 +25,35 @@ config NTB_PERF
 	 to and from the window without additional software interaction.
 
 	 If unsure, say N.
+
+config NTB_DB_TEST
+	tristate "NTB Doorbell Test Client"
+	help
+	 This is a driver to test doorbell subsystem of NTB bus devices.
+	 The design is similar to the ping pong although it exchanges the
+	 doorbell bits one-by-one, waiting for the peer response before getting
+	 to a next doorbell.
+
+	 If unsure, say N.
+
+config NTB_MSG_TEST
+	tristate "NTB Messaging Test Client"
+	help
+	 This is a driver to test messaging subsystem of NTB. It just creates
+	 one file in the DebugFS for each NTB device of asynchronous
+	 architecture. In order to send a message one can just write a text to
+	 the file. It will be immediately sent to the peer so user can get it
+	 by reading from the corresponding file.
+
+	 If unsure, say N.
+
+config NTB_MW_TEST
+	tristate "NTB Memory Windows Test Client"
+	help
+	 This is a driver to test memory sharing amongst devices. It creates a
+	 set of files in the DebugFS, one of which are used to write a text to
+	 outbound memory windows and anothers can be used to read data written
+	 by the peer to our inbound memory window.
+
+	 If unsure, say N.
+
diff --git a/drivers/ntb/test/Makefile b/drivers/ntb/test/Makefile
index 9e77e0b..6ea6db4 100644
--- a/drivers/ntb/test/Makefile
+++ b/drivers/ntb/test/Makefile
@@ -1,3 +1,8 @@
+# Synchronous hardware clients (Intel/AMD)
 obj-$(CONFIG_NTB_PINGPONG) += ntb_pingpong.o
-obj-$(CONFIG_NTB_TOOL) += ntb_tool.o
-obj-$(CONFIG_NTB_PERF) += ntb_perf.o
+obj-$(CONFIG_NTB_TOOL)     += ntb_tool.o
+obj-$(CONFIG_NTB_PERF)     += ntb_perf.o
+# Asynchronous hardware clients (IDT)
+obj-$(CONFIG_NTB_DB_TEST)  += ntb_db_test.o
+obj-$(CONFIG_NTB_MSG_TEST) += ntb_msg_test.o
+obj-$(CONFIG_NTB_MW_TEST)  += ntb_mw_test.o
diff --git a/drivers/ntb/test/ntb_db_test.c b/drivers/ntb/test/ntb_db_test.c
new file mode 100644
index 0000000..e93c0c6
--- /dev/null
+++ b/drivers/ntb/test/ntb_db_test.c
@@ -0,0 +1,677 @@
+/*
+ *   This file is provided under a GPLv2 license.  When using or
+ *   redistributing this file, you may do so under that license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms and conditions of the GNU General Public License,
+ *   version 2, as published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful, but WITHOUT
+ *   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ *   more details.
+ *
+ *   You should have received a copy of the GNU General Public License along with
+ *   this program; if not, one can be found <http://www.gnu.org/licenses/>.
+ *
+ *   The full GNU General Public License is included in this distribution in
+ *   the file called "COPYING".
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * PCIe NTB doorbells test Linux driver
+ *
+ * Contact Information:
+ * Serge Semin <fancer.lancer@gmail.com>, <Sergey.Semin@t-platforms.ru>
+ */
+
+/*
+ *       NOTE of the NTB doorbells pingpong driver design.
+ * The driver is designed to implement the pingpong algorithm. After a quick
+ * initailization the driver starts from setting the peer doorbell of the last
+ * locally set doorbell bit. If there is not any doorbell locally set, then it
+ * sets the very first bit. After that the driver unmasks the events of the
+ * just set bits and waits until the peer is set the same doorbell. When it's
+ * done, the driver iterates to the next doorbell and starts delayed work
+ * thread, which will set the corresponding bit and perform doorbell umasking
+ * on waking up.
+ */
+
+/* Note: You can load this module with either option 'dyndbg=+p' or define the
+ * next preprocessor constant */
+/*#define DEBUG*/
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+
+#include <linux/ntb.h>
+
+#define DRIVER_NAME		"ntb_db_test"
+#define DRIVER_DESCRIPTION	"PCIe NTB Doorbells Pingpong Client"
+#define DRIVER_VERSION		"1.0"
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("T-platforms");
+
+static unsigned int delay_ms = 1000;
+module_param(delay_ms, uint, 0644);
+MODULE_PARM_DESC(delay_ms,
+	"Milliseconds to delay before setting a next doorbell bit");
+
+/*
+ * DebugFS directory to place the driver debug file
+ */
+static struct dentry *dbgfs_dir;
+
+/*
+ * Enumeration of the driver states
+ * @PP_WAIT:	Driver waits until the peer sets the corresponding doorbell bit
+ * @PP_SLEEP:	Driver sleeps before to set the next doorbell bit
+ */
+enum db_pp_state {
+	PP_WAIT = 0,
+	PP_SLEEP = 1
+};
+
+/*
+ * Doorbells pingpong driver context
+ * @ntb:	Pointer to the NTB device
+ * @cycle:	Doorbells setting cycle made up until now
+ * @valid_ids:	Valid Doorbel bits
+ * @delay:	Delay between setting the next doorbell bit
+ * @state:	Current cycle state
+ * @dwork:	Kernel thread used to perform the delayed doorbell bit set
+ * @dbgfs_info:	Handler of the DebugFS driver info-file
+ */
+struct pp_ctx {
+	struct ntb_dev *ntb;
+	unsigned long long cycle;
+	u64 valid_ids;
+	unsigned long delay;
+	enum db_pp_state state;
+	struct delayed_work dwork;
+	struct dentry *dbgfs_info;
+};
+#define to_ctx_dwork(work) \
+	container_of(to_delayed_work(work), struct pp_ctx, dwork)
+
+/*
+ * Wrapper dev_err/dev_warn/dev_info/dev_dbg macros
+ */
+#define dev_err_pp(ctx, args...) \
+	dev_err(&ctx->ntb->dev, ## args)
+#define dev_warn_pp(ctx, args...) \
+	dev_warn(&ctx->ntb->dev, ## args)
+#define dev_info_pp(ctx, args...) \
+	dev_info(&ctx->ntb->dev, ## args)
+#define dev_dbg_pp(ctx, args...) \
+	dev_dbg(&ctx->ntb->dev, ## args)
+
+/*
+ * Some common constant used in the driver for better readability:
+ * @ON: Enable something
+ * @OFF: Disable something
+ * @SUCCESS: Success of a function execution
+ */
+#define ON ((u32)0x1)
+#define OFF ((u32)0x0)
+#define SUCCESS 0
+
+/*===========================================================================
+ *                           Helper functions
+ *===========================================================================*/
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+#ifndef GENMASK_ULL
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+#endif /* !GENMASK_ULL */
+
+/*
+ * Set the corresponding bit in the 64-bits wide word
+ */
+#ifndef BIT_ULL
+#define BIT_ULL(nr) (1ULL << (nr))
+#endif /* !BIT_ULL */
+
+/*
+ * Method to find a first set bit in 64-bits wide word. The bits numbering is
+ * from 0 to 63. If there is no any set bit, then 64 is returned.
+ */
+static inline unsigned long find_first_bit64(u64 var)
+{
+	return (0x0ULL == var) ? BITS_PER_LONG_LONG : __ffs64(var);
+}
+
+/*
+ * Method to find a next set bit in 64-bits wide word starting from the
+ * specified position. The bits numbering is from 0 to 63. If there is no any
+ * set bit within the position and the last bit of the word, then 64 is
+ * returned.
+ */
+static inline unsigned long find_next_bit64(u64 var, unsigned long pos)
+{
+	/* Consider only the valuable positions */
+	var &= GENMASK_ULL(BITS_PER_LONG_LONG - 1, pos);
+
+	return find_first_bit64(var);
+}
+
+/*===========================================================================
+ *                Pingpong algorithm functions definition
+ *===========================================================================*/
+
+/*
+ * Iterate Doorbell PingPong algorithm work thread
+ * This function clears the currently set doorbell bit, which has been
+ * unmasked before, and masks it back. Then method sets the next doorbell
+ * bit and locally unmasks it.
+ */
+static void pp_iterate_cycle(struct work_struct *work)
+{
+	struct pp_ctx *ctx = to_ctx_dwork(work);
+	struct ntb_dev *ntb = ctx->ntb;
+	u64 db_umsk, db_sts;
+	unsigned long db_id;
+	int ret;
+
+	/* Read the mask of the current disposition */
+	db_umsk = ~ntb_db_read_mask(ntb) & ctx->valid_ids;
+	if (1 != hweight64(db_umsk)) {
+		dev_err_pp(ctx,
+			"Got invalid doorbells mask %#018llx", db_umsk);
+		return;
+	}
+
+	/* Read the currently set doorbells */
+	db_sts = ntb_db_read(ntb);
+	if (0x0 == (db_sts & db_umsk)) {
+		dev_err_pp(ctx, "Got driver bug %#018llx & %#018llx == 0",
+			db_sts, db_umsk);
+		return;
+	}
+
+	/* Find the doorbell id (use db_umsk since db_sts can have several
+	 * bits set) */
+	db_id = find_first_bit64(db_umsk);
+
+	dev_dbg_pp(ctx, "PingPong the doorbell bit %lu of cycle %llu",
+		db_id, ctx->cycle);
+
+	/* Mask the currently unmasked doorbell */
+	ret = ntb_db_set_mask(ntb, db_umsk);
+	if (SUCCESS != ret) {
+		dev_err_pp(ctx, "Failed to mask db %lu by %#018llx",
+			db_id, db_umsk);
+		return;
+	}
+
+	/* Clear the currently set doorbell */
+	ret = ntb_db_clear(ntb, db_umsk);
+	if (SUCCESS != ret) {
+		dev_err_pp(ctx,
+			"Failed to clear the db bit %lu", db_id);
+		return;
+	}
+
+	/* Iterate the doorbell id to set the next doorbell bit */
+	db_id = find_next_bit64(ctx->valid_ids, db_id + 1);
+	if (BITS_PER_LONG_LONG == db_id) {
+		db_id = find_first_bit64(ctx->valid_ids);
+		ctx->cycle++;
+	}
+
+	/* Calculate the new unmasking field */
+	db_umsk = BIT_ULL(db_id);
+
+	/* Set the new peer doorbell bit */
+	ret = ntb_peer_db_set(ntb, db_umsk);
+	if (SUCCESS != ret) {
+		dev_err_pp(ctx,
+			"Failed to set the peer doorbell %lu by field %#018llx",
+			db_id, db_umsk);
+		return;
+	}
+
+	/* After this the driver is waiting for the peer response */
+	ctx->state = PP_WAIT;
+
+	/* Unmask the corresponding doorbell bit to receive the event */
+	ret = ntb_db_clear_mask(ntb, db_umsk);
+	if (SUCCESS != ret) {
+		dev_err_pp(ctx,
+			"Failed to unmask the doorbell %lu by field %#018llx",
+			db_id, db_umsk);
+		return;
+	}
+}
+
+/*
+ * Handle the event of Doorbell set
+ */
+static void pp_db_event(void *data, int vec)
+{
+	struct pp_ctx *ctx = data;
+
+	/* From now the driver is sleeping before sending the response */
+	ctx->state = PP_SLEEP;
+
+	/* Schedule the delayed work of the algorithm */
+	(void)schedule_delayed_work(&ctx->dwork, ctx->delay);
+}
+
+/*===========================================================================
+ *                      11. DebugFS callback functions
+ *===========================================================================*/
+
+static ssize_t pp_dbgfs_read(struct file *filp, char __user *ubuf,
+				  size_t count, loff_t *offp);
+
+/*
+ * Driver DebugFS operations
+ */
+static const struct file_operations pp_dbgfs_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = pp_dbgfs_read
+};
+
+/*
+ * DebugFS read node info callback
+ */
+static ssize_t pp_dbgfs_read(struct file *filp, char __user *ubuf,
+			     size_t count, loff_t *offp)
+{
+	struct pp_ctx *ctx = filp->private_data;
+	struct ntb_dev *ntb = ctx->ntb;
+	char *strbuf;
+	size_t size;
+	ssize_t ret = 0, off = 0;
+
+	/* Limit the buffer size */
+	size = min_t(size_t, count, 0x800U);
+
+	/* Allocate the memory for the buffer */
+	strbuf = kmalloc(size, GFP_KERNEL);
+	if (NULL == strbuf) {
+		return -ENOMEM;
+	}
+
+	/* Put the data into the string buffer */
+	off += scnprintf(strbuf + off, size - off,
+		"\n\t\tNTB Doorbells PingPong test driver:\n\n");
+
+	/* Current driver state */
+	off += scnprintf(strbuf + off, size - off,
+		"Link state\t- %s\n",
+		(ON == ntb_link_is_up(ntb, NULL, NULL)) ? "Up" : "Down");
+	off += scnprintf(strbuf + off, size - off,
+		"Cycle\t\t- %llu\n", ctx->cycle);
+	off += scnprintf(strbuf + off, size - off,
+		"Algo state\t- %s\n",
+		(PP_SLEEP == ctx->state) ? "sleep" : "wait");
+	off += scnprintf(strbuf + off, size - off,
+		"Delay\t\t- %u ms\n", delay_ms);
+
+	/* Copy the buffer to the User Space */
+	ret = simple_read_from_buffer(ubuf, count, offp, strbuf, off);
+	kfree(strbuf);
+
+	return ret;
+}
+
+/*
+ * Driver DebugFS initialization function
+ */
+static int pp_init_dbgfs(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	const char *devname;
+
+	/* If the top directory is not created then do nothing */
+	if (IS_ERR_OR_NULL(dbgfs_dir)) {
+		dev_warn_pp(ctx,
+			"Top DebugFS directory has not been created for "
+			DRIVER_NAME);
+		return PTR_ERR(dbgfs_dir);
+	}
+
+	/* Retrieve the device name */
+	devname = dev_name(&ntb->dev);
+
+	/* Create the corresponding file node */
+	ctx->dbgfs_info = debugfs_create_file(devname, S_IRUSR,
+		dbgfs_dir, ctx, &pp_dbgfs_ops);
+	if (IS_ERR(ctx->dbgfs_info)) {
+		dev_err_pp(ctx, "Could not create the DebugFS node %s",
+			devname);
+		return PTR_ERR(ctx->dbgfs_info);
+	}
+
+	dev_dbg_pp(ctx, "Doorbell PingPong DebugFS node is created for %s",
+		devname);
+
+	return SUCCESS;
+}
+
+/*
+ * Driver DebugFS deinitialization function
+ */
+static void pp_deinit_dbgfs(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Remove the DebugFS file */
+	debugfs_remove(ctx->dbgfs_info);
+
+	dev_dbg_pp(ctx, "Doorbell PingPong DebugFS node %s is discarded",
+		dev_name(&ntb->dev));
+}
+
+/*===========================================================================
+ *                   NTB device/client driver initialization
+ *===========================================================================*/
+
+/*
+ * NTB device events handlers
+ */
+static const struct ntb_ctx_ops pp_ops = {
+	.db_event = pp_db_event
+};
+
+/*
+ * Create the driver context structure
+ */
+static struct pp_ctx *pp_create_ctx(struct ntb_dev *ntb)
+{
+	struct pp_ctx *ctx;
+	int node;
+
+	/* Allocate the memory at the device NUMA node */
+	node = dev_to_node(&ntb->dev);
+	ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, node);
+	if (IS_ERR_OR_NULL(ctx)) {
+		dev_err(&ntb->dev,
+			"No memory for NTB PingPong driver context");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Initialize the NTB device descriptor and delayed work */
+	ctx->ntb = ntb;
+	ctx->cycle = 0;
+	ctx->valid_ids = ntb_db_valid_mask(ntb);
+	ctx->delay = msecs_to_jiffies(delay_ms);
+	ctx->state = PP_WAIT;
+	INIT_DELAYED_WORK(&ctx->dwork, pp_iterate_cycle);
+
+	dev_dbg_pp(ctx, "Context structure is created");
+
+	return ctx;
+}
+
+/*
+ * Free the driver context structure
+ */
+static void pp_free_ctx(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Just free the memory allocated for the context structure */
+	kfree(ctx);
+
+	dev_dbg(&ntb->dev, "Context structure is freed");
+}
+
+/*
+ * Correspondingly initialize the ntb device structure
+ */
+static int pp_init_ntb_dev(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	int ret;
+
+	/* Set the NTB device events context */
+	ret = ntb_set_ctx(ntb, ctx, &pp_ops);
+	if (SUCCESS != ret) {
+		dev_err_pp(ctx, "Failed to specify the NTB device context");
+		return ret;
+	}
+
+	/* Enable the link */
+	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	/*ntb_link_event(ntb);*/
+
+	dev_dbg_pp(ctx, "NTB device is initialized");
+
+	return SUCCESS;
+}
+
+/*
+ * Deinitialize the ntb device structure
+ */
+static void pp_stop_ntb_dev(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Disable the link */
+	ntb_link_disable(ntb);
+
+	/* Clear the context to make sure there won't be any doorbell event */
+	ntb_clear_ctx(ntb);
+
+	dev_dbg_pp(ctx, "NTB device is deinitialized");
+}
+
+/*
+ * Initialize the basic algorithm-related fields
+ */
+static int pp_init_algo(struct pp_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	u64 db_sts, db_umsk;
+	int ret;
+
+	/* Read the current mask */
+	db_umsk = ~ntb_db_read_mask(ntb) & ctx->valid_ids;
+
+	/* If all doorbell have been unmasked then mask them all */
+	if (db_umsk == ctx->valid_ids) {
+		ret = ntb_db_set_mask(ntb, db_umsk);
+		if (SUCCESS != ret) {
+			dev_err_pp(ctx,
+				"Failed to mask all the doorbells "
+				"%#018llx", db_umsk);
+			return ret;
+		}
+		/* Set the unmasking variable to zero so the algorithm would
+		 * initialize the corresponding DB bit */
+		db_umsk = 0;
+	}
+
+	/* If there is no any unmasked bit then set the very first peer doorbell
+	 * bit and locally unmask it */
+	if (0x0 == db_umsk) {
+		db_umsk = BIT_ULL(0);
+		/* Set the new peer doorbell bit */
+		ret = ntb_peer_db_set(ntb, db_umsk);
+		if (SUCCESS != ret) {
+			dev_err_pp(ctx,
+				"Failed to set the peer doorbell %u by field "
+				"%#018llx", 0, db_umsk);
+			return ret;
+		}
+		/* Clear the mask of the corresponding doorbell bit */
+		ret = ntb_db_clear_mask(ntb, db_umsk);
+		if (SUCCESS != ret) {
+			dev_err_pp(ctx,
+				"Failed to unmask the doorbell %u by field "
+				"%#018llx", 0, db_umsk);
+			return ret;
+		}
+	}
+	/* If there is one umasked bit then just read the doorbell status.
+	 * If the bit is set then just start the work thread to handle the
+	 * disposition otherwise just don't do anything waiting for the peer
+	 * to set the doorbell bit */
+	else if (1 == hweight64(db_umsk)) {
+		db_sts = ntb_db_read(ntb);
+		if (0x0 != (db_sts & db_umsk)) {
+			/* Schedule the delayed work of the algorithm */
+			(void)schedule_delayed_work(&ctx->dwork, ctx->delay);
+		}
+	} else /* if (1 < hweight64(db_umsk)) */ {
+		dev_err_pp(ctx, "Invalid mask is found %#018llx", db_umsk);
+		return -EINVAL;
+	}
+
+	dev_dbg_pp(ctx, "Doorbell PingPong algorithm is initialized");
+
+	return SUCCESS;
+}
+
+/*
+ * Stop the driver algorithm
+ */
+static void pp_stop_algo(struct pp_ctx *ctx)
+{
+	/* Make sure the delayed work is not started */
+	cancel_delayed_work_sync(&ctx->dwork);
+
+	dev_dbg_pp(ctx, "Doorbell PingPong algorithm is stopped");
+}
+
+/*
+ * NTB device probe() callback function
+ */
+static int pp_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct pp_ctx *ctx;
+	int ret;
+
+	/* Both synchronous and asynchronous hardware is supported */
+	if (!ntb_valid_sync_dev_ops(ntb) && !ntb_valid_async_dev_ops(ntb)) {
+		return -EINVAL;
+	}
+
+	/* Create the current device context */
+	ctx = pp_create_ctx(ntb);
+	if (IS_ERR_OR_NULL(ctx)) {
+		return PTR_ERR(ctx);
+	}
+
+	/* Initialize the NTB device */
+	ret = pp_init_ntb_dev(ctx);
+	if (SUCCESS != ret) {
+		goto err_free_ctx;
+	}
+
+	/* Initialize the pingpong algorithm */
+	ret = pp_init_algo(ctx);
+	if (SUCCESS != ret) {
+		goto err_stop_ntb_dev;
+	}
+
+	/* Create the DebugFS node */
+	(void)pp_init_dbgfs(ctx);
+
+	/* Start  */
+
+	return SUCCESS;
+
+/*err_stop_algo:
+	pp_stop_algo(ctx);
+*/
+err_stop_ntb_dev:
+	pp_stop_ntb_dev(ctx);
+
+err_free_ctx:
+	pp_free_ctx(ctx);
+
+	return ret;
+}
+
+/*
+ * NTB device remove() callback function
+ */
+static void pp_remove(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct pp_ctx *ctx = ntb->ctx;
+
+	/* Remove the DebugFS node */
+	pp_deinit_dbgfs(ctx);
+
+	/* Disable the NTB device link and clear the context */
+	pp_stop_ntb_dev(ctx);
+
+	/* Stop the algorithm */
+	pp_stop_algo(ctx);
+
+	/* Free the allocated context */
+	pp_free_ctx(ctx);
+}
+
+/*
+ * NTB bus client driver structure definition
+ */
+static struct ntb_client pp_client = {
+	.ops = {
+		.probe = pp_probe,
+		.remove = pp_remove,
+	},
+};
+/* module_ntb_client(pp_client); */
+
+/*
+ * Driver initialize method
+ */
+static int __init ntb_pp_init(void)
+{
+	/* Create the top DebugFS directory if the FS is initialized */
+	if (debugfs_initialized())
+		dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	/* Registers the client driver */
+	return ntb_register_client(&pp_client);
+}
+module_init(ntb_pp_init);
+
+/*
+ * Driver exit method
+ */
+static void __exit ntb_pp_exit(void)
+{
+	/* Unregister the client driver */
+	ntb_unregister_client(&pp_client);
+
+	/* Discard the top DebugFS directory */
+	debugfs_remove_recursive(dbgfs_dir);
+}
+module_exit(ntb_pp_exit);
+
diff --git a/drivers/ntb/test/ntb_msg_test.c b/drivers/ntb/test/ntb_msg_test.c
new file mode 100644
index 0000000..a4aecf4
--- /dev/null
+++ b/drivers/ntb/test/ntb_msg_test.c
@@ -0,0 +1,736 @@
+/*
+ *   This file is provided under a GPLv2 license.  When using or
+ *   redistributing this file, you may do so under that license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms and conditions of the GNU General Public License,
+ *   version 2, as published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful, but WITHOUT
+ *   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ *   more details.
+ *
+ *   You should have received a copy of the GNU General Public License along with
+ *   this program; if not, one can be found <http://www.gnu.org/licenses/>.
+ *
+ *   The full GNU General Public License is included in this distribution in
+ *   the file called "COPYING".
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * PCIe NTB messaging test Linux driver
+ *
+ * Contact Information:
+ * Serge Semin <fancer.lancer@gmail.com>, <Sergey.Semin@t-platforms.ru>
+ */
+
+/*
+ *               NOTE of the NTB Messaging driver design.
+ * The driver is designed to implement the simple transmition/reception
+ * algorithm. User can send data to a peer by writing it to
+ * debugfs:ntb_msg_test/ntbA_/data file, and one can read it by reading the
+ * same file on the opposite side.
+ */
+
+/* Note: You can load this module with either option 'dyndbg=+p' or define the
+ * next preprocessor constant */
+/*#define DEBUG*/
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+
+#include <linux/ntb.h>
+
+#define DRIVER_NAME		"ntb_msg_test"
+#define DRIVER_DESCRIPTION	"PCIe NTB Simple Messaging Client"
+#define DRIVER_VERSION		"1.0"
+#define CACHE_NAME		"ntb_msg_cache"
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("T-platforms");
+
+/*
+ * DebugFS directory to place the driver debug file
+ */
+static struct dentry *dbgfs_topdir;
+
+/*
+ * Doorbells pingpong driver context
+ * @ntb:	Pointer to the NTB device
+ * @msg_cache:	Messages wrapper slab
+ * @msg_lock:	Spin lock to synchrnize access to the messages list
+ * @msg_list:	List of received messages
+ * @msgcnt:	Number of received messages
+ * @failed:	Number of failed transfers
+ * @succeeded:	Number of succeeded transfers
+ * @datasize:	Maximum size of message data (in bytes) excluding the size byte
+ * @dbgfs_dir:	Handler of the driver DebugFS directory
+ */
+struct msg_ctx {
+	struct ntb_dev *ntb;
+	struct kmem_cache *msg_cache;
+	spinlock_t msg_lock;
+	struct list_head msg_list;
+	unsigned long msgcnt;
+	unsigned long failed;
+	unsigned long succeeded;
+	size_t datasize;
+	struct dentry *dbgfs_dir;
+};
+
+/*
+ * Received messages container
+ * @msg:	Message
+ * @entry:	List entry
+ */
+struct ntb_msg_wrap {
+	struct ntb_msg msg;
+	struct list_head entry;
+};
+
+/*
+ * Message converter is used to translate the struct ntb_msg to the
+ * char sized data structure with size.
+ * @size:	Size of the data
+ * @data:	Pointer to the data buffer
+ */
+struct ntb_msg_conv {
+	u8 size;
+	char data[];
+};
+
+/*
+ * Wrapper dev_err/dev_warn/dev_info/dev_dbg macros
+ */
+#define dev_err_msg(ctx, args...) \
+	dev_err(&ctx->ntb->dev, ## args)
+#define dev_warn_msg(ctx, args...) \
+	dev_warn(&ctx->ntb->dev, ## args)
+#define dev_info_msg(ctx, args...) \
+	dev_info(&ctx->ntb->dev, ## args)
+#define dev_dbg_msg(ctx, args...) \
+	dev_dbg(&ctx->ntb->dev, ## args)
+
+/*
+ * Some common constant used in the driver for better readability:
+ * @ON: Enable something
+ * @OFF: Disable something
+ * @SUCCESS: Success of a function execution
+ */
+#define ON ((u32)0x1)
+#define OFF ((u32)0x0)
+#define SUCCESS 0
+
+/*===========================================================================
+ *                         Incoming messages handlers
+ *===========================================================================*/
+
+/*
+ * Save the receive message
+ */
+static void msg_recv_handler(struct msg_ctx *ctx, const struct ntb_msg *msg)
+{
+	struct ntb_msg_wrap *wrap;
+	struct ntb_msg_conv *conv;
+
+	/* Cast the message to the converted one */
+	conv = (struct ntb_msg_conv *)msg;
+
+	/* Allocate the memory from the slab */
+	wrap = kmem_cache_alloc(ctx->msg_cache, GFP_KERNEL);
+	if (NULL == wrap) {
+		dev_err_msg(ctx,
+			"Failed to allocate memory for incoming message %.*s",
+			conv->size, conv->data);
+		return;
+	}
+
+	/* Copy the message to the buffer */
+	memcpy(&wrap->msg, msg, conv->size + 1);
+
+	/* Add the wrapped message to the list of received messages */
+	spin_lock(&ctx->msg_lock);
+	list_add_tail(&wrap->entry, &ctx->msg_list);
+	/* Increment the number of received messages in the buffer */
+	ctx->msgcnt++;
+	spin_unlock(&ctx->msg_lock);
+
+	dev_dbg_msg(ctx, "Message '%.*s' was received",
+		conv->size, conv->data);
+}
+
+/*
+ * Handler of the transmit errors
+ */
+static void msg_fail_handler(struct msg_ctx *ctx, const struct ntb_msg *msg)
+{
+	struct ntb_msg_conv *conv = (struct ntb_msg_conv *)msg;
+
+	/* Just print the error increment the errors counter */
+	dev_err_msg(ctx,
+		"Failed to send the submessage '%.*s'",
+			conv->size, conv->data);
+	ctx->failed++;
+}
+
+/*
+ * Handler of the succeeded transmits
+ */
+static void msg_sent_handler(struct msg_ctx *ctx, const struct ntb_msg *msg)
+{
+	struct ntb_msg_conv *conv = (struct ntb_msg_conv *)msg;
+
+	/* Just print the debug text and increment the succeeded msgs counter */
+	dev_dbg_msg(ctx,
+		"Submessage '%.*s' has been successfully sent",
+			conv->size, conv->data);
+	ctx->succeeded++;
+}
+
+/*
+ * Message event handler
+ */
+static void msg_event_handler(void *data, enum NTB_MSG_EVENT ev,
+			      struct ntb_msg *msg)
+{
+	struct msg_ctx *ctx = data;
+
+	/* Call the corresponding event handler */
+	switch (ev) {
+	case NTB_MSG_NEW:
+		msg_recv_handler(ctx, msg);
+		break;
+	case NTB_MSG_SENT:
+		msg_sent_handler(ctx, msg);
+		break;
+	case NTB_MSG_FAIL:
+		msg_fail_handler(ctx, msg);
+		break;
+	default:
+		dev_err_msg(ctx, "Got invalid message event %d", ev);
+		break;
+	}
+}
+
+/*===========================================================================
+ *                      11. DebugFS callback functions
+ *===========================================================================*/
+
+static ssize_t msg_dbgfs_data_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp);
+
+static ssize_t msg_dbgfs_data_write(struct file *filep, const char __user *ubuf,
+				    size_t usize, loff_t *offp);
+
+static ssize_t msg_dbgfs_stat_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp);
+
+/*
+ * DebugFS data node operations
+ */
+static const struct file_operations msg_dbgfs_data_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = msg_dbgfs_data_read,
+	.write = msg_dbgfs_data_write
+};
+
+/*
+ * DebugFS statistics node operations
+ */
+static const struct file_operations msg_dbgfs_stat_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = msg_dbgfs_stat_read,
+};
+
+/*
+ * DebugFS callback of read messages node
+ */
+static ssize_t msg_dbgfs_data_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp)
+{
+	struct msg_ctx *ctx = filep->private_data;
+	struct list_head *entry, *safe_entry;
+	struct ntb_msg_wrap *wrap;
+	struct ntb_msg_conv *conv;
+	size_t datasize, retsize;
+	char *databuf;
+	ssize_t ret;
+
+	/* Find the size of the retrieved data in messages */
+	datasize = 0;
+	spin_lock(&ctx->msg_lock);
+	list_for_each(entry, &ctx->msg_list) {
+		wrap = list_entry(entry, struct ntb_msg_wrap, entry);
+		conv = (struct ntb_msg_conv *)&wrap->msg;
+		datasize += conv->size;
+	}
+	spin_unlock(&ctx->msg_lock);
+
+	/* Calculate the size of the output buffer */
+	datasize = min(datasize, usize);
+
+	/* Allocate the buffer */
+	databuf = kmalloc(datasize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_msg(ctx, "No memory to allocate the output buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data from the messages to the output buffer */
+	retsize = 0;
+	spin_lock(&ctx->msg_lock);
+	list_for_each_safe(entry, safe_entry, &ctx->msg_list) {
+		/* Get the message and copy it to the buffer */
+		wrap = list_entry(entry, struct ntb_msg_wrap, entry);
+		conv = (struct ntb_msg_conv *)&wrap->msg;
+
+		/* If there is no enough space left in the buffer then stop the
+		 * loop */
+		if ((datasize - retsize) < conv->size) {
+			break;
+		}
+
+		/* Copy the data to the output buffer */
+		memcpy(&databuf[retsize], conv->data, conv->size);
+
+		/* Increment the size of the retrieved data */
+		retsize += conv->size;
+
+		/* Delete the list entry and free the memory */
+		list_del(&wrap->entry);
+		kmem_cache_free(ctx->msg_cache, wrap);
+
+		/* Decrement the number of messages in the buffer */
+		ctx->msgcnt--;
+	}
+	spin_unlock(&ctx->msg_lock);
+
+	/* Copy the text to the output buffer */
+	ret = simple_read_from_buffer(ubuf, usize, offp, databuf, retsize);
+
+	/* Free the memory allocated for the buffer */
+	kfree(databuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS callback of write messages node
+ */
+static ssize_t msg_dbgfs_data_write(struct file *filep, const char __user *ubuf,
+				    size_t usize, loff_t *offp)
+{
+	struct msg_ctx *ctx = filep->private_data;
+	struct ntb_dev *ntb = ctx->ntb;
+	struct ntb_msg msg;
+	struct ntb_msg_conv *conv;
+	char *databuf;
+	int pos, copied, sts = SUCCESS;
+	ssize_t ret;
+
+	/* Allocate the memory for sending data */
+	databuf = kmalloc(usize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_msg(ctx, "No memory to allocate the sending data buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data to the output buffer */
+	ret = simple_write_to_buffer(databuf, usize, offp, ubuf, usize);
+	if (0 > ret) {
+		dev_err_msg(ctx, "Failed to copy the data from the User-space");
+		kfree(databuf);
+		return ret;
+	}
+
+	/* Start copying data to the message structure and send it straight away
+	 * to the peer */
+	conv = (struct ntb_msg_conv *)&msg;
+	for (pos = 0, copied = 0; pos < usize; pos += copied) {
+		/* Calculate the size of data to copy to the message */
+		copied = min(ctx->datasize, (usize - pos));
+		/* Set the data size of the message */
+		conv->size = copied;
+		/* Copy the data */
+		memcpy(conv->data, &databuf[pos], copied);
+
+		/* Send the data stright away */
+		sts = ntb_msg_post(ntb, &msg);
+		if (SUCCESS != sts) {
+			dev_err_msg(ctx, "Failed to post the submessage %.*s",
+				copied, conv->data);
+		}
+	}
+
+	return (SUCCESS == sts) ? usize : -EINVAL;
+}
+
+/*
+ * DebugFS callback to read statistics
+ */
+static ssize_t msg_dbgfs_stat_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp)
+{
+	struct msg_ctx *ctx = filep->private_data;
+	struct ntb_dev *ntb = ctx->ntb;
+	char *strbuf;
+	size_t size;
+	ssize_t ret = 0, off = 0;
+
+	/* Limit the buffer size */
+	size = min_t(size_t, usize, 0x800U);
+
+	/* Allocate the memory for the buffer */
+	strbuf = kmalloc(size, GFP_KERNEL);
+	if (NULL == strbuf) {
+		dev_dbg_msg(ctx,
+			"Failed to allocate the memory for statistics "
+			"output buffer");
+		return -ENOMEM;
+	}
+
+	/* Put the data into the string buffer */
+	off += scnprintf(strbuf + off, size - off,
+		"\n\t\tNTB Messaging Test driver:\n\n");
+
+	/* Current driver state */
+	off += scnprintf(strbuf + off, size - off,
+		"Link state\t\t- %s\n",
+		(ON == ntb_link_is_up(ntb, NULL, NULL)) ? "Up" : "Down");
+	off += scnprintf(strbuf + off, size - off,
+		"Message count\t\t- %lu\n", ctx->msgcnt);
+	off += scnprintf(strbuf + off, size - off,
+		"Message size\t\t- %u\n", ntb_msg_size(ntb));
+	off += scnprintf(strbuf + off, size - off,
+		"Data size\t\t- %lu\n", (unsigned long)ctx->datasize);
+	off += scnprintf(strbuf + off, size - off,
+		"Successfully sent\t- %lu\n", ctx->succeeded);
+	off += scnprintf(strbuf + off, size - off,
+		"Failed to send\t\t- %lu\n", ctx->failed);
+
+	/* Copy the buffer to the User Space */
+	ret = simple_read_from_buffer(ubuf, usize, offp, strbuf, off);
+	kfree(strbuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS initialization function
+ */
+static int msg_init_dbgfs(struct msg_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct dentry *dbgfs_data, *dbgfs_stat;
+	const char *devname;
+	int ret;
+
+	/* If the top directory is not created then do nothing */
+	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
+		dev_warn_msg(ctx,
+			"Top DebugFS directory has not been created for "
+			DRIVER_NAME);
+		return PTR_ERR(dbgfs_topdir);
+	}
+
+	/* Retrieve the device name */
+	devname = dev_name(&ntb->dev);
+
+	/* Create the device related subdirectory */
+	ctx->dbgfs_dir = debugfs_create_dir(devname, dbgfs_topdir);
+	if (IS_ERR_OR_NULL(ctx->dbgfs_dir)) {
+		dev_warn_msg(ctx,
+			"Failed to create the DebugFS subdirectory %s",
+			devname);
+		return PTR_ERR(ctx->dbgfs_dir);
+	}
+
+	/* Create the file node for data io operations */
+	dbgfs_data = debugfs_create_file("data", S_IRWXU, ctx->dbgfs_dir, ctx,
+					 &msg_dbgfs_data_ops);
+	if (IS_ERR(dbgfs_data)) {
+		dev_err_msg(ctx, "Could not create DebugFS data node");
+		ret = PTR_ERR(dbgfs_data);
+		goto err_rm_dir;
+	}
+
+	/* Create the file node for statistics io operations */
+	dbgfs_stat = debugfs_create_file("stat", S_IRWXU, ctx->dbgfs_dir, ctx,
+					 &msg_dbgfs_stat_ops);
+	if (IS_ERR(dbgfs_stat)) {
+		dev_err_msg(ctx, "Could not create DebugFS statistics node");
+		ret = PTR_ERR(dbgfs_stat);
+		goto err_rm_dir;
+	}
+
+	dev_dbg_msg(ctx, "NTB Messaging DebugFS nodes are created for %s",
+		devname);
+
+	return SUCCESS;
+
+err_rm_dir:
+	debugfs_remove_recursive(ctx->dbgfs_dir);
+
+	return ret;
+}
+
+/*
+ * DebugFS deinitialization function
+ */
+static void msg_deinit_dbgfs(struct msg_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Remove the DebugFS directory */
+	debugfs_remove_recursive(ctx->dbgfs_dir);
+
+	dev_dbg_msg(ctx, "NTB Messaging DebugFS nodes %s/ are discarded",
+		dev_name(&ntb->dev));
+}
+
+/*===========================================================================
+ *                   NTB device/client driver initialization
+ *===========================================================================*/
+
+/*
+ * NTB device events handlers
+ */
+static const struct ntb_ctx_ops msg_ops = {
+	.msg_event = msg_event_handler
+};
+
+/*
+ * Create the driver context structure
+ */
+static struct msg_ctx *msg_create_ctx(struct ntb_dev *ntb)
+{
+	struct msg_ctx *ctx;
+	int node;
+
+	/* Allocate the memory at the device NUMA node */
+	node = dev_to_node(&ntb->dev);
+	ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, node);
+	if (IS_ERR_OR_NULL(ctx)) {
+		dev_err(&ntb->dev,
+			"No memory for NTB Messaging driver context");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Create the message cache */
+	ctx->msg_cache = kmem_cache_create(CACHE_NAME,
+		sizeof(struct ntb_msg_wrap), 0, 0, NULL);
+	if (NULL == ctx->msg_cache) {
+		dev_err(&ntb->dev,
+			"Failed to allocate the message wrap structures cache");
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Initialize the context NTB device pointer */
+	ctx->ntb = ntb;
+
+	/* Initialize the message list lock and the list head */
+	spin_lock_init(&ctx->msg_lock);
+	INIT_LIST_HEAD(&ctx->msg_list);
+
+	/* Initialize the counters */
+	ctx->msgcnt = 0;
+	ctx->failed = 0;
+	ctx->succeeded = 0;
+
+	/* Initialize the data size of one message excluding the size byte */
+	ctx->datasize = 4*ntb_msg_size(ntb) - 1;
+
+	dev_dbg_msg(ctx, "Context structure is created");
+
+	return ctx;
+}
+
+/*
+ * Free the driver context structure
+ */
+static void msg_free_ctx(struct msg_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct ntb_msg_wrap *wrap;
+	struct list_head *entry, *safe_entry;
+
+	/* Walk through the list of messages and destroy all the allocated
+	 * memory */
+	spin_lock(&ctx->msg_lock);
+	list_for_each_safe(entry, safe_entry, &ctx->msg_list) {
+		/* Get the message wrapper */
+		wrap = list_entry(entry, struct ntb_msg_wrap, entry);
+
+		/* Delete the list entry and free the memory */
+		list_del(entry);
+		kmem_cache_free(ctx->msg_cache, wrap);
+
+		/* Decrement the number of messages in the buffer */
+		ctx->msgcnt--;
+	}
+	spin_unlock(&ctx->msg_lock);
+
+	/* Destroy the IDT messages cache */
+	kmem_cache_destroy(ctx->msg_cache);
+
+	/* Free the memory allocated for the context structure */
+	kfree(ctx);
+
+	dev_dbg(&ntb->dev, "Context structure is freed");
+}
+
+/*
+ * Initialize the ntb device structure
+ */
+static int msg_init_ntb_dev(struct msg_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	int ret;
+
+	/* Set the NTB device events context */
+	ret = ntb_set_ctx(ntb, ctx, &msg_ops);
+	if (SUCCESS != ret) {
+		dev_err_msg(ctx, "Failed to specify the NTB device context");
+		return ret;
+	}
+
+	/* Enable the link */
+	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	/*ntb_link_event(ntb);*/
+
+	dev_dbg_msg(ctx, "NTB device is initialized");
+
+	return SUCCESS;
+}
+
+/*
+ * Deinitialize the ntb device structure
+ */
+static void msg_stop_ntb_dev(struct msg_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Disable the link */
+	ntb_link_disable(ntb);
+
+	/* Clear the context */
+	ntb_clear_ctx(ntb);
+
+	dev_dbg_msg(ctx, "NTB device is deinitialized");
+}
+
+/*
+ * NTB device probe() callback function
+ */
+static int msg_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct msg_ctx *ctx;
+	int ret;
+
+	/* Only asynchronous hardware is supported */
+	if (!ntb_valid_async_dev_ops(ntb)) {
+		return -EINVAL;
+	}
+
+	/* Create the current device context */
+	ctx = msg_create_ctx(ntb);
+	if (IS_ERR_OR_NULL(ctx)) {
+		return PTR_ERR(ctx);
+	}
+
+	/* Initialize the NTB device */
+	ret = msg_init_ntb_dev(ctx);
+	if (SUCCESS != ret) {
+		msg_free_ctx(ctx);
+		return ret;
+	}
+
+	/* Create the DebugFS node */
+	(void)msg_init_dbgfs(ctx);
+
+	return SUCCESS;
+}
+
+/*
+ * NTB device remove() callback function
+ */
+static void msg_remove(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct msg_ctx *ctx = ntb->ctx;
+
+	/* Remove the DebugFS node */
+	msg_deinit_dbgfs(ctx);
+
+	/* Disable the NTB device link and clear the context */
+	msg_stop_ntb_dev(ctx);
+
+	/* Free the allocated context */
+	msg_free_ctx(ctx);
+}
+
+/*
+ * NTB bus client driver structure definition
+ */
+static struct ntb_client msg_client = {
+	.ops = {
+		.probe = msg_probe,
+		.remove = msg_remove,
+	},
+};
+/* module_ntb_client(msg_client); */
+
+/*
+ * Driver initialize method
+ */
+static int __init ntb_msg_init(void)
+{
+	/* Create the top DebugFS directory if the FS is initialized */
+	if (debugfs_initialized())
+		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	/* Registers the client driver */
+	return ntb_register_client(&msg_client);
+}
+module_init(ntb_msg_init);
+
+/*
+ * Driver exit method
+ */
+static void __exit ntb_msg_exit(void)
+{
+	/* Unregister the client driver */
+	ntb_unregister_client(&msg_client);
+
+	/* Discard the top DebugFS directory */
+	debugfs_remove_recursive(dbgfs_topdir);
+}
+module_exit(ntb_msg_exit);
+
diff --git a/drivers/ntb/test/ntb_mw_test.c b/drivers/ntb/test/ntb_mw_test.c
new file mode 100644
index 0000000..97dbfc9
--- /dev/null
+++ b/drivers/ntb/test/ntb_mw_test.c
@@ -0,0 +1,1539 @@
+/*
+ *   This file is provided under a GPLv2 license.  When using or
+ *   redistributing this file, you may do so under that license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms and conditions of the GNU General Public License,
+ *   version 2, as published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful, but WITHOUT
+ *   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ *   more details.
+ *
+ *   You should have received a copy of the GNU General Public License along with
+ *   this program; if not, one can be found <http://www.gnu.org/licenses/>.
+ *
+ *   The full GNU General Public License is included in this distribution in
+ *   the file called "COPYING".
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * PCIe NTB memory windows test Linux driver
+ *
+ * Contact Information:
+ * Serge Semin <fancer.lancer@gmail.com>, <Sergey.Semin@t-platforms.ru>
+ */
+
+/*
+ *           NOTE of the NTB memory windows test driver design.
+ * The driver implements the simple read/write algorithm. It allocates the
+ * necessary inbound shared memory window by demand from the peer. Then it
+ * sends the physical address of the memory back to the peer. The corresponding
+ * inwndwN and outwndwN files are created at the DebugFS:ntb_mw_test/ntbA_/
+ * directory. The inwndwN file can be used to read the data written by a peer.
+ * The other outwndwN file is used to write data to the peer memory window.
+ */
+
+/* Note: You can load this module with either option 'dyndbg=+p' or define the
+ * next preprocessor constant */
+/*#define DEBUG*/
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/dma-mapping.h>
+
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+
+#include <linux/ntb.h>
+
+#define DRIVER_NAME		"ntb_mw_test"
+#define DRIVER_DESCRIPTION	"PCIe NTB Memory Window Test Client"
+#define DRIVER_VERSION		"1.0"
+#define CACHE_NAME		"ntb_mw_cache"
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("T-platforms");
+
+/*
+ * DebugFS directory to place the driver debug file
+ */
+static struct dentry *dbgfs_topdir;
+
+/*
+ * Inbound memory windows (locally allocated) structure
+ * @dma_addr:	Address if the locally allocated memory and sent to the peer
+ * @virt_addr:	Virtual address of that memory
+ * @size:	Size of the allocated memory
+ * @addr_align:	Address alignment
+ * @size_align:	Size alignment
+ * @size_max:	Maximum possible size of the window
+ * @dbgfs_node:	DebugFS node to read data from peer
+ * @ctx:	Pointer to the driver context
+ */
+struct mw_ctx;
+struct inmw_wrap {
+	dma_addr_t dma_addr;
+	void *virt_addr;
+	resource_size_t size;
+	resource_size_t addr_align;
+	resource_size_t size_align;
+	resource_size_t size_max;
+	struct dentry *dbgfs_node;
+	struct mw_ctx *ctx;
+};
+
+/*
+ * Outbound memory windows (remotely allocated) structure
+ * @enabled:	Flag whether the window is enabled
+ * @dma_addr:	DMA address of the remotely allocated memory window and
+ *		retrieved from the peer
+ * @phys_addr:	Physical address of the memory to locally map it (retrieved
+ *		from the NTB subsystem, shortly it must be from BAR2 of IDT)
+ * @virt_addr:	Virtual address of mapped IOMEM physical address
+ * @size:	Size of the peer allocated memory
+ * @addr_align:	Alignment of the DMA address allocated by the peer
+ * @size_align:	Size alignment of the DMA address allocated by the peer
+ * @size_max:	Maximum size of the peer allocated memory
+ * @dbgfs_node:	DebugFS node to write data to peer
+ * @ctx:        Pointer to the driver context
+ */
+struct outmw_wrap {
+	bool enabled;
+	dma_addr_t dma_addr;
+	phys_addr_t phys_addr;
+	void __iomem *virt_addr;
+	resource_size_t size;
+	resource_size_t addr_align;
+	resource_size_t size_align;
+	resource_size_t size_max;
+	struct dentry *dbgfs_node;
+	struct mw_ctx *ctx;
+};
+
+/*
+ * Doorbells pingpong driver context
+ * @ntb:	Pointer to the NTB device
+ * @inmw_cnt:	Number of possible inbound memory windows
+ * @outmw_cnt:	Number of possible outbound memory windows
+ * @dbgfs_dir:	Handler of the DebugFS driver info-file
+ */
+struct mw_ctx {
+	struct ntb_dev *ntb;
+	int inmws_cnt;
+	struct inmw_wrap *inmws;
+	int outmws_cnt;
+	struct outmw_wrap *outmws;
+	struct dentry *dbgfs_dir;
+};
+
+/*
+ * Enumeration of commands
+ * @MW_GETADDRS:	Get the addresses of all memory windows peer allocated
+ * @MW_DMAADDR:		DMA address of the memory window is sent within this msg
+ * @MW_FREEADDRS:	Lock the memory windows shared from the local device
+ * @MW_TYPEMASK:	Mask of the message type
+ */
+enum msg_type {
+	MW_GETADDRS,
+	MW_DMAADDR,
+	MW_FREEADDRS,
+	MW_TYPEMASK = 0xFFFFU
+};
+
+/*
+* Helper method to get the type string name
+*/
+static inline char *mw_get_typename(enum msg_type type)
+{
+	switch (type) {
+	case MW_GETADDRS:
+		return "GETADDRS";
+	case MW_DMAADDR:
+		return "DMAADDR";
+	case MW_FREEADDRS:
+		return "FREEADDRS";
+	default:
+		break;
+	}
+
+	return "INVALID";
+}
+
+/*
+ * Wrapper dev_err/dev_warn/dev_info/dev_dbg macros
+ */
+#define dev_err_mw(ctx, args...) \
+	dev_err(&ctx->ntb->dev, ## args)
+#define dev_warn_mw(ctx, args...) \
+	dev_warn(&ctx->ntb->dev, ## args)
+#define dev_info_mw(ctx, args...) \
+	dev_info(&ctx->ntb->dev, ## args)
+#define dev_dbg_mw(ctx, args...) \
+	dev_dbg(&ctx->ntb->dev, ## args)
+
+/*
+ * Some common constant used in the driver for better readability:
+ * @ON: Enable something
+ * @OFF: Disable something
+ * @SUCCESS: Success of a function execution
+ * @MIN_MW_CNT:	Minimum memory windows count
+ * @MAX_MW_CNT: Maximum memory windows count
+ */
+#define ON ((u32)0x1)
+#define OFF ((u32)0x0)
+#define SUCCESS 0
+#define MIN_MW_CNT ((unsigned char)1)
+#define MAX_MW_CNT ((unsigned char)255)
+
+/*
+ * Shared data converter to support the different CPU architectures
+ */
+#define to_sh32(data) \
+	cpu_to_le32((data))
+#define from_sh32(data) \
+	le32_to_cpu((data))
+
+/*
+ * Cast DMA address to real address pointer
+ *
+ * NOTE It's used in the printf's to get rid of warnings
+ */
+#define CAST_DMA_PTR(addr) \
+	((void *)(phys_addr_t)(addr))
+
+/*
+ * Module parameters:
+ * @inmw_cnt:	Number of inbound memory windows [1; 255]
+ * @outmw_cnt:	Number of outbound memory windows [1; 255]
+ * If the specified value exceeds the maximum possible valiue, then it is
+ * initialized with maximum one
+ */
+static unsigned char inmws_cnt = MAX_MW_CNT;
+module_param(inmws_cnt, byte, 0000);
+MODULE_PARM_DESC(inmws_cnt,
+	"Inbound memory windows count. Those are the memory windows, which are "
+	"locally allocated. Their address is sent to the remote host."
+	" - Parameter can be set within [1; 255], where 255 means maximum possible"
+	"   number of windows");
+
+/*===========================================================================
+ *                               Helper methods
+ *===========================================================================*/
+
+/*
+ * Alter the passed driver paremeters
+ */
+static void mw_alter_params(struct mw_ctx *ctx)
+{
+	unsigned char inmws_cnt_bak = ctx->inmws_cnt;
+
+	/* Clamp the inbound memory windows parameter */
+	ctx->inmws_cnt = clamp(inmws_cnt,
+		MIN_MW_CNT, (unsigned char)ctx->inmws_cnt);
+	if (inmws_cnt_bak != ctx->inmws_cnt) {
+		dev_warn_mw(ctx,
+			"Inbound memory windows count is altered from "
+			"%hhu to %hhu", inmws_cnt_bak, ctx->inmws_cnt);
+	}
+
+	dev_dbg_mw(ctx, "Memory windows test driver parameter is verified");
+}
+
+/*
+ * Memory block IO write method
+ */
+static void iomem_write(void __iomem *dst, const void *src, size_t cnt)
+{
+	while (cnt--) {
+		iowrite8(*(u8 *)src, dst);
+		dst++;
+		src++;
+	}
+}
+
+/*
+ * Memory block IO read method
+ */
+static void iomem_read(void __iomem *src, void *dst, size_t cnt)
+{
+	while (cnt--) {
+		*(u8 *)dst = ioread8(src);
+		dst++;
+		src++;
+	}
+}
+
+/*===========================================================================
+ *                          Message command handlers
+ *===========================================================================*/
+
+/*
+ * Send MW_GETADDRS command method
+ */
+static void mw_send_getaddrs_cmd(struct mw_ctx *ctx)
+{
+	struct ntb_msg msg;
+	int sts;
+
+	/* Clear the message structure */
+	memset(&msg, 0, sizeof(msg));
+
+	/* Set the message type only */
+	msg.type = to_sh32(MW_GETADDRS);
+
+	/* Send the message */
+	sts = ntb_msg_post(ctx->ntb, &msg);
+	if (SUCCESS != sts) {
+		dev_err_mw(ctx, "Failed to send message to get outbound window "
+			"addresses");
+	}
+}
+
+/*
+ * Send MW_FREEADDRS command method
+ */
+static void mw_send_freeaddrs_cmd(struct mw_ctx *ctx)
+{
+	struct ntb_msg msg;
+	int sts;
+
+	/* Clear the message structure */
+	memset(&msg, 0, sizeof(msg));
+
+	/* Set the message type only */
+	msg.type = to_sh32(MW_FREEADDRS);
+
+	/* Send the message */
+	sts = ntb_msg_post(ctx->ntb, &msg);
+	if (SUCCESS != sts) {
+		dev_err_mw(ctx, "Failed to send a message to disable the peer "
+			"outbound windows");
+	}
+}
+
+/*
+ * Callback method for response on the command MW_GETADDRS
+ */
+static void mw_send_inmw_addrs(struct mw_ctx *ctx)
+{
+	struct ntb_msg msg;
+	struct inmw_wrap *inmw;
+	int mwindx, sts;
+
+	/* Clear the message structure */
+	memset(&msg, 0, sizeof(msg));
+
+	/* Walk through all the inbound memory windows and send the
+	 * corresponding DMA address of the window */
+	for (mwindx = 0; mwindx < ctx->inmws_cnt; mwindx++) {
+		inmw = &ctx->inmws[mwindx];
+		/* Set the type and the memory window index */
+		msg.type = to_sh32(MW_DMAADDR | ((u32)mwindx << 16));
+
+		/* First set the size of the memory window */
+		msg.payload[0] = to_sh32(inmw->size);
+
+		/* Set the Upper part of the memory window address */
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
+#else
+		/* WARNING! NTB entpoints must either have the same architecture
+		 * (x32 or x64) or use lower 4Gb for memory windows */
+		msg.payload[1] = 0;
+#endif /* !CONFIG_ARCH_DMA_ADDR_T_64BIT */
+		/* Set the Lower part of the memory window address */
+		msg.payload[2] = to_sh32((u32)(inmw->dma_addr));
+
+		/* Send the message */
+		sts = ntb_msg_post(ctx->ntb, &msg);
+		if (SUCCESS != sts) {
+			dev_err_mw(ctx,
+				"Failed to send a message with window %d "
+				"address", mwindx);
+		}
+	}
+}
+
+/*
+ * Method to set the corresponding memory window and enable it
+ */
+static void mw_set_outmw_addr(struct mw_ctx *ctx, const struct ntb_msg *msg)
+{
+	struct outmw_wrap *outmw;
+	int mwindx, sts;
+
+	/* Read the memory windows index (it's the part of the message type) */
+	mwindx = from_sh32(msg->type) >> 16;
+	if (ctx->outmws_cnt <= mwindx) {
+		dev_err_mw(ctx,
+			"Retrieved invalid outbound memory window index %d",
+			mwindx);
+		return;
+	}
+	outmw = &ctx->outmws[mwindx];
+
+	/* Read the memory window size and check whether it has proper size and
+	 * alignment */
+	outmw->size = from_sh32(msg->payload[0]);
+	if (!IS_ALIGNED(outmw->size, outmw->size_align) ||
+	    outmw->size_max < outmw->size) {
+		dev_err_mw(ctx,
+			"Retrieved invalid memory window %d size %u "
+			"(max: %u, align: %u)", mwindx, (unsigned int)outmw->size,
+			(unsigned int)outmw->size_max,
+			(unsigned int)outmw->size_align);
+		return;
+	}
+
+	/* Read the DMA address, where the second DWORD is the upper part and
+	 * the third DWORD - lower */
+	outmw->dma_addr = from_sh32(msg->payload[2]);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	outmw->dma_addr |= ((dma_addr_t)from_sh32(msg->payload[1]) << 32);
+#endif /* CONFIG_ARCH_DMA_ADDR_T_64BIT */
+	/* Check whether the retrieved address is properly aligned */
+	if (!IS_ALIGNED(outmw->dma_addr, outmw->addr_align)) {
+		dev_err_mw(ctx,
+			"Outbound memory window address 0x%p is not aligned "
+			"within %lu bytes", CAST_DMA_PTR(outmw->dma_addr),
+			(unsigned long int)outmw->addr_align);
+		return;
+	}
+
+	/* Set the translation address of the outbound memory window */
+	sts = ntb_mw_set_trans(ctx->ntb, mwindx, outmw->dma_addr, outmw->size);
+	if (SUCCESS != sts) {
+		dev_err_mw(ctx, "Failed to set the translated address %p of "
+			"outbound memory window %d",
+			CAST_DMA_PTR(outmw->dma_addr), 	mwindx);
+		return;
+	}
+
+	/* Enable the memory window */
+	outmw->enabled = true;
+
+	dev_dbg_mw(ctx, "Outbound memory window %d is initialized with "
+		"address 0x%p", mwindx, CAST_DMA_PTR(outmw->dma_addr));
+}
+
+/*
+ * Lock all the outbound memory windows
+ */
+static void mw_lock_outmw_addrs(struct mw_ctx *ctx)
+{
+	int mwindx;
+
+	/* Walk through all the memory windows and lock whem by falsing
+	 * the flag */
+	for (mwindx = 0; mwindx < ctx->outmws_cnt; mwindx++) {
+		ctx->outmws[mwindx].enabled = false;
+	}
+
+	dev_dbg_mw(ctx, "Outbound memory windows are locked");
+}
+
+/*===========================================================================
+ *                      Messages and link events handlers
+ *===========================================================================*/
+
+/*
+ * Handle the retrieved message
+ */
+static void msg_recv_handler(struct mw_ctx *ctx, const struct ntb_msg *msg)
+{
+	enum msg_type type = from_sh32(msg->type) & MW_TYPEMASK;
+
+	/* Check the message types */
+	switch (type) {
+	case MW_GETADDRS:
+		mw_send_inmw_addrs(ctx);
+		break;
+	case MW_DMAADDR:
+		mw_set_outmw_addr(ctx, msg);
+		break;
+	case MW_FREEADDRS:
+		mw_lock_outmw_addrs(ctx);
+		break;
+	default:
+		dev_err_mw(ctx, "Invalid message type retrieved %d", type);
+		return;
+	}
+
+	dev_dbg_mw(ctx, "Message of type %s was received",
+		mw_get_typename(type));
+}
+
+/*
+ * Handler of the transmit errors
+ */
+static void msg_fail_handler(struct mw_ctx *ctx, const struct ntb_msg *msg)
+{
+	enum msg_type type = from_sh32(msg->type) & MW_TYPEMASK;
+
+	/* Just print the error */
+	dev_err_mw(ctx, "Failed to send the message of type %s",
+		mw_get_typename(type));
+}
+
+/*
+ * Handler of the succeeded transmits
+ */
+static void msg_sent_handler(struct mw_ctx *ctx, const struct ntb_msg *msg)
+{
+	enum msg_type type = from_sh32(msg->type) & MW_TYPEMASK;
+
+	/* Just print the debug text and increment the succeeded msgs counter */
+	dev_dbg_mw(ctx, "Message of type %s has been successfully sent",
+		mw_get_typename(type));
+}
+
+/*
+ * Message event handler
+ */
+static void msg_event_handler(void *data, enum NTB_MSG_EVENT ev,
+			      struct ntb_msg *msg)
+{
+	struct mw_ctx *ctx = data;
+
+	/* Call the corresponding event handler */
+	switch (ev) {
+	case NTB_MSG_NEW:
+		msg_recv_handler(ctx, msg);
+		break;
+	case NTB_MSG_SENT:
+		msg_sent_handler(ctx, msg);
+		break;
+	case NTB_MSG_FAIL:
+		msg_fail_handler(ctx, msg);
+		break;
+	default:
+		dev_err_mw(ctx, "Got invalid message event %d", ev);
+		break;
+	}
+}
+
+/*
+ * Link Up/Down event handler
+ */
+static void link_event_handler(void *data)
+{
+	struct mw_ctx *ctx = data;
+	int sts;
+
+	/* If link is up then send the message with GETADDRS command, otherwise
+	 * the outbound memory windows must be disabled */
+	sts = ntb_link_is_up(ctx->ntb, NULL, NULL);
+	if (ON == sts) {
+		mw_send_getaddrs_cmd(ctx);
+	} else /* if (OFF == sts) */ {
+		mw_lock_outmw_addrs(ctx);
+	}
+
+	dev_dbg_mw(ctx, "Link %s event was retrieved",
+		ON == sts ? "Up" : "Down");
+}
+
+/*===========================================================================
+ *                      11. DebugFS callback functions
+ *===========================================================================*/
+
+static ssize_t mw_dbgfs_outmw_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp);
+
+static ssize_t mw_dbgfs_outmw_write(struct file *filep, const char __user *ubuf,
+				    size_t usize, loff_t *offp);
+
+static ssize_t mw_dbgfs_outmw_cfg_read(struct file *filep, char __user *ubuf,
+				       size_t usize, loff_t *offp);
+
+static ssize_t mw_dbgfs_inmw_read(struct file *filep, char __user *ubuf,
+				  size_t usize, loff_t *offp);
+
+static ssize_t mw_dbgfs_inmw_write(struct file *filep, const char __user *ubuf,
+				   size_t usize, loff_t *offp);
+
+static ssize_t mw_dbgfs_inmw_cfg_read(struct file *filep, char __user *ubuf,
+				      size_t usize, loff_t *offp);
+
+/*
+ * DebugFS outbound memory window node operations
+ */
+static const struct file_operations mw_dbgfs_outmw_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = mw_dbgfs_outmw_read,
+	.write = mw_dbgfs_outmw_write
+};
+
+/*
+ * DebugFS outbound memory window configuration node operations
+ */
+static const struct file_operations mw_dbgfs_outmw_cfg_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = mw_dbgfs_outmw_cfg_read,
+};
+
+/*
+ * DebugFS inbound memory window node operations
+ */
+static const struct file_operations mw_dbgfs_inmw_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = mw_dbgfs_inmw_read,
+	.write = mw_dbgfs_inmw_write
+};
+
+/*
+ * DebugFS inbound memory window configuration node operations
+ */
+static const struct file_operations mw_dbgfs_inmw_cfg_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = mw_dbgfs_inmw_cfg_read,
+};
+
+/*
+ * DebugFS read callback of outbound memory window node
+ */
+static ssize_t mw_dbgfs_outmw_read(struct file *filep, char __user *ubuf,
+				   size_t usize, loff_t *offp)
+{
+	struct outmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *databuf;
+	size_t datasize;
+	ssize_t ret = 0;
+	int sts;
+
+	/* Check whether the link is up and the outbound window is enabled */
+	sts = ntb_link_is_up(ctx->ntb, NULL, NULL);
+	if (OFF == sts || !wrap->enabled) {
+		dev_err_mw(ctx, "NTB link is %s, memory window status is %s",
+			OFF == sts ? "Down" : "Up",
+			wrap->enabled ? "enabled" : "disabled");
+		return -ENODEV;
+	}
+
+	/* Read the first DWORD with the size of the message */
+	datasize = readl(wrap->virt_addr);
+
+	/* Check the read data size */
+	if (wrap->size < datasize) {
+		dev_err_mw(ctx, "Data size %u exceeds the memory window size %u",
+			(unsigned int)datasize, (unsigned int)wrap->size);
+		return -EINVAL;
+	}
+
+	/* Calculate the size of the output buffer */
+	datasize = min(datasize, usize);
+
+	/* If there is nothing to copy then just return from the function */
+	if (0 == datasize) {
+		return 0;
+	}
+
+	/* Allocate the buffer */
+	databuf = kmalloc(datasize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_mw(ctx, "No memory to allocate the output buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data from the shared memory to the temporary buffer */
+	/* NOTE memcpy_toio could be used instead, but it weirdly works so
+	 * the traditional looping is used */
+	iomem_read((wrap->virt_addr + 4), databuf, datasize);
+	/*memcpy_fromio(databuf, wrap->virt_addr + 4, datasize);*/
+
+	/* Copy the data to the output buffer */
+	ret = simple_read_from_buffer(ubuf, usize, offp, databuf, datasize);
+
+	/* Free the memory allocated for the buffer */
+	kfree(databuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS write callback of outbound memory window node
+ */
+static ssize_t mw_dbgfs_outmw_write(struct file *filep, const char __user *ubuf,
+				    size_t usize, loff_t *offp)
+{
+	struct outmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *databuf;
+	size_t datasize;
+	ssize_t ret = 0;
+	int sts;
+
+	/* Check whether the link is up and the outbound window is enabled */
+	sts = ntb_link_is_up(ctx->ntb, NULL, NULL);
+	if (OFF == sts || !wrap->enabled) {
+		dev_err_mw(ctx, "NTB link is %s, memory window status is %s",
+			OFF == sts ? "Down" : "Up",
+			wrap->enabled ? "enabled" : "disabled");
+		return -ENODEV;
+	}
+
+	/* Calculate the data size */
+	datasize = min(((size_t)wrap->size - 4), usize);
+
+	/* Allocate the memory for sending data */
+	databuf = kmalloc(datasize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_mw(ctx, "No memory to allocate the input data buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data to the output buffer */
+	ret = simple_write_to_buffer(databuf, datasize, offp, ubuf, usize);
+	if (0 > ret) {
+		dev_err_mw(ctx, "Failed to copy the data from the User-space");
+		kfree(databuf);
+		return ret;
+	}
+
+	/* First DWORD is the data size */
+	writel((u32)datasize, wrap->virt_addr);
+
+	/* Copy the data to the memory window */
+	/* NOTE memcpy_toio could be used instead, but it weirdly works so
+	 * the traditional looping is used */
+	iomem_write((wrap->virt_addr + 4), databuf, datasize);
+	/*memcpy_toio((wrap->virt_addr + 4), databuf, datasize);*/
+
+	/* Ensure that the data is fully copied out by setting the memory
+	 * barrier */
+	wmb();
+
+	/* Free the memory allocated for the buffer */
+	kfree(databuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS read callback of outbound memory window configurations
+ */
+static ssize_t mw_dbgfs_outmw_cfg_read(struct file *filep, char __user *ubuf,
+				       size_t usize, loff_t *offp)
+{
+	struct outmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *strbuf;
+	size_t size;
+	ssize_t ret = 0, off = 0;
+	int id;
+
+	/* Limit the buffer size */
+	size = min_t(size_t, usize, 0x800U);
+
+	/* Allocate the memory for the buffer */
+	strbuf = kmalloc(size, GFP_KERNEL);
+	if (NULL == strbuf) {
+		dev_dbg_mw(ctx,
+			"Failed to allocated the memory for outbound memory "
+			"window configuration");
+		return -ENOMEM;
+	}
+
+	/* Put the data into the string buffer */
+	off += scnprintf(strbuf + off, size - off,
+		"\n\t\tNTB Outbound Memory Window configuration:\n\n");
+
+	/* Current driver state */
+	off += scnprintf(strbuf + off, size - off,
+		"Status\t\t\t- %s\n",
+		wrap->enabled ? "enabled" : "disabled");
+	off += scnprintf(strbuf + off, size - off,
+		"DMA address\t\t- 0x%p\n", CAST_DMA_PTR(wrap->dma_addr));
+	off += scnprintf(strbuf + off, size - off,
+		"DMA address alignment\t- %lu\n",
+		(unsigned long int)wrap->addr_align);
+	off += scnprintf(strbuf + off, size - off,
+		"Physycal map address\t- 0x%p\n", (void *)wrap->phys_addr);
+	off += scnprintf(strbuf + off, size - off,
+		"Virtual map address\t- 0x%p\n", (void *)wrap->virt_addr);
+	off += scnprintf(strbuf + off, size - off,
+		"Size of the window\t- %lu\n",
+		(unsigned long int)wrap->size);
+	off += scnprintf(strbuf + off, size - off,
+		"Size alignment\t\t- %lu\n",
+		(unsigned long int)wrap->size_align);
+	off += scnprintf(strbuf + off, size - off,
+		"Maximum size\t\t- %lu\n",
+		(unsigned long int)wrap->size_max);
+	/* Print raw data from the inbound window */
+	off += scnprintf(strbuf + off, size - off,
+		"Raw data (16 bytes)\t- ");
+	for (id = 0; id < 16; id++) {
+		off += scnprintf(strbuf + off, size - off,
+			"%02hhx ", ioread8(wrap->virt_addr + id));
+	}
+	off += scnprintf(strbuf + off, size - off, "\n");
+
+
+	/* Copy the buffer to the User Space */
+	ret = simple_read_from_buffer(ubuf, usize, offp, strbuf, off);
+	kfree(strbuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS read callback of inbound memory window node
+ */
+static ssize_t mw_dbgfs_inmw_read(struct file *filep, char __user *ubuf,
+				  size_t usize, loff_t *offp)
+{
+	struct inmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *databuf;
+	size_t datasize;
+	ssize_t ret = 0;
+
+	/* Read the first DWORD with the size of the data */
+	datasize = le32_to_cpu(*(u32 *)wrap->virt_addr);
+
+	/* Calculate the size of the output buffer */
+	datasize = min(datasize, usize);
+
+	/* If there is nothing to copy then just return from the function */
+	if (0 == datasize) {
+		return 0;
+	}
+
+	/* Allocate the buffer */
+	databuf = kmalloc(datasize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_mw(ctx, "No memory to allocate the output buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data from the shared memory to the temporary buffer */
+	memcpy(databuf, wrap->virt_addr + 4, datasize);
+
+	/* Copy the data to the output buffer */
+	ret = simple_read_from_buffer(ubuf, usize, offp, databuf, datasize);
+
+	/* Free the memory allocated for the buffer */
+	kfree(databuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS write callback of inbound memory window node
+ */
+static ssize_t mw_dbgfs_inmw_write(struct file *filep, const char __user *ubuf,
+				   size_t usize, loff_t *offp)
+{
+	struct inmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *databuf;
+	size_t datasize;
+	ssize_t ret = 0;
+
+	/* Calculate the data size */
+	datasize = min((size_t)wrap->size - 4, usize);
+
+	/* Allocate the memory for sending data */
+	databuf = kmalloc(datasize, GFP_KERNEL);
+	if (NULL == databuf) {
+		dev_err_mw(ctx, "No memory to allocate the input data buffer");
+		return -ENOMEM;
+	}
+
+	/* Copy the data to the output buffer */
+	ret = simple_write_to_buffer(databuf, usize, offp, ubuf, usize);
+	if (0 > ret) {
+		dev_err_mw(ctx, "Failed to copy the data from the User-space");
+		kfree(databuf);
+		return ret;
+	}
+
+	/* First DWORD is the data size */
+	*(u32 *)wrap->virt_addr = cpu_to_le32(datasize);
+
+	/* Copy the data to the memory window */
+	memcpy(wrap->virt_addr + 4, databuf, datasize);
+
+	/* Free the memory allocated for the buffer */
+	kfree(databuf);
+
+	return datasize;
+}
+
+/*
+ * DebugFS read callback of outbound memory window configurations
+ */
+static ssize_t mw_dbgfs_inmw_cfg_read(struct file *filep, char __user *ubuf,
+				      size_t usize, loff_t *offp)
+{
+	struct inmw_wrap *wrap = filep->private_data;
+	struct mw_ctx *ctx = wrap->ctx;
+	char *strbuf;
+	size_t size;
+	ssize_t ret = 0, off = 0;
+	int id;
+
+	/* Limit the buffer size */
+	size = min_t(size_t, usize, 0x800U);
+
+	/* Allocate the memory for the buffer */
+	strbuf = kmalloc(size, GFP_KERNEL);
+	if (NULL == strbuf) {
+		dev_dbg_mw(ctx,
+			"Failed to allocated the memory for inbound memory "
+			"window configuration");
+		return -ENOMEM;
+	}
+
+	/* Put the data into the string buffer */
+	off += scnprintf(strbuf + off, size - off,
+		"\n\t\tNTB Inbound Memory Window configuration:\n\n");
+
+	/* Current driver state */
+	off += scnprintf(strbuf + off, size - off,
+		"DMA address\t\t- 0x%p\n", CAST_DMA_PTR(wrap->dma_addr));
+	off += scnprintf(strbuf + off, size - off,
+		"DMA address alignment\t- %lu\n",
+		(unsigned long int)wrap->addr_align);
+	off += scnprintf(strbuf + off, size - off,
+		"Virtual address\t\t- 0x%p\n", (void *)wrap->virt_addr);
+	off += scnprintf(strbuf + off, size - off,
+		"Size of the window\t- %lu\n",
+		(unsigned long int)wrap->size);
+	off += scnprintf(strbuf + off, size - off,
+		"Size alignment\t\t- %lu\n",
+		(unsigned long int)wrap->size_align);
+	off += scnprintf(strbuf + off, size - off,
+		"Maximum size\t\t- %lu\n",
+		(unsigned long int)wrap->size_max);
+
+	/* Print raw data from the inbound window */
+	off += scnprintf(strbuf + off, size - off,
+		"Raw data (16 bytes)\t- ");
+	for (id = 0; id < 16; id++) {
+		off += scnprintf(strbuf + off, size - off,
+			"%02hhx ", *(char *)(wrap->virt_addr + id));
+	}
+	off += scnprintf(strbuf + off, size - off, "\n");
+
+
+	/* Copy the buffer to the User Space */
+	ret = simple_read_from_buffer(ubuf, usize, offp, strbuf, off);
+	kfree(strbuf);
+
+	return ret;
+}
+
+/*
+ * DebugFS initialization function
+ */
+#define NAMESIZE 16
+static int mw_init_dbgfs(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct dentry *dbgfs_node;
+	char nodename[NAMESIZE];
+	const char *devname;
+	int outmwindx, inmwindx, ret;
+
+	/* If the top directory is not created then do nothing */
+	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
+		dev_warn_mw(ctx,
+			"Top DebugFS directory has not been created for "
+			DRIVER_NAME);
+		return PTR_ERR(dbgfs_topdir);
+	}
+
+	/* Retrieve the device name */
+	devname = dev_name(&ntb->dev);
+
+	/* Create the device related subdirectory */
+	ctx->dbgfs_dir = debugfs_create_dir(devname, dbgfs_topdir);
+	if (IS_ERR_OR_NULL(ctx->dbgfs_dir)) {
+		dev_warn_mw(ctx,
+			"Failed to create the DebugFS subdirectory %s",
+			devname);
+		return PTR_ERR(ctx->dbgfs_dir);
+	}
+
+	/* Walk through all the outbound memory windows creating the
+	 * corresponding nodes */
+	for (outmwindx = 0; outmwindx < ctx->outmws_cnt; outmwindx++) {
+		/* Create the name of the read/write node */
+		snprintf(nodename, NAMESIZE, "outmw%d", outmwindx);
+		/* Create the data read/write node */
+		dbgfs_node = debugfs_create_file(nodename, S_IRWXU,
+			ctx->dbgfs_dir, &ctx->outmws[outmwindx],
+			&mw_dbgfs_outmw_ops);
+		if (IS_ERR(dbgfs_node)) {
+			dev_err_mw(ctx, "Could not create DebugFS '%s' node",
+			nodename);
+			ret = PTR_ERR(dbgfs_node);
+			goto err_rm_dir;
+		}
+
+		/* Create the name of the configuration node */
+		snprintf(nodename, NAMESIZE, "outmwcfg%d", outmwindx);
+		/* Create the data read/write node */
+		dbgfs_node = debugfs_create_file(nodename, S_IRWXU,
+			ctx->dbgfs_dir, &ctx->outmws[outmwindx],
+			&mw_dbgfs_outmw_cfg_ops);
+		if (IS_ERR(dbgfs_node)) {
+			dev_err_mw(ctx, "Could not create DebugFS '%s' node",
+			nodename);
+			ret = PTR_ERR(dbgfs_node);
+			goto err_rm_dir;
+		}
+	}
+
+	/* Walk through all the inbound memory windows creating the
+	 * corresponding nodes */
+	for (inmwindx = 0; inmwindx < ctx->inmws_cnt; inmwindx++) {
+		/* Create the name of the read/write node */
+		snprintf(nodename, NAMESIZE, "inmw%d", inmwindx);
+		/* Create the data read/write node */
+		dbgfs_node = debugfs_create_file(nodename, S_IRWXU,
+			ctx->dbgfs_dir, &ctx->inmws[inmwindx],
+			&mw_dbgfs_inmw_ops);
+		if (IS_ERR(dbgfs_node)) {
+			dev_err_mw(ctx, "Could not create DebugFS '%s' node",
+			nodename);
+			ret = PTR_ERR(dbgfs_node);
+			goto err_rm_dir;
+		}
+
+		/* Create the name of the configuration node */
+		snprintf(nodename, NAMESIZE, "inmwcfg%d", inmwindx);
+		/* Create the data read/write node */
+		dbgfs_node = debugfs_create_file(nodename, S_IRWXU,
+			ctx->dbgfs_dir, &ctx->inmws[inmwindx],
+			&mw_dbgfs_inmw_cfg_ops);
+		if (IS_ERR(dbgfs_node)) {
+			dev_err_mw(ctx, "Could not create DebugFS '%s' node",
+			nodename);
+			ret = PTR_ERR(dbgfs_node);
+			goto err_rm_dir;
+		}
+	}
+
+	dev_dbg_mw(ctx, "NTB Memory Windows DebugFS top diretory is created "
+		"for %s", devname);
+
+	return SUCCESS;
+
+err_rm_dir:
+	debugfs_remove_recursive(ctx->dbgfs_dir);
+
+	return ret;
+}
+
+/*
+ * DebugFS deinitialization function
+ */
+static void mw_deinit_dbgfs(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Remove the DebugFS directory */
+	debugfs_remove_recursive(ctx->dbgfs_dir);
+
+	dev_dbg_mw(ctx, "Memory Windows DebugFS nodes %s/ are discarded",
+		dev_name(&ntb->dev));
+}
+
+/*===========================================================================
+ *                   NTB device/client driver initialization
+ *===========================================================================*/
+
+/*
+ * NTB device events handlers
+ */
+static const struct ntb_ctx_ops mw_ops = {
+	.link_event = link_event_handler,
+	.msg_event = msg_event_handler
+};
+
+/*
+ * Create the outbound memory windows
+ */
+static int mw_create_outmws(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct outmw_wrap *outmw;
+	int ret, mwindx;
+
+	/* Loop over all the outbound memory window descriptors initializing the
+	 * corresponding fields */
+	for (mwindx = 0; mwindx < ctx->outmws_cnt; mwindx++) {
+		outmw = &ctx->outmws[mwindx];
+		/* Outbound memory windows are disabled by default */
+		outmw->enabled = false;
+
+		/* Set the context */
+		outmw->ctx = ctx;
+
+		/* Retrieve the physical address of the memory to map */
+		ret = ntb_mw_get_maprsc(ntb, mwindx, &outmw->phys_addr,
+			&outmw->size);
+		if (SUCCESS != ret) {
+			dev_err_mw(ctx, "Failed to get map resources of "
+				"outbound window %d", mwindx);
+			mwindx--;
+			goto err_unmap_rsc;
+		}
+
+		/* Map the memory window resources */
+		outmw->virt_addr = ioremap_nocache(outmw->phys_addr, outmw->size);
+
+		/* Retrieve the memory windows maximum size and alignments */
+		ret = ntb_mw_get_align(ntb, mwindx, &outmw->addr_align,
+			&outmw->size_align, &outmw->size_max);
+		if (SUCCESS != ret) {
+			dev_err_mw(ctx, "Failed to get alignment options of "
+				"outbound window %d", mwindx);
+			goto err_unmap_rsc;
+		}
+	}
+
+	dev_dbg_mw(ctx, "Outbound memory windows are created");
+
+	return SUCCESS;
+
+err_unmap_rsc:
+	for (; 0 <= mwindx; mwindx--) {
+		outmw = &ctx->outmws[mwindx];
+		iounmap(outmw->virt_addr);
+	}
+
+	return ret;
+}
+
+/*
+ * Free the outbound memory windows
+ */
+static void mw_free_outmws(struct mw_ctx *ctx)
+{
+	struct outmw_wrap *outmw;
+	int mwindx;
+
+	/* Loop over all the outbound memory window descriptors and unmap the
+	 * resources */
+	for (mwindx = 0; mwindx < ctx->outmws_cnt; mwindx++) {
+		outmw = &ctx->outmws[mwindx];
+
+		/* Disable the memory window */
+		outmw->enabled = false;
+
+		/* Unmap the resource */
+		iounmap(outmw->virt_addr);
+	}
+
+	dev_dbg_mw(ctx, "Outbound memory windows are freed");
+}
+
+/*
+ * Create the inbound memory windows
+ */
+static int mw_create_inmws(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct inmw_wrap *inmw;
+	int mwindx, ret = SUCCESS;
+
+	/* Loop over all the inbound memory window descriptors initializing the
+	 * corresponding fields */
+	for (mwindx = 0; mwindx < ctx->inmws_cnt; mwindx++) {
+		inmw = &ctx->inmws[mwindx];
+		/* Set the context */
+		inmw->ctx = ctx;
+		/* Retrieve the memory windows maximum size and alignments */
+		ret = ntb_peer_mw_get_align(ntb, mwindx, &inmw->addr_align,
+			&inmw->size_align, &inmw->size_max);
+		if (SUCCESS != ret) {
+			dev_err_mw(ctx, "Failed to get alignment options of "
+				"inbound window %d", mwindx);
+			mwindx--;
+			ret = -ENOMEM;
+			goto err_free_dma_bufs;
+		}
+		/* Allocate all the maximum possible size */
+		inmw->size = inmw->size_max;
+
+		/* Allocate the cache coherent DMA memory windows */
+		inmw->virt_addr = dma_zalloc_coherent(&ntb->dev, inmw->size,
+			&inmw->dma_addr, GFP_KERNEL);
+		if (IS_ERR_OR_NULL(inmw->virt_addr)) {
+			dev_err_mw(ctx,
+				"Failed to allocate the inbound buffer for %d",
+				mwindx);
+			mwindx--;
+			ret = -ENOMEM;
+			goto err_free_dma_bufs;
+		}
+		/* Make sure the allocated address is properly aligned */
+		if (!IS_ALIGNED(inmw->dma_addr, inmw->addr_align)) {
+			dev_err_mw(ctx, "DMA address %p of inbound mw %d isn't "
+				"aligned with %lu", CAST_DMA_PTR(inmw->dma_addr),
+				mwindx, (unsigned long int)inmw->addr_align);
+			ret = -EINVAL;
+			goto err_free_dma_bufs;
+		}
+	}
+
+	dev_dbg_mw(ctx, "Inbound memory windows are created");
+
+	return SUCCESS;
+
+err_free_dma_bufs:
+	for (; 0 <= mwindx; mwindx--) {
+		inmw = &ctx->inmws[mwindx];
+		dma_free_coherent(&ntb->dev, inmw->size, inmw->virt_addr,
+			inmw->dma_addr);
+	}
+
+	return ret;
+}
+
+/*
+ * Free the inbound memory windows
+ */
+static void mw_free_inmws(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	struct inmw_wrap *inmw;
+	int mwindx;
+
+	/* Loop over all the inbound memory window descriptors and free
+	 * the allocated memory */
+	for (mwindx = 0; mwindx < ctx->inmws_cnt; mwindx++) {
+		inmw = &ctx->inmws[mwindx];
+
+		/* Free the cache coherent DMA memory window */
+		dma_free_coherent(&ntb->dev, inmw->size, inmw->virt_addr,
+			inmw->dma_addr);
+	}
+
+	dev_dbg_mw(ctx, "Inbound memory windows are freed");
+}
+
+/*
+ * Create the driver context structure
+ */
+static struct mw_ctx *mw_create_ctx(struct ntb_dev *ntb)
+{
+	struct mw_ctx *ctx, *ret;
+	int node;
+
+	/* Allocate the memory at the device NUMA node */
+	node = dev_to_node(&ntb->dev);
+	ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, node);
+	if (IS_ERR_OR_NULL(ctx)) {
+		dev_err(&ntb->dev,
+			"No memory for NTB Memory windows driver context");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Initialize the context NTB device pointer */
+	ctx->ntb = ntb;
+
+	/* Read the number of memory windows */
+	/* Number of memory windows local NTB device can set to the translated
+	 * address register */
+	ctx->outmws_cnt = ntb_mw_count(ntb);
+	/* Number of memory windows peer can set to his translated address
+	 * register */
+	ctx->inmws_cnt = ntb_peer_mw_count(ntb);
+
+	/* Alter the inbound memory windows count with respect to the driver
+	 * parameter */
+	mw_alter_params(ctx);
+
+	/* Allocate the memory for memory window descriptors */
+	ctx->outmws = kzalloc_node(ctx->outmws_cnt * sizeof(*ctx->outmws),
+		GFP_KERNEL, node);
+	if (IS_ERR_OR_NULL(ctx->outmws)) {
+		dev_err_mw(ctx,
+			"Failed to allocate memory for outbound MW descriptors");
+		ret = ERR_PTR(-ENOMEM);
+		goto err_free_ctx;
+	}
+	ctx->inmws = kzalloc_node(ctx->inmws_cnt * sizeof(*ctx->inmws),
+		GFP_KERNEL, node);
+	if (IS_ERR_OR_NULL(ctx->inmws)) {
+		dev_err_mw(ctx,
+			"Failed to allocate memory for inbound MW descriptors");
+		ret = ERR_PTR(-ENOMEM);
+		goto err_free_outmws;
+	}
+
+	dev_dbg_mw(ctx, "Context structure is created");
+
+	return ctx;
+
+/*err_free_inmws:
+	kfree(ctx->inmws);
+*/
+err_free_outmws:
+	kfree(ctx->outmws);
+err_free_ctx:
+	kfree(ctx);
+
+	return ret;
+}
+
+/*
+ * Free the driver context structure
+ */
+static void mw_free_ctx(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Free the outbound memory windows descriptors */
+	kfree(ctx->outmws);
+
+	/* Free the inbound memory windows descriptors */
+	kfree(ctx->inmws);
+
+	/* Free the memory allocated for the context structure */
+	kfree(ctx);
+
+	dev_dbg(&ntb->dev, "Context structure is freed");
+}
+
+/*
+ * Initialize the ntb device structure
+ */
+static int mw_init_ntb_dev(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+	int ret;
+
+	/* Set the NTB device events context */
+	ret = ntb_set_ctx(ntb, ctx, &mw_ops);
+	if (SUCCESS != ret) {
+		dev_err_mw(ctx, "Failed to specify the NTB device context");
+		return ret;
+	}
+
+	/* Enable the link and rise the event to check the link state */
+	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	/*ntb_link_event(ntb);*/
+
+	dev_dbg_mw(ctx, "NTB device is initialized");
+
+	return SUCCESS;
+}
+
+/*
+ * Deinitialize the ntb device structure
+ */
+static void mw_stop_ntb_dev(struct mw_ctx *ctx)
+{
+	struct ntb_dev *ntb = ctx->ntb;
+
+	/* Clear the context */
+	ntb_clear_ctx(ntb);
+
+	/* Disable the link */
+	ntb_link_disable(ntb);
+
+	dev_dbg_mw(ctx, "NTB device is deinitialized");
+}
+
+/*
+ * Initialize the DMA masks
+ */
+static int __maybe_unused mw_ntb_set_dma_mask(struct ntb_dev *ntb)
+{
+	struct device *dev;
+	int ret = SUCCESS;
+
+	/* Get the NTB device structure */
+	dev = &ntb->dev;
+	/* Try to set the Highmem DMA address */
+	ret = dma_set_mask(dev, DMA_BIT_MASK(64));
+	if (SUCCESS == ret) {
+		/* Next call won't fail of the upper one returned OK */
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		return SUCCESS;
+	}
+
+	/* Warn if the HIGHMEM can be used for DMA */
+	dev_warn(dev, "Cannot set the NTB device DMA highmem mask");
+
+	/* Try the Low 32-bits DMA addresses */
+	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (SUCCESS == ret) {
+		/* The same is here */
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+		return SUCCESS;
+	}
+
+	dev_err(dev, "Failed to set the NTB device DMA lowmem mask");
+
+	return ret;
+}
+
+/*
+ * NTB device probe() callback function
+ */
+static int mw_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct mw_ctx *ctx;
+	int ret;
+
+	/* Only asynchronous hardware is supported */
+	if (!ntb_valid_async_dev_ops(ntb)) {
+		return -EINVAL;
+	}
+
+	/* Check whether the messaging supports at least 4 DWORDS */
+	ret = ntb_msg_size(ntb);
+	if (4 > ret) {
+		dev_err(&ntb->dev, "NTB Messaging supports just %d < 4 dwords",
+			ret);
+		return -EINVAL;
+	}
+
+	/* Set the NTB device DMA mask */
+	/*ret = mw_ntb_set_dma_mask(ntb);
+	if (SUCCESS != ret) {
+		return ret;
+	}*/
+
+	/* Create the current device context */
+	ctx = mw_create_ctx(ntb);
+	if (IS_ERR_OR_NULL(ctx)) {
+		return PTR_ERR(ctx);
+	}
+
+	/* Allocate the inbound memory windows */
+	ret = mw_create_inmws(ctx);
+	if (SUCCESS != ret) {
+		goto err_free_ctx;
+	}
+
+	/* Map the outbound memory windows */
+	ret = mw_create_outmws(ctx);
+	if (SUCCESS != ret) {
+		goto err_free_inmws;
+	}
+
+	/* Initialize the NTB device */
+	ret = mw_init_ntb_dev(ctx);
+	if (SUCCESS != ret) {
+		goto err_free_outmws;
+	}
+
+	/* Create the DebugFS nodes */
+	(void)mw_init_dbgfs(ctx);
+
+	return SUCCESS;
+
+/*err_stop_ntb_dev:
+	mw_stop_ntb_dev(ctx);
+*/
+err_free_outmws:
+	mw_free_outmws(ctx);
+err_free_inmws:
+	mw_free_inmws(ctx);
+err_free_ctx:
+	mw_free_ctx(ctx);
+
+	return ret;
+
+}
+
+/*
+ * NTB device remove() callback function
+ */
+static void mw_remove(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct mw_ctx *ctx = ntb->ctx;
+
+	/* Send the message so the peer would lock outbound memory windows */
+	mw_send_freeaddrs_cmd(ctx);
+
+	/* Remove the DebugFS node */
+	mw_deinit_dbgfs(ctx);
+
+	/* Disable the NTB device link and clear the context */
+	mw_stop_ntb_dev(ctx);
+
+	/* Clear the outbound memory windows */
+	mw_free_outmws(ctx);
+
+	/* Clear the inbound memory windows */
+	mw_free_inmws(ctx);
+
+	/* Free the allocated context */
+	mw_free_ctx(ctx);
+}
+
+/*
+ * NTB bus client driver structure definition
+ */
+static struct ntb_client mw_client = {
+	.ops = {
+		.probe = mw_probe,
+		.remove = mw_remove,
+	},
+};
+/* module_ntb_client(mw_client); */
+
+/*
+ * Driver initialize method
+ */
+static int __init ntb_mw_init(void)
+{
+	/* Create the top DebugFS directory if the FS is initialized */
+	if (debugfs_initialized())
+		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	/* Registers the client driver */
+	return ntb_register_client(&mw_client);
+}
+module_init(ntb_mw_init);
+
+/*
+ * Driver exit method
+ */
+static void __exit ntb_mw_exit(void)
+{
+	/* Unregister the client driver */
+	ntb_unregister_client(&mw_client);
+
+	/* Discard the top DebugFS directory */
+	debugfs_remove_recursive(dbgfs_topdir);
+}
+module_exit(ntb_mw_exit);
+
-- 
2.6.6

